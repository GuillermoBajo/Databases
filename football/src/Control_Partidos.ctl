load data
 infile '/home/a842748/2ing_inf/BD/practica1/Partidos.csv'
 into table Partidos
 fields terminated by ";" TRAILING NULLCOLS
(
JornadaT,
JornadaD,
JornadaN,
EquipoLocal,
EquipoVisitante,
GolesLocal,
GolesVisitante
)