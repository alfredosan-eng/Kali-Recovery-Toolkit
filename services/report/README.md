# Report Service

## Purpose

The Report Service provides a reusable API for generating text reports across
the Kali Recovery Toolkit.

## Responsibilities

- Initialize reports
- Create report headers
- Add report sections
- Add free-form messages
- Close reports
- Save reports

## Public API

- report_init()
- report_header()
- report_section()
- report_message()
- report_footer()
- report_save()

## Used By

- Doctor Module
- Backup Module
- Recovery Module (future)

## Output Directory

reports/
