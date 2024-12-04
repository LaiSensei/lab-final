terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.46.0"
    }

  tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"  
    }
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  region = "us-west-1"
}