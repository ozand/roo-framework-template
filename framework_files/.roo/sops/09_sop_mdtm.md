# SOP 09: Markdown Task Management (MDTM) Protocol

## 1. Principle

To ensure robust project management and dependency tracking, all tasks MUST be defined as individual Markdown files within the `.mdtm/` directory. This makes the project state explicit, version-controlled, and machine-readable for the Orchestrator agent.

## 2. Task File Format

Each task file MUST begin with a TOML frontmatter block containing metadata, followed by a Markdown description.

**File Naming Convention:** `TASK-<ID>.md` (e.g., `TASK-001.md`)

**Format:**

```toml
---
id = "TASK-001"
title = "Implement User Authentication Endpoint"
status = "todo" # todo, in_progress, done, blocked
dependencies = ["TASK-000"] # List of task IDs this task depends on
---

### Description

Detailed description of the task, including acceptance criteria.

- [ ] Create the main route in `routes/auth.py`.
- [ ] Implement password hashing.
- [ ] Add unit tests.

### Acceptance Criteria
- A user can register with a username and password.
- A registered user can log in to receive a token.
```

## 3. Orchestrator Responsibilities

- The `sparc-orchestrator` MUST parse all files in the `.mdtm/` directory at the beginning of a session to build a dependency graph.
- Before starting a task, the orchestrator MUST verify that all its dependencies have a `status` of `done`.
- Upon completion of a task, the orchestrator MUST update the corresponding file, setting its `status` to `done`.