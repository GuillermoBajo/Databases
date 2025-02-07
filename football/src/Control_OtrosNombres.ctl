load data
 infile '/home/a842748/2ing_inf/BD/practica1/OtrosNombres.csv'
 into table OtrosNombres
 fields terminated by ";" TRAILING NULLCOLS
(
Equipo,
NombreAdicional
)