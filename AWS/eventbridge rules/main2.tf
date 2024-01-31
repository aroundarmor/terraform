#provider block for access
provider "aws" {
  region = "us-west-2"
  access_key = "access_key"
  secret_key = "secret_key"
}
 
#creating eventbridge event rule
#1
resource "aws_cloudwatch_event_rule" "config" {
  name = "AWSConfigChanges"
  description = "Rule [SecurityAlert] Changes in AWSConfig"
  event_pattern = file("AWSConfigChanges.json")
}

#2
resource "aws_cloudwatch_event_rule" "mfa" {
  name = "ConsoleSignInWithoutMfa"
  description = "Rule [SecurityAlert] Without MFA Login"
  event_pattern = file("ConsoleSignInWithoutMfa.json")
}

#3
resource "aws_cloudwatch_event_rule" "org" {
  name = "OrganizationsChanges"
  description = "Rule [SecurityAlert] AWS Organization Changes"
  event_pattern = file("OrganizationsChanges.json")
}

#4
resource "aws_cloudwatch_event_rule" "auth" {
  name = "AuthorizationFailureCount"
  description = "Rule [SecurityAlert] Login Failure UnauthorizedOperation"
  event_pattern = file("AuthorizationFailureCount.json")
}

#5
resource "aws_cloudwatch_event_rule" "cmk" {
  name = "AWSCMKChanges"
  description = "Rule [SecurityAlert] CMK Schedule Deletion and Disable Key"
  event_pattern = file("AWSCMKChanges.json")
}

#6
resource "aws_cloudwatch_event_rule" "trail" {
  name = "AWSCloudTrailChanges"
  description = "Rule [SecurityAlert] AWS CloudTrail configuration changes"
  event_pattern = file("AWSCloudTrailChanges.json")
}

#7
resource "aws_cloudwatch_event_rule" "signin" {
  name = "AWSConsoleSignInFailures"
  description = "Rule [SecurityAlert] AWS Signin Failures"
  event_pattern = file("AWSConsoleSignInFailures.json")
}

#8
resource "aws_cloudwatch_event_rule" "instance" {
  name        = "EC2InstanceStatusChanges"
  description = "Rule [SecurityAlert] AWS EC2 instance changes"
  event_pattern = file("EC2InstanceStatusChanges.json")
}

#9
resource "aws_cloudwatch_event_rule" "large" {
  name = "LaunchEC2LargeInstances"
  description = "Rule [SecurityAlert] AWS EC2 large instance changes"
  event_pattern = file("LaunchEC2LargeInstances.json")
}

#10
resource "aws_cloudwatch_event_rule" "iam" {
  name = "IAMAuthConfigChanges"
  description = "Rule [SecurityAlert] AWS IAM policy configuration changes"
  event_pattern = file("IAMAuthConfigChanges.json")
}

#11
resource "aws_cloudwatch_event_rule" "s3" {
  name = "S3BucketConfigChanges"
  description = "Rule [SecurityAlert] AWS S3 Buckets configuration changes"
  event_pattern = file("S3BucketConfigChanges.json")
}

#############################################################################################################
#configuring sns topic
#1
resource "aws_cloudwatch_event_target" "config" {
  rule      = aws_cloudwatch_event_rule.config.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.aws_logins.arn
}

#2
resource "aws_cloudwatch_event_target" "mfa" {
  rule = aws_cloudwatch_event_rule.mfa.name
  target_id = "SendToSNS"
  arn = aws_sns_topic.aws_logins.arn
}

#3
resource "aws_cloudwatch_event_target" "org" {
  rule = aws_cloudwatch_event_rule.org.name
  target_id = "SendToSNS"
  arn = aws_sns_topic.aws_logins.arn
}

#4
resource "aws_cloudwatch_event_target" "auth" {
  rule = aws_cloudwatch_event_rule.auth.name
  target_id = "SendToSNS"
  arn = aws_sns_topic.aws_logins.arn
}

#5
resource "aws_cloudwatch_event_target" "cmk" {
  rule = aws_cloudwatch_event_rule.cmk.name
  target_id = "SendToSNS"
  arn = aws_sns_topic.aws_logins.arn
}

#6
resource "aws_cloudwatch_event_target" "trail" {
  rule = aws_cloudwatch_event_rule.trail.name
  target_id = "SendToSNS"
  arn = aws_sns_topic.aws_logins.arn
}

#7
resource "aws_cloudwatch_event_target" "signin" {
  rule = aws_cloudwatch_event_rule.signin.name
  target_id = "SendToSNS"
  arn = aws_sns_topic.aws_logins.arn
}

#8
resource "aws_cloudwatch_event_target" "instance" {
  rule      = aws_cloudwatch_event_rule.instance.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.aws_logins.arn
}

#9
resource "aws_cloudwatch_event_target" "large" {
  rule = aws_cloudwatch_event_rule.large.name
  target_id = "SendToSNS"
  arn = aws_sns_topic.aws_logins.arn
}

#10
resource "aws_cloudwatch_event_target" "iam" {
  rule = aws_cloudwatch_event_rule.iam.name
  target_id = "SendToSNS"
  arn = aws_sns_topic.aws_logins.arn
}

#11
resource "aws_cloudwatch_event_target" "s3" {
  rule = aws_cloudwatch_event_rule.s3.name
  target_id = "SendToSNS"
  arn = aws_sns_topic.aws_logins.arn
}


#Alert set
resource "aws_sns_topic" "aws_logins" {
  name = "AWSSecurityAlerts"
}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.aws_logins.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.aws_logins.arn]
  }
}
