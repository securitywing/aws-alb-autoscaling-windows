resource "aws_key_pair" "example-keypair" {
  key_name = "example-pair"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
  lifecycle {
    ignore_changes = ["public_key"]
  }
}
