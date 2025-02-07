load data
 infile 'Personas.csv'
 into table Personas
 fields terminated by ";" TRAILING NULLCOLS
(
    idPersona,
    Nombre,
    Sexo
)