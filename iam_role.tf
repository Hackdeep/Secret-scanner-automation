resource "aws_iam_policy" "lambda_final_policy" {
  name = "lambda_final_policy"
  #role = "${aws_iam_role.lambda_final_role.id}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = "${file("lambda_attach_policy.json")}"
}

resource "aws_iam_role" "lambda_final_role" {
  name = "lambda_final_role"

  assume_role_policy = "${file("lambda_assume_role.json")}"
}

#create role and policy for ec2 instance 
resource "aws_iam_policy" "ec2_final_policy" {
  name = "ec2_final_policy"
  #role = "${aws_iam_role.ec2_final_role.id}"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = "${file("ec2_attach_policy.json")}"
}

resource "aws_iam_role" "ec2_final_role" {
  name = "ec2_final_role"

  assume_role_policy = "${file("ec2_assume_role.json")}"
}

resource "aws_iam_instance_profile" "final_ec2_profile" {
  name = "final_ec2_profile"
  role = "${aws_iam_role.ec2_final_role.name}"
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  policy_arn = aws_iam_policy.lambda_final_policy.arn
  role = aws_iam_role.lambda_final_role.name
  
}

resource "aws_iam_role_policy_attachment" "ec2_attach" {
  policy_arn = aws_iam_policy.ec2_final_policy.arn
  role = aws_iam_role.ec2_final_role.name
  
}
