# Useful scripts
This repository contains scripts for easier work with miscellaneous tools.

_All scripts were tested in `Git Bash` on Windows 10 and in terminal of Ubuntu._

## Postcardware download
This repository is available under postcardware license. If you using mine scripts, please send me a postcard from your hometown. My address is no longer available at this public site - I give you my address if you write me to: seki.php@gmail.com Thank you!

# git/commit_helper.sh
Script for faster commiting and checking changes.
![image](https://github.com/Sekiphp/useful-scripts/assets/9967016/477932db-2cde-465b-a6b4-e67c4dc60ca2)


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

# git/branch_delete.sh
Delete specified branch (local + remote).

**Command syntax:** `gbd BRANCH_NAME`

# git/analyze_changes_in_folders.sh
If you are working with a large number of repositories (vendor), it is good to know where the changed files are.
![image](https://github.com/Sekiphp/useful-scripts/assets/9967016/bc6e39e3-5480-4f59-8ad3-704062ca7c0a)


## Create commands:

Add line below to file: `~/.bashrc` or `~/.bash_profile`
```console
alias gch=path/to/git/commit_helper.sh
alias gbu=path/to/git/branch_update.sh
alias gbc=path/to/git/branch_create.sh
alias gsu=path/to/git/set_upstream_to.sh
alias gaf=path/to/git/analyze_changes_in_folders.sh
alias gbd=path/to/git/branch_delete.sh
alias tag=path/to/git/create_tag.sh
```

_You can do something like that: `echo "alias ..." >> ~/.bashrc`_


## Special thanks to:
[Milan Davídek](https://github.com/midlan)
