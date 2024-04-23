-- Equipo que más ligas de primera división ha ganado.
-- puntos_temporada (Equipo,puntos,temporada)
    CREATE VIEW puntos_temporada AS
        SELECT partidos_puntos_div1.equipo as equipo,
-- los puntos totales de cada equipo en cada temporada en primera division
        sum(partidos_puntos_div1.puntos) as puntos,
-- partidos_puntos_div1 = tl + tv
        partidos_puntos_div1.temporada as temporada
-- tuplas tl (nombreEquipoLocal, puntos, jornada y temporada)
        FROM ( SELECT equipolocal as equipo,
            CASE
-- si gana el partido 3 puntos
                    WHEN goleslocal > golesvisitante THEN 3
-- si empata 1 punto
                    WHEN goleslocal = golesvisitante THEN 1
-- si pierde 0 puntos
                    ELSE 0
            END AS puntos,jornadaN as jornada,jornadaT as temporada
            FROM Partidos
            WHERE jornadaD='1'
            UNION ALL
-- tuplas tv (nombreEquipoVisitante, puntos, jornada y temporada)
            SELECT equipovisitante as equipo,
            CASE
                    WHEN golesvisitante > goleslocal THEN 3
                    WHEN goleslocal = golesvisitante THEN 1
                    ELSE 0
            END AS puntos,jornadaN as jornada ,jornadaT as temporada
            FROM Partidos
            WHERE jornadaD='1') partidos_puntos_div1
-- queremos los puntos de cada equipo en cada temporada
        GROUP BY partidos_puntos_div1.equipo,partidos_puntos_div1.temporada;
-- num_win_liga (Equipo,numLigasGanadas)
    CREATE VIEW num_win_liga AS
-- numero de ligas que ha ganado un equipo de primera division
    SELECT win_temp.equipo, count(*) numLigasGanadas
    FROM (
        SELECT a.equipo as equipo, a.temporada
        FROM puntos_temporada a
        INNER JOIN
        (
            SELECT temporada,
            max(puntos) as max_puntos
            FROM puntos_temporada
            GROUP BY temporada
-- tupla maximo de puntos en una temporada
        ) max_puntos_temporada
            ON a.temporada = max_puntos_temporada.temporada
-- nos quedamos con los equipos que ganaron en cada temporada
            AND a.puntos = max_puntos_temporada.max_puntos) win_temp
-- agrupamos por equipo para calcular la suma
    GROUP BY Equipo;

    SELECT equipo
    FROM num_win_liga
    WHERE num_win_liga.numLigasGanadas = (SELECT max(num_win_liga.numLigasGanadas)
-- finalmente calculamos el equipo que mas veces ha ganado ligas de primera division
    FROM num_win_liga);


