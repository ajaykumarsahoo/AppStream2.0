#IAM Roles
resource "aws_iam_role" "appstream_role" {
  name = "appstream-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "appstream.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = local.fleet_tags
}

resource "aws_iam_role_policy" "appstream_s3_access" {
  name = "appstream-s3-access"
  role = aws_iam_role.appstream_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = [
          "arn:aws:s3:::*",
          "arn:aws:s3:::*/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "appstream_s3_access_attachment" {
  role       = aws_iam_role.appstream_role.name
  policy_arn = aws_iam_role_policy.appstream_s3_access.arn
}


