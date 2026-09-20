# Omarchy - Setup Creatividad & Construcción (Tema Lizarbe)

Configuración completa para un sistema **Omarchy** recién instalado, orientada a la **creatividad visual, modelado/construcción espacial, desarrollo de software y ofimática**.

Incluye:
- **Tema personalizado Lizarbe**: Colores, fondos pixel art, previews, bordes y controles de shell.
- **Tema GTK Darky & Iconos**: `Lizarbe-Red` con integración visual nativa a Omarchy.
- **Branding propio y Terminal**: Logo ASCII, fastfetch, starship y hooks automáticos.
- **Instaladores modulares** organizados por suites independientes.

---

## 🚀 Instalación en un Omarchy limpio

1. Clona este repositorio:
```bash
git clone https://github.com/lizarbe513/Lizarbe-Omarchy-Theme.git
cd Lizarbe-Omarchy-Theme
```

2. Ejecuta el instalador interactivo:
```bash
./install.sh
```

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

### 1. Base del Sistema & Tema Lizarbe (`scripts/install-core.sh`)
* Tema Omarchy `Lizarbe` con wallpapers pixel art
* Tema GTK `Darky` y packs de iconos `Lizarbe-Red`
* `fastfetch`, `starship`, `nwg-look`, `htop`, `kdeconnect`

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
* **ONLYOFFICE Desktop**: Documentos, hojas de cálculo y presentaciones MS Office
* **LibreOffice**: Suite ofimática offline
* **Obsidian**: Notas y gestión de proyectos en Markdown
* **Xournal++**: Notas manuscritas y bocetos con tableta

### 6. Multimedia & Audio (`scripts/install-multimedia.sh`)
* **Kdenlive**: Edición de video
* **OBS Studio**: Grabación y captura de pantalla
* **Audacity**: Edición de audio

---

## 🔄 Desinstalación y Reversión Limpia

Si deseas remover paquetes o volver al tema oficial de Omarchy, cuentas con el script `./uninstall.sh`:

```bash
# Asistente interactivo guiado:
./uninstall.sh

# O mediante opciones directas:
./uninstall.sh --theme-only    # Elimina el tema Lizarbe, Darky GTK, iconos y restaura el tema oficial
./uninstall.sh --apps-only     # Desinstala las suites de aplicaciones (conservando el tema)
./uninstall.sh --all           # Remueve absolutamente todo y deja Omarchy en su estado base
```

