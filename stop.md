---
name: stop
description: "Protokolliert die Session in DEV-LOG.md, trägt gelöste Issues in ISSUES-LOG.md ein und erstellt/aktualisiert Dokumentation für alle geänderten Dateien — colocated und zentral im Root. Trigger: 'session abschließen', 'session protokollieren', 'session log', '/stop'."
argument-hint: "[kurze Beschreibung des Session-Themas]"
---

# Skill: Session-Abschluss

Protokolliert die aktuelle Session vollständig und hält Wissen dauerhaft fest.

## Was dieser Skill tut

1. **DEV-LOG.md** — Datierter Eintrag mit Zusammenfassung aller Änderungen dieser Session
2. **ISSUES-LOG.md** — Trägt gelöste Probleme mit Ursache & Lösung ein
3. **Colocated Docs** — `README.md` direkt neben jeder neuen/geänderten Datei oder in deren Verzeichnis
4. **Zentrale Docs** — `docs/<Thema>.md` im Root für alle relevanten Änderungen

> **Wichtig:** Dieser Skill protokolliert alles — auch die eigenen Schritte, die er ausführt. Jede erstellte oder aktualisierte Datei wird in DEV-LOG.md aufgeführt.

## Ablauf

### Schritt 1: Session analysieren

Gehe die gesamte Konversation durch und identifiziere:

- **Was wurde geändert/erstellt?** (Dateipfade, kurze Beschreibung)
- **Welche Probleme wurden gelöst?** (Problem, Ursache, Lösung)
- **Wurden neue Dateien, Komponenten, Routes, Schemas etc. erstellt?**
- **Welche Architekturentscheidungen wurden getroffen?**
- **Welche Dateien hat der Skill selbst erstellt oder aktualisiert?** (Docs, Logs)

### Schritt 2: DEV-LOG.md aktualisieren

Lies zuerst `DEV-LOG.md` und füge **oben nach dem Titel** einen neuen Eintrag ein:

```markdown
## YYYY-MM-DD — <Titel der Session>

### Durchgeführte Änderungen

- **<Kategorie>:** <Was wurde gemacht>
- ...

### Neue Dateien

| Datei | Zweck |
|-------|-------|
| `path/to/file` | Kurzbeschreibung |

### Architekturentscheidungen

- <Entscheidung> — <Begründung>

### Session-Protokoll (von /stop erstellt)

| Datei | Aktion |
|-------|--------|
| `DEV-LOG.md` | Eintrag ergänzt |
| `docs/foo.md` | Erstellt |
| `src/bar/README.md` | Aktualisiert |
```

Nur Sektionen einfügen, die relevant sind. Die Sektion **Session-Protokoll** immer einfügen — sie listet alle Dateien, die der Skill selbst angelegt oder verändert hat.

### Schritt 3: ISSUES-LOG.md aktualisieren

Falls in dieser Session Fehler/Probleme gelöst wurden, lies `ISSUES-LOG.md` und füge am Ende hinzu:

```markdown
---

## YYYY-MM-DD

### <Kurztitel des Problems>

**Problem:** <Was war das Symptom?>

**Ursache:** <Warum trat es auf?>

**Lösung:** <Was hat es behoben?>
```

Falls keine Issues gelöst wurden, diesen Schritt überspringen.

### Schritt 4: Colocated Docs erstellen/aktualisieren

Für **jede** neu erstellte oder veränderte Datei/Modul eine `README.md` im selben Verzeichnis anlegen oder aktualisieren. Inhalt je nach Dateityp:

- **Vue-Komponente / Web Component:** Props-Tabelle, Events, kurze Nutzungsbeschreibung
- **Controller / Route:** Endpoint-Tabelle mit Methode, Pfad, Beschreibung
- **Service / Modul:** Öffentliche Methoden mit Parametern und Rückgabewerten
- **Schema / Migration:** Zweck der Änderung, betroffene Tabellen/Felder
- **Konfig / Setup:** Pflichtfelder, Umgebungsvariablen, Abhängigkeiten
- **Sonstiges:** Kurze Beschreibung, Zweck, Nutzungshinweis

Wenn im Verzeichnis bereits eine `README.md` existiert: aktualisieren, nicht überschreiben. Bestehende korrekte Inhalte beibehalten.

### Schritt 5: Zentrale Docs erstellen/aktualisieren

Für **jede** relevante Änderung in `docs/<Thema>.md` im Root dokumentieren. Themen-Mapping:

- Neue Komponente / UI-Modul → `docs/components.md`
- Neue Route / API-Endpoint → `docs/api.md`
- Neues Schema / DB-Änderung → `docs/schema.md`
- Neues Setup / Konfiguration → `docs/setup.md`
- Architekturentscheidung → `docs/architecture.md`
- Sonstiges → `docs/<passendes-thema>.md`

Falls `docs/` noch nicht existiert: **ohne Rückfrage anlegen**.

Format für jeden Eintrag in einer zentralen Doc:

```markdown
## <Thema oder Feature-Name> _(YYYY-MM-DD)_

<Kurze Beschreibung, was es ist und wozu es dient>

**Ort:** `path/to/file`

**Begründung:** <Warum wurde es so umgesetzt?>

**Bezüge:** <Verbindung zu anderen Teilen des Systems, falls relevant>
```

Bestehende Einträge nicht überschreiben — neue Abschnitte anhängen oder vorhandene aktualisieren.

### Schritt 6: Bestätigung

Gib eine kompakte Zusammenfassung aus:

```
Session protokolliert:
✓ DEV-LOG.md        — "<Session-Titel>"
✓ ISSUES-LOG.md     — N Issue(s) eingetragen
✓ Colocated Docs    — X README.md erstellt/aktualisiert
✓ Zentrale Docs     — Y docs/*.md erstellt/aktualisiert
```

## Regeln

- **Datum immer aus dem aktuellen Datum** (nicht aus der Konversation schätzen)
- Keine leeren Abschnitte oder Platzhalter eintragen
- Bestehende Einträge in DEV-LOG / ISSUES-LOG / Docs **nie überschreiben** — nur anhängen oder ergänzen
- Alle Dokumentations-Dateien sind **Markdown** (`.md`)
- `docs/` immer anlegen, wenn noch nicht vorhanden — keine Rückfrage
- Das **Session-Protokoll** im DEV-LOG immer befüllen, auch wenn nur Docs geschrieben wurden
- Stil konsistent mit bestehenden Einträgen halten
