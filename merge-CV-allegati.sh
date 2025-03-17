#!/bin/bash

declare -a array=("SYS" "MEC" "comune")
if [[ $(pwd | awk -F'/' '{print $NF}') != "curriculum" ]]; then
   cd static/curriculum/
else
   cd .
fi

if [ $? -eq 0 ]; then
   for i in {0..2}; do
      elemento=${array[$i]}
      nuovonome=${elemento}_allegati.pdf
      pdfunite $elemento.pdf ../certifications/allegati_cv.pdf $nuovonome
   done
else
   echo "Sicuro che la cartella static/curriculum esista e sia in questa directory?"
   exit 1
fi
