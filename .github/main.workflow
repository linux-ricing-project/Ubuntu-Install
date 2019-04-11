workflow "Deploy Release" {
  on = "push"
  resolves = ["frankjuniorr/github-create-release-action@master"]
}

action "frankjuniorr/github-create-release-action@master" {
  uses = "frankjuniorr/github-create-release-action@master"
  secrets = ["GITHUB_TOKEN"]
}