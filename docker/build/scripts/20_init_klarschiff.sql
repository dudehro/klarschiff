CREATE USER u_klarschiff WITH PASSWORD 'klarschiff';
CREATE DATABASE db_klarschiff;
GRANT ALL PRIVILEGES ON DATABASE db_klarschiff TO u_klarschiff;
\connect db_klarschiff
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;
CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
CREATE SCHEMA klarschiff AUTHORIZATION u_klarschiff;
CREATE SCHEMA klarschiff_import AUTHORIZATION u_klarschiff;

CREATE OR REPLACE FUNCTION klarschiff.create_import_table() RETURNS TEXT
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	r RECORD;
	ret	TEXT;
BEGIN
	DROP TABLE IF EXISTS klarschiff.import;
	ret := 'CREATE TABLE klarschiff.import AS (';
	for r IN
		SELECT	t.schemaname
				,t.tablename
		FROM	pg_catalog.pg_tables	t
		WHERE	schemaname = 'klarschiff_import'
	LOOP                        /*Column foto wurde über die Zeit entfernt, daher aufzählung*/
		ret := ret || CHR(10) || ' SELECT latitude,longitude,nummer,typ,hauptkategorie,unterkategorie, '
                   || CHR(10) || ' status,statusinformation,unterstuetzungen,beschreibung,erstellungsdatum,letztes_aenderungsdatum,aktuelle_zustaendigkeit, '''
                   || CHR(10) ||  r.tablename ||'''::DATE datum_datei FROM '||
					r.schemaname||'."'||r.tablename||'"'||CHR(10)||
					'UNION';
	END LOOP;
	ret := rtrim(ret, 'UNION');
	ret := ret || ')';

	EXECUTE ret;

	return ret;
END;
$BODY$;
