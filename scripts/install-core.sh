#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

info "=== Instalando Configuración Base y Tema Lizarbe en la Raíz del Sistema ==="
ensure_sudo

# 1. Instalar paquetes base
install_pkg_file "$REPO_DIR/packages/pkgs-core.txt" "Paquetes Base del Sistema"

# 2. Copiar tema Lizarbe a la carpeta global de temas de Omarchy en la raíz del sistema
info "Instalando tema nativo Lizarbe en /usr/share/omarchy/themes/..."
$SUDO mkdir -p "/usr/share/omarchy/themes"
$SUDO cp -r "$REPO_DIR/config/omarchy/themes/lizarbe" "/usr/share/omarchy/themes/"
$SUDO chmod -R a+rX "/usr/share/omarchy/themes/lizarbe"
# Limpiar copia local antigua en caso de existir para evitar colisiones
rm -rf "$HOME/.config/omarchy/themes/lizarbe"

# 3. Copiar branding a nivel global en /usr/share/omarchy/branding y /etc/omarchy/branding
if [[ -d "$REPO_DIR/config/omarchy/branding" ]]; then
    info "Copiando branding personalizado en la raíz del sistema..."
    $SUDO mkdir -p "/usr/share/omarchy/branding" "/etc/omarchy/branding"
    $SUDO cp -r "$REPO_DIR/config/omarchy/branding/"* "/usr/share/omarchy/branding/" 2>/dev/null || true
    $SUDO cp -r "$REPO_DIR/config/omarchy/branding/"* "/etc/omarchy/branding/" 2>/dev/null || true
    $SUDO chmod -R a+rX "/usr/share/omarchy/branding" "/etc/omarchy/branding" 2>/dev/null || true
    mkdir -p "$HOME/.config/omarchy/branding"
    cp -r "$REPO_DIR/config/omarchy/branding/"* "$HOME/.config/omarchy/branding/"
fi

# 4. Copiar configuración de Fastfetch y Starship a nivel global (/etc) y de usuario
info "Configurando Fastfetch y terminal en la raíz del sistema (/etc)..."
$SUDO mkdir -p "/etc/xdg/fastfetch"
$SUDO cp -r "$REPO_DIR/config/fastfetch/"* "/etc/xdg/fastfetch/"
$SUDO chmod -R a+rX "/etc/xdg/fastfetch"

if [[ -f "$REPO_DIR/config/starship.toml" ]]; then
    $SUDO cp "$REPO_DIR/config/starship.toml" "/etc/starship.toml"
    $SUDO chmod a+r "/etc/starship.toml"
fi

if [[ -d "/etc/skel" ]]; then
    $SUDO mkdir -p "/etc/skel/.config/fastfetch"
    $SUDO cp -r "$REPO_DIR/config/fastfetch/"* "/etc/skel/.config/fastfetch/" 2>/dev/null || true
    [[ -f "$REPO_DIR/config/starship.toml" ]] && $SUDO cp "$REPO_DIR/config/starship.toml" "/etc/skel/.config/" 2>/dev/null || true
fi

mkdir -p "$HOME/.config/fastfetch"
cp -r "$REPO_DIR/config/fastfetch/"* "$HOME/.config/fastfetch/"
[[ -f "$REPO_DIR/config/starship.toml" ]] && cp "$REPO_DIR/config/starship.toml" "$HOME/.config/"

# 5. Instalar tema de iconos Lizarbe-Red a nivel global en /usr/share/icons/
if [[ -d "$REPO_DIR/icons/Lizarbe-Red" ]]; then
    info "Instalando tema de iconos Lizarbe-Red en /usr/share/icons/..."
    $SUDO mkdir -p "/usr/share/icons"
    $SUDO cp -r "$REPO_DIR/icons/Lizarbe-Red" "/usr/share/icons/"
    $SUDO chmod -R a+rX "/usr/share/icons/Lizarbe-Red"
    if command -v gtk-update-icon-cache &>/dev/null; then
        $SUDO gtk-update-icon-cache -f "/usr/share/icons/Lizarbe-Red" >/dev/null 2>&1 || true
    fi
    # Enlace de compatibilidad
    mkdir -p "$HOME/.local/share/icons" "$HOME/.icons"
    ln -sf "/usr/share/icons/Lizarbe-Red" "$HOME/.local/share/icons/Lizarbe-Red" 2>/dev/null || true
    ln -sf "/usr/share/icons/Lizarbe-Red" "$HOME/.icons/Lizarbe-Red" 2>/dev/null || true
fi

# 6. Instalar tema GTK Darky a nivel global en /usr/share/themes/
if [[ -d "$REPO_DIR/themes/Darky" ]]; then
    info "Instalando tema GTK Darky en /usr/share/themes/ (sin aplicar)..."
    $SUDO mkdir -p "/usr/share/themes"
    $SUDO cp -r "$REPO_DIR/themes/Darky" "/usr/share/themes/"
    $SUDO chmod -R a+rX "/usr/share/themes/Darky"
    mkdir -p "$HOME/.local/share/themes"
    ln -sf "/usr/share/themes/Darky" "$HOME/.local/share/themes/Darky" 2>/dev/null || true
fi

# 7. Configurar Zen Browser como predeterminado
if command -v omarchy-default-browser &>/dev/null; then
    info "Estableciendo Zen Browser como navegador predeterminado de Omarchy..."
    omarchy-default-browser zen || true
fi

# 8. Aplicar tema de forma nativa e instantánea a través de Omarchy
if command -v omarchy &>/dev/null; then
    info "Aplicando tema Lizarbe con omarchy theme set..."
    omarchy theme set lizarbe || true
fi

success "Tema Lizarbe instalado en la raíz del sistema (/usr/share/omarchy/themes/) y aplicado con éxito."
echo ""
echo -e "${YELLOW}💡 Recomendación (Tema GTK Darky):${NC}"
echo -e "   El tema GTK Darky ha quedado preinstalado en el sistema."
echo -e "   Si deseas activarlo en tus aplicaciones GTK:"
echo -e "   1. Abre el gestor de apariencia: ejecuta ${CYAN}nwg-look${NC} en la terminal (o desde el menú)."
echo -e "   2. En la pestaña 'Widget', selecciona ${CYAN}Darky${NC} y haz clic en ${GREEN}Apply${NC}."
echo ""
