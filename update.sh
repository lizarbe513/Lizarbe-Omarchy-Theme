#!/usr/bin/env bash
# ==============================================================================
# Script de Actualización Rápida para el Tema Lizarbe & Dotfiles en Omarchy
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/common.sh"

info "=== Actualizando Tema Lizarbe & Configuraciones ==="

# 1. Obtener últimos cambios del repositorio si es un clon de Git
if [[ -d "$SCRIPT_DIR/.git" ]] && command -v git &>/dev/null; then
    info "Descargando actualizaciones desde GitHub (git pull)..."
    git -C "$SCRIPT_DIR" pull --ff-only || {
        warn "No se pudo realizar git pull automático (posibles cambios locales). Continuando con la aplicación..."
    }
fi

# 2. Actualizar tema nativo Lizarbe en ~/.config/omarchy/themes/
info "Actualizando tema Lizarbe en ~/.config/omarchy/themes/..."
mkdir -p "$HOME/.config/omarchy/themes"
cp -r "$SCRIPT_DIR/config/omarchy/themes/lizarbe" "$HOME/.config/omarchy/themes/"

# 3. Actualizar branding (logo Fastfetch y about)
if [[ -d "$SCRIPT_DIR/config/omarchy/branding" ]]; then
    info "Actualizando branding personalizado..."
    mkdir -p "$HOME/.config/omarchy/branding"
    cp -r "$SCRIPT_DIR/config/omarchy/branding/"* "$HOME/.config/omarchy/branding/"
fi

# 4. Actualizar configuración de Fastfetch y Starship
info "Actualizando configuración de terminal, Starship y Fastfetch..."
mkdir -p "$HOME/.config/fastfetch"
cp -r "$SCRIPT_DIR/config/fastfetch/"* "$HOME/.config/fastfetch/"

if [[ -f "$SCRIPT_DIR/config/starship.toml" ]]; then
    cp "$SCRIPT_DIR/config/starship.toml" "$HOME/.config/"
fi

# 5. Actualizar pack de iconos Lizarbe-Red
if [[ -d "$SCRIPT_DIR/icons/Lizarbe-Red" ]]; then
    info "Actualizando iconos Lizarbe-Red..."
    mkdir -p "$HOME/.local/share/icons" "$HOME/.icons"
    cp -r "$SCRIPT_DIR/icons/Lizarbe-Red" "$HOME/.local/share/icons/"
    ln -sf "$HOME/.local/share/icons/Lizarbe-Red" "$HOME/.icons/Lizarbe-Red"
    if command -v gtk-update-icon-cache &>/dev/null; then
        gtk-update-icon-cache -f "$HOME/.local/share/icons/Lizarbe-Red" >/dev/null 2>&1 || true
    fi
fi

# 6. Actualizar tema GTK Darky en ~/.local/share/themes/
if [[ -d "$SCRIPT_DIR/themes/Darky" ]]; then
    info "Actualizando tema GTK Darky en ~/.local/share/themes/..."
    mkdir -p "$HOME/.local/share/themes"
    cp -r "$SCRIPT_DIR/themes/Darky" "$HOME/.local/share/themes/"
fi

# 7. Asegurar que Zen Browser siga como predeterminado si está instalado
if command -v zen-browser &>/dev/null && command -v omarchy-default-browser &>/dev/null; then
    omarchy-default-browser zen >/dev/null 2>&1 || true
fi

# 8. Refrescar tema de forma nativa a través de Omarchy
if command -v omarchy &>/dev/null; then
    info "Recargando tema Lizarbe en vivo..."
    omarchy theme set lizarbe || true
fi

echo ""
success "=============================================================="
success " ¡Tema Lizarbe y dotfiles actualizados con éxito!"
success "=============================================================="
