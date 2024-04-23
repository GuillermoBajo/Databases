load data
 infile 'Relaciones.csv'
 into table Relaciones
 fields terminated by ";" TRAILING NULLCOLS
(
    TituloOrig,
    EstrenoOrig,
    Asociada,
    Agno,
    Tipo
)