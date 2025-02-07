/* Autores:	Lizer Bernad		779035 */
/*			Guillermo Bajo		842748 */
/*			Axel Isaac Pazmiño	817627 */
/* File name: crear_bd.sql             */

CREATE TABLE Personas(
    idPersona   NUMBER(5) PRIMARY KEY,
    Nombre      VARCHAR(200) NOT NULL,
    Sexo        VARCHAR(1),
    CONSTRAINT ck_Sexo CHECK (Sexo IN ('f', 'm'))
);

CREATE TABLE Peliculas(
    EstrenoP     NUMBER(4),
    TituloP      VARCHAR(200),
    CONSTRAINT Peliculas_PK PRIMARY KEY (EstrenoP, TituloP),
    CONSTRAINT ck_Estreno CHECK (EstrenoP > 1895 AND EstrenoP < 2024)
);

CREATE TABLE GeneroPelis(
	GeneroP		VARCHAR(200),
	EstrenoGP   NUMBER(4),
    TituloGP    VARCHAR(200),
	FOREIGN KEY (EstrenoGP, TituloGP) REFERENCES Peliculas(EstrenoP, TituloP),
	CONSTRAINT GenerosP_PK PRIMARY KEY (GeneroP, EstrenoGP, TituloGP)
);

CREATE TABLE Relaciones(
    EstrenoOrig  NUMBER(4),
    TituloOrig   VARCHAR(200),
    Tipo        VARCHAR(200),
    Agno        NUMBER(4),
    Asociada    VARCHAR(200),
    FOREIGN KEY (EstrenoOrig, TituloOrig) REFERENCES Peliculas(EstrenoP, TituloP),
    CONSTRAINT Rels_PK PRIMARY KEY (EstrenoOrig, TituloOrig, Tipo, Agno, Asociada),
    CONSTRAINT ck_AgnoAsociada CHECK (Agno > 1895 AND Agno < 2024)
);  

CREATE TABLE Series(
    Estreno     NUMBER(4),
    Titulo      VARCHAR(200),
    Fin         NUMBER(4),
    CONSTRAINT Series_PK PRIMARY KEY (Estreno, Titulo),
    CONSTRAINT ck_EstrenoS CHECK (Estreno > 1946 AND Estreno < 2024),
    CONSTRAINT ck_FinS CHECK (Fin > 1946 AND Fin < 2024 AND Fin >= Estreno)
);

CREATE TABLE GeneroSeries(
	GeneroS		VARCHAR(200),
	EstrenoGS   NUMBER(4),
    TituloGS    VARCHAR(200),
	FOREIGN KEY (EstrenoGS, TituloGS) REFERENCES Series(Estreno, Titulo),
	CONSTRAINT GenerosS_PK PRIMARY KEY (GeneroS, EstrenoGS, TituloGS)
);

CREATE TABLE Capitulos(
    EstrenoS    NUMBER(4),
    TituloS     VARCHAR(200),
    Nombre      VARCHAR(200) NOT NULL,
    Temporada   NUMBER(1),
    Episodio    NUMBER(2),
    Produccion  NUMBER(4) NOT NULL,
    CONSTRAINT Capitulos_PK PRIMARY KEY (EstrenoS, TituloS, Nombre),
    FOREIGN KEY (EstrenoS, TituloS) REFERENCES Series(Estreno, Titulo),
    CONSTRAINT ck_Capitulo CHECK (Temporada > 0 AND Episodio > 0)
);

CREATE TABLE ParticipaPeli(
    EstrenoPP  NUMBER(4),
    TituloPP   VARCHAR(200),
    ParticipantePP NUMBER(5),
    FOREIGN KEY (EstrenoPP, TituloPP) REFERENCES Peliculas(EstrenoP, TituloP),
    FOREIGN KEY (ParticipantePP) REFERENCES Personas(idPersona),
    CONSTRAINT ParticipaPeli_PK PRIMARY KEY (EstrenoPP, TituloPP, ParticipantePP)
);

CREATE TABLE InformacionP(
    EstrenoIP       NUMBER(4),
    TituloIP        VARCHAR(200),
    ParticipanteIP  NUMBER(5),
    Rol             VARCHAR(200),
    Papel           VARCHAR(200),
    FOREIGN KEY (EstrenoIP, TituloIP, ParticipanteIP) REFERENCES ParticipaPeli(EstrenoPP, TituloPP, ParticipantePP),
    CONSTRAINT InfP_PK PRIMARY KEY (EstrenoIP, TituloIP, ParticipanteIP, Rol, Papel)    
);

CREATE TABLE ParticipaSerie(
    ParticipantePS  NUMBER(5),
    EstrenoPS       NUMBER(4),
    TituloPS        VARCHAR(200),
    FOREIGN KEY (EstrenoPS, TituloPS) REFERENCES Series(Estreno, Titulo),
    FOREIGN KEY (ParticipantePS) REFERENCES Personas(idPersona),
    CONSTRAINT ParticipaSerie_PK PRIMARY KEY (ParticipantePS, EstrenoPS, TituloPS)
);

CREATE TABLE InformacionS(
    ParticipanteIS  NUMBER(5),
    EstrenoIS       NUMBER(4),
    TituloIS        VARCHAR(200),
    Rol             VARCHAR(200),
    Papel           VARCHAR(200),
    FOREIGN KEY (ParticipanteIS, EstrenoIS, TituloIS) REFERENCES ParticipaSerie(ParticipantePS, EstrenoPS, TituloPS),  
    CONSTRAINT InfS_PK PRIMARY KEY (ParticipanteIS, EstrenoIS, TituloIS, Rol, Papel)   
);