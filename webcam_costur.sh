#!/bin/bash

# =========================
# CONFIGURACIÓN
# =========================

# Zona horaria
export TZ=Europe/Madrid

UBICACION="Costur"
URL_IMAGEN="https://www.avametnuvol.es/estacions/c04m049e01/costur.jpg"
BASE_DIR="/mnt/nas_proyecto/imagenes/webcam/costur"

INTERVALO=130

# =========================
# BUCLE INFINITO
# =========================

while true; do

  # Fecha actual
  ANIO=$(date +"%Y")
  MES=$(date +"%m")
  DIA=$(date +"%d")

  # Ruta dinámica
  DESTINO="$BASE_DIR/$ANIO/$MES/$DIA"

  # Fecha y hora para el nombre del archivo
  FECHA_HORA=$(date +"%d-%m-%Y-%H-%M")
  ARCHIVO="$UBICACION-$FECHA_HORA.jpg"

  # Comprobar que la ruta existe
  if [ -d "$DESTINO" ]; then
    curl -s "$URL_IMAGEN" -o "$DESTINO/$ARCHIVO"
    echo "$(date) Imagen guardada en $DESTINO/$ARCHIVO"
  else
    echo "$(date) ERROR: No existe el directorio $DESTINO"
  fi

  sleep $INTERVALO
done
