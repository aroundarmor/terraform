terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "aroundarmor"

    workspaces {
      name = "terraform-playground"
    }
  }
}