/* Autores:	Lizer Bernad		779035 */
/*			Guillermo Bajo		842748 */
/*			Axel Isaac Pazmiño	817627 */
/* File name: consultas.sql            */

-- Consulta 1:
CREATE VIEW CompanyasPorPuntualidad AS
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

CREATE OR REPLACE VIEW PrimeraCompanyaPorPuntualidad AS	
SELECT NombreC, Puntualidad
FROM CompanyasPorPuntualidad
WHERE
	Puntualidad = (
		SELECT MAX(Puntualidad)
		FROM CompanyasPorPuntualidad
	);

CREATE OR REPLACE VIEW SegundaCompanyaPorPuntualidad AS	
SELECT NombreC, Puntualidad
FROM CompanyasPorPuntualidad
WHERE
	Puntualidad = (
		SELECT MAX(Puntualidad)
		FROM(
			SELECT NombreC, Puntualidad
			FROM CompanyasPorPuntualidad
			WHERE
				NombreC NOT IN(
					SELECT NombreC
					FROM PrimeraCompanyaPorPuntualidad
				)
		)
	);

CREATE OR REPLACE VIEW TerceraCompanyaPorPuntualidad AS	
SELECT NombreC, Puntualidad
FROM CompanyasPorPuntualidad
WHERE
	Puntualidad = (
		SELECT MAX(Puntualidad)
		FROM(
			SELECT NombreC, Puntualidad
			FROM CompanyasPorPuntualidad
			WHERE
				NombreC NOT IN(
					SELECT NombreC
					FROM PrimeraCompanyaPorPuntualidad
					UNION
					SELECT NombreC
					FROM SegundaCompanyaPorPuntualidad
				)
		)
	);

SELECT NombreC
FROM(
	SELECT NombreC, Puntualidad
	FROM PrimeraCompanyaPorPuntualidad
	UNION
	SELECT NombreC, Puntualidad
	FROM SegundaCompanyaPorPuntualidad
	UNION
	SELECT NombreC, Puntualidad
	FROM TerceraCompanyaPorPuntualidad
	ORDER BY Puntualidad DESC
);




-- Consulta 2:
select M1.fabricante, M1.nombreM, M1.motor
from aviones A1, vuelos V1, modelos M1, retrasos R1
-- hacemos un join de las diferentes tablas para tener de cada vuelo (V1) retrasado (R1)
-- información de su modelo (M1) de avion (A1). descartamos los vuelos de aviones sin
-- información relativa a su modelo.
-- Hay tuplas de vuelos duplicadas si tienen más de una causa de retraso.
where A1.modelo IS NOT NULL and V1.avionv = A1.Matricula and M1.nombreM = A1.modelo and V1.idVuelo = R1.vueloRetrasado
-- agrupamos los vuelos por el fabricante, modelo y motor del avión que lo realizó
group by fabricante, motor, NombreM
-- distinct idvuelo nos quita las tuplas duplicadas de los vuelos con más de un tipo
-- de retraso y nos quedamos con los que el porcentaje de retrasos por Seguridad respecto al
-- total de retrasos es mayor del 1%
having sum(case causa when 'Seguridad' then 1 else 0 end)/count(distinct idvuelo)*100 > 1.0;



-- Consulta 3:
CREATE OR REPLACE VIEW ActividadAeropuertosSalidas AS
SELECT idVuelo, AeroOrigen AS Aeropuerto, Fecha, HoraSalida AS Hora
FROM Vuelos;

CREATE OR REPLACE VIEW ActividadAeropuertos AS
SELECT idVuelo, AeroDestino AS Aeropuerto, Fecha, HoraLlegada AS Hora
FROM Vuelos
UNION
SELECT *
FROM ActividadAeropuertosSalidas;

CREATE VIEW ActividadMomentos AS
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

SELECT Nombre, Fecha, Hora
FROM (
		SELECT Aeropuerto, Fecha, Hora, Actividad
		FROM ActividadMomentos
		WHERE Actividad = (
				SELECT MAX(Actividad)
				FROM ActividadMomentos
			)
	) JOIN Aeropuertos ON
		Aeropuerto = CodigoIATA;