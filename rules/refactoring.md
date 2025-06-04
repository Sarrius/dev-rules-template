# Refactoring Guidelines

## Overview

This document describes standards for refactoring code safely and effectively.

## Core Principles

### Goals of Refactoring
- **IMPROVE**: Enhance existing code without changing behavior
- **REFACTOR**: Increase readability, maintainability, and performance
- **AVOID**: Major rewrites unless absolutely necessary

## Safety-First Approach

### File Preservation
- **NEVER MODIFY ORIGINALS**: Create new files with `_refactored` or `_clean` suffix
- **PRESERVE SAFETY NET**: Keep original files untouched for rollback capability
- **SWITCH VIA IMPORTS**: Change import paths to test refactored versions
- **GRADUAL MIGRATION**: Move components one at a time when confident

### Naming Conventions
- `_refactored.{ext}` - Improved version with same interface
- `_clean.{ext}` - Complete rewrite with simplified architecture  
- `_state.{ext}` - For state classes with proper copying methods

## Drastic Changes Policy

### New File Creation
- **CREATE NEW FILES**: Make `filename_clean.{ext}` for complete rewrites
- **CREATE VARIANTS**: Use `filename_refactored.{ext}` for improved versions
- **MAINTAIN ORIGINALS**: Keep original file untouched as safety net
- **UPDATE IMPORTS**: Only change import paths to switch between versions
- **DOCUMENT CHANGES**: Provide clear migration path in code comments

## Implementation Strategies

### Incremental Approach
1. Identify a small, self-contained unit to refactor
2. Create a new file with the appropriate suffix
3. Implement the refactored version
4. Test thoroughly
5. Update imports to switch to the new version
6. Repeat for the next unit

### Documentation Requirements
1. Comment on why the refactoring was needed
2. Explain architectural improvements
3. Document any interface changes
4. Note performance improvements
5. Provide migration guidance for related components

### Testing Standards
1. Ensure all existing tests pass with refactored code
2. Add tests for edge cases discovered during refactoring
3. Verify performance is maintained or improved
4. Test integration with dependent components
