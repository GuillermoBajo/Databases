load data
 infile '/home/a842748/2ing_inf/BD/practica1/Estadios.csv'
 into table Estadios
 fields terminated by ";" TRAILING NULLCOLS
(
    NombreEstadio,
    FechaInauguracion,
    Capacidad
)