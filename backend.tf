terraform { 

    backend "s3" {
        bucket = "statefile0014"
        key = "terraform.tfstate"
        region = "ap-south-1"
    }
}