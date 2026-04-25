# Pro-Link

**Enterprise Internship & Skill Tracking** — a Flutter app built for the
*Mobile Development* unit at *Université Constantine 2 — Abdelhamid Mehri*
(IFA, 2025-2026).

Pro-Link bridges the university and the corporate world by streamlining the
internship process: companies can track student progress, manage corporate IDs
and evaluate professional skills in a single application.

The project is structured according to the four sprints required by the
project brief.

## Sprint plan

| Sprint | Scope                                                                                       | Status |
|--------|---------------------------------------------------------------------------------------------|--------|
| 1      | Front-end & UI — corporate theme, dashboards for the three actors, Digital Work ID, login   | in progress (login deferred) |
| 2      | Functions — admin assignment panel, intern views, mentor tooling                            | planned |
| 3      | Backend — Neon Postgres + PHP REST API, authentication, file uploads                        | planned |
| 4      | Search & responsive optimisation                                                            | planned |

## Roles

- **Administrator** — validates intern registrations, assigns mentors and
  departments, uploads office schedules and policy handbooks.
- **Mentor** — manages assigned interns, uploads training files, tracks weekly
  attendance, evaluates performance.
- **Intern** — sees their Digital Work ID, schedules, training resources and
  evaluations once approved by an administrator.

## Tech stack

- **Framework**: Flutter (Dart 3.11+, Material 3)
- **State management**: Riverpod (added in Sprint 2)
- **Backend**: Neon serverless PostgreSQL via PHP REST API (Sprint 3)
- **HTTP**: `package:http`
- **Navigation**: `Navigator` + named routes / `MaterialPageRoute`

## Project layout

```
lib/
├── main.dart                          # MaterialApp + named routes
├── core/
│   ├── constants/app_strings.dart
│   ├── routes/app_routes.dart
│   └── theme/                         # navy #1A2332 corporate theme
├── data/mock_data.dart                # Sprint 1 in-memory data
├── models/                            # User, Evaluation, Schedule, TrainingFile
├── screens/
│   ├── role_selector_screen.dart      # temporary home until login lands
│   ├── admin/admin_dashboard.dart
│   ├── mentor/mentor_dashboard.dart
│   ├── mentor/evaluation_form_screen.dart
│   └── intern/
│       ├── intern_dashboard.dart
│       └── widgets/work_id_card.dart  # Digital Work ID badge
└── widgets/                           # shared building blocks
```

## Running locally

```bash
flutter pub get
flutter run        # pick a device with `flutter devices`
flutter analyze
flutter test
```

## Visual identity

- Primary navy: `#1A2332`
- Accent gold: `#C8A24B`
- Background: `#F4F6FA`
