package spacelift

# Common settings.
fail_color = "e21717"
success_color = "17bd81"
warning_color = "f2a40b"

# START run state changes.
stack_url = sprintf("https://%s.spacelift.io/stack/%s", [
    input.account.name,
    input.run_updated.stack.id,
])

run_url = sprintf("%s/run/%s", [
    stack_url,
    input.run_updated.run.id,
])

interesting_run_states = {
    "DISCARDED": { "color": fail_color, "title": "has been discarded" },
    "FAILED": { "color": fail_color, "title": "has failed" },
    "FINISHED": { "color": success_color, "title": "has finished" },
    "STOPPED": { "color": fail_color, "title": "has been stopped" },
    "UNCONFIRMED": { "color": warning_color, "title": "is pending confirmation" },
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
    "@type": "MessageCard",
    "@context": "http://schema.org/extensions",
    "themeColor": interesting_run_states[run_state].color,
    "summary": sprintf("%s %s", [
        interesting_run_types[run_type],
        interesting_run_states[run_state].title],
    ),
    "sections": run_sections,
}

# Main section.
run_sections[{
    "activityTitle": sprintf("[%s](%s) %s", [
        interesting_run_types[run_type],
        run_url,
        interesting_run_states[run_state].title,
    ]),
    "activitySubtitle": sprintf("Stack [%s](%s)", [
        input.run_updated.stack.name,
        stack_url,
    ]),
    "facts": run_facts,
    "markdown": true
}]

run_sections[{
    "activityTitle": sprintf("%s resources (%d)", [
        resource_section,
        count(collection),
    ]),
    "text": as_html_list(collection)
}] {
    run_type == "TRACKED"
    resource_section := {"Added","Changed","Deleted","Replaced"}[_]
    collection := resources(lower(resource_section))
    count(collection) > 0
}

run_facts[{ "name": "Command", "value": value }] {
    run_type == "TASK"
    value := sprintf("`%s`", [input.run_updated.run.command])
}

run_facts[{ "name": "Branch", "value": value }] {
    run_type != "TASK"
    value :=  input.run_updated.run.commit.branch
}

run_facts[{ "name": "Commit", "value": value }] {
    run_type != "TASK"
    value := sprintf("[%s](%s) by %s", [
        input.run_updated.run.commit.message,
        input.run_updated.run.commit.hash,
        input.run_updated.run.commit.author,
    ])
}

run_facts[{ "name": "Triggered by", "value": value }] {
    value := input.run_updated.run.triggered_by
}

run_facts[{ "name": "Created at", "value": value }] {
    value := time.format(input.run_updated.run.created_at)
}

run_facts[{ "name": "Space", "value": value }] {
    value := input.run_updated.stack.space.name
}

resources(type) = [change.entity.address |
    change := input.run_updated.run.changes[_]
    change.phase == "plan"
    contains(change.action, type)
]

as_html_list(resources) = sprintf("<ul>%s</ul>", [
    concat("", [sprintf("<li>%s</li>", [resource]) | resource := resources[_]]),
])
# END run state changes.


# START module version state changes.
module_url := sprintf("https://%s.spacelift.io/module/%s", [
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
    "ACTIVE": { "color": success_color, "title": "has been published" },
    "FAILED": { "color": fail_color, "title": "has failed" },
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
    "markdown": true
}]

version_facts[{ "name": "Branch", "value": value }] {
    value :=  input.module_version.version.commit.branch
}

version_facts[{ "name": "Commit", "value": value }] {
    value := sprintf("[%s](%s) by %s", [
        input.module_version.version.commit.message,
        input.module_version.version.commit.hash,
        input.module_version.version.commit.author,
    ])
}

version_facts[{ "name": "Created at", "value": value }] {
    value := time.format(input.module_version.version.created_at)
}

version_facts[{ "name": "Space", "value": value }] {
    value := input.module_version.module.space.name
}

version_facts[{ "name": name, "value": value }] {
    run := input.module_version.version.test_runs[_]

    name := sprintf("Test case %q", [run.title])
    value := sprintf("[%s](%s)", [
        run.state,
        sprintf("%s/run/%s", [version_url, run.id]),
    ])
}

# Sample if we actually send a webhook.
sample { count(webhook) > 0 }
