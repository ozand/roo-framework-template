# --- Tool Definitions ---
tools:
  # --- File Reading/Listing ---
  - name: read_file
    description: |
      Reads file content (optionally specific lines). Handles PDF/DOCX text. Output includes line numbers prefixed to each line (e.g., "1 | const x = 1").
      Use this to get the exact current content and line numbers of a file before planning modifications.
      Efficient streaming for line ranges. May not suit other binary files.
    parameters:
      - name: path
        required: true
        description: Relative path to file (relative to T:\Code\python\RuRu).
      - name: start_line
        required: false
        description: Start line (1-based).
        If omitted, starts from beginning.
      - name: end_line
        required: false
        description: End line (1-based, inclusive).
        If omitted, reads to end.
    usage_format: |
      <read_file>
      <path>File path here</path>
      <start_line>Starting line number (optional)</start_line>
      <end_line>Ending line number (optional)</end_line>
      </read_file>
    examples:
      - description: Read entire file
        usage: |
          <read_file>
          <path>config.json</path>
          </read_file>
      - description: Read lines 10-20
        usage: |
          <read_file>
          <path>log.txt</path>
          <start_line>10</start_line>
          <end_line>20</end_line>
          </read_file>

  - name: fetch_instructions
    description: Fetches detailed instructions for specific tasks ('create_mcp_server', 'create_mode').
    parameters:
      - name: task
        required: true
        description: Task name ('create_mcp_server' or 'create_mode').
    usage_format: |
      <fetch_instructions>
      <task>Task name here</task>
      </fetch_instructions>

  - name: search_files
    description: |
      Regex search across files in a directory (recursive). Provides context lines. Uses Rust regex syntax.
      Useful for finding patterns or content across multiple files.
    parameters:
      - name: path
        required: true
        description: Relative path to directory (relative to T:\Code\python\RuRu).
        Recursive search.
      - name: regex
        required: true
        description: Rust regex pattern to search for.
      - name: file_pattern
        required: false
        description: "Glob pattern filter (e.g., '*.py'). Defaults to '*' (all files)."
    usage_format: |
      <search_files>
      <path>Directory path here</path>
      <regex>Your regex pattern here</regex>
      <file_pattern>file pattern here (optional)</file_pattern>
      </search_files>
    examples:
      - description: Find 'TODO:' in Python files in current directory
        usage: |
          <search_files>
          <path>.</path>
          <regex>TODO:</regex>
          <file_pattern>*.py</file_pattern>
          </search_files>

  - name: list_files
    description: |
      Lists files/directories within a directory (relative to T:\Code\python\RuRu).
      Use `recursive: true` for deep listing, `false` (default) for top-level.
      Do not use to confirm creation (user confirms).
    parameters:
      - name: path
        required: true
        description: Relative path to directory.
      - name: recursive
        required: false
        description: List recursively (true/false).
        Defaults to false.
    usage_format: |
      <list_files>
      <path>Directory path here</path>
      <recursive>true or false (optional)</recursive>
      </list_files>
    examples:
      - description: List top-level in current dir
        usage: |
          <list_files>
          <path>.</path>
          </list_files>
      - description: List all files recursively in src/
        usage: |
          <list_files>
          <path>src</path>
          <recursive>true</recursive>
          </list_files>

  # --- Code Analysis ---
  - name: list_code_definition_names
    description: |
      Lists definition names (classes, functions, etc.) from a source file or all top-level files in a directory (relative to T:\Code\python\RuRu).
      Useful for code structure overview and understanding constructs.
    parameters:
      - name: path
        required: true
        description: Relative path to file or directory.
    usage_format: |
      <list_code_definition_names>
      <path>File or directory path here</path>
      </list_code_definition_names>
    examples:
      - description: List definitions in main.py
        usage: |
          <list_code_definition_names>
          <path>src/main.py</path>
          </list_code_definition_names>
      - description: List definitions in src/ directory
        usage: |
          <list_code_definition_names>
          <path>src/</path>
          </list_code_definition_names>

  # --- File Modification ---
  - name: apply_diff
    description: |
      Applies precise, surgical modifications to a file by replacing existing content with new content using one or more SEARCH/REPLACE blocks.
      This is the primary tool for editing existing files while maintaining correct indentation and formatting.
      The content in the SEARCH section MUST exactly match the existing content in the file, including all whitespace, indentation, and line breaks.
      Crucially, consolidate multiple intended changes to the *same file* into a *single* 'apply_diff' call by concatenating multiple SEARCH/REPLACE blocks within the 'diff' parameter string.
      Be mindful that changes might require syntax adjustments outside the modified blocks.
      Base path for files is 'T:\Code\python\RuRu'.
      CRITICAL ESCAPING RULE: If the literal text '<<<<<<< SEARCH', '=======', or '>>>>>>> REPLACE' appears within the content you need to put inside the SEARCH or REPLACE sections, it MUST be escaped.
      See the 'diff' parameter description for exact escaping rules.
    parameters:
    - name: path
      required: true
      description: The path of the file to modify (relative to 'T:\Code\python\RuRu').
    - name: diff
      required: true
      description: |
        A string containing one or more concatenated SEARCH/REPLACE blocks defining the changes.
        Each block MUST adhere to the following format exactly:
        <<<<<<< SEARCH
        :start_line:[start_line_number]
        :end_line:[end_line_number]
        -------
        [Exact content to find, including whitespace and line breaks]
        =======
        [New content to replace with]
        >>>>>>> REPLACE

         - ':start_line:' and ':end_line:' are required and specify the line numbers (1-based, inclusive) of the original content block being targeted.
        - Use exactly one '=======' separator between the SEARCH and REPLACE content *within each block's structure*.
        *** IMPORTANT ESCAPING RULE ***
        If the literal text of any of the diff markers themselves needs to be part of the [Exact content to find] or [New content to replace with], you MUST escape it by prepending a backslash (\) at the beginning of the line where the marker appears *within the content*.
        This applies ONLY to these specific markers when found inside the content blocks:
          \<<<<<<< SEARCH
          \=======
          \>>>>>>> REPLACE
        Failure to escape these markers when they appear *as content* will cause the diff application to fail.
        The structural markers (the ones defining the block) should NOT be escaped.
    usage_format: |
      <apply_diff>
      <path>File path here</path>
      <diff>
      <<<<<<< SEARCH
      :start_line:start_line_num
      :end_line:end_line_num
      -------
      [Exact content to find - escape internal markers if necessary]
      =======
      [New content to replace with - escape internal markers if necessary]
      >>>>>>> REPLACE
      (Optional: Concatenate additional SEARCH/REPLACE blocks here)
      </diff>
      </apply_diff>
    example:
    - description: Replace an entire function definition (standard case)
      usage: |
        <apply_diff>
        <path>src/utils.py</path>
        <diff>
        <<<<<<< SEARCH
        :start_line:1
        :end_line:5
        -------
        def calculate_total(items):
            total = 0
            for item in items:
                 total += item
            return total
        =======
        def calculate_total(items):
            """Calculate total with 10% markup"""
            return sum(item * 1.1 for item in items)
        >>>>>>> REPLACE
        </diff>
        </apply_diff>
    - description: Apply multiple edits (rename variable 'sum' to 'total') within the same file 'calculator.py' in a single call
      usage: |
        <apply_diff>
        <path>calculator.py</path>
        <diff>
        <<<<<<< SEARCH
        :start_line:2
        :end_line:2
        -------
            sum = 0
        =======
            total = 0 # Renamed variable initialization
        >>>>>>> REPLACE
        <<<<<<< SEARCH
        :start_line:4
        :end_line:5
        -------
                sum += item
            return sum
        =======
                total += item # Use renamed variable
            return total  # Return renamed variable
        >>>>>>> REPLACE
        </diff>
        </apply_diff>
    - description: Remove merge conflict markers where '=======' is part of the content to find
      usage: |
        <apply_diff>
        <path>src/conflicted_file.js</path>
        <diff>
        <<<<<<< SEARCH
        :start_line:15
        :end_line:19
        -------
        <<<<<<< HEAD
        const version = '1.2.0';
        \======= # Escaped because it's CONTENT, not a structural separator
        const version = '1.3.0-beta';
        >>>>>>> feature/new-version
        =======
        // Keep the version from the feature branch
        const version = '1.3.0-beta';
        >>>>>>> REPLACE
        </diff>
        </apply_diff>

  - name: write_to_file
    description: |
      Writes full content to a file, overwriting if exists, creating if not (including directories).
      Use for new files or complete rewrites.
      CRITICAL: Provide COMPLETE file content.
      No partial updates or placeholders (`// rest of code`). Include ALL parts, modified or not.
      Do not include line numbers in content.
    parameters:
      - name: path
        required: true
        description: Relative path to file (relative to T:\Code\python\RuRu).
      - name: content
        required: true
        description: Complete file content (use `|` for multiline).
      - name: line_count
        required: true
        description: The number of lines in the file.
        Compute this based on the actual content of the file you are providing.
    usage_format: |
      <write_to_file>
      <path>File path here</path>
      <content>
      Complete content...