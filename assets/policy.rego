package spacelift

import future.keywords.in

# Common settings.
fail_color = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyhpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDcuMi1jMDAwIDc5LjU2NmViYzViNCwgMjAyMi8wNS8wOS0wODoyNTo1NSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIzLjQgKE1hY2ludG9zaCkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6QTQwQzQyMzZFMzYzMTFFRDhCM0FFRTVFNzNFNDIyOTUiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6QTQwQzQyMzdFMzYzMTFFRDhCM0FFRTVFNzNFNDIyOTUiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo3NjA5MzA4OUUzNjExMUVEOEIzQUVFNUU3M0U0MjI5NSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo3NjA5MzA4QUUzNjExMUVEOEIzQUVFNUU3M0U0MjI5NSIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PmtPR9AAAAAXSURBVHjaYnyoocGADTAx4ACDUwIgwADzpwFBKPVC8wAAAABJRU5ErkJggg=="

success_color = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyhpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDcuMi1jMDAwIDc5LjU2NmViYzViNCwgMjAyMi8wNS8wOS0wODoyNTo1NSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIzLjQgKE1hY2ludG9zaCkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6QTQwQzQyM0FFMzYzMTFFRDhCM0FFRTVFNzNFNDIyOTUiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6QTQwQzQyM0JFMzYzMTFFRDhCM0FFRTVFNzNFNDIyOTUiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDpBNDBDNDIzOEUzNjMxMUVEOEIzQUVFNUU3M0U0MjI5NSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDpBNDBDNDIzOUUzNjMxMUVEOEIzQUVFNUU3M0U0MjI5NSIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/Pp2WMLAAAAAXSURBVHjaYhTf28iADTAx4ACDUwIgwAAOawFlwjvetAAAAABJRU5ErkJggg=="

warning_color = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyhpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDcuMi1jMDAwIDc5LjU2NmViYzViNCwgMjAyMi8wNS8wOS0wODoyNTo1NSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIzLjQgKE1hY2ludG9zaCkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NzYwOTMwODdFMzYxMTFFRDhCM0FFRTVFNzNFNDIyOTUiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NzYwOTMwODhFMzYxMTFFRDhCM0FFRTVFNzNFNDIyOTUiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo3NjA5MzA4NUUzNjExMUVEOEIzQUVFNUU3M0U0MjI5NSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo3NjA5MzA4NkUzNjExMUVEOEIzQUVFNUU3M0U0MjI5NSIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/Ph5OA5YAAAA2SURBVHjaYvy0hPsZAwMDDwN28IUFSEgy4Aa8TEDiMx4Fn5kYCADqKODF50iQL57j8yZAgAEAITEHqIetqNAAAAAASUVORK5CYII="

# START run state changes.
stack_url = sprintf("https://%s.app.spacelift.io/stack/%s", [
	input.account.name,
	input.run_updated.stack.id,
])

run_url = sprintf("%s/run/%s", [
	stack_url,
	input.run_updated.run.id,
])

review_flags_mentionable[sprintf(message, [])] {
	# Basically extracts flags, one by one
	policy_receipts := input.run_updated.policy_receipts[_].flags[_]
	flag := strings.any_prefix_match(policy_receipts.flags[_], "review:")
	message := sprintf("%s", [flag])
}

# interesting_review_flags {
# 	strings.any_prefix_match(input.run_updated.policy_receipts[_].flags[_], "review:")
# }

prefix_mention_flag(f) = concat("", ["@", f])

interesting_review_flags {
	strings.any_prefix_match(input.run_updated.policy_receipts[_].flags[_], "review:")
}

