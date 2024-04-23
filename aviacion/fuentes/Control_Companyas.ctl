OPTIONS (SKIP=1)
 load data
 infile 'Companyas.csv'
 into table Companyas
 fields terminated by ";" TRAILING NULLCOLS
(
    Codigo,
    NombreC
)