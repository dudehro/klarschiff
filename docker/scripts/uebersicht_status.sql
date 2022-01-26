			SELECT	q.nummer
					,q.rownumber
					,q.ranking
					,q.letztes_aenderungsdatum
					,string_agg(status, ', ') OVER (PARTITION BY nummer ORDER BY letztes_aenderungsdatum ASC) statuse
			FROM	(
					SELECT	nummer
							,status
							,min(letztes_aenderungsdatum)	letztes_aenderungsdatum
							,row_number() OVER (PARTITION BY nummer ORDER BY min(letztes_aenderungsdatum)) rownumber
							,dense_rank() OVER (ORDER BY nummer ASC) ranking
					FROM	klarschiff.v_import
					group by nummer, status
					)	q
			--ORDER by ranking, letztes_aenderungsdatum
		
