#!/bin/bash
# auto-log.sh — Automatisches Session-Protokoll via Stop-Hook
# Wird von Claude Code am Session-Ende ausgeführt.
# Schreibt einen Git-basierten Eintrag in DEV-LOG.md,
# falls seit dem letzten Commit Änderungen vorliegen.

WORKDIR="${PWD}"
DEVLOG="${WORKDIR}/DEV-LOG.md"
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)

# Nur ausführen, wenn DEV-LOG.md existiert
if [ ! -f "$DEVLOG" ]; then
  exit 0
fi

# Git-Änderungen ermitteln (staged + unstaged gegenüber HEAD)
DIFF_STAT=$(git -C "$WORKDIR" diff --stat HEAD 2>/dev/null)
UNTRACKED=$(git -C "$WORKDIR" ls-files --others --exclude-standard 2>/dev/null | head -20)

# Nichts zu protokollieren → stille Beendigung
if [ -z "$DIFF_STAT" ] && [ -z "$UNTRACKED" ]; then
  exit 0
fi

# Bereits ein automatischer Eintrag für heute vorhanden? → überspringen
if grep -q "^## ${DATE} — Automatisch" "$DEVLOG" 2>/dev/null; then
  exit 0
fi

# Eintrag zusammenstellen
ENTRY="## ${DATE} — Automatisch protokolliert (${TIME})\n\n"
ENTRY+="### Geänderte Dateien\n\n"

if [ -n "$DIFF_STAT" ]; then
  ENTRY+="\`\`\`\n${DIFF_STAT}\n\`\`\`\n\n"
fi

if [ -n "$UNTRACKED" ]; then
  ENTRY+="### Neue Dateien (untracked)\n\n"
  while IFS= read -r file; do
    ENTRY+="- \`${file}\`\n"
  done <<< "$UNTRACKED"
  ENTRY+="\n"
fi

ENTRY+="> Für vollständige Dokumentation (Colocated Docs + zentrale Docs) \`/stop\` ausführen.\n"

# In DEV-LOG.md einfügen — direkt nach dem Titel (erste Zeile mit #)
TITLE_LINE=$(grep -n "^# " "$DEVLOG" | head -1 | cut -d: -f1)

if [ -n "$TITLE_LINE" ]; then
  # Nach dem Titel einfügen
  sed -i '' "${TITLE_LINE}a\\
\\
${ENTRY}" "$DEVLOG" 2>/dev/null || {
    # Fallback: ans Ende anhängen
    printf "\n%b" "$ENTRY" >> "$DEVLOG"
  }
else
  printf "\n%b" "$ENTRY" >> "$DEVLOG"
fi
