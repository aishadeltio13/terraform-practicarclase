resource "local_file" "saludo" {
    filename= "saludo.txt"
    content= "${var.file-content["statement1"]} ${var.prefix[0]}"
}

resource "local_file" "despedida" {
    filename= "despedida.txt"
    content= "${var.file-content["statement2"]} ${var.prefix[1]}"
}

resource "random_pet" "random" {
}

resource "local_file" "random_mascota" {
    filename= "random_mascota.txt"
    content= "${var.file-content["statement1"]} ${random_pet.random.id}"
}

