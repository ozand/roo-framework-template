# SOP 12: Hybrid "Agent + Script" Tools

## 1. Principle

For complex, precise, or high-risk operations (e.g., database migrations, complex refactoring, infrastructure changes), relying solely on the probabilistic nature of an LLM is unreliable. The Hybrid Tool pattern MUST be used to ensure deterministic and predictable outcomes.

## 2. Workflow

1.  **Generate a Script:** The agent (e.g., `sparc-orchestrator` or a specialist) uses its intelligence to generate a deterministic script (e.g., SQL, Bash, Python) that performs the required operation.
2.  **Save the Script:** The agent saves this script to a file within the project (e.g., in `framework_files/scripts/generated/`).
3.  **Execute the Script:** The agent uses the `execute_command` tool to run the script via a trusted interpreter (e.g., `bash`, `python`, `psql`). The agent passes any required parameters as command-line arguments.
4.  **Verify the Output:** The agent analyzes the output (stdout/stderr) of the `execute_command` call to confirm the script executed successfully.

## 3. Example

**Task:** Add a new 'email' column to the 'users' table.

-   **WRONG:** Asking the agent to connect to the database and run a query directly.
-   **RIGHT:**
    1.  Agent generates the content for a file named `migration_001.sql`: `ALTER TABLE users ADD COLUMN email VARCHAR(255);`
    2.  Agent uses `write_to_file` to save `framework_files/scripts/generated/migration_001.sql`.
    3.  Agent uses `execute_command` to run `psql -f framework_files/scripts/generated/migration_001.sql`.