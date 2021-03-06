-- populate the bbl field
-- create the boro code lookup table
WITH borolookup AS (
SELECT DISTINCT boro,
	(CASE 
		WHEN boro = 'MANHATTAN' THEN '1'
		WHEN boro = 'BRONX' THEN '2'
		WHEN boro = 'BROOKLYN' THEN '3'
		WHEN boro = 'QUEENS' THEN '4'
		WHEN boro = 'STATEN ISLAND' THEN '5'
		ELSE NULL
	END ) borocode
FROM housing
)

UPDATE housing a
SET bbl = b.borocode||a.block||a.lot
FROM borolookup b
WHERE a.boro=b.boro;