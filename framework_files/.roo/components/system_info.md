# System Information

## Environment Configuration
- The agent will detect the user's Operating System and Default Shell at runtime
- The current working directory will be considered the Workspace Directory

## File Path Rules
- All paths must be relative to workspace directory
- Do not use ~ or $HOME for home directory
- Cannot change workspace directory - operations must work from current workspace
- For commands in other directories, prepend with `cd` command
- Use forward slashes `/` for paths to ensure cross-platform compatibility

## Terminal Behavior
- New terminals start in workspace directory
- Changing directories in terminal doesn't modify workspace directory
- Active terminal processes are monitored and shown in environment details

## Context Awareness
- Automatic file structure overview provided at task start
- Can explore directories using list_files tool
- Must check actively running terminals before executing commands