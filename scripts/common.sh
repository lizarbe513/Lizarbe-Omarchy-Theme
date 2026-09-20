#!/usr/bin/env bash
set -e

# Colores para salida
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Sincronizar y actualizar usando el actualizador nativo de Omarchy
sync_repos() {
    if [[ "${REPOS_SYNCED:-0}" != "1" ]]; then
        if command -v omarchy &>/dev/null; then
            info "Actualizando sistema, keyrings y repositorios con Omarchy (omarchy update -y)..."
            omarchy update -y || {
                warn "omarchy update terminó con observaciones. Asegurando sincronización con pacman..."
                sudo pacman -Sy --noconfirm || true
            }
        else
            info "Sincronizando bases de datos de repositorios de Arch (pacman -Sy)..."
            sudo pacman -Sy --noconfirm || true
        fi
        export REPOS_SYNCED=1
    fi
}

# Comprobar que yay esté disponible
check_aur_helper() {
    sync_repos
    if ! command -v yay &>/dev/null; then
        warn "yay no está instalado. Intentando instalar paquetes con pacman..."
        AUR_HELPER="sudo pacman -S --needed --noconfirm"
    else
        AUR_HELPER="yay -S --needed --noconfirm"
    fi
}

# Instalar lista de paquetes desde archivo
install_pkg_file() {
    local pkg_file="$1"
    local suite_name="$2"

    if [[ ! -f "$pkg_file" ]]; then
        error "No se encontró el archivo de paquetes: $pkg_file"
        return 1
    fi

    check_aur_helper

    local pkgs=()
    while IFS= read -r line || [[ -n "$line" ]]; do
        line="$(echo "$line" | sed -e 's/#.*//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
        if [[ -n "$line" ]]; then
            pkgs+=("$line")
        fi
    done < "$pkg_file"

    if [[ ${#pkgs[@]} -gt 0 ]]; then
        info "Instalando paquetes de ${suite_name} (${#pkgs[@]} paquetes)..."
        $AUR_HELPER "${pkgs[@]}"
        success "${suite_name} instalada exitosamente."
    else
        warn "No hay paquetes para instalar en $pkg_file."
    fi
}
