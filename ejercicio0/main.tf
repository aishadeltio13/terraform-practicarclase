
resource "local_file" "pet" {
    filename= var.filenameD
    content= var.contentD
    file_permission= "0644"
}

resource "local_sensitive_file" "personas" {
    filename=var.filenameP
    content= var.contentP
}

resource "random_pet" "server" {
    prefix= "child"
    length= 1
    separator = "-"
}

resource "random_shuffle" "a" {
    input= ["saul", "noelia", "fran"]
}

resource "random_password" "password" {
  length           = 16
  special          = var.password_change
}