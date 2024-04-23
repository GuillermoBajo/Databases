/* Autores:	Lizer Bernad		779035 */
/*			Guillermo Bajo		842748 */
/*			Axel Isaac Pazmiño	817627 */
/* File name: crear_bd.sql             */

CREATE TABLE Companyas(
    Codigo       VARCHAR(100) PRIMARY KEY,
    NombreC      VARCHAR(100)
);

CREATE TABLE Aeropuertos(
    codigoIATA  VARCHAR(5) PRIMARY KEY,
    Nombre      VARCHAR(100),
    Estado      VARCHAR(100),
    Ciudad      VARCHAR(100)
);

CREATE TABLE Modelos(
    NombreM         VARCHAR(100) PRIMARY KEY,
    Fabricante      VARCHAR(100),
    Motor           VARCHAR(100)
);

CREATE TABLE Aviones(
    Matricula       VARCHAR(10) PRIMARY KEY,
    AgnoFabricacion NUMBER(4),
    Modelo          VARCHAR(100),
    CompanyaAv      VARCHAR(100),
    FOREIGN KEY (Modelo) REFERENCES Modelos(NombreM),
    FOREIGN KEY (CompanyaAv) REFERENCES Companyas(Codigo),
    CONSTRAINT ck_Fabricacion CHECK (AgnoFabricacion >  1903 AND AgnoFabricacion < 2024)
);


CREATE TABLE Vuelos(
    idVuelo         NUMBER(5) PRIMARY KEY,
    Fecha           VARCHAR(10),
    Numero          NUMBER(5),
    HoraSalida      NUMBER(4),
    HoraLlegada     NUMBER(4),
    AeroOrigen      VARCHAR(5),
    AeroDestino     VARCHAR(5),
    AvionV          VARCHAR(10),
    FOREIGN KEY (AeroOrigen) REFERENCES Aeropuertos(codigoIATA),
    FOREIGN KEY (AeroDestino) REFERENCES Aeropuertos(codigoIATA),
    FOREIGN KEY (AvionV) REFERENCES Aviones(Matricula),
    CONSTRAINT ck_HoraSal CHECK (HoraSalida>=0 AND HoraSalida<=2359),
    CONSTRAINT ck_Lleg CHECK (HoraLlegada>=0 AND HoraLlegada<=2359)
);


CREATE TABLE Retrasos(
    idRetraso       NUMBER(5) PRIMARY KEY,
    VueloRetrasado  NUMBER(5),
    Duracion        NUMBER(5),
    Causa           VARCHAR(100),
    CONSTRAINT ck_Duracion CHECK (Duracion > 0),
    FOREIGN KEY (VueloRetrasado) REFERENCES Vuelos(idVuelo)
);


CREATE TABLE Desvios(
    idDesvio         NUMBER(3) PRIMARY KEY,
    AeropuertoDesv   VARCHAR(5),
    VueloDesviado    NUMBER(5),
    FOREIGN KEY (AeropuertoDesv) REFERENCES Aeropuertos(codigoIATA),
    FOREIGN KEY (VueloDesviado) REFERENCES Vuelos(idVuelo)
);


CREATE TABLE Cancelaciones(
    idCancelacion     NUMBER(4) PRIMARY KEY,
    VueloCancelado    NUMBER(5),
    FOREIGN KEY (VueloCancelado) REFERENCES Vuelos(idVuelo)
);