/* Archivo de poblaci de tablas:	   */

INSERT INTO Divisiones
SELECT DISTINCT DIVISION
FROM datosdb.ligahost
WHERE DIVISION IS NOT NULL;

INSERT INTO Temporadas(Inicio, Fin)
SELECT DISTINCT INICIO_TEMPORADA, FIN_TEMPORADA
FROM datosdb.ligahost
WHERE INICIO_TEMPORADA IS NOT NULL
	AND FIN_TEMPORADA IS NOT NULL;

INSERT INTO Jornadas(Numero, Temporada, Division)
SELECT DISTINCT JORNADA, Temporadas.Inicio, Divisiones.DenominacionOficial
FROM datosdb.ligahost
INNER JOIN Temporadas ON datosdb.ligahost.INICIO_TEMPORADA = Temporadas.Inicio
INNER JOIN Divisiones ON datosdb.ligahost.DIVISION = Divisiones.DenominacionOficial
WHERE datosdb.ligahost.JORNADA IS NOT NULL
	AND datosdb.ligahost.JORNADA > 0;