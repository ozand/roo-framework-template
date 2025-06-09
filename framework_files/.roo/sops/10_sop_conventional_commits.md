# SOP 10: Conventional Commits

## 1. Principle

All Git commit messages MUST adhere to the Conventional Commits specification. This creates an explicit and machine-readable commit history, which facilitates automation and improves changelog clarity.

## 2. Format

The commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

- **Type:** Must be one of `feat` (new feature), `fix` (bug fix), `docs` (documentation), `style` (formatting), `refactor`, `test`, `chore` (build/tool changes).
- **Description:** A concise summary of the change in the imperative mood.
- **Body:** Provides additional context or rationale.
- **Footer:** Used for referencing issue trackers (e.g., `Refs: TASK-123`).

## 3. Agent Responsibility

Agents responsible for committing code (e.g., `sparc-autocoder`, `sparc-refiner`) MUST generate commit messages in this format. The `sparc-orchestrator` may delegate the commit action with a pre-formatted message.