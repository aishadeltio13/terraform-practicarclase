variable file-content {
    type = map
    default = {
        "statement1" = "Hola"
        "statement2" = "Adiós"
    }
}

variable prefix {
    default = ["Mr", "Ms", "Sir"]
    type = list(string)
}


variable prefix2 {
    default = ["1", "2", "3"]
    type = list(string)
}

variable cats {
    default = {
        "color" = "black"
        "name" = "michi"   
        }
    type = map(string)  
}

variable pet_count {
    default = {
        "dogs" = 2
        "cats" = 3
    }
    type = map(number)
}


