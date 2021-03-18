################################
#CRIAÇÃO DO PROVISIONAMENTO AWS
################################


provider "aws" {
	region = "us-east-1"
	access_key = "${var.chaveacesso}" 
	secret_key = "${var.chavesecreta}"
}

