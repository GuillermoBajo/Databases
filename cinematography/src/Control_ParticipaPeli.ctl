load data
 infile 'ParticipaPeli.csv'
 into table ParticipaPeli
 fields terminated by ";" TRAILING NULLCOLS
(
    TituloPP,
    EstrenoPP,
    ParticipantePP
)