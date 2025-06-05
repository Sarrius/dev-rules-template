# Refactoring Guidelines

## REFACTORING GUIDELINES
- IMPROVE: Existing code without changing behavior
- REFACTOR: For better readability, maintainability, performance
- AVOID: Major rewrites unless necessary

## SAFETY-FIRST APPROACH
NEVER MODIFY ORIGINALS: Create new files with `_refactored` or `_clean` suffix
PRESERVE SAFETY NET: Keep originals untouched for rollback capability
SWITCH VIA IMPORTS: Change import path to test refactored version
GRADUAL MIGRATION: Move screens one at a time when confident

## DRASTIC CHANGES POLICY
CREATE: `filename_clean.dart` for complete rewrites
CREATE: `filename_refactored.dart` for improved versions
MAINTAIN: Original file untouched as safety net
UPDATE: Only imports to switch between versions
DOCUMENT: Clear migration path in code comments

## NAMING CONVENTIONS
- `_refactored.dart` - Improved version with same interface
- `_clean.dart` - Complete rewrite with simplified architecture
