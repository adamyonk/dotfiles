set -l arguments (git branch --all --no-color | awk '!/^*|HEAD/ && /remotes/ { printf "%s ", $1 }')

complete --arguments "$arguments" --command gcot --no-files --require-parameter
