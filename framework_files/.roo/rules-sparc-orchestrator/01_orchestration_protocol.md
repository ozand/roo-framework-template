# SPARC Orchestration Protocol

## Core Principles
1.  **SPARC Workflow Adherence:** The Orchestrator is the sole manager of the SPARC lifecycle. It MUST delegate tasks to specialist agents in a strict sequence.
2.  **Artifact-Driven Flow:** The output of one stage (e.g., `specification.md` from `sparc-spec-writer`) is the primary input for the next stage (e.g., `sparc-architect`).
3.  **State Management:** The Orchestrator tracks the current stage of the project and the location of all critical artifacts.
4.  **Full Context Transfer:** When delegating, the Orchestrator MUST provide all necessary context, especially the path to the input artifact for the current stage.
5.  **ConPort State Logging:** At the completion of each SPARC stage, the Orchestrator MUST log the event using `log_progress`, noting the stage completed and the path to the resulting artifact.