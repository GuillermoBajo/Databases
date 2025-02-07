/* Archivo de creación de tablas:	   */

CREATE TABLE Estadios(
	NombreEstadio		VARCHAR(50) PRIMARY KEY,
	FechaInauguracion	NUMBER(4),
	Capacidad			NUMBER(6), CHECK (Capacidad > 0)
);

CREATE TABLE Equipos(
	NombreCorto			VARCHAR(50) PRIMARY KEY,
	NombreOficial		VARCHAR(50),
	NombreHistorico		VARCHAR(50),
	Fecha				NUMBER(4),
	Ciudad				VARCHAR(50),
	Sede				VARCHAR(50),
	FOREIGN KEY (Sede)	REFERENCES Estadios(NombreEstadio)
);

CREATE TABLE OtrosNombres(
	NombreAdicional		VARCHAR(50),
	Equipo				VARCHAR(50) NOT NULL,
	FOREIGN KEY (Equipo)	REFERENCES Equipos(NombreCorto),
	CONSTRAINT			OtrosNombres_PK PRIMARY KEY (NombreAdicional, Equipo)
);

CREATE TABLE Divisiones(
	DenominacionOficial	VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Temporadas(
	Inicio			NUMBER(4) PRIMARY KEY,
	Fin				NUMBER(4) NOT NULL
);

CREATE TABLE Jornadas(
	Numero				NUMBER(2) NOT NULL CHECK (Numero > 0),
	Temporada			NUMBER(4) NOT NULL,
	Division			VARCHAR(50) NOT NULL,
	FOREIGN KEY (Temporada) REFERENCES Temporadas(Inicio),
	FOREIGN KEY (Division)	REFERENCES Divisiones(DenominacionOficial),
	CONSTRAINT			Jornadas_PK PRIMARY KEY (Temporada, Numero, Division)
);

CREATE TABLE Partidos(
	GolesLocal			NUMBER(3) NOT NULL CHECK (GolesLocal >= 0),
	GolesVisitante		NUMBER(3) NOT NULL CHECK (GolesVisitante >= 0),
	EquipoLocal			VARCHAR(50) NOT NULL,
	EquipoVisitante		VARCHAR(50) NOT NULL,
	JornadaT			NUMBER(4) NOT NULL,
	JornadaN			NUMBER(2) NOT NULL,
	JornadaD			VARCHAR(50) NOT NULL,
	FOREIGN KEY (EquipoLocal)		REFERENCES Equipos(NombreCorto),
	FOREIGN KEY (EquipoVisitante)	REFERENCES Equipos(NombreCorto),
	FOREIGN KEY (JornadaT, JornadaN, JornadaD)	REFERENCES Jornadas(Temporada, Numero, Division),
	CONSTRAINT			Partidos_PK PRIMARY KEY (EquipoLocal, EquipoVisitante, JornadaT, JornadaN, JornadaD)
);