# scripts/

Hilfsskripte für den automatisierten Session-Workflow.

## auto-log.sh

Wird von Claude Code-Hooks automatisch ausgeführt — kein manueller Aufruf nötig.

**Zweck:** Schreibt einen git-basierten Eintrag in `DEV-LOG.md`, wenn Dateiänderungen vorliegen.

**Auslöser:**

| Hook | Zeitpunkt |
|------|-----------|
| `Stop` | Wenn die Claude-Session endet |
| `PreCompact` | Bevor das Context-Window komprimiert wird |

**Verhalten:**

- Liest `git diff --stat HEAD` und untracked Files
- Fügt einen Eintrag nach dem Titel in `DEV-LOG.md` ein
- Schreibt maximal einen automatischen Eintrag pro Tag (Deduplizierung)
- Macht nichts, wenn keine Änderungen vorliegen
- Läuft `async` — blockiert die Session nicht

**Grenzen:** Das Skript kennt keine Konversationsinhalte. Für vollständige Dokumentation (Colocated Docs, zentrale Docs, Issues-Log) muss `/stop` manuell ausgeführt werden.
