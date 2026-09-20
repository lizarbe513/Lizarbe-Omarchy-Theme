#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

info "=== Instalando Suite Multimedia & Audio/Video ==="
install_pkg_file "$REPO_DIR/packages/pkgs-multimedia.txt" "Suite Multimedia"

success "Herramientas multimedia listas: DaVinci Resolve, Kdenlive, Shotcut, OBS Studio y Audacity."
