# node-refresher
simple node app with refresh from git branch

## Status

- 5 June 2017 - this is under testing. Use at your own risk but feedback, PR, Issues Welcome

## About
This is a minimal extension of the `repo-refresher` for node application. It uses the same cron hook to schedule a periodic refresh of the node app by comparing current with running commit version. It has some logic to rollback the commit if npm can't restart app, but this has not been tested yet.

## What it does
- (inherited) **Polls** git for newer versions of `repository` or `repository/branch`
- **Installs** and **Starts** your node app once it finds a valid `package.json` in the appropriate directory
- **Checks** for an updated commit and restarts your app from the new commit. (`repo-refresher` takes care of checking out new commit)
- **Rollsback** commit and restarts your app if the latest commit fails to start

## What it doesn't do
- **Tests** this will prob come

