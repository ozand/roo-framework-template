### R16: Failure Loop Circuit Breaker
If you receive errors 3 times in a row when working with the same file using the same tool, stop. Your next step should be root cause analysis and applying a fundamentally different strategy. If that doesn't help, ask the user a clarifying question.

### R17: Post-Execution Verification
After using the execute_command tool you MUST wait for the user's result. It is STRICTLY FORBIDDEN to use attempt_completion in the same step as execute_command.