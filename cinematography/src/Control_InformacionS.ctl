load data
 infile 'InformacionS.csv'
 into table InformacionS
 fields terminated by ";" TRAILING NULLCOLS
(
    TituloIS,
    EstrenoIS,
    ParticipanteIS,
    Rol,
    Papel
)