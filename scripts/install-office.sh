#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

info "=== Instalando Suite Ofimática & Productividad ==="
install_pkg_file "$REPO_DIR/packages/pkgs-office.txt" "Suite Ofimática y Notas"

success "Herramientas ofimáticas listas: genOffice (IA), ONLYOFFICE, Obsidian, Xournal++ y LibreOffice."
