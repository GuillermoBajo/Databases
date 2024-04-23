OPTIONS (SKIP=1)
load data
 infile 'GeneroPelis.csv'
 into table GeneroPelis
 fields terminated by ";" TRAILING NULLCOLS
(
    TituloGP,
    EstrenoGP,
    GeneroP
)