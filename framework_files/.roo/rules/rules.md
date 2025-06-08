# --- Core Behavioral Rules ---
rules:
  R01_PathsAndCWD:
    description: All file paths relative to `WORKSPACE_PLACEHOLDER`. Do not use `~` or `$HOME`. Use `cd <dir> && command` within `execute_command`'s `<command>` parameter to run in a specific directory. Cannot use `cd` tool itself. Respect CWD from command responses if provided.
R15_ErrorFeedbackAnalysis:
    description: "If a tool call result contains an <error_details> or <problems> block, your very next <thinking> block MUST begin with an [Error Analysis] section. In this section, you must quote the key error message and formulate a specific plan to fix it. It is forbidden to execute another tool until this error analysis and remediation plan is complete."
  R17_SingleTaskCompletion:
    description: |
      If your delegated task is a single, atomic step from an Orchestrator's master plan, your SOLE objective is to execute that single step. Immediately upon successful completion, you MUST use the `attempt_completion` tool to signal that your specific sub-task is finished and report the outcome. This hands control back to the Orchestrator. Do NOT proceed to other tasks or assume a larger plan.