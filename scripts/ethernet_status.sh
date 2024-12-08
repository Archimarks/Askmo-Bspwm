#!/bin/sh

# Función para verificar si estamos en una máquina virtual
es_maquina_virtual() {
    # Buscamos interfaces que suelen ser típicas en máquinas virtuales
    if /usr/sbin/ifconfig -a | grep -qE "ens33|vnet|virbr|virtio"; then
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

# Verificar conexión
if /usr/sbin/ifconfig ens33 | grep -q "inet "; then
    IP=$( /usr/sbin/ifconfig ens33 | grep "inet " | awk '{print $2}' )
    echo "%{F#7dcfff} %{F#ffffff}${TIPO}: ${IP}%{u-}"
elif /usr/sbin/ifconfig vnet | grep -q "inet "; then
    IP=$( /usr/sbin/ifconfig vnet | grep "inet " | awk '{print $2}' )
    echo "%{F#7dcfff} %{F#ffffff}${TIPO}: ${IP}%{u-}"
elif /usr/sbin/ifconfig virbr | grep -q "inet "; then
    IP=$( /usr/sbin/ifconfig virbr | grep "inet " | awk '{print $2}' )
    echo "%{F#7dcfff} %{F#ffffff}${TIPO}: ${IP}%{u-}"
elif /usr/sbin/ifconfig virtio | grep -q "inet "; then
    IP=$( /usr/sbin/ifconfig virtio | grep "inet " | awk '{print $2}' )
    echo "%{F#7dcfff} %{F#ffffff}${TIPO}: ${IP}%{u-}"



# Verificar conexión por cable (eth0 o eth1)
if /usr/sbin/ifconfig eth0 | grep -q "inet "; then
    IP=$( /usr/sbin/ifconfig eth0 | grep "inet " | awk '{print $2}' )
    echo "%{F#7dcfff} %{F#ffffff}${TIPO}: ${IP}%{u-}"
elif /usr/sbin/ifconfig eth1 | grep -q "inet "; then
    IP=$( /usr/sbin/ifconfig eth1 | grep "inet " | awk '{print $2}' )
    echo "%{F#7dcfff} %{F#ffffff}${TIPO}: ${IP}%{u-}"

# Verificar conexión por Wi-Fi (wlan0 o wlan1)
elif /usr/sbin/ifconfig wlan0 | grep -q "inet "; then
    IP=$( /usr/sbin/ifconfig wlan0 | grep "inet " | awk '{print $2}' )
    echo "%{F#7dcfff} %{F#ffffff}${TIPO}: ${IP}%{u-}"
elif /usr/sbin/ifconfig wlan1 | grep -q "inet "; then
    IP=$( /usr/sbin/ifconfig wlan1 | grep "inet " | awk '{print $2}' )
    echo "%{F#7dcfff} %{F#ffffff}${TIPO}: ${IP}%{u-}"

# Sin conexión
else
    echo "%{F#ff0000} %{F#ffffff}No conectado en ${TIPO}%{u-}"
fi
