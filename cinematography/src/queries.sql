/* Autores:	Lizer Bernad		779035 */
/*			Guillermo Bajo		842748 */
/*			Axel Isaac Pazmiño	817627 */
/* File name: consultas.sql            */

-- Consulta 1
SELECT DISTINCT TituloP
FROM Peliculas
	JOIN GeneroPelis
	ON EstrenoP = EstrenoGP
		AND TituloP = TituloGP
WHERE GeneroP = 'family'
	AND TituloP NOT IN (
		SELECT DISTINCT TituloP
		FROM Peliculas
			JOIN GeneroPelis
			ON EstrenoP = EstrenoGP
				AND TituloP = TituloGP
			JOIN ParticipaPeli
			ON EstrenoP = EstrenoPP
				AND TituloP = TituloPP
			JOIN Personas
			ON ParticipantePP = idPersona
			JOIN InformacionP
			ON EstrenoPP = EstrenoIP
				AND TituloPP = TituloIP
				AND ParticipantePP = ParticipanteIP
		WHERE GeneroP = 'family'
			AND Rol = 'actor'
	);


-- Consulta 2
SELECT Nombre
FROM Personas
	JOIN ParticipaSerie
	ON idPersona = ParticipantePS
	JOIN Series
	ON Estreno = EstrenoPS
		AND Titulo = TituloPS
	JOIN InformacionS
	ON EstrenoPS = EstrenoIS
		AND TituloPS = TituloIS
		AND ParticipantePS = ParticipanteIS
WHERE Rol = 'director'
	AND ((Estreno >= 1990
			AND Estreno <= 1999
		)
		OR (Fin >= 1990
			AND Fin <= 1999
		)
		OR (Estreno < 1990
			AND (Fin > 1999 
				OR Fin IS NULL
			)
		)
	)
GROUP BY Nombre
HAVING COUNT(DISTINCT Titulo) >= 6;


-- Consulta 3
SELECT COUNT(COUNT(Papel)) AS NumeroPapeles
FROM InformacionP
	JOIN ParticipaPeli
	ON EstrenoPP = EstrenoIP
		AND TituloPP = TituloIP
		AND ParticipanteIP = ParticipantePP
	JOIN Personas
	ON ParticipantePP = IdPersona
	JOIN Relaciones
	ON EstrenoIP = EstrenoOrig
		AND TituloIP = TituloOrig
WHERE Papel <> 'Ninguno'
	AND (Tipo = 'followed by'
		OR Tipo = 'follows'
	)
GROUP BY Papel
HAVING COUNT(DISTINCT IdPersona) >= 4;