#!/bin/bash
THEME="$1"

GTK4_DIR="$HOME/.config/gtk-4.0"
DARKY_GTK4="$HOME/.local/share/themes/Darky/gtk-4.0"

if [[ "$THEME" == "lizarbe" ]]; then
  # 1. Aplicar en GNOME Settings
  gsettings set org.gnome.desktop.interface gtk-theme "Darky"
  gsettings set org.gnome.desktop.interface icon-theme "Lizarbe-Red"
  gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

  # 2. Sincronizar xsettingsd y gtkrc
  if [[ -f "$HOME/.config/xsettingsd/xsettingsd.conf" ]]; then
    sed -i 's/^Net\/ThemeName .*/Net\/ThemeName "Darky"/' "$HOME/.config/xsettingsd/xsettingsd.conf"
    sed -i 's/^Net\/IconThemeName .*/Net\/IconThemeName "Lizarbe-Red"/' "$HOME/.config/xsettingsd/xsettingsd.conf"
  fi
  if [[ -f "$HOME/.gtkrc-2.0" ]]; then
    sed -i 's/^gtk-theme-name=.*/gtk-theme-name="Darky"/' "$HOME/.gtkrc-2.0"
    sed -i 's/^gtk-icon-theme-name=.*/gtk-icon-theme-name="Lizarbe-Red"/' "$HOME/.gtkrc-2.0"
  fi

  # 3. Vincular tema GTK4 / Libadwaita para Nautilus
  mkdir -p "$GTK4_DIR"
  ln -sf "$DARKY_GTK4/gtk.css" "$GTK4_DIR/gtk.css"
  ln -sf "$DARKY_GTK4/gtk-dark.css" "$GTK4_DIR/gtk-dark.css"
  ln -sf "$DARKY_GTK4/assets" "$GTK4_DIR/assets"
else
  # Restaurar valores limpios para otros temas de Omarchy
  OFFICIAL_ICON="Yaru-blue"
  if [[ -f "$HOME/.local/state/omarchy/current/theme/icons.theme" ]]; then
    OFFICIAL_ICON=$(cat "$HOME/.local/state/omarchy/current/theme/icons.theme")
  fi

  if [[ -f "$HOME/.config/xsettingsd/xsettingsd.conf" ]]; then
    sed -i 's/^Net\/ThemeName .*/Net\/ThemeName "Adwaita-dark"/' "$HOME/.config/xsettingsd/xsettingsd.conf"
    sed -i "s/^Net\/IconThemeName .*/Net\/IconThemeName \"$OFFICIAL_ICON\"/" "$HOME/.config/xsettingsd/xsettingsd.conf"
  fi
  if [[ -f "$HOME/.gtkrc-2.0" ]]; then
    sed -i 's/^gtk-theme-name=.*/gtk-theme-name="Adwaita-dark"/' "$HOME/.gtkrc-2.0"
    sed -i "s/^gtk-icon-theme-name=.*/gtk-icon-theme-name=\"$OFFICIAL_ICON\"/" "$HOME/.gtkrc-2.0"
  fi

  # Quitar enlaces de Darky de GTK4 para que vuelva al estilo nativo de Omarchy/Adwaita
  if [[ -L "$GTK4_DIR/gtk.css" && "$(readlink -f "$GTK4_DIR/gtk.css")" == *Darky* ]]; then
    rm -f "$GTK4_DIR/gtk.css"
  fi
  if [[ -L "$GTK4_DIR/gtk-dark.css" && "$(readlink -f "$GTK4_DIR/gtk-dark.css")" == *Darky* ]]; then
    rm -f "$GTK4_DIR/gtk-dark.css"
  fi
  if [[ -L "$GTK4_DIR/assets" && "$(readlink -f "$GTK4_DIR/assets")" == *Darky* ]]; then
    rm -f "$GTK4_DIR/assets"
  fi
fi

# Recargar xsettingsd si está corriendo
if pgrep -x xsettingsd >/dev/null; then
  pkill -HUP xsettingsd >/dev/null 2>&1 || true
fi

# Cerrar daemon de Nautilus para que aplique los nuevos iconos y tema inmediatamente al abrirse
if command -v nautilus &>/dev/null; then
  nautilus -q >/dev/null 2>&1 || true
fi

# Reiniciar la barra superior de Omarchy
omarchy-restart-shell >/dev/null 2>&1
