SELECT 
DISTINCT Ta.punkt,ROUND(T1.dist,0) AS dist,
ROUND(T2.alpha,3) AS alpha,
T2.farbe,
T2.Region AS Region,
ROUND(T4.N,3) AS N,
ROUND(T4.O,3) AS O,
T4.radius,
ROUND(-0.3+dist/2000,3) AS fi
FROM 
(	SELECT 
	distinct T6g.punkt FROM select_all AS T3 
	JOIN 
	(	select 
		site,
		punkt FROM ALL2Point GROUP BY site
	) AS T6g
       	ON (T3.id=T6g.site) 
	ORDER BY T6g.punkt
) AS Ta 
JOIN dist AS T1 
ON (T1.id=Ta.punkt) 
JOIN alpha AS T2 
ON (T2.id=Ta.punkt) 
JOIN punkte AS T4 
ON (T4.id=Ta.punkt)
ORDER BY punkt
