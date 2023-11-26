data "archive_file" "lambda" {
  type        = "zip"
  source_file = "source2.py"
  output_path = "source2.zip"
}

resource "aws_lambda_function" "source2_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "source2.zip"
  function_name = "source2"
  role          = "${aws_iam_role.lambda_final_role.arn}"
  handler       = "source2.lambda_handler"

  #source_code_hash = filebase64basesha256(data.archive_file.lambda.output_path)

  runtime = "python3.9"
  timeout = "10"
  #environment {
    #variables = {
     # ami_id = "ami-024e6efaf93d85776"
     # INSTANCE_TYPE	= "t2.micro"
      #KEY_NAME = "kali"
      #REGION = "us-east-2"
      #security_group_ids =
      #SUBNET_ID = "subnet-02eeefa9b6aa9942a"
   # }
  #}

}