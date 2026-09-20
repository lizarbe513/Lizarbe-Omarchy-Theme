#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

info "=== Instalando Suite de Desarrollo & Construcción de Software ==="
install_pkg_file "$REPO_DIR/packages/pkgs-dev.txt" "Suite de Desarrollo"

# Configuración de Docker si está instalado
if command -v docker &>/dev/null; then
    info "Habilitando servicio Docker..."
    sudo systemctl enable --now docker.service || true
    if ! groups "$USER" | grep -q "\bdocker\b"; then
        info "Añadiendo usuario $USER al grupo docker..."
        sudo usermod -aG docker "$USER" || true
        warn "Recuerda reiniciar sesión para usar docker sin sudo."
    fi
fi

success "Herramientas de desarrollo listas: VS Code, Git, Lazygit, Docker y Lazydocker."
