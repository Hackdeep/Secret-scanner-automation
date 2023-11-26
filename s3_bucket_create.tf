resource "aws_s3_bucket" "trufflehog-git-scan-log" {
    bucket = "trufflehog-git-scan-log"
    acl = "private"

    tags = {
      Name = "My bucket"
    }
  
}

resource "aws_s3_object" "trufflehog-git-result-folder" {
    key = "trufflehog-result-folder/"
    bucket = aws_s3_bucket.trufflehog-git-scan-log.id
  
}

resource "aws_s3_bucket_public_access_block" "trufflehog-git-scan-log" {
    bucket = aws_s3_bucket.trufflehog-git-scan-log.id

     #blocking public access
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true

}