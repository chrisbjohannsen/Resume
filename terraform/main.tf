resource "aws_s3_bucket" "bucket" {

  bucket                      = "chrisbjohannsen-resume"
  object_lock_enabled         = false
  tags                        = {}
  tags_all                    = {}
}


#resource "aws_s3_bucket_policy" "bucket_policy" {
#  bucket = aws_s3_bucket.bucket.id
#  policy = <<EOT
#  {
#    "Version": "2012-10-17",
#    "Statement": [
#      {
#        "Effect": "Allow",
#        "Principal": {
#          "Federated": "arn:aws:iam::188671421216:oidc-provider/token.actions.githubusercontent.com"
#        },
#        "Action": "sts:AssumeRoleWithWebIdentity",
#        "Condition": {
#          "StringLike": {
#            "token.actions.githubusercontent.com:sub": "repo:chrisbjohannsen/Resume:*"
#          },
#          "StringEquals": {
#            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
#          }
#        }
#      }
#    ]
#  }
#  EOT
#}
resource "aws_iam_role" "gha_oidc_s3_role" {
  assume_role_policy = <<EOT
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::188671421216:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringLike": {
            "token.actions.githubusercontent.com:sub": "repo:chrisbjohannsen/Resume:*"
          },
          "StringEquals": {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
          }
        }
      }
    ]
  }
  EOT
}
