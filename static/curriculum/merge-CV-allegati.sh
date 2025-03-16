#!/bin/bash

declare -a array=("SYS" "MEC" "comune")
for i in {0..2}; do
   elemento=${array[$i]}
   nuovonome=${elemento}_allegati.pdf
   pdfunite $elemento.pdf ../certifications/allegati_cv.pdf $nuovonome
   #echo $elemento
done

