#!/bin/bash

BASE="/srv/imagenes/meteorologia"

# Años que queremos crear
YEARS=(2025 2026)

declare -A MESES
MESES=(
  ["Enero"]=31
  ["Febrero"]=28
  ["Marzo"]=31
  ["Abril"]=30
  ["Mayo"]=31
  ["Junio"]=30
  ["Julio"]=31
  ["Agosto"]=31
  ["Septiembre"]=30
  ["Octubre"]=31
  ["Noviembre"]=30
  ["Diciembre"]=31
)

TIPOS=("prediccion" "observacion")

# Bucle principal por cada año
for YEAR in "${YEARS[@]}"; do
  echo "Creando estructura para el año $YEAR..."

  for TIPO in "${TIPOS[@]}"; do
    for MES in "${!MESES[@]}"; do
      
      # Ajuste opcional para febrero en año bisiesto
      DIAS=${MESES[$MES]}
      if [[ "$MES" == "Febrero" && $((YEAR % 4 == 0 && (YEAR % 100 != 0 || YEAR % 400 == 0))) -eq 1 ]]; then
        DIAS=29
      fi

      for ((DIA=1; DIA<=DIAS; DIA++)); do
        mkdir -p "$BASE/$TIPO/$YEAR/$MES/$(printf "%02d" $DIA)"
      done
    done
  done
done

echo "Estructura de carpetas creada correctamente para los años: ${YEARS[*]}"
