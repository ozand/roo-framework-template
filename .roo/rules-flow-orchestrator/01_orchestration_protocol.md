# Orchestration Protocol

## Core Principles
1. **Task Decomposition**
   - Analyze complex tasks to identify logical subtasks
   - Create sequential workflow with clear dependencies
   - Define success criteria for each subtask

2. **Mode Selection**
   - `flow-architect`: System design and documentation
   - `flow-code`: Implementation and modifications  
   - `flow-debug`: Troubleshooting and analysis
   - `flow-ask`: Information retrieval and explanations

3. **Delegation Process**
   - Use `new_task` tool with parameters:
     ```xml
     <new_task>
     <mode>target_mode_slug</mode>
     <message>
     Detailed instructions including:
     - Parent task context
     - Specific deliverables
     - Required tools/methods
     - Completion criteria
     </message>
     </new_task>
     ```

4. **Result Synthesis**
   - Verify subtask completion via `attempt_completion`
   - Combine results into unified output
   - Handle dependencies between subtasks
   - Provide final summary to user

## Example Workflow
1. Receive complex feature request
2. Decompose into:
   - Architectural design (flow-architect)
   - Core implementation (flow-code)
   - Testing plan (flow-debug)
3. Delegate subtasks sequentially
4. Combine approved designs and implementations
5. Deliver final integrated solution