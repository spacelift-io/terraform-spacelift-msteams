package spacelift

# START run state changes.
stack_url = sprintf("https://%s.app.spacelift.io/stack/%s", [
	input.account.name,
	input.run_updated.stack.id,
])

run_url = sprintf("%s/run/%s", [
	stack_url,
	input.run_updated.run.id,
])

interesting_run_states = {
	"DISCARDED": {"style": "attention", "title": "has been discarded"},
	"FAILED": {"style": "attention", "title": "has failed"},
	"FINISHED": {"style": "good", "title": "has finished"},
	"STOPPED": {"style": "attention", "title": "has been stopped"},
	"UNCONFIRMED": {"style": "warning", "title": "is pending confirmation"},
}

interesting_run_types = {
	"TRACKED": "Tracked run",
	"TASK": "Custom task",
}

run_state := input.run_updated.run.state

run_type := input.run_updated.run.type

# Run state changes.
webhook[{"endpoint_id": endpoint_id, "payload": run_payload}] {
	# Send the webhook to any endpoint labeled as "msteams".
	endpoint := input.webhook_endpoints[_]
	endpoint.labels[_] == "msteams"
	endpoint_id := endpoint.id

	# Only send the webhook if both the run state and type are interesting.
	interesting_run_states[run_state]
	interesting_run_types[run_type]
}

# Main section.
run_payload = {
	"type": "message",
	"attachments": [{
		"contentType": "application/vnd.microsoft.card.adaptive",
		"contentUrl": null,
		"content": {
			"$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
			"type": "AdaptiveCard",
			"version": "1.5",
			"body": [
				{
					"type": "Container",
					"items": [{
						"type": "TextBlock",
						"text": sprintf("[%s](%s) %s", [
							interesting_run_types[run_type],
							run_url,
							interesting_run_states[run_state].title,
						]),
						"size": "large",
						"weight": "bolder",
					}],
					"style": interesting_run_states[run_state].style,
				},
				{
					"type": "FactSet",
					"facts": run_facts,
				},
				{
					"type": "Container",
					"items": run_resources,
				},
			],
		},
	}],
}

run_resources[{
	"type": "Container",
	"items": [
		{
			"type": "TextBlock",
			"text": sprintf("%s resources (%d)", [
				resource_section,
				count(collection),
			]),
			"weight": "bolder",
		},
		{
			"type": "TextBlock",
			"text": as_list(collection),
		},
	],
}] {
	run_type == "TRACKED"
	resource_section := {"Added", "Changed", "Deleted", "Replaced"}[_]
	collection := resources(lower(resource_section))
	count(collection) > 0
}

run_facts[{"title": "Stack", "value": value}] {
	value := sprintf("[%s](%s)", [
		input.run_updated.stack.name,
		stack_url,
	])
}

run_facts[{"title": "Command", "value": value}] {
	run_type == "TASK"
	value := sprintf("`%s`", [input.run_updated.run.command])
}

run_facts[{"title": "Branch", "value": value}] {
	run_type != "TASK"
	value := input.run_updated.run.commit.branch
}

run_facts[{"title": "Commit", "value": value}] {
	run_type != "TASK"
	value := sprintf("[%s](%s) by %s", [
		input.run_updated.run.commit.message,
		input.run_updated.run.commit.url,
		input.run_updated.run.commit.author,
	])
}

run_facts[{"title": "Triggered by", "value": value}] {
	value := input.run_updated.run.triggered_by
}

run_facts[{"title": "Created at", "value": value}] {
	value := time.format(input.run_updated.run.created_at)
}

run_facts[{"title": "Space", "value": value}] {
	value := input.run_updated.stack.space.name
}

resources(type) = [change.entity.address |
	change := input.run_updated.run.changes[_]
	change.phase == "plan"
	contains(change.action, type)
]

as_list(resources) = concat("\r", [sprintf("- %s", [resource]) | resource := resources[_]])

# END run state changes.

# START module version state changes.
module_url := sprintf("https://%s.app.spacelift.io/module/%s", [
	input.account.name,
	input.module_version.module.id,
])

version_number := input.module_version.version.number

version_state := input.module_version.version.state

version_url := sprintf("%s/version/%s", [
	module_url,
	input.module_version.version.id,
])

interesting_version_states = {
	"ACTIVE": {"style": "good", "title": "has been published"},
	"FAILED": {"style": "attention", "title": "has failed"},
}

# Module version state changes.
webhook[{"endpoint_id": endpoint_id, "payload": version_payload}] {
	# Send the webhook to any endpoint labeled as "msteams".
	endpoint := input.webhook_endpoints[_]
	endpoint.labels[_] == "msteams"
	endpoint_id := endpoint.id

	# Only send the webhook if the version state is interesting.
	interesting_version_states[version_state]
}

version_payload = {
	"type": "message",
	"attachments": [{
		"contentType": "application/vnd.microsoft.card.adaptive",
		"contentUrl": null,
		"content": {
			"$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
			"type": "AdaptiveCard",
			"version": "1.5",
			"body": [
				{
					"type": "Container",
					"items": [{
						"type": "TextBlock",
						"text": sprintf("[Module version %s](%s) %s", [
							version_number,
							version_url,
							interesting_version_states[version_state].title,
						]),
						"size": "large",
						"weight": "bolder",
					}],
					"style": interesting_version_states[version_state].style,
				},
				{
					"type": "FactSet",
					"facts": version_facts,
				},
				{
					"type": "Table",
					"firstRowAsHeader": false,
					"showGridLines": false,
					"columns": [
						{"width": 1},
						{"width": 2},
						{"width": 1},
					],
					"rows": version_tests,
				},
			],
		},
	}],
}

version_facts[{"title": "Module", "value": value}] {
	value := sprintf("[%s](%s)", [
		input.module_version.module.name,
		module_url,
	])
}

version_facts[{"title": "Branch", "value": value}] {
	value := input.module_version.version.commit.branch
}

version_facts[{"title": "Commit", "value": value}] {
	value := sprintf("[%s](%s) by %s", [
		input.module_version.version.commit.message,
		input.module_version.version.commit.url,
		input.module_version.version.commit.author,
	])
}

version_facts[{"title": "Created at", "value": value}] {
	value := time.format(input.module_version.version.created_at)
}

version_facts[{"title": "Space", "value": value}] {
	value := input.module_version.module.space.name
}

version_tests[{
	"type": "TableRow",
	"cells": [
		{
			"type": "TableCell",
			"items": [{
				"type": "TextBlock",
				"text": name,
				"weight": "bolder",
				"wrap": true,
			}],
		},
		{
			"type": "TableCell",
			"items": [{
				"type": "TextBlock",
				"text": title,
				"weight": "bolder",
				"wrap": true,
			}],
		},
		{
			"type": "TableCell",
			"items": [{
				"type": "TextBlock",
				"text": value,
			}],
		},
	],
}] {
	some i
	run := input.module_version.version.test_runs[i]

	name := sprintf("Test case #%02d", [i + 1])
	title := sprintf("%q", [run.title])
	value := sprintf("[%s](%s)", [
		run.state,
		sprintf("%s/run/%s", [version_url, run.id]),
	])
}

# Sample if we actually send a webhook.
sample {
	count(webhook) > 0
}
