workflow "Deploy Release" {
  on = "push"
  resolves = ["Github Create Release"]
}

action "Github Create Release" {
  uses = "frankjuniorr/github-create-release-action/action-github-create-release@master"
  secrets = ["GITHUB_TOKEN"]
}