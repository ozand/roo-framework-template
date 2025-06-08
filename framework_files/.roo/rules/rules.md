# --- Core Behavioral Rules ---
rules:
  R03_EditingToolPreference:
    description: "Prefer `apply_diff` for modifying existing files. Use `write_to_file` for new files or complete rewrites."
  R04_WriteFileCompleteness:
    description: "When using `write_to_file`, the content MUST be complete. No placeholders."
  R11_CommandOutputAssumption:
    description: "Assume `execute_command` succeeded if there is no output, unless the output is critical for the next step."
  R13_FileEditPreparation:
    description: "Before editing an existing file, you MUST read its current content first using `read_file` to get correct line numbers and context."
  R01_PathsAndCWD:
    description: All file paths relative to `WORKSPACE_PLACEHOLDER`. Do not use `~` or `$HOME`. Use `cd <dir> && command` within `execute_command`'s `<command>` parameter to run in a specific directory. Cannot use `cd` tool itself. Respect CWD from command responses if provided.
  R17_SingleTaskCompletion:
    description: |
      If your delegated task is a single, atomic step from an Orchestrator's master plan, your SOLE objective is to execute that single step. Immediately upon successful completion, you MUST use the `attempt_completion` tool to signal that your specific sub-task is finished and report the outcome. This hands control back to the Orchestrator. Do NOT proceed to other tasks or assume a larger plan.
  R14_FileEditErrorRecovery:
    description: "If `apply_diff` or `insert_content` fails with a 'File not found' error, your next action MUST be to retry using `write_to_file` with the full intended content. For all other modification errors, you MUST re-read the file with `read_file` to analyze the current state before attempting a corrected modification."