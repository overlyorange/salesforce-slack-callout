# Salesforce Slack Callout Invocable Method
This invocable apex method takes in variables and posts them to a Slack webhook, e.g. to send messages about record updates to a specfic Slack channel from within a Flow.

## Why
To keep your Slack users in the loop around specific changes to your database.

## How
[SlackCallout](/force-app/main/default/classes/SlackCallout.cls) contains an invocable method as well as two classes specifying input and output variables (FlowInput and FlowOutput). When called, it passes these variables to a [Slack Webhook](https://slack.com/help/articles/360041352714-Create-more-advanced-workflows-using-webhooks) triggering a [Slack Workflow](https://slack.com/help/articles/360035692513-Guide-to-Workflow-Builder).

## Setup
To make this work, both Salesforce and Slack need to be configured.

[SlackCallout](/force-app/main/default/classes/SlackCallout.cls)
- Specify Input variables to be called from within your Flow
- Add these variables to the JSON body of your HttpRequest
- Add the Slack webhook URL

[Slack Workflow](https://slack.com/help/articles/360035692513-Guide-to-Workflow-Builder)
- Create a new workflow that is triggered via [webhook](https://slack.com/help/articles/360041352714-Create-more-advanced-workflows-using-webhooks).
- Configure workflow variables - these need to be the same as the ones you've specified in the JSON body of your HttpRequest
- Use these variables to add steps to your workflow, e.g. by posting a message to a #channel

## Caveats
Slack Workflows do not currently allow us to parse variables as hyperlinks. This means that if you wanted your #channel message to include a link to a Salesforce record, it will need to be the full link, e.g. "htt<span>ps://domain.sandbox.lightning.</span>force.com/lightning/r/Contact/contactId/view" instead of [Contact Record]().