# Useful scripts

## Postcardware download
This repository is available under postcardware license. If you using my scripts, please send me a postcard from your hometown. My address is no longer available at this public site - I give you my address if you write me to: seki.php@gmail.com Thank you!

## git/commit_helper.sh
Script for faster commiting and checking changes.

##### Settings:
Fix spaces & UTF characters in filename:
```
git config core.quotepath off
```
##### Create command:

Add line below to file: `~/.bashrc`
```
alias gch=path/to/commit_helper.sh
```

## git/branch_update.sh
Script for updating current branch from master branch.

##### Create command:

Add line below to file: `~/.bashrc`
```
alias gbu=path/to/branch_update.sh
```

## git/branch_create.sh
Create new branch based on current version of master branch. First argument is used as name of new branch.

##### Create command:

Add line below to file: `~/.bashrc`
```
alias gbc=path/to/branch_create.sh
```