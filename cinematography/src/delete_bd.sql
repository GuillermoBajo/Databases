/* Autores:	Lizer Bernad		779035 */
/*			Guillermo Bajo		842748 */
/*			Axel Isaac Pazmiño	817627 */
/* File name: borrar_bd.sql            */

--Tablas
DROP TABLE InformacionS;
DROP TABLE ParticipaSerie;
DROP TABLE InformacionP;
DROP TABLE ParticipaPeli;
DROP TABLE Capitulos;
DROP TABLE GeneroSeries;
DROP TABLE Series;
DROP TABLE Relaciones;
DROP TABLE GeneroPelis;
DROP TABLE Peliculas;
DROP TABLE Personas;

--Triggers
DROP TRIGGER integridadGeneroPelis;
DROP TRIGGER integridadGeneroSeries;
DROP TRIGGER integridadCapitulos;

--Vistas e indices
DROP VIEW PelisFamActores;
DROP INDEX IndiceRol;
