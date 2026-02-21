#!/bin/bash

YEAR=2026

BASE_WEBCAM="/imagenes/webcam/costur"
BASE_SATELITE="/imagenes/meteorologia/observacion/satelite"

declare -A MESES
MESES=(
  ["01"]=31
  ["02"]=28
  ["03"]=31
  ["04"]=30
  ["05"]=31
  ["06"]=30
  ["07"]=31
  ["08"]=31
  ["09"]=30
  ["10"]=31
  ["11"]=30
  ["12"]=31
)

echo "Creando estructura de carpetas para el año $YEAR..."

for MES in "${!MESES[@]}"; do

  DIAS=${MESES[$MES]}

  # Ajuste de febrero en año bisiesto
  if [[ "$MES" == "02" && $((YEAR % 4 == 0 && (YEAR % 100 != 0 || YEAR % 400 == 0))) -eq 1 ]]; then
    DIAS=29
  fi

  for ((DIA=1; DIA<=DIAS; DIA++)); do
    DIA_FMT=$(printf "%02d" $DIA)

    mkdir -p "$BASE_WEBCAM/$YEAR/$MES/$DIA_FMT"
    mkdir -p "$BASE_SATELITE/$YEAR/$MES/$DIA_FMT"
  done
done

echo "Estructuras creadas correctamente:"
echo " - $BASE_WEBCAM/$YEAR"
echo " - $BASE_SATELITE/$YEAR"
