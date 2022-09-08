#!/bin/zsh

# Organize by Extension
source /Applications/Smart-Organize/Scripts.sh
for file in $@
do
    organize_file_by_extension "$file"
done

# Organize by Creation Date
source /Applications/Smart-Organize/Scripts.sh
for file in $@
do
    organize_file_by_creation_date "$file"
done

# Organize by Current Date
source /Applications/Smart-Organize/Scripts.sh
for file in $@
do
    organize_file_by_current_date "$file"
done
