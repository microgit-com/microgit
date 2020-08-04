# Microgit

Microgit is meant to be a self-hosting open source that will be an alternative to gitlab. See this as a crystal version of gitea but with own design.

## What it can do now:
* Git pull/push/fetch
* See tree of files
* See last commit
* See commit list
* See branch list
* see commits for specific branch
* See diffs
* See file content (non-binary files)
* Create issues
* Create Merge Requests
* See diff of merge request compare to master
* Commenting on merge request
* Commenting on issue
* Merge merge request
* teams
* user invite to team

## What is left to be done:
* Better handling of git updates, using git hooks
* Squash merge
* add labels to issues and merge requests
* Show logs of changes on issue and merge requests
* add related issue, merge requests
* Better assignee and owner handling
* optmization
* Cleaning up code
* Upgrades of Lucky and Crystal
* tests
* ssh support?

This is a project written using [Lucky](https://luckyframework.org). Enjoy!

### Setting up the project

1. [Install required dependencies](https://luckyframework.org/guides/getting-started/installing#install-required-dependencies)
1. Update database settings in `config/database.cr`
1. Run `script/setup`
1. Run `lucky dev` to start the app

## Contributing
Microgit is built to be fully open and transparent. You can help contribute and do push this project forward.

Fork this repo, add push your changes to a new branch and create an pull request.
