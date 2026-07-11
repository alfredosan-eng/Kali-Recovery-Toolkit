# KRT Framework Specification

## Purpose

This document defines the internal architecture of the Kali Recovery Toolkit Framework.

Its goal is to provide a stable engineering reference for future development.

---

# Framework Layers

## Layer 1

Entry Point

Responsible for starting the framework.

Current component:

- krt

---

## Layer 2

Core

Responsible for framework initialization.

Current component:

- core/initialize.sh

---

## Layer 3

Configuration

Responsible for loading project configuration.

Current component:

- config/krt.conf

---

## Layer 4

Shared Services

Reusable services available to the entire framework.

Current services:

- Logger

Future services:

- Report Service
- Validation Service
- User Interface
- Module Loader

---

## Layer 5

Modules

Recovery functionality.

Examples:

- GRUB
- EFI
- Kernel
- Backup
- Network

---

## Layer 6

Reports

Responsible for generating reports.

Status:

Planned.

---

## Layer 7

Testing

Responsible for validating framework components.

Status:

In Progress.

---

# Engineering Principle

Each layer depends only on the layer below it whenever possible.

---

Version: 1.0

Status: Active
