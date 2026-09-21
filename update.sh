#!/usr/bin/env bash
# ==============================================================================
# Script de Actualización Rápida para el Tema Lizarbe & Dotfiles en Omarchy
# ==============================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/common.sh"

info "=== Actualizando Tema Lizarbe & Configuraciones en la Raíz del Sistema ==="
ensure_sudo

# 1. Obtener últimos cambios del repositorio si es un clon de Git
if [[ -d "$SCRIPT_DIR/.git" ]] && command -v git &>/dev/null; then
    info "Descargando actualizaciones desde GitHub (git pull)..."
    git -C "$SCRIPT_DIR" pull --ff-only || {
        warn "No se pudo realizar git pull automático (posibles cambios locales). Continuando con la aplicación..."
    }
fi

# 2. Actualizar tema nativo Lizarbe en /usr/share/omarchy/themes/
info "Actualizando tema Lizarbe en /usr/share/omarchy/themes/lizarbe..."
$SUDO mkdir -p "/usr/share/omarchy/themes"
$SUDO cp -r "$SCRIPT_DIR/config/omarchy/themes/lizarbe" "/usr/share/omarchy/themes/"
$SUDO chmod -R a+rX "/usr/share/omarchy/themes/lizarbe"
rm -rf "$HOME/.config/omarchy/themes/lizarbe"

# 3. Actualizar branding a nivel global y de usuario
if [[ -d "$SCRIPT_DIR/config/omarchy/branding" ]]; then
    info "Actualizando branding personalizado en el sistema..."
    $SUDO mkdir -p "/usr/share/omarchy/branding" "/etc/omarchy/branding"
    $SUDO cp -r "$SCRIPT_DIR/config/omarchy/branding/"* "/usr/share/omarchy/branding/" 2>/dev/null || true
    $SUDO cp -r "$SCRIPT_DIR/config/omarchy/branding/"* "/etc/omarchy/branding/" 2>/dev/null || true
    $SUDO chmod -R a+rX "/usr/share/omarchy/branding" "/etc/omarchy/branding" 2>/dev/null || true
    mkdir -p "$HOME/.config/omarchy/branding"
    cp -r "$SCRIPT_DIR/config/omarchy/branding/"* "$HOME/.config/omarchy/branding/"
fi

# 4. Actualizar configuración de Fastfetch y Starship
info "Actualizando configuración de terminal, Starship y Fastfetch..."
$SUDO mkdir -p "/etc/xdg/fastfetch"
$SUDO cp -r "$SCRIPT_DIR/config/fastfetch/"* "/etc/xdg/fastfetch/"
$SUDO chmod -R a+rX "/etc/xdg/fastfetch"

if [[ -f "$SCRIPT_DIR/config/starship.toml" ]]; then
    $SUDO cp "$SCRIPT_DIR/config/starship.toml" "/etc/starship.toml"
    $SUDO chmod a+r "/etc/starship.toml"
fi

if [[ -d "/etc/skel" ]]; then
    $SUDO mkdir -p "/etc/skel/.config/fastfetch"
    $SUDO cp -r "$SCRIPT_DIR/config/fastfetch/"* "/etc/skel/.config/fastfetch/" 2>/dev/null || true
    [[ -f "$SCRIPT_DIR/config/starship.toml" ]] && $SUDO cp "$SCRIPT_DIR/config/starship.toml" "/etc/skel/.config/" 2>/dev/null || true
fi

mkdir -p "$HOME/.config/fastfetch"
cp -r "$SCRIPT_DIR/config/fastfetch/"* "$HOME/.config/fastfetch/"
[[ -f "$SCRIPT_DIR/config/starship.toml" ]] && cp "$SCRIPT_DIR/config/starship.toml" "$HOME/.config/"

# 5. Actualizar pack de iconos Lizarbe-Red
if [[ -d "$SCRIPT_DIR/icons/Lizarbe-Red" ]]; then
    info "Actualizando iconos Lizarbe-Red en /usr/share/icons/..."
    $SUDO mkdir -p "/usr/share/icons"
    $SUDO cp -r "$SCRIPT_DIR/icons/Lizarbe-Red" "/usr/share/icons/"
    $SUDO chmod -R a+rX "/usr/share/icons/Lizarbe-Red"
    if command -v gtk-update-icon-cache &>/dev/null; then
        $SUDO gtk-update-icon-cache -f "/usr/share/icons/Lizarbe-Red" >/dev/null 2>&1 || true
    fi
    mkdir -p "$HOME/.local/share/icons" "$HOME/.icons"
    ln -sf "/usr/share/icons/Lizarbe-Red" "$HOME/.local/share/icons/Lizarbe-Red" 2>/dev/null || true
    ln -sf "/usr/share/icons/Lizarbe-Red" "$HOME/.icons/Lizarbe-Red" 2>/dev/null || true
fi

# 6. Actualizar tema GTK Darky en /usr/share/themes/
if [[ -d "$SCRIPT_DIR/themes/Darky" ]]; then
    info "Actualizando tema GTK Darky en /usr/share/themes/..."
    $SUDO mkdir -p "/usr/share/themes"
    $SUDO cp -r "$SCRIPT_DIR/themes/Darky" "/usr/share/themes/"
    $SUDO chmod -R a+rX "/usr/share/themes/Darky"
    mkdir -p "$HOME/.local/share/themes"
    ln -sf "/usr/share/themes/Darky" "$HOME/.local/share/themes/Darky" 2>/dev/null || true
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
success " ¡Tema Lizarbe y dotfiles actualizados en la raíz con éxito!"
success "=============================================================="
