#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

info "=== Instalando Suite Creativa 3D, CAD & Videojuegos ==="

# Detección informativa de GPU
if command -v lspci &>/dev/null; then
    gpus=$(lspci | grep -E -i "vga|3d|display" || true)
    info "GPU(s) detectada(s):"
    echo "$gpus"
    if ! echo "$gpus" | grep -E -i "nvidia|radeon rx|dedicated" &>/dev/null; then
        warn "No se detectó una GPU dedicada evidente. Herramientas pesadas como Blender o Godot podrían requerir moderar la complejidad de la escena o renders por CPU."
    fi
fi

install_pkg_file "$REPO_DIR/packages/pkgs-3d.txt" "Suite Creativa 3D & CAD"

success "Aplicaciones 3D listas: Blender, FreeCAD, Godot y Blockbench."
