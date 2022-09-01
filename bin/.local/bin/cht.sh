#!/usr/bin/env bash

lang=$(echo "bash python java golang" | tr ' ' '\n')
core_utils=$(echo "xargs sed jq awk tar" | tr ' ' '\n')

selected=$(echo -e "$lang\n$core_utils" | fzf)

echo "Selected $selected"
read -p "Query: " query
query=$(echo $query | tr ' ' '+')

if  echo $lang | grep -qs "$selected"
then
    echo "Language"
    curl cheat.sh/$selected/$query & while [ : ]; do sleep 1; done
else
    echo "Coreutils"
    curl cheat.sh/$selected~$query & while [ : ]; do sleep 1; done
fi
