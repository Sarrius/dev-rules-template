# Workflow Rules

## Overview

This document describes the standard workflow for completing tasks in projects that follow these development rules.

## Workflow Stages

### BEFORE
1. **READ_README**: Understand the project architecture and conventions
2. **ASSESS_COMPLEXITY**: Determine task complexity (Easy, Medium, Hard)
3. **CREATE_TASK_FILE**: Initialize tracking files in `.tasks/` folder

### DURING
1. **UPDATE_PROGRESS**: Keep progress.md updated as you work
2. **LOG_CHANGES**: Document all significant changes
3. **FOLLOW_PATTERNS**: Adhere to established code patterns

### AFTER
1. **COMMIT**: Save changes with descriptive messages
2. **CLEANUP**: Remove temporary files and clean up code
3. **UPDATE_DOCS**: Update relevant documentation
4. **UPDATE_TASK_STATUS**: Mark task as completed

## Task Complexity Guidelines

### Easy (E)
- **Time**: 5-15 minutes
- **Scope**: ≤3 files
- **Testing**: No specific test files required
- **Change Type**: Single edit or configuration change

### Medium (M)
- **Time**: 15-60 minutes
- **Scope**: ≤10 files
- **Testing**: Tests required
- **Change Type**: Multi-file changes or new feature

### Hard (H)
- **Time**: 60+ minutes
- **Scope**: Unlimited files
- **Testing**: Comprehensive tests required
- **Change Type**: Architecture changes or complex patterns

## Task Tracking

### Task Creation
Create a new task by initializing:
- `.tasks/current.json` with task details
- `.tasks/progress.md` for ongoing progress

### Task Progress
Update `.tasks/progress.md` with:
- Completed tasks
- Patterns established
- Benefits achieved
- Next steps
- Impact metrics

### Task Completion
- Update task status to "completed"
- Ensure documentation is updated
- Review the checklist for completion
