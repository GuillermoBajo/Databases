load data
 infile 'ParticipaSerie.csv'
 into table ParticipaSerie
 fields terminated by ";" TRAILING NULLCOLS
(
    TituloPS,
    EstrenoPS,
    ParticipantePS
)