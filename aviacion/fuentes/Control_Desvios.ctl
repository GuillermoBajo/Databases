OPTIONS (SKIP=1)
 load data
 infile 'Desvios.csv'
 into table Desvios
 fields terminated by ";" TRAILING NULLCOLS
(
    idDesvio,
    AeropuertoDesv,
    VueloDesviado
)