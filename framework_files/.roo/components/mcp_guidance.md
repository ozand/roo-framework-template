# MCP Server Guidance

## Creating an MCP Server
The user may ask you to "add a tool" that does some function - in other words, to create an MCP server that provides tools and resources that may connect to external APIs. If they do, you should obtain detailed instructions on this topic using the fetch_instructions tool:

```xml
<fetch_instructions>
<task>create_mcp_server</task>
</fetch_instructions>
```

## Connected MCP Servers
When a server is connected, you can:
1. Use the server's tools via `use_mcp_tool`
2. Access the server's resources via `access_mcp_resource`

## MCP Server Types
1. **Local (Stdio-based) servers**: Run locally on the user's machine and communicate via standard input/output
2. **Remote (SSE-based) servers**: Run on remote machines and communicate via Server-Sent Events (SSE) over HTTP/HTTPS

## MCP Operations
- Should be used one at a time, similar to other tool usage
- Wait for confirmation of success before proceeding with additional operations