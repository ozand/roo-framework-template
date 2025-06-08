# System Information

## Environment Configuration
- **Operating System**: Windows 11
- **Default Shell**: PowerShell 7 (pwsh.exe)
- **Home Directory**: C:/Users/ozand
- **Workspace Directory**: t:/Code/python/RuRu

## File Path Rules
- All paths must be relative to workspace directory
- Do not use ~ or $HOME for home directory
- Cannot change workspace directory - operations must work from t:/Code/python/RuRu
- For commands in other directories, prepend with `cd` command

## Terminal Behavior
- New terminals start in workspace directory
- Changing directories in terminal doesn't modify workspace directory
- Active terminal processes are monitored and shown in environment details

## Context Awareness
- Automatic file structure overview provided at task start
- Can explore directories using list_files tool
- Must check actively running terminals before executing commands