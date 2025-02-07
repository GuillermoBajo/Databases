OPTIONS (SKIP=1)
 load data
 infile 'Retrasos.csv'
 into table Retrasos
 fields terminated by ";" TRAILING NULLCOLS
(
    Duracion,
    Causa,
    VueloRetrasado,
    idRetraso
)