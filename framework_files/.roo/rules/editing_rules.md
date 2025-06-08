# Editing Rules

This document specifies rules for file modifications:
- File change protocols
- Version control requirements
- Change approval workflows
- Backup procedures

R13_FileEditPrecision:
  description: |
      When making file edits, you MUST:
      - Use the exact line numbers from the most recent file read
      - Preserve all whitespace and formatting
      Analyze the `read_file` result to get accurate line numbers and the exact content needed for your edit operation.
R14_FileEditErrorRecovery:
  description: |
      If a file modification tool (`apply_diff`, `insert_content`, `write_to_file`) fails, your immediate next step MUST be to use the `read_file` tool to read the entire content of the target file and get the current line numbers.
      Analyze the fresh file content and the error details to understand the failure.
      Re-evaluate the required changes based on the current file state and the error, then attempt the modification again with corrected parameters.
      Upon a second failure of apply_diff or insert_content, your next step, after using read_file again, must be to use the write_to_file tool to overwrite the entire file with the revised content.