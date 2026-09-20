# Omarchy - Setup Creatividad & Construcción (Tema Lizarbe)

Configuración completa para un sistema **Omarchy** recién instalado, orientada a la **creatividad visual, modelado/construcción espacial, desarrollo de software y ofimática**.

Incluye:
- **Tema nativo Lizarbe**: Colores, fondos pixel art, bordes e iconos/texto de la barra en rojo de forma nativa.
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

### 1. Base del Sistema & Tema Lizarbe (`scripts/install-core.sh`)
* Tema Omarchy `Lizarbe` con wallpapers pixel art e iconos de barra en rojo
* Pack de iconos propio `Lizarbe-Red`
* **Zen Browser**: Navegador web predeterminado configurado nativamente con Omarchy
* Tema GTK `Darky` copiado a `~/.local/share/themes/` (sin forzarse)
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
* **DaVinci Resolve**: Edición, corrección de color y postproducción profesional
* **Kdenlive**: Edición de video multipista
* **Shotcut**: Editor de video rápido, ligero y simple
* **OBS Studio**: Grabación y streaming
* **Audacity**: Edición de audio

---

## ⚡ Actualizaciones Rápidas (`./update.sh`)

Para actualizar el tema, iconos, configs y dotfiles sin tener que reinstalar todo ni pasar por los instaladores de paquetes:

```bash
./update.sh
```

Este comando descarga los últimos cambios con `git pull`, actualiza los archivos del tema, iconos y recarga el shell en vivo al instante.

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

