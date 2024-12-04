resource "aws_s3_bucket" "connectus_media" {
  bucket = "connectus-media-bucket"
}

resource "aws_s3_object" "connectus_media_acl" {
  bucket = aws_s3_bucket.connectus_media.bucket
  key    = "key.pem"  # Name of the object in the bucket
  source = "/home/ryan/lab-final-laisensei/lab-final-laisensei/key.pem"  # Absolute path to the local file
  acl    = "private"
}


