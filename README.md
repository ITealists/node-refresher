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

### What it doesn't do
- **Tests** this will prob come
- **Application Logic** it's expected that this can serve as a basis for your own docker which takes care of any other build or run commands you need. 


## Configuration

### Standalone
You can use the docker as a standalone for simple node apps that only need `npm start`. 

### As a base for other dockers
You can build a docker on top of this one and add in any commands needed. Although the built in logic will attempt to do a git clone, if you have already moved your repository in this step will fail and it will just move on to the next step, no harm - no foul.
It should then still pick up the git-refresh automation and keep your repo in sync.

If you provide your own startups instead of using the `crond` mechanism, you may need to include the start up for this in your own `CMD` or `ENTRYPOINT`

    crond -l2 -f
    
### Environment Variables

- See [repo-refresher]() for inherited vars used to setup git sync and refresh rate
- `REPO` - set for `repo-refresher` too, used here to navigate to the application directory before `npm` commands
- `NODE_DIR` - in an app with multiple layers, this provides the directory containing `package.json`
- `RUNNING_COMMIT` - this is set but the `node-runner` process and tells you what commit your app is running on
