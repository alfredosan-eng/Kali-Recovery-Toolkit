# KRT Design System

**Project:** Kali Recovery Toolkit

**Version:** v0.1.0

**Status:** Active

---

# Purpose

This document defines the visual, technical and documentation standards used throughout the Kali Recovery Toolkit (KRT) project.

Every new module, script, document and interface should follow these guidelines to ensure consistency across the project.

---

# Design Philosophy

KRT is designed around four principles:

- Simplicity
- Consistency
- Readability
- Transparency

The toolkit should feel clean, professional and predictable.

---

# Visual Identity

## Primary Colors

| Color | Purpose |
|---------|---------|
| Blue | Primary interface |
| Orange | Warnings and highlights |
| White | Standard text |
| Gray | Secondary information |
| Red | Critical errors |
| Green | Success messages |

---

# Terminal Style

KRT uses a minimal interface.

Avoid excessive decorations.

Prefer clean spacing over visual clutter.

Example:

═══════════════════════════════════════

Kali Recovery Toolkit

Version 0.1.0

═══════════════════════════════════════

Loading modules...

Done.

---

# Icons

The project uses Unicode icons sparingly.

| Icon | Meaning |
|-------|----------|
| ✓ | Success |
| ⚠ | Warning |
| ✗ | Error |
| ℹ | Information |
| ► | Current action |
| • | List item |

Icons should improve readability, not decoration.

---

# Naming Convention

## Variables

Use lowercase.

Example

```bash
backup_path
efi_partition
```

---

## Constants

Uppercase.

```bash
VERSION
LOG_DIRECTORY
CONFIG_FILE
```

---

## Functions

Snake case.

```bash
create_backup()

detect_efi_partition()

repair_grub()
```

---

## Modules

One responsibility per module.

Examples

```text
backup

grub

efi

network

health

logger

config
```

---

# Bash Style Guide

Always use

```bash
#!/usr/bin/env bash
```

Enable strict mode whenever possible.

```bash
set -euo pipefail
```

Quote variables.

Good

```bash
"$backup_path"
```

Bad

```bash
$backup_path
```

---

# Logging Standard

Every module should log important actions.

Log format

```
[TIME] [LEVEL] MESSAGE
```

Example

```
[19:45:10] [INFO] Backup started

[19:45:12] [SUCCESS] EFI copied

[19:45:14] [WARNING] GRUB configuration missing

[19:45:15] [ERROR] EFI mount failed
```

---

# Menu Style

Menus should be numbered.

Example

```
1. Backup EFI

2. Restore GRUB

3. Network Diagnostics

4. Settings

0. Exit
```

Avoid letters as menu options.

---

# Documentation Style

Every document must contain:

- Title
- Purpose
- Overview
- Technical Details
- Examples
- References
- Future Improvements

---

# Directory Organization

```
assets/
backups/
config/
docs/
logs/
modules/
reports/
tests/
utils/
```

Each module owns its own documentation.

---

# Git Commit Convention

Examples

```
feat(core): initialize framework

feat(logger): add logging engine

docs(readme): improve project overview

fix(grub): detect EFI partition correctly

refactor(core): simplify module loader

test(network): validate connectivity checks

chore(repo): update project structure
```

---

# Project Documentation Rule

Documentation is created before implementation.

Every important engineering decision should be documented.

---

# Long-Term Goal

Maintain a consistent visual identity and coding standard from v0.1.0 through future major releases.

Every contribution should look like it was written by the same development team.

---

**End of Document**
