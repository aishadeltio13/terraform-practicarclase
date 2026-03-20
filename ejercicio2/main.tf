resource "local_file" "random_mascota" {
    filename= "random_mascota.txt"
    content= "${var.file-content["statement1"]}"
    depends_on = [random_pet.random]
}

resource "random_pet" "random" {
}

