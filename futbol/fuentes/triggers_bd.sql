/* Autores:	Lizer Bernad		779035 */
/*			Guillermo Bajo		842748 */
/*			Axel Isaac Pazmiño	817627 */
/* Triggers:	   */

-- Verifica que el equipo local no sea el mismo que el visitante
CREATE OR REPLACE TRIGGER LocalNoVisitante
BEFORE INSERT OR UPDATE ON Partidos
FOR EACH ROW
-- se dispara cuando ambos equipos son iguales
WHEN (NEW.EquipoLocal = NEW.EquipoVisitante)
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Un equipo no puede enfrentarse a si mismo.');
END LocalNoVisitante;
/


-- Verifica que la temporada insertada sea valida
CREATE OR REPLACE TRIGGER TempValida
BEFORE INSERT OR UPDATE ON Temporadas
FOR EACH ROW
-- se dispara cuando la temporada no acaba al año siguiente de comenzar
WHEN (NEW.Fin - NEW.Inicio != 1)
BEGIN
    RAISE_APPLICATION_ERROR(-20002, 'Temporada invalida.');
END TempValida;
/


-- Verifica que ninguno de los equipos introducidos haya jugado ya en esa jornada
CREATE OR REPLACE TRIGGER RepiteEnJornada
BEFORE INSERT OR UPDATE ON Partidos
FOR EACH ROW
DECLARE
    jugados NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO jugados
    FROM Jornadas, Equipos
    WHERE JornadaT = :NEW.JornadaT
    AND JornadaD = :NEW.JornadaD
    AND JornadaN = :NEW.JornadaN
    AND (NombreCorto = :NEW.EquipoLocal OR NombreCorto = NEW.EquipoVisitante);

    -- si uno de los dos equipos ya ha jugado en esa jornada, salta el error
    IF (jugados > 0) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Cada equipo puede jugar un maximo de una vez por jornada.');
    END IF;
END RepiteEnJornada;
/