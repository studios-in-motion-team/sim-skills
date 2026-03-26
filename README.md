# sim-skills

Firmeninterne Workflows und Custom Skills für Claude Code.

---

## Enthaltene Skills

| Skill | Beschreibung |
|-------|-------------|
| `/stop` | Session-Abschluss: schreibt DEV-LOG, ISSUES-LOG und erstellt/aktualisiert Dokumentation (colocated + zentral) |

---

## Installation

### Voraussetzungen

- [Claude Code](https://claude.ai/code) installiert
- `jq` installiert (`brew install jq`) — wird für den automatischen Hook benötigt

### Installation — ein Befehl

Im Projektverzeichnis ausführen:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/studios-in-motion-team/sim-skills/main/install.sh)
```

Der Installer führt drei Schritte durch:

1. **Skill installieren** — kopiert `stop.md` nach `~/.claude/commands/stop.md`
2. **Hooks einrichten** — trägt `Stop`- und `PreCompact`-Hook in `~/.claude/settings.json` ein sowie das Auto-Log-Skript ins Projektverzeichnis
3. **Projekt-Templates (optional)** — legt `DEV-LOG.md` und `ISSUES-LOG.md` im aktuellen Verzeichnis an, wenn gewünscht

> Der Installer ist idempotent — mehrfaches Ausführen richtet keinen Schaden an. Bestehende Hooks und Templates werden nicht überschrieben.

### Schritt 3 — Claude Code neu starten

Falls `/stop` nach der Installation nicht erkannt wird, Claude Code einmal neu starten.

---

## Automatisches Logging

Nach der Installation werden Logs **ohne manuellen Aufruf** geführt:

| Auslöser | Was passiert |
|----------|-------------|
| Session endet (`Stop`-Hook) | Git-basierter Eintrag wird automatisch in `DEV-LOG.md` geschrieben |
| Context-Window voll (`PreCompact`-Hook) | Zwischenstand wird vor der Komprimierung protokolliert |

Das automatische Logging erfasst geänderte und neue Dateien aus `git diff`. Für vollständige inhaltliche Zusammenfassungen, Issues und Dokumentation `/stop` aufrufen.

---

## Manuelle Verwendung

`/stop` in Claude Code eingeben. Der Skill:

- schreibt einen inhaltlichen Eintrag in `DEV-LOG.md` (was wurde warum gemacht)
- trägt gelöste Probleme mit Ursache & Lösung in `ISSUES-LOG.md` ein
- erstellt oder aktualisiert `README.md` colocated bei geänderten Dateien
- erstellt oder aktualisiert zentrale `docs/*.md` im Root

---

## Projekt-Templates manuell anlegen

Falls beim Installer-Aufruf keine Templates angelegt wurden, können sie später manuell ins Projektverzeichnis kopiert werden:

```bash
curl -fsSL https://raw.githubusercontent.com/studios-in-motion-team/sim-skills/main/templates/DEV-LOG.md -o DEV-LOG.md
curl -fsSL https://raw.githubusercontent.com/studios-in-motion-team/sim-skills/main/templates/ISSUES-LOG.md -o ISSUES-LOG.md
```

---

## Updates

Den Installationsbefehl erneut ausführen — der Installer überschreibt den Skill und ist idempotent:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/studios-in-motion-team/sim-skills/main/install.sh)
```
