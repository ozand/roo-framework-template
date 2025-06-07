# SOP 07: Cross-Platform Shell Command Execution

## 1. Principle

To ensure robustness and avoid errors, all shell commands must be executed with awareness of the target operating system (OS). The agent MUST NOT assume a Unix-like environment. Trial-and-error execution is inefficient and should be avoided.

## 2. Procedure

### Step 1: Identify the Environment

Early in the task, determine the host OS. Look for clues in file paths (`\\` for Windows, `/` for Unix-like), previous command outputs, or environment variables.

### Step 2: Use OS-Specific Commands

When executing basic shell commands, use the correct syntax for the identified OS. Refer to the table below for common commands.

| Task | Unix/Linux/macOS | Windows (PowerShell) |
| :--- | :--- | :--- |
| **List Files** | `ls -la` | `Get-ChildItem` (alias: `ls`, `gci`) |
| **Create Directory** | `mkdir -p /path/to/dir` | `mkdir \\path\\to\\dir` or `New-Item -ItemType Directory -Path \\path\\to\\dir` |
| **Remove File(s)** | `rm file1 file2` | `Remove-Item file1, file2` or `rm file1; rm file2` |
| **Remove Directory** | `rm -rf /path/to/dir` | `Remove-Item -Recurse -Force \\path\\to\\dir` |
| **Move Item** | `mv source dest` | `Move-Item -Path source -Destination dest` |
| **Copy Directory**| `cp -r source dest` | `Copy-Item -Recurse -Path source -Destination dest` |
| **Make Executable** | `chmod +x script.sh` | (Not directly applicable. Execution policy may apply.) |

### Step 3: Author Cross-Platform Scripts

When creating scripts for automation (e.g., installers), provide versions for both Windows (`.cmd` or `.ps1`) and Unix-like (`.sh`) environments. Do not attempt to execute a script in an incompatible shell (e.g., running `chmod +x` or a `.sh` file on Windows).

## 3. Justification

This SOP is based on analysis of `roo_task_jun-8-2025_12-14-18-am.md`. In that log, the agent repeatedly failed by attempting to use Unix-native commands (`mkdir` with multiple arguments, `chmod`, `rm -rf`) in a Windows PowerShell environment. These failures required extra recovery steps, reducing efficiency. This SOP provides a clear protocol to prevent such errors.