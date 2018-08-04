# Useful scripts
This repository contains scripts for easier work with miscellaneous tools.

_All scripts were tested in `Git Bash` on Windows 10._

## Postcardware download
This repository is available under postcardware license. If you using mine scripts, please send me a postcard from your hometown. My address is no longer available at this public site - I give you my address if you write me to: seki.php@gmail.com Thank you!

# git/commit_helper.sh
Script for faster commiting and checking changes.

**Command syntax:** `gch`

### Recommended settings:
Fix spaces & UTF characters in filename: `git config core.quotepath off`

# git/branch_update.sh
Script for updating current branch from master branch.

**Command syntax:** `gbu`

# git/branch_create.sh
Create new branch based on current version of master branch. First argument is used as name of new branch.

**Command syntax:** `gbc NEW_BRANCH_NAME [-b FROM_BRANCH]`

**Examples:**
```console
gbc my_new_branch
gbc my_new_branch -b master
gbc my_new_branch -b develop
```

## Create commands:

Add line below to file: `~/.bashrc` or `~/.bash_profile`
```console
alias gch=path/to/commit_helper.sh
alias gbu=path/to/branch_update.sh
alias gbc=path/to/branch_create.sh
```

_You can do something like that: `echo "alias ..." >> ~/.bashrc`_