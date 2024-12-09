#!/bin/sh

# Función para verificar si estamos en una máquina virtual
es_maquina_virtual() {
    # Buscamos interfaces que suelen ser típicas en máquinas virtuales
    if ip link show | grep -qE "ens33"; then
        return 0  # Máquina virtual
    fi

    if ip link show | grep -qE "lo"; then
        return 1  # Máquina local
    fi
}

# Verificar si estamos en una máquina virtual
if es_maquina_virtual; then
    TIPO="Máquina Virtual"
else
    TIPO="Máquina Local"
fi

# Detectar la interfaz activa que no sea 'lo'
INTERFAZ=$(ip -o -4 addr show up | grep -v " lo " | awk '{print $2}' | head -n 1)

# Verificar si hay una interfaz activa con dirección IP
if [ -n "$INTERFAZ" ]; then
    # Extraer la IP utilizando ifconfig
    IP=$(echo "%{F#ffffff}  %{F#ffffff}$(/usr/sbin/ifconfig "$INTERFAZ" | grep 'inet ' | awk '{print $2}')%{u-}")

    if echo "$INTERFAZ" | grep -qE "wlan|wlx"; then
        ICONO=""  # Icono para Wi-Fi
    else
        ICONO=""  # Icono para Ethernet
    fi
    echo "%{F#7dcfff}${ICONO} %{F#ffffff}${TIPO}: ${IP}%{u-}"
else
    echo "%{F#ff0000} %{F#ffffff}No conectado en ${TIPO}%{u-}"
fi
