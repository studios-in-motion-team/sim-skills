#!/bin/bash

# Claude Code — Session Workflow Installer
# https://github.com/studios-in-motion-team/sim-skills

SKILL_VERSION="1.1.0"
REPO_RAW="https://raw.githubusercontent.com/studios-in-motion-team/sim-skills/main"
SKILL_TARGET=".claude/commands/stop.md"
SETTINGS_FILE=".claude/settings.json"

HOOK_COMMAND="echo '{\"systemMessage\": \"Session-Abschluss: Bitte /stop ausfuehren, um DEV-LOG, ISSUES-LOG und Dokumentation zu aktualisieren.\"}'"

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo -e "${BLUE}Claude Code — Session Workflow Installer v${SKILL_VERSION}${NC}"
echo "────────────────────────────────────────────"
echo ""

# ── 1. Skill installieren ──────────────────────────────────────────────────────

echo -e "${BLUE}[1/3] Skill installieren...${NC}"

mkdir -p ".claude/commands"

if [ -f "$SKILL_TARGET" ]; then
  echo -e "  ${YELLOW}⚠ $SKILL_TARGET existiert bereits — wird überschrieben.${NC}"
fi

curl -fsSL "$REPO_RAW/stop.md" -o "$SKILL_TARGET"
echo -e "  ${GREEN}✓ stop.md → $SKILL_TARGET${NC}"

# ── 2. Stop-Hook einrichten ────────────────────────────────────────────────────

echo ""
echo -e "${BLUE}[2/3] Stop-Hook einrichten...${NC}"

if [ ! -f "$SETTINGS_FILE" ]; then
  echo '{}' > "$SETTINGS_FILE"
  echo -e "  ${GREEN}✓ $SETTINGS_FILE erstellt${NC}"
fi

# Prüfen ob jq verfügbar ist
if ! command -v jq &> /dev/null; then
  echo -e "  ${YELLOW}⚠ jq nicht gefunden — Hook muss manuell eingetragen werden.${NC}"
  echo ""
  echo "  Füge folgendes in $SETTINGS_FILE ein:"
  echo '  "hooks": {'
  echo '    "Stop": [{'
  echo '      "hooks": [{'
  echo '        "type": "command",'
  echo "        \"command\": \"$HOOK_COMMAND\","
  echo '        "statusMessage": "Session-Abschluss-Reminder..."'
  echo '      }]'
  echo '    }]'
  echo '  }'
else
  # Hook nur eintragen wenn noch nicht vorhanden
  HOOK_EXISTS=$(jq '.hooks.Stop // [] | length' "$SETTINGS_FILE" 2>/dev/null)

  if [ "$HOOK_EXISTS" -gt "0" ] 2>/dev/null; then
    echo -e "  ${YELLOW}⚠ Stop-Hook bereits vorhanden — wird nicht überschrieben.${NC}"
  else
    UPDATED=$(jq \
      --arg cmd "$HOOK_COMMAND" \
      '.hooks.Stop = [{"hooks": [{"type": "command", "command": $cmd, "statusMessage": "Session-Abschluss-Reminder..."}]}]' \
      "$SETTINGS_FILE")
    echo "$UPDATED" > "$SETTINGS_FILE"
    echo -e "  ${GREEN}✓ Stop-Hook eingetragen${NC}"
  fi
fi

# ── 3. Projekt-Templates ──────────────────────────────────────────────────────

echo ""
echo -e "${BLUE}[3/3] Projekt-Templates...${NC}"

if [ ! -f "DEV-LOG.md" ]; then
  curl -fsSL "$REPO_RAW/templates/DEV-LOG.md" -o DEV-LOG.md
  echo -e "  ${GREEN}✓ DEV-LOG.md angelegt${NC}"
else
  echo -e "  ${YELLOW}⚠ DEV-LOG.md existiert bereits — übersprungen${NC}"
fi

if [ ! -f "ISSUES-LOG.md" ]; then
  curl -fsSL "$REPO_RAW/templates/ISSUES-LOG.md" -o ISSUES-LOG.md
  echo -e "  ${GREEN}✓ ISSUES-LOG.md angelegt${NC}"
else
  echo -e "  ${YELLOW}⚠ ISSUES-LOG.md existiert bereits — übersprungen${NC}"
fi

# ── Fertig ─────────────────────────────────────────────────────────────────────

echo ""
echo -e "${GREEN}────────────────────────────────────────────${NC}"
echo -e "${GREEN}Installation abgeschlossen.${NC}"
echo ""
echo -e "  Skill verfügbar als: ${BLUE}/stop${NC}"
echo -e "  Hook + Skill sind repo-lokal in ${YELLOW}.claude/${NC} installiert."
echo -e "  Beim nächsten Session-Ende erscheint automatisch eine Erinnerung."
echo ""
