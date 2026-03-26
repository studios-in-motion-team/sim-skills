---
name: stop
description: "Protokolliert die Session in DEV-LOG.md, trägt gelöste Issues in ISSUES-LOG.md ein und erstellt/aktualisiert Dokumentation für geänderte Dateien. Trigger: 'session abschließen', 'session protokollieren', 'session log', '/stop'."
argument-hint: "[kurze Beschreibung des Session-Themas]"
---

# Skill: Session-Abschluss

Protokolliert die aktuelle Session vollständig und hält Wissen dauerhaft fest.

## Was dieser Skill tut

1. **DEV-LOG.md** — Datierter Eintrag mit Zusammenfassung aller Änderungen dieser Session
2. **ISSUES-LOG.md** — Trägt gelöste Probleme mit Ursache & Lösung ein
3. **Dokumentation** — Erstellt oder aktualisiert Docs für neue/geänderte Dateien (colocated + zentral)

## Ablauf

### Schritt 1: Session analysieren

Gehe die gesamte Konversation durch und identifiziere:

- **Was wurde geändert/erstellt?** (Dateipfade, kurze Beschreibung)
- **Welche Probleme wurden gelöst?** (Problem, Ursache, Lösung)
- **Wurden neue Dateien, Komponenten, Routes, Schemas etc. erstellt?**
- **Welche Architekturentscheidungen wurden getroffen?**

### Schritt 2: DEV-LOG.md aktualisieren

Lies zuerst `DEV-LOG.md` und füge **oben nach dem Titel** (oder am Ende, falls das Format es so vorgibt) einen neuen Eintrag ein:

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
```

Nur Sektionen einfügen, die relevant sind. Keine leeren Tabellen oder Abschnitte.

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

### Schritt 4: Dokumentation erstellen/aktualisieren

#### Colocated Docs (Priorität 1)

Für jede neu erstellte oder stark veränderte Datei/Modul:

- **Vue-Komponente / Lit Web Component:** Kurz-Kommentar im File-Header mit Props-Tabelle (falls noch nicht vorhanden)
- **PHP-Controller / Route:** `README.md` im gleichen Verzeichnis mit Endpoint-Tabelle
- **Backend-Modul / Service:** JSDoc / PHPDoc für öffentliche Methoden
- **Datenbank-Schema / Migration:** Kommentar in der SQL/Schema-Datei mit Zweck der Änderung

Nur erstellen, wenn die Datei **keine ausreichende Dokumentation** hat. Bestehende Docs aktualisieren, nicht überschreiben.

#### Zentrale Docs (Priorität 2)

Nur wenn eine **architekturrelevante Entscheidung** getroffen wurde (neue Technologie, neue Layer, neues Pattern):

- Erstelle oder aktualisiere `docs/<Thema>.md`
- Format: Kurze Beschreibung, Begründung, Bezug zu anderen Teilen des Systems

Wenn ein `docs/`-Verzeichnis noch nicht existiert, frage den User zuerst, ob es angelegt werden soll.

### Schritt 5: Bestätigung

Gib eine kompakte Zusammenfassung aus:

```
Session protokolliert:
✓ DEV-LOG.md — "<Session-Titel>"
✓ ISSUES-LOG.md — N Issue(s) eingetragen
✓ Docs — X Datei(en) erstellt/aktualisiert
```

## Regeln

- **Datum immer aus dem aktuellen Datum** (nicht aus der Konversation schätzen)
- Keine leeren Abschnitte oder Platzhalter eintragen
- Bestehende Einträge in DEV-LOG / ISSUES-LOG nie überschreiben — nur anhängen
- Dokumentation nur für tatsächlich geänderte/erstellte Dateien
- Stil konsistent mit bestehenden Einträgen halten
