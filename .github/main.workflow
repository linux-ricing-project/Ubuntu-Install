workflow "Deploy Release" {
  on = "push"
  resolves = ["frankjuniorr/github-create-release-action@dev"]
}

action "frankjuniorr/github-create-release-action@dev" {
  uses = "frankjuniorr/github-create-release-action@dev"
  secrets = ["GITHUB_TOKEN"]
}