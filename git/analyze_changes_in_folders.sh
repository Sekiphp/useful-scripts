#!/bin/bash

COLOR_RED="\033[0;31m"
COLOR_BG_RED="\033[41m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\e[36m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

clear

# how many repositories to inspect at once (defaults to number of CPU cores)
JOBS="${GAF_JOBS:-$(nproc 2>/dev/null || echo 4)}"

# show mode
if [[ "$1" = "--empty" ]];
then
    echo "Show all directories..."
else
    echo "Show only repositories with uncommitted changes..."
    echo "You can use --empty flag to show all folder"
fi

# worker: inspect a single folder and write the result to $TMPDIR/<index>
# output format - first line is a status code, the rest is the git status:
#   NOTGIT   -> folder is not a git repository
#   DIRTY    -> repository has uncommitted changes (followed by the status)
#   CLEAN    -> repository is clean
inspect_folder() {
    local idx="$1" folder="$2"
    local out="${TMPDIR}/${idx}"

    local toplevel
    toplevel=$(git -C "$folder" rev-parse --show-toplevel 2>/dev/null)

    if [[ "$toplevel" != "$(pwd)/${folder}" ]];
    then
        echo "NOTGIT" > "$out"
        return
    fi

    local status
    status=$(git -C "$folder" status -su)

    if [[ -n "$status" ]];
    then
        { echo "DIRTY"; echo "$status"; } > "$out"
    else
        echo "CLEAN" > "$out"
    fi
}
export -f inspect_folder

# collect folders
folders=()
while IFS= read -r folder;
do
    folders+=("$folder")
done < <(ls -d */ 2>/dev/null | tr -d "/")

# inspect every folder in parallel
TMPDIR=$(mktemp -d)
export TMPDIR
for idx in "${!folders[@]}";
do
    printf '%s\t%s\n' "$idx" "${folders[$idx]}"
done | xargs -P "$JOBS" -d '\n' -I {} bash -c '
    line="{}"
    inspect_folder "${line%%	*}" "${line#*	}"
'

# print the results in the original order with a running counter
i=1
for idx in "${!folders[@]}";
do
    folder="${folders[$idx]}"
    out="${TMPDIR}/${idx}"
    status_code=$(head -n 1 "$out")

    if [[ "$status_code" = "NOTGIT" ]];
    then
        echo -e "$COLOR_RED"
        echo "Folder ${folder} is not git repository!"
        continue
    fi

    if [[ "$status_code" = "DIRTY" ]] || [[ "$1" = "--empty" ]];
    then
        echo -e "$COLOR_BG_RED" "$i" "$COLOR_RESET" "$COLOR_BLUE" "Showing git status of folder: ${folder}"
        i=$((i + 1))
    fi

    if [[ "$status_code" = "DIRTY" ]];
    then
        echo -e "$COLOR_WHITE"
        tail -n +2 "$out"
        echo -e "\n"
    fi
done

rm -rf "$TMPDIR"
