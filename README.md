# Omarchy - Setup Creatividad & Construcción (Tema Lizarbe)

Configuración completa para un sistema **Omarchy** recién instalado, orientada a la **creatividad visual, modelado/construcción espacial, desarrollo de software y ofimática**.

Incluye:
- **Temas nativos Lizarbe (Dark & Light)**: Variantes completas en modo oscuro (fondo OLED / charcoal) y modo claro (papel milimetrado y dibujo técnico CAD / Whiteprint), con wallpapers en pixel art, bordes geométricos e indicadores en rojo de forma nativa.
- **Pack de Iconos Lizarbe-Red**: Iconos personalizados que alternan fluidamente con cualquier tema de Omarchy.
- **Tema GTK Darky**: Preinstalado en el sistema como opción para activarlo libremente mediante `nwg-look`.
- **Branding propio y Terminal**: Logo ASCII personalizado en Fastfetch, starship prompt y soporte dinámico de terminales.
- **Instaladores modulares** organizados por suites independientes.

---

## 🚀 Instalación Rápida (Un solo comando)

Puedes instalarlo directamente en tu terminal ejecutando esta sola línea:

```bash
git clone https://github.com/lizarbe513/Lizarbe-Omarchy-Theme.git && cd Lizarbe-Omarchy-Theme && ./install.sh
```

> [!TIP]
> Si prefieres la instalación manual paso a paso:
> ```bash
> git clone https://github.com/lizarbe513/Lizarbe-Omarchy-Theme.git
> cd Lizarbe-Omarchy-Theme
> ./install.sh
> ```

El instalador te preguntará qué suites deseas instalar en ese equipo específico.

---

## ⚙️ Opciones de instalación automática (Flags)

Si prefieres no usar el modo interactivo, puedes pasarle argumentos directos:

| Comando | Descripción |
|---|---|
| `./install.sh --all` | Instala todo (incluye 3D) |
| `./install.sh --no-3d` | **Recomendado para portátiles / sin gráfica dedicada** (instala todo excepto 3D) |
| `./install.sh --core-only` | Solo tema, iconos, branding y dotfiles base |
| `./install.sh --2d` | Solo la suite de Ilustración & Pixel Art |
| `./install.sh --3d` | Solo la suite de Modelado 3D & CAD |
| `./install.sh --dev` | Solo herramientas de desarrollo y Docker |
| `./install.sh --office` | Solo ofimática y notas |
| `./install.sh --multimedia` | Solo edición de video y audio |
| `./install.sh --webapps` | Solo las webapps (WhatsApp, YouTube) |

También puedes ejecutar cualquiera de los scripts individuales directamente:
```bash
bash scripts/install-2d.sh
bash scripts/install-core.sh
```

---

## 📦 Suites y Aplicaciones Incluidas

### 1. Base del Sistema & Temas Lizarbe (`scripts/install-core.sh`)
* **Temas Omarchy `Lizarbe` y `Lizarbe Light`**: Instalados en la raíz del sistema en `/usr/share/omarchy/themes/` con wallpapers de dibujo técnico/pixel art, configuración modular para Quickshell (`shell.bar`, `shell.menu`, `shell.launcher`, `shell.lock`) y colores de sintaxis con alto contraste.
  * Cambiar a modo oscuro: `omarchy theme set lizarbe`
  * Cambiar a modo claro: `omarchy theme set lizarbe-light`
* **Pack de iconos `Lizarbe-Red`**: Instalado globalmente en `/usr/share/icons/`
* **Zen Browser**: Navegador web predeterminado configurado nativamente con Omarchy
* **Tema GTK `Darky`**: Instalado a nivel de sistema en `/usr/share/themes/` (opcional: actívalo abriendo `nwg-look` > Widget > `Darky`)
* `fastfetch` con logo personalizado, `starship` (estilo limpio Omarchy), `nwg-look`, `htop`, `kdeconnect`

### 2. Creatividad 2D (`scripts/install-2d.sh`)
* **Krita**: Pintura digital e ilustración
* **LibreSprite**: Animación y pixel art
* **Inkscape**: Diseño y vectores
* **Pinta**: Retoque rápido de imagen

### 3. Creatividad 3D, CAD & Construcción (`scripts/install-3d.sh`)
*(Recomendado con GPU dedicada)*
* **Blender**: Modelado 3D, escultura y animación
* **FreeCAD**: Diseño paramétrico 3D y piezas mecánicas/CAD
* **Blockbench**: Modelado 3D low-poly y vóxeles
* **Godot**: Motor de videojuegos 2D/3D

### 4. Desarrollo & Construcción de Software (`scripts/install-dev.sh`)
* **Visual Studio Code**: Editor principal
* **Git** y **Lazygit**: Control de versiones ágil
* **Docker** y **Lazydocker**: Contenedores y servicios locales

### 5. Ofimática & Productividad (`scripts/install-office.sh`)
* **genOffice**: Suite ofimática moderna potenciada por IA (Genspark)
* **ONLYOFFICE Desktop**: Documentos, hojas de cálculo y presentaciones MS Office
* **LibreOffice**: Suite ofimática offline
* **Obsidian**: Notas y gestión de proyectos en Markdown
* **Xournal++**: Notas manuscritas y bocetos con tableta

### 6. Multimedia & Audio/Video (`scripts/install-multimedia.sh`)
* **Kdenlive**: Edición de video multipista
* **Shotcut**: Editor de video rápido, ligero y simple
* **OBS Studio**: Grabación y streaming
* **Audacity**: Edición de audio

---

## ⚡ CLI del Sistema `lizarbe` & Actualizaciones

Lizarbe es una aplicación del sistema con su propio comando global `lizarbe`:

```bash
# Ver estado del tema, versión local y remota en GitHub
lizarbe status

# Actualizar el tema a la última versión oficial de GitHub
lizarbe update

# Desinstalar componentes o el tema
lizarbe uninstall --theme-only
lizarbe uninstall --all

# Re-aplicar dotfiles, iconos, configuración y corrección de Bloq Mayús
lizarbe apply

# Ver ayuda y opciones disponibles
lizarbe help
```

### Actualización Automática con el Sistema
Lizarbe incluye hooks prioritarios (`00-lizarbe-update.hook`) tanto para el comando `omarchy update` como para Pacman. Cada vez que el sistema se actualiza, la aplicación `lizarbe` consulta el repositorio oficial y se mantiene sincronizada con máxima prioridad sin requerir pasos manuales.

---

## 🔄 Desinstalación y Reversión Limpia

Si deseas remover paquetes o volver al tema oficial de Omarchy, cuentas con el comando `lizarbe uninstall` o el script `./uninstall.sh`:

```bash
# Asistente interactivo guiado:
lizarbe uninstall
# o: ./uninstall.sh

# O mediante opciones directas:
lizarbe uninstall --theme-only    # Elimina el tema Lizarbe, Darky GTK, iconos y restaura el tema oficial
lizarbe uninstall --apps-only     # Desinstala las suites de aplicaciones (conservando el tema)
lizarbe uninstall --all           # Remueve absolutamente todo y deja Omarchy en su estado base
```

