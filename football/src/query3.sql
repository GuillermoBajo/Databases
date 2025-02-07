--Estadios en los que el local ha ganado o empatado más del 85% de las veces
SELECT e.NombreEstadio 
-- seleccionamos estadios donde...
FROM Estadios e
WHERE 
    -- contamos el total de partidos ganados
    (SELECT COUNT(*) FROM Partidos p1, Equipos eq1
     WHERE e.NombreEstadio = eq1.Sede
     AND eq1.NombreCorto = p1.EquipoLocal
     -- los partidos ganados o empatados por el local 
     AND GolesLocal >= GolesVisitante 
     -- son mayores que 
    ) >     
    -- contamos el total de partidos jugados                         
    (SELECT COUNT(*) FROM Partidos p2, Equipos eq2
     WHERE e.NombreEstadio = eq2.Sede
      -- multiplicamos el total *0.85% 
     AND eq2.NombreCorto = p2.EquipoLocal) *85/100;
     --seleccionara aquellos en el que los ganados > 85% (total jugados*0.85)