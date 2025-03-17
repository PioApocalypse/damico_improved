#!/bin/bash

SITO=sito-damico

echo Versione di Hugo installata: $(hugo version | awk '{print $2}' | awk -F'-' '{gsub(/v/, "", $1); print $1}').
echo Versione minima richiesta: $(grep min: hugo.yaml | awk '{gsub(/\x27/, "", $2); print $2}').
echo Il seguente script tenterà di:
echo "   1. Eliminare la cartella public"
echo "   2. Rigenerare i file del sito"
echo "   3. Fare deploy dei nuovi file sul web server (ssh verso $SITO)"
read -p "Sei sicuro di voler procedere? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf public/
    echo "Cartella public eliminata."
    sleep 1
    hugo
    echo "Sito rigenerato."
    sleep 1
    echo "Tento rsync via verso $SITO"
    rsync -ar --delete-after public/* $SITO:/var/www/html/
    if [ $? -eq 0 ]; then
        echo "Sito aggiornato! Visualizza le modifiche su https://damico.ing/"
    else
        echo "ERRORE durante il deploy."
	exit 1
    fi
else
    echo "Operazione annullata."
fi
