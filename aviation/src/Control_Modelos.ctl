OPTIONS (SKIP=1)
 load data
 infile 'Modelos.csv'
 into table Modelos
 fields terminated by ";" TRAILING NULLCOLS
(
    Fabricante,
    NombreM,
    Motor
)