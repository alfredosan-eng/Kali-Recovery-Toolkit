# ADR-001: Project Principles

- **Status:** Accepted
- **Date:** 2026-07-08
- **Decision Makers:** Project Founder (Alfredo), Project Architect (ChatGPT)
- **Version:** v0.1.0

---

# Context

Kali Recovery Toolkit (KRT) was created after recovering a real Kali Linux installation that failed to boot following a system update.

Rather than becoming just another collection of Bash scripts, the project aims to become a professional, modular and maintainable recovery framework.

To ensure consistency as the project grows, the fundamental engineering principles must be defined from the beginning.

---

# Decision

The project adopts the following core principles.

## 1. Documentation First

Every significant feature must be documented before implementation.

Documentation is considered part of the software, not an optional addition.

---

## 2. Safety Before Recovery

No recovery operation should modify the system before offering the possibility of creating a backup.

Protecting user data always has higher priority than repairing the system.

---

## 3. Modular Architecture

Each module must have a single responsibility.

Modules should be independent and reusable whenever possible.

---

## 4. Transparency

KRT should explain what it is doing.

Hidden operations should be avoided.

Users should understand the recovery process.

---

## 5. Simplicity

Choose the simplest solution that satisfies the requirements.

Complexity should only be introduced when it provides a measurable benefit.

---

## 6. Incremental Development

The project evolves through small, tested and documented iterations.

Each release should improve the project while maintaining stability.

---

## 7. Open Learning

KRT is not only a recovery toolkit.

It is also intended to help users understand Linux recovery techniques and Bash engineering.

Educational value is considered a project objective.

---

## 8. Engineering over Shortcuts

Quick fixes should never compromise maintainability.

Architecture decisions should consider long-term evolution.

---

# Consequences

Following these principles means:

- More documentation.
- Smaller modules.
- Better maintainability.
- Easier collaboration.
- Predictable project growth.

The initial development may be slower, but the long-term benefits outweigh the additional effort.

---

# Alternatives Considered

### Single Bash Script

Rejected.

Although easier to start, a monolithic script would become difficult to maintain as the project grows.

---

### Minimal Documentation

Rejected.

Lack of documentation would reduce maintainability and make collaboration more difficult.

---

### Feature-First Development

Rejected.

Building features without defining architectural principles increases technical debt.

---

# References

- Clean Architecture — Robert C. Martin
- The Pragmatic Programmer
- Unix Philosophy
- Linux From Scratch
- Bash Style Guide

---

# Notes

This ADR is considered the constitutional document of KRT.

Future architectural decisions should remain consistent with these principles unless a new ADR explicitly supersedes them.

---

**End of ADR-001**
