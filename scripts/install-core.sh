#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

info "=== Instalando Configuración Base y Tema Lizarbe ==="

# 1. Instalar paquetes base
install_pkg_file "$REPO_DIR/packages/pkgs-core.txt" "Paquetes Base del Sistema"

# 2. Copiar tema Lizarbe a la carpeta de temas de Omarchy
info "Instalando tema nativo Lizarbe en ~/.config/omarchy/themes/..."
mkdir -p "$HOME/.config/omarchy/themes"
cp -r "$REPO_DIR/config/omarchy/themes/lizarbe" "$HOME/.config/omarchy/themes/"

# 3. Copiar branding (logo y acerca de)
if [[ -d "$REPO_DIR/config/omarchy/branding" ]]; then
    info "Copiando branding personalizado..."
    mkdir -p "$HOME/.config/omarchy/branding"
    cp -r "$REPO_DIR/config/omarchy/branding/"* "$HOME/.config/omarchy/branding/"
fi

# 4. Copiar configuración de Fastfetch y Starship
info "Configurando Fastfetch y terminal..."
mkdir -p "$HOME/.config/fastfetch"
cp -r "$REPO_DIR/config/fastfetch/"* "$HOME/.config/fastfetch/"

if [[ -f "$REPO_DIR/config/starship.toml" ]]; then
    cp "$REPO_DIR/config/starship.toml" "$HOME/.config/"
fi

# 5. Instalar tema de iconos Lizarbe-Red
if [[ -d "$REPO_DIR/icons/Lizarbe-Red" ]]; then
    info "Instalando tema de iconos Lizarbe-Red en ~/.local/share/icons/..."
    mkdir -p "$HOME/.local/share/icons" "$HOME/.icons"
    cp -r "$REPO_DIR/icons/Lizarbe-Red" "$HOME/.local/share/icons/"
    ln -sf "$HOME/.local/share/icons/Lizarbe-Red" "$HOME/.icons/Lizarbe-Red"
    if command -v gtk-update-icon-cache &>/dev/null; then
        gtk-update-icon-cache -f "$HOME/.local/share/icons/Lizarbe-Red" >/dev/null 2>&1 || true
    fi
fi

# 6. Aplicar tema de forma nativa e instantánea a través de Omarchy
if command -v omarchy &>/dev/null; then
    info "Aplicando tema Lizarbe con omarchy theme set..."
    omarchy theme set lizarbe || true
fi

success "Tema Lizarbe instalado y aplicado de forma 100% nativa y fluida."
