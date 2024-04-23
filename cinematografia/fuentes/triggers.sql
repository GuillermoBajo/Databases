/* Autores:	Lizer Bernad		779035 */
/*			Guillermo Bajo		842748 */
/*			Axel Isaac Pazmiño	817627 */
/* File name: create_triggers.sql      */

CREATE TRIGGER integridadGeneroPelis
BEFORE INSERT ON informacionP
FOR EACH ROW
DECLARE sexp VARCHAR(1);
BEGIN
    SELECT sexo INTO sexp
    FROM personas
    WHERE (personas.idpersona=:NEW.participanteip);
    -- Si pretende introducir una persona con rol 'actor' pero es mujer, dispara el trigger.
    IF (:NEW.rol = 'actor') AND (sexp = 'f') THEN
        RAISE_APPLICATION_ERROR(-20000,'Si quien participa en la pelicula de actor su genero es femenino, su rol debe ser "actress": violada');
    END IF;

    -- Si pretende introducir una persona con rol 'actress' pero es hombre, dispara el trigger.
    IF (:NEW.rol = 'actress') AND (sexP = 'm') THEN
        RAISE_APPLICATION_ERROR(-20001,'Si quien participa en la pelicula de actor su genero es masculino, su rol debe ser "actor": violada');
    END IF;
END;
/
CREATE TRIGGER integridadGeneroSeries
BEFORE INSERT ON informacions
FOR EACH ROW
DECLARE sexs VARCHAR(1);
BEGIN
    SELECT sexo INTO sexs
    FROM personas
    WHERE (personas.idpersona = :NEW.participanteis);
    -- Si pretende introducir una persona con rol 'actor' pero es mujer, dispara el trigger.
    IF (:NEW.rol = 'actor') AND (sexs = 'f') THEN
        RAISE_APPLICATION_ERROR(-20000,'Si quien participa en la serie de actor su genero es femenino, su rol debe ser "actress": violada');
    END IF;

    -- Si pretende introducir una persona con rol 'actress' pero es hombre, dispara el trigger.
    IF (:NEW.rol = 'actress') AND (sexs = 'm') THEN
        RAISE_APPLICATION_ERROR(-20001,'Si quien participa en la serie de actor su genero es masculino, su rol debe ser "actor": violada');
    END IF;
END;
/
CREATE TRIGGER integridadCapitulos
BEFORE INSERT ON capitulos
FOR EACH ROW
-- El trigger se dispara solo con Capitulos con los valores de temporada y episodio asignados (no nulos)
WHEN ((NEW.temporada IS NOT NULL) AND (NEW.episodio IS NOT NULL))
DECLARE temp NUMBER(1);
ep NUMBER(2);
BEGIN
    SELECT temporada, episodio INTO temp, ep
    FROM capitulos
    WHERE (capitulos.titulos=:NEW.titulos) AND (capitulos.estrenos=:NEW.estrenos ) AND (capitulos.temporada=:NEW.temporada) AND (capitulos.episodio=:NEW.episodio);
    IF (temp IS NOT NULL) AND (ep IS NOT NULL) THEN
        RAISE_APPLICATION_ERROR(-20002,'Si se especifica temporada y episodio al añadir capitulo, este no puede tener los mismos que otro capitulo de la misma serie: violada');
    END IF;
END;
/
