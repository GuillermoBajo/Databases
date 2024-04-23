OPTIONS (SKIP=1)
 load data
 infile 'Cancelaciones.csv'
 into table Cancelaciones
 fields terminated by ";" TRAILING NULLCOLS
(
    idCancelacion,
    VueloCancelado
)