#!/bin/bash

function import_csv(){
IMPORT_FILE_PATH=$1
IMPORT_FILE=$(basename $IMPORT_FILE_PATH)
IMPORT_DATE=${IMPORT_FILE:0:10}

psql -U postgres -c "COPY klarschiff.import (
latitude
,longitude
,nummer
,typ
,hauptkategorie
,unterkategorie
,status
,statusinformation
,unterstuetzungen
,beschreibung
,foto
,erstellungsdatum
,letztes_aenderungsdatum
,aktuelle_zustaendigkeit
)
FROM  '/var/www/pg_dump/klarschiff_csv/2021_03_04__00_00.csv'
WITH (DELIMITER ',', FORMAT CSV, HEADER, QUOTE '\"')
;"

psql -U postgres -c "UPDATE klarschiff.import SET datum_datei = '$IMPORT_DATE'
					WHERE datum_datei IS NULL"
}

function import_all(){
	IMPORT_DIR="$1"
	while read IMPORT_FILE
	do
		echo "import $IMPORT_FILE"
		import_csv $IMPORT_FILE
	done < <(ls $IMPORT_DIR)
}

case "$1" in
	all)
		import_all "$2"
		;;
esac
