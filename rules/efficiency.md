# Efficiency Guidelines

## Overview

This document describes patterns for maximizing efficiency during development.

## Parallel Execution

### Identification
Identify operations that can be executed in parallel:
- Independent file changes
- Documentation updates
- Testing different components
- UI changes separate from business logic

### Batching
Group similar operations across multiple files:
- Similar refactoring patterns
- Similar documentation updates
- Style/formatting changes
- Similar test implementations

### Execution Strategies
- **PARALLELIZE**: Execute multiple independent operations simultaneously
- **SEQUENCE**: Execute dependent operations in the correct order
- **MULTI-TASK**: Perform multiple independent operations at once when possible

## Operation Types

### Independent Operations
Can be executed in parallel without dependencies:
- Formatting changes
- Documentation updates
- Independent component changes
- Configuration updates

### Dependent Operations
Must be executed in sequence:
- Model changes before view implementation
- Schema changes before data access layer
- API changes before client implementation

### Hybrid Operations
Partially dependent with independent subtasks:
- Major feature changes with separable components
- System-wide refactoring with independent modules
- Large-scale testing with independent test suites

## Maximizing Throughput

### Analysis Phase
- Identify critical paths and dependencies first
- Map out operation relationships
- Determine blockers and prerequisites

### Grouping Phase
- Batch similar operations for efficiency
- Organize tasks by dependency
- Prepare parallel execution paths

### Validation Phase
- Test each group of changes before proceeding
- Verify that dependencies are satisfied
- Ensure system stability after each change

### Optimization Phase
- Prioritize operations that unblock other tasks
- Eliminate bottlenecks
- Focus on high-impact changes first

## File Organization

### Temporary Files
- Store files that don't fit in .tasks scope in `.temp` folder
- Use for drafts, experimental code, and temporary snippets
- Remove once incorporated into the main codebase
- Keep exploratory work isolated from production code until proven

### History Tracking
- Review `.history` folder to understand code evolution
- Each file change creates a timestamped backup
- Recover from accidental changes or deletions
- Utilize history for catastrophic recovery
