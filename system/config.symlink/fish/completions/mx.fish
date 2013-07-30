set -l arguments (ls -l $PROJECTS | grep '^d' | awk '{printf $NF" "}')

complete --arguments "$arguments" --command mx --no-files
