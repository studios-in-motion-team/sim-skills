# Session-Logging _(2026-03-26)_

## Überblick

Das Session-Logging-System besteht aus zwei Stufen, die sich ergänzen:

| Stufe | Auslöser | Kann | Kann nicht |
|-------|----------|------|------------|
| **Automatisch** | Stop-Hook, PreCompact-Hook | Dateipfade aus Git, Zeilenzahlen | Konversationsinhalt, Dokumentation schreiben |
| **Manuell** | `/stop` | Vollständige Zusammenfassung, Docs, Issues | — |

## Automatisches Logging (`scripts/auto-log.sh`)

**Ort:** `scripts/auto-log.sh`

Läuft als Shell-Skript ohne Claude-Kontext. Nutzt `git diff --stat HEAD` und `git ls-files --others` um geänderte und neue Dateien zu ermitteln. Schreibt einen kompakten Eintrag in `DEV-LOG.md`.

**Konfiguration in `.claude/settings.json`:**

```json
"Stop":      [ { "hooks": [{ "type": "command", "command": "bash scripts/auto-log.sh", "async": true }] } ]
"PreCompact": [ { "hooks": [{ "type": "command", "command": "bash scripts/auto-log.sh", "async": true }] } ]
```

**Warum PreCompact?** Der Hook feuert *bevor* der Kontext komprimiert wird. So bleibt der Zwischenstand erhalten, auch wenn die Session weiterläuft.

## Manuelles Logging (`/stop`)

**Ort:** `stop.md` → installiert nach `~/.claude/commands/stop.md`

Analysiert die gesamte Konversation und schreibt:

1. Inhaltliche Zusammenfassung in `DEV-LOG.md`
2. Gelöste Issues in `ISSUES-LOG.md`
3. Colocated `README.md` pro geändertem Verzeichnis
4. Zentrale `docs/<Thema>.md` für alle relevanten Änderungen

## Bezüge

- `install.sh` — Installiert `stop.md` und richtet den Hook ein
- `templates/DEV-LOG.md` — Starter-Template für neue Projekte
