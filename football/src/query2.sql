
SELECT DISTINCT p.JornadaT, golL + golV
FROM (
        SELECT p1.JornadaT as tl, sum(p1.goleslocal) as golL
        FROM partidos p1
        WHERE p1.EquipoLocal = 'Zaragoza'
        AND p1.goleslocal > p1.GolesVisitante
        AND EXISTS (
                        SELECT *
                        FROM partidos p2
                        WHERE p2.JornadaT = p1.JornadaT
                        AND p2.EquipoVisitante = 'Zaragoza'
                        AND p2.EquipoLocal = p1.EquipoVisitante
                        AND p2.goleslocal < p2.GolesVisitante
                   )
        GROUP BY JornadaT
        HAVING COUNT(*) >= 4
     ),
     (
     SELECT p1.JornadaT as tv, sum(p1.GolesVisitante) as golV
        FROM partidos p1
        WHERE p1.EquipoVisitante = 'Zaragoza'
        AND p1.goleslocal < p1.GolesVisitante
        AND EXISTS (
                        SELECT *
                        FROM partidos p2
                        WHERE p2.JornadaT = p1.JornadaT
                        AND p2.EquipoLocal = 'Zaragoza'
                        AND p1.EquipoLocal = p2.EquipoVisitante
                        AND p2.goleslocal > p2.GolesVisitante
                   )
        GROUP BY JornadaT
        HAVING COUNT(*) >= 4), partidos p
WHERE p.JornadaT = tl and p.JornadaT = tv;
