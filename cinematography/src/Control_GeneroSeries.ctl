OPTIONS (SKIP=1)
load data
 infile 'GeneroSeries.csv'
 into table GeneroSeries
 fields terminated by ";" TRAILING NULLCOLS
(
    TituloGS,
    EstrenoGS,
    GeneroS
)