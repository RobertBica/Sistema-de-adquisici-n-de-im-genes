#!/bin/bash

# =========================
# CONFIGURACIÓN
# =========================

OBSERVACION_DIR="/mnt/nas_proyecto/imagenes/meteorologia/observacion/satelite"
BASE_URL="https://www.aemet.es/imagenes_d/eltiempo/observacion/satelite"

# =========================
# FECHA Y HORA
# =========================

ANIO=$(date +"%Y")
MES=$(date +"%m")
DIA=$(date +"%d")

# Restamos 1 hora
HORA=$(date -d "1 hour ago" +"%H")

FECHA_URL="${ANIO}${MES}${DIA}${HORA}00"
ARCHIVO="${FECHA_URL}_s93g.gif"

DEST_DIR="$OBSERVACION_DIR/$ANIO/$MES/$DIA"
DESTINO="$DEST_DIR/$ARCHIVO"

# =========================
# COMPROBACIONES
# =========================

if [ ! -d "$DEST_DIR" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR: No existe $DEST_DIR"
  exit 1
fi

# =========================
# DESCARGA
# =========================

wget -q --timeout=20 --tries=2 "$BASE_URL/$ARCHIVO" -O "$DESTINO"

if [ $? -eq 0 ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') Imagen guardada: $ARCHIVO"
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR descargando $ARCHIVO"
  rm -f "$DESTINO"
fi

exit 0
