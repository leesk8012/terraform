provider "aws" {
  region = "ap-northeast-2"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
}

module "leesk" {
    source = "./leesk-test"
}