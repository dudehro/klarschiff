#!/bin/bash

IMPORT_DIR=/csv

while read FILE
do
        FILE=$(basename $FILE)
        EXISTS=$(psql -U u_klarschiff db_klarschiff -Atc "Select ltrim(tablename) FROM pg_catalog.pg_tables WHERE schemaname='klarschiff_import' AND tablename = '${FILE:0:10}' ")
        if [ "$EXISTS" != "${FILE:0:10}" ]; then
                echo "Datei $FILE einlesen..."
                csvsql --insert --db-schema klarschiff_import --db postgresql://u_klarschiff@localhost/db_klarschiff /csv/${FILE}
        fi
done < <(ls ${IMPORT_DIR}/*)
