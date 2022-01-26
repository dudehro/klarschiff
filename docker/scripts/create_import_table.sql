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
	LOOP
		ret := ret || CHR(10) || ' SELECT *, '''|| r.tablename ||'''::DATE datum_datei FROM '||
					r.schemaname||'."'||r.tablename||'"'||CHR(10)||
					'UNION';
	END LOOP;
	ret := rtrim(ret, 'UNION');
	ret := ret || ')';

	EXECUTE ret;

	return ret;
END;
$BODY$;
