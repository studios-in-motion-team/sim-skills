# Claude — Dieses Repository

Dieses Repository verteilt einen Claude Code Custom Skill (`/stop`) sowie ein komplettes Session-Workflow-Setup.

## Was hier liegt

| Datei | Zweck |
|-------|-------|
| `stop.md` | Der Skill — kommt nach `~/.claude/commands/stop.md` |
| `install.sh` | Installiert Skill + Hook + Projekt-Templates |
| `templates/DEV-LOG.md` | Starter-Template für neue Projekte |
| `templates/ISSUES-LOG.md` | Starter-Template für neue Projekte |
| `README.md` | Doku für GitHub |

## Was der Skill macht

`/stop` wird am Ende jeder Arbeits-Session aufgerufen und:
1. Schreibt einen datierten Eintrag in `DEV-LOG.md` (was wurde gemacht)
2. Trägt gelöste Issues in `ISSUES-LOG.md` ein (Problem / Ursache / Lösung)
3. Erstellt oder aktualisiert Dokumentation für neue/geänderte Dateien

## Wenn du Änderungen machst

- **Skill-Logik ändern** → `stop.md` bearbeiten
- **Hook-Kommando ändern** → in `install.sh` unter `HOOK_COMMAND` anpassen
- **Templates ändern** → `templates/` bearbeiten
- **Nach Änderungen** → Version in `install.sh` (`SKILL_VERSION`) hochzählen und `README.md` aktuell halten

## Regeln für dieses Repo

- `stop.md` ist der primäre Artifact — alles andere dient der Distribution
- Keine Breaking Changes ohne Versionssprung
- `install.sh` muss idempotent bleiben (mehrfaches Ausführen = kein Schaden)
