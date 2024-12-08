#!/bin/sh

# Función para verificar si estamos en una máquina virtual
es_maquina_virtual() {
    # Buscamos interfaces que suelen ser típicas en máquinas virtuales
    if ip link show | grep -qE "ens33|vnet|virbr|virtio"; then
        return 0  # Si se encuentra alguna interfaz virtual, se asume que es una máquina virtual
    else
        return 1  # Si no se encuentra, se asume que no es una máquina virtual
    fi
}

# Verificar si estamos en una máquina virtual
if es_maquina_virtual; then
    TIPO="Máquina Virtual"
else
    TIPO="Máquina Local"
fi

# Detectar la interfaz activa
INTERFAZ=$(ip -o -4 addr show up | awk '{print $2}' | head -n 1)

# Verificar si hay una interfaz activa con dirección IP
if [ -n "$INTERFAZ" ]; then
    IP=$(ip -o -4 addr show "$INTERFAZ" | awk '{print $4}' | cut -d/ -f1)
    if echo "$INTERFAZ" | grep -qE "wlan"; then
        ICONO=""  # Icono para Wi-Fi
    else
        ICONO=""  # Icono para Ethernet
    fi
    echo "%{F#7dcfff}${ICONO} %{F#ffffff}${TIPO}: ${IP}%{u-}"
else
    echo "%{F#ff0000} %{F#ffffff}No conectado en ${TIPO}%{u-}"
fi
