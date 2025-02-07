load data
 infile 'InformacionP.csv'
 into table InformacionP
 fields terminated by ";" TRAILING NULLCOLS
(
    TituloIP,
    EstrenoIP,
    ParticipanteIP,
    Rol,
    Papel
)