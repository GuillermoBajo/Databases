OPTIONS (SKIP=1)
 load data
 infile 'Vuelos.csv'
 into table Vuelos
 fields terminated by ";" TRAILING NULLCOLS
(
    Fecha,
    AvionV,
    Numero,
    HoraSalida,
    HoraLlegada,
    AeroOrigen,
    AeroDestino,
    idVuelo
)