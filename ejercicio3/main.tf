resource "random_pet" "random" {
}

resource "github_repository" "crear_repositorio" {
  name        = random_pet.random.id
  description = "Este es un repositorio de prueba creado desde Terraform"
  visibility  = "public" 
  auto_init   = true # Inicia el repositorio con un README.md y se crea la rama principal automáticamente
}

resource "github_branch" "rama_develop" {
  repository = github_repository.crear_repositorio.name
  branch     = "develop"
  
  depends_on = [github_repository.crear_repositorio] # Primero creamos el repositorio, luego la rama
}

resource "github_repository_collaborator" "colaborador" {
  repository = github_repository.crear_repositorio.name
  username   = var.usuario # Usuario de Github

  depends_on = [github_repository.crear_repositorio]
}

resource "github_branch_protection" "proteccion_ramas" {
  for_each = toset(["main", "develop"]) # Ramas a proteger

  repository_id  = github_repository.crear_repositorio.id
  pattern        = each.key
  
  # Include administrators
  enforce_admins = true

  # Require pull request reviews before merging
  required_pull_request_reviews {
    # Dismiss stale pull request approvals when new commits are pushed
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }

  # Require status checks to pass before merging
  required_status_checks {
    # Require branches to be up to date before merging
    strict = true
  }

  depends_on = [
    github_repository.crear_repositorio,
    github_branch.rama_develop
  ]
}

resource "github_actions_secret" "repo_secret_password" {
  repository      = github_repository.crear_repositorio.name
  secret_name     = "PASSWORD" 
  plaintext_value = var.secret_password

  depends_on = [github_repository.crear_repositorio]
}