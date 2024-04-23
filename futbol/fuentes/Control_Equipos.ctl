load data
 infile '/home/a842748/2ing_inf/BD/practica1/Equipos.csv'
 into table Equipos
 fields terminated by ";" TRAILING NULLCOLS
(
    NombreCorto,
    NombreHistorico,
    Ciudad,
    Fecha,
    NombreOficial,
    Sede
)
