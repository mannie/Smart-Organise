#!/bin/zsh

cd "$0:h"

smart_organize="/Applications/Smart-Organize/"
mkdir -p "$smart_organize"

cp Installer/Scripts.sh "$smart_organize"
cp Installer/Uninstall.command "$smart_organize"

folder_actions=`bash -c "echo ~/Library/Workflows/Applications/Folder Actions"`
mkdir -p "$folder_actions"

cp -r Installer/FolderActions/* "$folder_actions"

quick_actions=`bash -c "echo ~/Library/Services"`
mkdir -p "$quick_actions"

cp -r Installer/QuickActions/* "$quick_actions"
