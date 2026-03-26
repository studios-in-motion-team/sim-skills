# sim-skills

Firmeninterne Workflows und Custom Skills für Claude Code.

---

## Enthaltene Skills

| Skill | Beschreibung |
|-------|-------------|
| `/stop` | Session-Abschluss: schreibt DEV-LOG, ISSUES-LOG und aktualisiert Dokumentation |

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
2. **Stop-Hook einrichten** — trägt einen Hook in `~/.claude/settings.json` ein, der beim Beenden von Claude Code an den Session-Abschluss erinnert
3. **Projekt-Templates (optional)** — legt `DEV-LOG.md` und `ISSUES-LOG.md` im aktuellen Verzeichnis an, wenn gewünscht

> Der Installer ist idempotent — mehrfaches Ausführen richtet keinen Schaden an. Bestehende Hooks und Templates werden nicht überschrieben.

### Schritt 3 — Claude Code neu starten

Falls `/stop` nach der Installation nicht erkannt wird, Claude Code einmal neu starten.

---

## Projekt-Templates manuell anlegen

Falls beim Installer-Aufruf keine Templates angelegt wurden, können sie später manuell ins Projektverzeichnis kopiert werden:

```bash
curl -fsSL https://raw.githubusercontent.com/studios-in-motion-team/sim-skills/main/templates/DEV-LOG.md -o DEV-LOG.md
curl -fsSL https://raw.githubusercontent.com/studios-in-motion-team/sim-skills/main/templates/ISSUES-LOG.md -o ISSUES-LOG.md
```

---

## Verwendung

Am Ende einer Arbeits-Session `/stop` in Claude Code eingeben. Der Skill:

- schreibt einen datierten Eintrag in `DEV-LOG.md`
- trägt gelöste Probleme mit Ursache & Lösung in `ISSUES-LOG.md` ein
- erstellt oder aktualisiert Dokumentation für neue/geänderte Dateien

Ohne manuellen Aufruf erscheint beim Beenden von Claude Code automatisch eine Erinnerung (sofern der Hook eingerichtet wurde).

---

## Updates

Den Installationsbefehl erneut ausführen — der Installer überschreibt den Skill und ist idempotent:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/studios-in-motion-team/sim-skills/main/install.sh)
```
