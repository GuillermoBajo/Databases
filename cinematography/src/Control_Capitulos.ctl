OPTIONS (SKIP=1)
load data
 infile 'Capitulos.csv'
 into table Capitulos
 fields terminated by ";" TRAILING NULLCOLS
(
    Nombre,
    Produccion,
    TituloS,
    EstrenoS,
    Temporada,
    Episodio
)