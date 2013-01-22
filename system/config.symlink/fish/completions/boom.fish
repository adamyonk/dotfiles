set -l arguments (boom all | sed 's/://' | awk '{printf "%s ", $1}')

complete --arguments "$arguments" --command boom --no-files
