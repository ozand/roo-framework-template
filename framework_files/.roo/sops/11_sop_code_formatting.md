# SOP 11: Code Formatting

## 1. Principle

All source code MUST be formatted using the project's designated formatting tool before being committed. This ensures a consistent and readable codebase, regardless of who or what wrote the code.

## 2. Procedure

1.  **Identify Tool:** The primary formatting tool for this project is `ruff format`. The configuration is stored in `pyproject.toml` or `.ruff.toml`.
2.  **Execution:** After writing or modifying code files, the agent MUST execute the formatting command on the changed files.

    **Example command:**
    ```xml
    <execute_command>
      <command>ruff format .</command>
    </execute_command>
    ```

## 3. Agent Responsibility

- The `sparc-autocoder` and `sparc-refiner` agents are responsible for adhering to this SOP.
- Before handing off code for committing or review, the agent must ensure it has been formatted.