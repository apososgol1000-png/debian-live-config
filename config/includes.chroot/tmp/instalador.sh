#!/bin/bash
echo "==============================================="
echo "   INICIANDO INSTALACIÓN DE AEROMAC-OS BASE    "
echo "==============================================="

# 1. Asegurar que el sistema no se detenga pidiendo confirmaciones
export DEBIAN_FRONTEND=noninteractive

# 2. Actualizar los servidores de paquetes de Debian 12
echo "=== ACTUALIZANDO REPOSITORIOS ==="
apt-get update

# 3. Instalar la base del sistema gráfico y utilidades ligeras
echo "=== INSTALANDO ENTORNO GRÁFICO LIGERO ==="
apt-get install -y --no-install-recommends \
    xserver-xorg-core \
    xserver-xorg \
    xinit \
    lxde-core \
    openbox \
    lightdm \
    lxterminal \
    pcmanfm \
    sudo \
    curl \
    wget \
    nano

# 4. Configurar el inicio automático del sistema gráfico sin pedir contraseña
echo "=== CONFIGURANDO AUTOLOGIN ==="
mkdir -p /etc/lightdm/lightdm.conf.dir
cat << 'EOF' > /etc/lightdm/lightdm.conf
[Seat:*]
autologin-user=user
autologin-user-timeout=0
user-session=LXDE
EOF

# 5. Crear el usuario por defecto del sistema Live
echo "=== CONFIGURANDO USUARIO PRINCIPAL ==="
if ! id -u user >/dev/null 2>&1; then
    useradd -m -s /bin/bash user
    echo "user:live" | chpasswd
    usermod -aG sudo user
fi

echo "==============================================="
echo "  ¡CONFIGURACIÓN BASE COMPLETADA CON ÉXITO!     "
echo "==============================================="
