#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

info "=== Instalando Suite Creativa 2D (Ilustración & Pixel Art) ==="
install_pkg_file "$REPO_DIR/packages/pkgs-2d.txt" "Suite Creativa 2D"

success "Aplicaciones 2D listas: Krita, LibreSprite, Inkscape y Pinta."
