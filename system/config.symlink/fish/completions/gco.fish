set -l arguments (git branch --all --no-color | awk '!/^*|HEAD/ { printf "%s ", $1 }' | sed s_remotes/__)

complete --arguments "$arguments" --command gco --no-files --require-parameter
complete --command gco --long-option track --short-option t
