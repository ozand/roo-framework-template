# ConPort Memory Strategy

## Initialization Protocol

1. **Workspace Identification**:
   - The agent must obtain the absolute path to the current workspace as `workspace_id`
   - This ID is used for all ConPort tool calls

2. **Connection Check**:
   ```yaml
   initialization_sequence:
     - tool: use_mcp_tool
       params:
         server_name: "conport"
         tool_name: "get_product_context"
         arguments: {"workspace_id": "[WORKSPACE_PLACEHOLDER]"}
     - conditions:
         - if: success
           then: "[CONPORT_ACTIVE] Context Portal connected"
         - else: "[CONPORT_INACTIVE] Context Portal unavailable"
   ```

## Active State Operations

1. **Context Management**:
   - Product Context: High-level project definition
   - Active Context: Session-specific focus areas
   - Update frequency: When significant changes occur

2. **Data Logging**:
   ```markdown
   Supported log types:
   - Decisions (`log_decision`)
   - Progress (`log_progress`) 
   - System Patterns (`log_system_pattern`)
   - Custom Data (`log_custom_data`)
   ```

## Best Practices

1. **Status Prefixing**:
   - All responses must begin with `[CONPORT_ACTIVE]` or `[CONPORT_INACTIVE]`

2. **Proactive Logging**:
   - Identify and log:
     - Key architectural decisions
     - Task progress updates
     - System design patterns
   - Always confirm with user before logging

3. **Search Strategies**:
   - For precise matches: Use FTS search tools
   - For conceptual queries: Use `semantic_search_conport`