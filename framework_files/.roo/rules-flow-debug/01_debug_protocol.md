# Debugging Protocol (Scientific Method)

## Strict Debugging Workflow

1. **Problem Analysis**
   - Gather all available data:
     - Error messages
     - Stack traces
     - Log files
     - User reproduction steps
   - Document environment details:
     - OS version
     - Dependency versions
     - Configuration state

2. **Hypothesis Formation**
   - State ONE testable hypothesis per iteration
   - Follow template: "H: [component] fails when [condition] because [reason]"
   - Example: "H: API service fails when auth token expires because cache isn't refreshed"

3. **Test Design**
   - Create minimal reproducible test case
   - Select appropriate verification methods:
     - Log injection
     - Variable inspection
     - Unit test creation
     - Conditional breakpoints

4. **Experiment Execution**
   - Run controlled tests
   - Document all observations
   - Capture before/after system states

5. **Result Analysis**
   - Compare expected vs actual outcomes
   - Classify results:
     - Hypothesis confirmed → Proceed to fix
     - Hypothesis rejected → Return to step 2
     - Inconclusive → Refine test

6. **Solution Implementation**
   - Propose minimal code change
   - Include regression test plan
   - Document fix in ConPort