interesting_run_states = {
	"DISCARDED": {"color": fail_color, "title": "has been discarded"},
	"FAILED": {"color": fail_color, "title": "has failed"},
	"FINISHED": {"color": success_color, "title": "has finished"},
	"STOPPED": {"color": fail_color, "title": "has been stopped"},
	"UNCONFIRMED": {"color": warning_color, "title": "is pending confirmation"},
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

# Best reference for the payload schema.
# https://adaptivecards.io/samples/
run_payload = {
	"type": "message",
	"attachments": run_attachments,
}

run_attachments[{
	"contentType": "application/vnd.microsoft.card.adaptive",
	"contentUrl": null,
	"content": run_content,
}]

run_content = {
	"type": "AdaptiveCard",
	"body": run_body,
	"actions": [],
	"$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
	"version": "1.5",
	"backgroundImage": {
		"url": interesting_run_states[run_state].color,
		"fillMode": "RepeatHorizontally",
		"verticalAlignment": "Top",
	},
}

# builds run_body and ensures proper order
run_body := array.concat(
	[run_body_activity_subtitle],
	array.concat(
		[run_body_activity_title],
		array.concat(
			[run_body_facts],
			array.concat(
				[run_body_resource_changes],
				[run_body_list_resources],
			),
		),
	),
)

# activitySubtitle
run_body_activity_subtitle = {
	"type": "TextBlock",
	"size": "medium",
	"text": sprintf("Stack [%s](%s)", [
		input.run_updated.stack.name,
		stack_url,
	]),
	"weight": "bolder",
	"wrap": false,
}

# activityTitle
run_body_activity_title = {
	"type": "TextBlock",
	"size": "small",
	"style": "heading",
	"text": sprintf("[%s](%s) %s", [
		interesting_run_types[run_type],
		run_url,
		interesting_run_states[run_state].title,
	]),
	"weight": "bolder",
	"wrap": false,
}

# facts
run_body_facts = {
	"type": "FactSet",
	"facts": run_facts,
}

# resource changes
run_body_resource_changes = {
	"type": "TextBlock",
	"size": "medium",
	"text": sprintf("%s resources (%d)", [
		resource_section,
		count(collection),
	]),
	"weight": "bolder",
	"wrap": false,
} {
	run_type == "TRACKED"
	resource_section := {"Added", "Changed", "Deleted", "Replaced"}[_]
	collection := resources(lower(resource_section))
	count(collection) > 0
}

# list of resources
run_body_list_resources = {
	"type": "TextBlock",
	"text": as_markdown_list(collection),
	"wrap": true,
} {
	run_type == "TRACKED"
	resource_section := {"Added", "Changed", "Deleted", "Replaced"}[_]
	collection := resources(lower(resource_section))
	count(collection) > 0
}

# the "list" of facts
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
		input.run_updated.run.commit.hash,
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

run_facts[{"title": "Waiting Review", "value": value}] {
	interesting_review_flags
	all_flags := [flag |
		receipt := input.run_updated.policy_receipts[_]
		flag := receipt.flags[_]
		startswith(flag, "review:")
	]
	result := [prefix_mention_flag(trim_prefix(flag, "review:")) | flag := all_flags[_]]
	value := concat(" ", result)
}

resources(type) = [change.entity.address |
	change := input.run_updated.run.changes[_]
	change.phase == "plan"
	contains(change.action, type)
]

as_markdown_list(resources) = sprintf("%s", [concat("\n", [sprintf("* %s", [resource]) | resource := resources[_]])])

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
	"ACTIVE": {"color": success_color, "title": "has been published"},
	"FAILED": {"color": fail_color, "title": "has failed"},
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
	"@type": "MessageCard",
	"@context": "http://schema.org/extensions",
	"themeColor": interesting_version_states[version_state].color,
	"summary": sprintf("Module version %s %s", [
		version_number,
		interesting_version_states[version_state].title,
	]),
	"sections": version_sections,
}

version_sections[{
	"activityTitle": sprintf("[Module version %s](%s) %s", [
		version_number,
		version_url,
		interesting_version_states[version_state].title,
	]),
	"activitySubtitle": sprintf("Module [%s](%s)", [
		input.module_version.module.name,
		module_url,
	]),
	"facts": version_facts,
	"markdown": true,
}]

version_facts[{"name": "Branch", "value": value}] {
	value := input.module_version.version.commit.branch
}

version_facts[{"name": "Commit", "value": value}] {
	value := sprintf("[%s](%s) by %s", [
		input.module_version.version.commit.message,
		input.module_version.version.commit.hash,
		input.module_version.version.commit.author,
	])
}

version_facts[{"name": "Created at", "value": value}] {
	value := time.format(input.module_version.version.created_at)
}

version_facts[{"name": "Space", "value": value}] {
	value := input.module_version.module.space.name
}

version_facts[{"name": name, "value": value}] {
	some i
	run := input.module_version.version.test_runs[i]

	name := sprintf("Test case #%02d: %q", [i + 1, run.title])
	value := sprintf("[%s](%s)", [
		run.state,
		sprintf("%s/run/%s", [version_url, run.id]),
	])
}

# Sample if we actually send a webhook.
sample {
	count(webhook) > 0
}
