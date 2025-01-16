# Spacelift-Microsoft Teams notification integration

Terraform module providing a notification-based integration between [Spacelift](https://spacelift.io) and [Microsoft Teams](https://www.microsoft.com/en-us/microsoft-teams/group-chat-software). It creates a webhook in Spacelift that will send notifications to a Microsoft Teams channel when:

- a [tracked run](https://docs.spacelift.io/concepts/run/tracked) [needs confirmation](https://docs.spacelift.io/concepts/run/tracked#unconfirmed);
- a [tracked run](https://docs.spacelift.io/concepts/run/tracked) or a [task](https://docs.spacelift.io/concepts/run/task) finishes;
- a [module version](https://docs.spacelift.io/vendors/terraform/module-registry#versions) succeeds or fails;

The official documentation for this integration is available in [here](https://docs.spacelift.io/integrations/chatops/msteams).

## Usage

```hcl
module "spacelift_msteams" {
  source = "spacelift-io/msteams/spacelift"

  channel_name = "My channel"
  space_id     = "root"
  webhook_url  = "https://outlook.office.com/webhook/..."
}
```

Based on this configuration, the module will send notifications to the `My channel` channel in Microsoft Teams that look like these:

![Run pending confirmation notification](https://docs.spacelift.io/assets/screenshots/msteams-run-pending.png)

![Run finished notification](https://docs.spacelift.io/assets/screenshots/msteams-run-finished.png)

![Module version notification](https://docs.spacelift.io/assets/screenshots/msteams-module-version.png)

## Prerequisites

In order to use this module, you need to have a Microsoft Teams channel and an incoming webhook URL. This needs to be set up manually.

To learn how to set up the webhook in Microsoft Teams, please refer to the [official documentation](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook).

## Further work

Microsoft Teams has a rich API for creating beautiful-looking, powerful integrations. Unfortunately, much of that is either not documented, and some is not available to incoming webhooks. If you're a heavy user of both Spacelift and Microsoft Teams, and familiar with the latter's API, we'd love to hear from you. Let's build something amazing together!
