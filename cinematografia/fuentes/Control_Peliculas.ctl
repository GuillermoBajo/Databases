load data
 infile 'Peliculas.csv'
 into table Peliculas
 fields terminated by ";" TRAILING NULLCOLS
(
    TituloP,
    EstrenoP
)