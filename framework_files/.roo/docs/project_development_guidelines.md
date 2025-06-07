# **Project Development Guidelines**

This document contains the core development rules and standards that must be followed by both human developers and AI assistants (Flow modes) throughout the project's lifecycle.

## **1\. Environment and Dependency Management**

### **1.1. Virtual Environment (CRITICAL)**

**Rule:** Before running any project-specific commands (including uv, pytest, ruff), the virtual environment **must** be activated. AI agents must verify the environment is active or activate it as the first step.

**Reasoning:** This ensures that all tools, dependencies, and scripts are executed using the correct versions isolated for this project, preventing "command not found" errors and version conflicts.

-   **Activation (Linux/macOS):**  
    source .venv/bin/activate

-   **Activation (Windows):**  
    .venv\\Scripts\\activate

### **1.2. Package Management**

-   **Tool:** **Exclusively uv** must be used for Python package management. The direct use of pip is forbidden.
-   **Installation:** Add new dependencies with uv add \[package-name\].
-   **Running Tools:** Execute package scripts via uv run \[tool-name\].
-   **Upgrading:** Use uv add \--dev \[package-name\] \--upgrade-package \[package-name\] for upgrades.
-   **Forbidden:** The use of uv pip install and the @latest syntax is not allowed to ensure deterministic builds.

## **2\. Code Quality and Style**

-   **Typing:** All code must include type hints.
-   **Documentation:** All public APIs (functions, classes, modules) must have detailed docstrings.
-   **Function Size:** Functions should be small, focused, and perform a single logical task.
-   **Pattern Adherence:** Strictly follow the existing architectural and style patterns within the project.
-   **Line Length:** The maximum line length is 88 characters.

## **3\. Testing**

-   **Framework:** Tests are run using uv run pytest.
-   **Asynchronous Testing:** Use anyio for asynchronous code, not asyncio.
-   **Coverage:** Tests must cover primary use cases, edge cases, and error handling.
-   **Requirements:**
    -   Tests must be written for every new feature.
    -   Every bug fix must be accompanied by a regression test.

## **4\. Version Control (Git)**

### **Commits**

-   **Commit Messages:**
    -   For commits fixing bugs or adding features based on user reports, use the Reported-by:\<name\> trailer.
    -   For commits related to a GitHub issue, use the Github-Issue:\#\<number\> trailer.
-   **Forbidden:** Never mention co-authored-by or similar attributes, especially information about tools used to create the commit.

### **Pull Requests (PRs)**

-   **Description:** A PR must contain a detailed, high-level description of the changes: what problem it solves and how. Do not go into implementation details unless it adds necessary clarity.
-   **Reviewers:** Always add Tom and Bob as reviewers.

## **5\. Static Analysis Tools**

### **Formatting and Linting (Ruff)**

-   **Format:** uv run ruff format .
-   **Check:** uv run ruff check .
-   **Auto-fix:** uv run ruff check . \--fix
-   **Critical Rules:**
    -   Line length (88 characters).
    -   Import sorting (I001).
    -   Removal of unused imports.

### **Type Checking (Pyright)**

-   **Command:** uv run pyright
-   **Requirements:**
    -   Explicit None checks for Optional types.
    -   Type narrowing for string literals.

### **Pre-commit Hooks**

-   **Configuration:** .pre-commit-config.yaml
-   **Tools:** Prettier (for YAML/JSON) and Ruff (for Python).
-   **Updating Ruff in Hooks:**
    1. Check for the new version on PyPI.
    2. Update the rev in .pre-commit-config.yaml.
    3. Commit the configuration file change first.

## **6\. Troubleshooting Process**

-   **CI Failure Fix Order:**
    1. Formatting errors.
    2. Type errors.
    3. Linter errors.
-   **Best Practices:**
    -   Always check file status with git status before committing.
    -   Run formatters before type checkers.
    -   Keep changes minimal and atomic.
    -   Always follow existing patterns in the codebase.
