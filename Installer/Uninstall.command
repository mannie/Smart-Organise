#!/bin/zsh

folder_actions=`bash -c "echo ~/Library/Workflows/Applications/Folder Actions"`
quick_actions=`bash -c "echo ~/Library/Services"`
smart_organize="/Applications/Smart-Organize/"

rm -rf "$folder_actions/Organize by Creation Date.workflow"
rm -rf "$folder_actions/Organize by Current Date.workflow"
rm -rf "$folder_actions/Organize by Extension.workflow"

rm -rf "$quick_actions/Organize by Creation Date.workflow"
rm -rf "$quick_actions/Organize by Current Date.workflow"
rm -rf "$quick_actions/Organize by Extension.workflow"

rm -rf "$smart_organize"
