terraform {
  backend "remote" {
    organization = "cm-natsume-yuta"

    workspaces {
      name = "terraform-version-up-test"
    }
  }

  required_providers {
    aws = "~> 3.0"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

data "aws_iam_policy_document" "first" {
  statement {
    sid = "SidToOverride"
    actions = ["s3:*"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "second" {
  override_json = data.aws_iam_policy_document.first.id

  statement {
    actions = ["ec2:*"]
    resources = ["*"]
  }

  statement {
    sid = "SidToOverride"
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::somebucket",
      "arn:aws:s3:::somebucket/*"
    ]
  }
}
