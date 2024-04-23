/* Autores:	Lizer Bernad		779035 */
/*			Guillermo Bajo		842748 */
/*			Axel Isaac Pazmiño	817627 */
/* File name: disegno_fisico.sql            */

-- Este fichero se ejecuta despues de poblar
DROP VIEW CompanyasPorPuntualidad;

CREATE MATERIALIZED VIEW CompanyasPorPuntualidad 
BUILD IMMEDIATE
REFRESH COMPLETE
ON DEMAND AS
SELECT NombreC, Puntualidad
FROM Companyas
	JOIN(
		SELECT VuelosCompanyas.Codigo, (TotalRetrasos * 100 / TotalVuelos) AS Puntualidad
		FROM(
			SELECT Codigo, COUNT(Codigo) AS TotalVuelos
			FROM Vuelos
				JOIN Aviones ON
					AvionV = Matricula
				JOIN Companyas ON
					CompanyaAv = Codigo
			GROUP BY Codigo
		) VuelosCompanyas
			JOIN(
				SELECT Codigo, COUNT(Codigo) AS TotalRetrasos
				FROM(
					SELECT DISTINCT idVuelo, AvionV
					FROM Vuelos
						JOIN Retrasos ON
							idVuelo = VueloRetrasado
				) VuelosRetrasados
					JOIN Aviones ON
						AvionV = Matricula
					JOIN Companyas ON
						CompanyaAv = Codigo
				GROUP BY Codigo
			) VuelosRetrasados ON
				VuelosCompanyas.Codigo = VuelosRetrasados.Codigo
		ORDER BY Puntualidad DESC
	) PuntualidadCompanyas ON
		Companyas.Codigo = PuntualidadCompanyas.Codigo;

CREATE OR REPLACE VIEW ActividadAeropuertosSalidas AS
SELECT idVuelo, AeroOrigen AS Aeropuerto, Fecha, HoraSalida AS Hora
FROM Vuelos;

CREATE OR REPLACE VIEW ActividadAeropuertos AS
SELECT idVuelo, AeroDestino AS Aeropuerto, Fecha, HoraLlegada AS Hora
FROM Vuelos
UNION
SELECT *
FROM ActividadAeropuertosSalidas;

DROP VIEW ActividadMomentos;

CREATE MATERIALIZED VIEW ActividadMomentos
BUILD IMMEDIATE
REFRESH COMPLETE
ON DEMAND AS
SELECT a1.Aeropuerto, a1.Fecha, a1.Hora, count(*) AS Actividad
FROM ActividadAeropuertosSalidas a1
	JOIN ActividadAeropuertos a2 ON
		a1.Aeropuerto = a2.Aeropuerto AND ((	
				a1.Fecha = a2.Fecha AND
				a2.Hora - a1.Hora <= 15 AND
				a2.Hora - a1.Hora >= 0
			) OR (
				to_date(a2.Fecha) = to_date(a1.Fecha) + 1 AND
				a2.Hora - (a1.Hora - 2400) <= 15 AND
				a2.Hora - (a1.Hora - 2400) >= 0
			)
		)
GROUP BY a1.Aeropuerto, a1.Fecha, a1.Hora
ORDER BY Actividad DESC;