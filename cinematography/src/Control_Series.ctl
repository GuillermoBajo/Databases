load data
 infile 'Series.csv'
 into table Series
 fields terminated by ";" TRAILING NULLCOLS
(
    Titulo,
    Estreno,
    Fin
)