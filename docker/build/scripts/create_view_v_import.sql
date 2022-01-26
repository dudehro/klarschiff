CREATE OR REPLACE VIEW klarschiff.v_import AS
SELECT	a.latitude
		,a.longitude
		,a.nummer
		,a.typ
		,a.hauptkategorie
		,a.unterkategorie
		,a.status
		,a.statusinformation
		,a.unterstuetzungen
		,a.beschreibung
/*		,a.foto */
		,a.erstellungsdatum
		,a.letztes_aenderungsdatum
		,a.aktuelle_zustaendigkeit
		,min(a.datum_datei) datum_datei
FROM	klarschiff.import	a
GROUP BY a.latitude
		,a.longitude
		,a.nummer
		,a.typ
		,a.hauptkategorie
		,a.unterkategorie
		,a.status
		,a.statusinformation
		,a.unterstuetzungen
		,a.beschreibung
/*      ,a.foto */
		,a.erstellungsdatum
		,a.letztes_aenderungsdatum
		,a.aktuelle_zustaendigkeit
;
