OPTIONS (SKIP=1)
 load data
 infile 'Aeropuertos.csv'
 into table Aeropuertos
 fields terminated by ";" TRAILING NULLCOLS
(
    codigoIATA,
    Nombre,
    Ciudad,
    Estado
)