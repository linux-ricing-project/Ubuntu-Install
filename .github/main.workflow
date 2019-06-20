workflow "Deploy Release" {
  on = "push"
  resolves = ["Github Create Release"]
}

action "Github Create Release" {
  uses = "frankjuniorr/github-create-release-action@master"
  secrets = ["GITHUB_TOKEN"]
  env = {VERSION  = "2.0"}
}