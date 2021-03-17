provider "aws" {
	region = "us-east-1"
	access_key = "${var.chavedeacesso}" 
	secret_key = "${var.chavesecreta}"
}