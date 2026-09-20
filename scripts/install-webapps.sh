#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

info "=== Configurando Webapps en Omarchy ==="

if command -v omarchy-webapp-install &>/dev/null; then
    info "Instalando WhatsApp Web..."
    omarchy-webapp-install "WhatsApp" "https://web.whatsapp.com/" "whatsapp" || true

    info "Instalando YouTube..."
    omarchy-webapp-install "YouTube" "https://youtube.com/" "youtube" || true

    success "Webapps instaladas y añadidas al menú de aplicaciones."
else
    warn "omarchy-webapp-install no encontrado en el sistema. Asegúrate de estar ejecutando Omarchy."
fi
