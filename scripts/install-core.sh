#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

info "=== Instalando Configuración Base y Tema Lizarbe ==="

# 1. Instalar paquetes base
install_pkg_file "$REPO_DIR/packages/pkgs-core.txt" "Paquetes Base del Sistema"

# 2. Copiar configuraciones a ~/.config
info "Copiando dotfiles y configuraciones..."
mkdir -p "$HOME/.config"
cp -r "$REPO_DIR/config/omarchy" "$HOME/.config/"
cp -r "$REPO_DIR/config/fastfetch" "$HOME/.config/"
if [[ -f "$REPO_DIR/config/starship.toml" ]]; then
    cp "$REPO_DIR/config/starship.toml" "$HOME/.config/"
fi
if [[ -f "$REPO_DIR/config/darkyrc" ]]; then
    cp "$REPO_DIR/config/darkyrc" "$HOME/.config/"
fi

# 3. Permisos de hooks
if [[ -f "$HOME/.config/omarchy/hooks/theme-set.d/set-darky.sh" ]]; then
    chmod +x "$HOME/.config/omarchy/hooks/theme-set.d/set-darky.sh"
fi

# 4. Instalar tema GTK Darky
info "Instalando tema GTK Darky..."
mkdir -p "$HOME/.local/share/themes"
cp -r "$REPO_DIR/themes/Darky" "$HOME/.local/share/themes/"

# 5. Instalar Iconos
info "Instalando paquetes de iconos..."
mkdir -p "$HOME/.local/share/icons" "$HOME/.icons"
cp -r "$REPO_DIR/icons/Lizarbe-Red" "$HOME/.local/share/icons/"
cp -r "$REPO_DIR/icons/Dedicated-to-Hackerer-Red" "$HOME/.local/share/icons/"

# Enlaces simbólicos en ~/.icons para compatibilidad con aplicaciones antiguas
ln -sf "$HOME/.local/share/icons/Lizarbe-Red" "$HOME/.icons/Lizarbe-Red"
ln -sf "$HOME/.local/share/icons/Dedicated-to-Hackerer-Red" "$HOME/.icons/Dedicated-to-Hackerer-Red"
ln -sf "$HOME/.local/share/icons/Dedicated-to-Hackerer-Red" "$HOME/.icons/Dedicated to Hackerer (Red)"

# Actualizar caché de iconos
if command -v gtk-update-icon-cache &>/dev/null; then
    gtk-update-icon-cache -f "$HOME/.local/share/icons/Lizarbe-Red" >/dev/null 2>&1 || true
fi

# 6. Aplicar tema en Omarchy
if command -v omarchy &>/dev/null; then
    info "Aplicando tema Lizarbe con omarchy theme set..."
    omarchy theme set lizarbe || true
fi

success "Base y tema Lizarbe instalados y configurados con éxito."
