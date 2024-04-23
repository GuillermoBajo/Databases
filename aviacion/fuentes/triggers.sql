/* Autores:	Lizer Bernad		779035 */
/*			Guillermo Bajo		842748 */
/*			Axel Isaac Pazmiño	817627 */
/* File name: triggers.sql             */

-- Trigger que comprueba que un desvio no tenga como destino el aeropuerto al que originalmente
-- se dirigia el avion, ya que en ese caso no es un desvio.
CREATE OR REPLACE TRIGGER DesvioDistinoDestino
-- El trigger comprueba inserciones de tuplas en la tabla de desvios
BEFORE INSERT OR UPDATE ON Desvios
FOR EACH ROW
DECLARE
    -- Declaramos una variable para almacenar el valor del destino original del vuelo desviado
    destinoT VARCHAR(5);
BEGIN
    -- Guardamos en destinoT el aeropuerto destino original
    SELECT AeroDestino INTO destinoT FROM Vuelos
    WHERE (idVuelo =:NEW.VueloDesviado);
    -- Si el aeropuerto de desvio es igual al aeropuerto de destino, salta un error
    IF (destinoT =:new.AeropuertoDesv) THEN
        RAISE_APPLICATION_ERROR(-20000,'Error al insertar en Desvios: un vuelo no puede ser desviado al aeropuerto de destino.');
    END IF;
END DesvioDistinoDestino;
/


-- Trigger que comprueba que la fecha de un vuelo sea posterior a la de fabricación del avión
-- que realiza el vuelo
CREATE OR REPLACE TRIGGER FabricacionAnteriorAVuelo
-- El trigger comprueba inserciones de tuplas en la tabla de vuelos
BEFORE INSERT OR UPDATE ON Vuelos
FOR EACH ROW
-- El trigger solo tendra en cuenta aquellos vuelos que tengan avion, dado que puede darse el caso
--  de que se recopile información de vuelos de los que no conste información del avión
WHEN (NEW.AvionV IS NOT NULL)
DECLARE
    -- Declaramos una variable para almacenar el año de fabricacion del avion que realiza el vuelo a insertar
    fabricacion NUMBER(4);
BEGIN
    -- Guardamos en fabricacion el año de fabricacion del vuelo a insertar
    SELECT AgnoFabricacion INTO fabricacion FROM Aviones
    WHERE (Matricula =:NEW.AvionV);
    -- Si la fabricacion es mas reciente que la fecha de salida del vuelo, se dispara el trigger
    IF (fabricacion > EXTRACT(year FROM TO_DATE(:NEW.Fecha))) THEN
         RAISE_APPLICATION_ERROR(-20000,'Error al insertar en Vuelos: la fecha del vuelo no puede ser anterior a la de fabricacion del avion.');
    END IF;
END FabricacionAnteriorAVuelo;
/

-- Trigger que comprueba que la vuelo no sea desviado dos veces al mismo aeropuerto
CREATE OR REPLACE TRIGGER DobleDesvio
-- El trigger comprueba inserciones de tuplas en la tabla de desvios
BEFORE INSERT ON Desvios
FOR EACH ROW
DECLARE
    -- Declaramos un contador en el que se almacenara el numero de desvios del mismo vuelo
    -- al mismo aeropuerto en caso de que los haya
    contador INTEGER :=0;
BEGIN
    -- Calculamos la cuenta de desvios del mismo vuelo al mismo aeropuerto que la tupla que se desea insertar
    SELECT COUNT(*) INTO contador FROM Desvios WHERE (AeropuertoDesv = :NEW.AeropuertoDesv AND VueloDesviado = :NEW.VueloDesviado);
    -- Si hay alguno se dispara el trigger
    IF contador > 0 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Error al insertar en Desvios: Este vuelo ya ha sido desviado a este aeropuerto.');
    END IF;
END tr_evitar_desvios_repetidos;
/