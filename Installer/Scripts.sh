#!/bin/zsh

function organize_file_by_organization() {
    unset __organized_file
    
    file="$1"
    organization="$2"

    if echo "$file" | grep -q ".download$"
    then
        __organized_file="$file"
    else
        folder="$file:h"
        destination="$folder/$organization"
        mkdir -p "$destination"

        filename="$file:t"
        __organized_file="$destination/$filename"
        mv "$file" "$__organized_file"
    fi
}

function organize_file_by_extension() {
    file="$1"
    extension="$file:t:e"
    organize_file_by_organization "$file" "$extension"
    echo $__organized_file
}

function organize_file_by_current_date() {
    file="$1"
    current_date=`date +%Y-%m-%d`
    organize_file_by_organization "$file" "$current_date"
    echo $__organized_file
}

function organize_file_by_creation_date() {
    file="$1"
    creation_date=`stat -t '%Y-%m-%d' "$file" | cut -d ' ' -f 12 | cut -d '"' -f 2`
    organize_file_by_organization "$file" "$creation_date"
    echo $__organized_file
}
