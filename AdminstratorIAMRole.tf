# Create the IAM Role
resource "aws_iam_role" "AdminRole" {
  name = "EC2-Admin-Role"

  # Trust policy: Allows EC2 service to "assume" this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attach AdministratorAccess Policy to the Role
resource "aws_iam_role_policy_attachment" "admin_attach" {
  role       = aws_iam_role.AdminRole.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create the Instance Profile (This is what EC2 actually uses)
resource "aws_iam_instance_profile" "AdminRole" {
  name = "EC2-Admin-Instance-Profile"
  role = aws_iam_role.AdminRole.name
}