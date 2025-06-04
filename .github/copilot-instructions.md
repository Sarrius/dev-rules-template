# TASK RULES

## MANDATORY
READ README.md BEFORE STARTING WORK
CHECK .tasks/ FOLDER BEFORE ANY WORK - Read current.json, progress.md

## WORKFLOW
BEFORE: READ_README → ASSESS_COMPLEXITY → CREATE_TASK_FILE
DURING: UPDATE_PROGRESS → LOG_CHANGES → FOLLOW_PATTERNS  
AFTER: COMMIT → CLEANUP → UPDATE_DOCS → UPDATE_TASK_STATUS

## COMPLEXITY
E: 5-15min | ≤3 files | No tests | Single edit/config
M: 15-60min | ≤10 files | Tests required | Multi-file/new feature
H: 60min+ | Unlimited | Tests required | Architecture/complex patterns

## EFFICIENCY
### PARALLEL EXECUTION
- IDENTIFY: Independent operations that can run in parallel
- BATCH: Group similar changes across multiple files
- PARALLELIZE: Execute multiple independent operations simultaneously
- SEQUENCE: Dependent operations must follow prerequisites

### OPERATION TYPES
- INDEPENDENT: Can be executed in parallel (e.g., formatting, documentation updates)
- DEPENDENT: Require sequential execution (e.g., model changes before view implementation)
- HYBRID: Partially dependent operations with independent subtasks

### MAXIMIZING THROUGHPUT
- ANALYZE: Identify critical paths and dependencies first
- GROUP: Batch similar operations for efficiency
- TEST: Validate each group of changes before proceeding
- OPTIMIZE: Prioritize operations that unblock other tasks
- MULTI-TASK: Perform multiple independent operations at once when possible

### FILE ORGANIZATION
- TEMPORARY FILES: Store files that don't fit in .tasks scope in .temp folder
- WORK-IN-PROGRESS: Use .temp for drafts, experimental code, and temporary snippets
- CLEANUP: Remove .temp files once incorporated into the main codebase
- ISOLATION: Keep exploratory work isolated from production code until proven

### FILE HISTORY
- REVIEW CHANGES: Check `.history` folder to understand previous code iterations
- FILE VERSIONING: Each change creates timestamped backups in `.history/{path}/{filename}_{timestamp}.ext`
- RECOVER CODE: Use history files to recover from broken or accidental changes or deletions
- TRACK EVOLUTION: Review historical changes to understand code evolution and past decisions
- CATASTROPHIC RECOVERY: Utilize `.history` when workspace has catastrophic issues

## REFACTORING
### REFACTORING GUIDELINES
- IMPROVE: Existing code without changing behavior
- REFACTOR: For better readability, maintainability, performance
- AVOID: Major rewrites unless necessary

### SAFETY-FIRST APPROACH
NEVER MODIFY ORIGINALS: Create new files with `_refactored` or `_clean` suffix
PRESERVE SAFETY NET: Keep originals untouched for rollback capability
SWITCH VIA IMPORTS: Change import path to test refactored version
GRADUAL MIGRATION: Move components one at a time when confident

### DRASTIC CHANGES POLICY
CREATE: `filename_clean.{ext}` for complete rewrites
CREATE: `filename_refactored.{ext}` for improved versions
MAINTAIN: Original file untouched as safety net
UPDATE: Only imports to switch between versions
DOCUMENT: Clear migration path in code comments

### NAMING CONVENTIONS
- `_refactored.{ext}` - Improved version with same interface
- `_clean.{ext}` - Complete rewrite with simplified architecture  
- `_state.{ext}` - For state classes with proper copying methods

## FUNCTIONS
PURE: Same input = Same output, No side effects
NO MUTATION: Don't modify input params or external state
SEPARATION: Services for side effects

## SOLID
S: Single Responsibility per class/module
O: Open/Closed - extend, don't modify
L: Liskov Substitution - subclasses substitutable  
I: Interface Segregation - many small interfaces
D: Dependency Inversion - depend on abstractions

## TRACKING
**MODEL RESPONSIBILITIES FOR PROGRESS FILES:**
- CREATE: .tasks/current.json (task start)
- MAINTAIN: .tasks/progress.md (ongoing updates)
- UPDATE: .tasks/rules-ref.md (rule references)
- REMOVE: All after user is reported that task is completed .tasks/ files (task completion)

Current: .tasks/current.json
Progress: .tasks/progress.md

## CHECKLIST
- Task complexity assessed
- Progress files created by model
- Progress logged and maintained by model
- Tests written (M/H)
- Documentation updated
- Changes committed
- Progress files cleaned up by model
