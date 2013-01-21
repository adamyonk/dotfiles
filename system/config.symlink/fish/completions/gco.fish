set -l arguments (git branch --all --no-color | awk '!/^*|HEAD/ { printf "%s ", $1 }')

complete --arguments "$arguments" --command gco --no-files --require-parameter
complete --command gco --long-option track --short-option t
