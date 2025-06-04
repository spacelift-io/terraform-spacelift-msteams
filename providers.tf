terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = ">= 1.1.4"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.6.1"
    }
  }
}
