# SOP-08: Git Workflow Protocol

## 1. Principle

All version control operations MUST be executed with full awareness of the project's directory structure and any running processes that may cause resource conflicts. This protocol prevents common errors related to incorrect working directories and file locking.

## 2. Procedure

### Step 1: Identify Project Root

At the beginning of any task involving Git, confirm the correct project subdirectory that contains the `.git` folder (e.g., `framework-template`).

### Step 2: Enforce Correct Working Directory

All `execute_command` calls for `git` operations (e.g., `status`, `checkout`, `merge`, `commit`, `push`) MUST use the `cwd` parameter to specify the correct project root directory identified in Step 1.

**Example:**
```xml
<execute_command>
  <cwd>framework-template</cwd>
  <command>git status</command>
</execute_command>
```

### Step 3: Manage Process Conflicts

Before executing any Git command that modifies the working tree (`checkout`, `merge`, `rebase`, `stash`, `pull`), you MUST check for active MCP servers (like `conport`) that could be locking files.

1.  **Identify Conflict:** If a server like `conport` is active, identify it as a potential conflict.
2.  **Request Shutdown:** Use the `ask_followup_question` tool to inform the user of the conflict and request that they temporarily disable the server through their IDE's MCP settings.
3.  **Execute Git Operation:** Proceed with the Git command ONLY after the user confirms the server has been disabled.
4.  **Request Restart:** After the Git operation is complete, use `ask_followup_question` again to remind the user to re-enable the server to restore full functionality.

## 3. Justification

This SOP is a direct result of the analysis of failures in logs `roo_task_jun-8-2025_4-21-30-am.md` and `roo_task_jun-8-2025_4-34-14-am.md`, where workspace ambiguity and file locking by the `conport` server caused critical, unrecoverable errors in the Git workflow.