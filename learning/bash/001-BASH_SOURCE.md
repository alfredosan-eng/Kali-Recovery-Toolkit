# BASH_SOURCE

## What is it?

`BASH_SOURCE` is a Bash array that contains the path of the current script being executed or sourced.

Unlike `$0`, it correctly identifies the file currently being processed, even when it is loaded using the `source` command.

---

# Why KRT Needed It

During the development of KRT, the framework initially used:

```bash
dirname "$0"
```

to locate configuration files.

This worked while executing scripts directly.

However, it failed when `initialize.sh` was loaded using `source`.

---

# The Problem

The framework displayed:

```
Configuration file not found.
```

The generated path pointed to the wrong location because `$0` referred to the entry point (`krt`) instead of the sourced file.

---

# The Solution

The framework adopted:

```bash
${BASH_SOURCE[0]}
```

which correctly identifies the current file regardless of how it was loaded.

---

# Lessons Learned

- `$0` is not always reliable.
- `BASH_SOURCE` is safer for modular Bash projects.
- Small architectural decisions have long-term impact.

---

# Related Components

- Core
- Configuration Manager
- Service Loader

---

Status

Completed
