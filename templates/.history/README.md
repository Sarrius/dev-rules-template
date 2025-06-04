# File History

This directory contains the history of files in your project. It is managed by the Local History VS Code extension.

## Purpose

- Track changes to files
- Recover from accidental changes or deletions
- Understand code evolution over time
- Provide a safety net beyond Git version control
- Help recover from catastrophic issues

## File Format

Each file revision is stored with a timestamp in the format:
`.history/{path}/{filename}_{YYYYMMDDHHMMSS}.{extension}`

For example: `.history/lib/main_20250604123045.dart`

## Usage

- Review previous iterations of code
- Recover lost code that wasn't committed to Git
- Track the evolution of files over time
- Compare current files with historical versions

## Configuration

This directory is managed by the Local History VS Code extension. You can configure this extension in VS Code settings.

Recommended settings:
```
"local-history.daysLimit": 30,
"local-history.maxDisplay": 10,
"local-history.saveDelay": 0,
"local-history.enabled": 1
```

Add `.history/` to your `.gitignore` file to prevent history files from being committed to Git.
