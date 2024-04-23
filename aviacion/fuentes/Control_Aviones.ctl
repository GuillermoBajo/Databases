OPTIONS (SKIP=1)
 load data
 infile 'Aviones.csv'
 into table Aviones
 fields terminated by ";" TRAILING NULLCOLS
(
    CompanyaAv,
    Matricula,
    Modelo,
    AgnoFabricacion
)