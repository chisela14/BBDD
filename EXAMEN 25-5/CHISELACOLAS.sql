--SE DEBERÁ ENTREGAR UN ÚNICO SCRIPT NOMBREAPELLIDO.SQL QUE CONTENGA LA
--SOLUCIÓN DE LOS EJERCICIOS PLANTEADOS ASÍ COMO LAS CORRESPONDIENTES
--INSTRUCCIONES DE PRUEBA PARA TODAS LAS CASUÍSTICAS.
--ATENCIÓN: No se corregirá el ejercicio que no incluya las instrucciones para probarlo.

--Ejercicio 1 (3 puntos)
--Crea un procedimiento que muestre un listado en el que aparezcan todos los cines, el número de salas que tiene, los
--nombres de las salas y las películas proyectadas. El formato será el siguiente:
--CINE: nombre_del_cine CIUDAD: nombre_de_la ciudad DIRECCIÓN: dirección NÚMERO DE SALAS: num_salas
--*** SALA: sala AFORO: aforo NÚMERO DE PELÍCULAS PROYECTADA:num
--******* TÍTULO: titulo_p FECHA_ESTRENO: fecha_estreno RECAUDACIÓN_SALA; recaudación RECAUDACIÓN PELÍCULA: recaud_película
--******* TÍTULO: titulo_p FECHA_ESTRENO: fecha_estreno RECAUDACIÓN_SALA; recaudación RECAUDACIÓN PELÍCULA: recaud_película
--******* TÍTULO: titulo_p FECHA_ESTRENO: fecha_estreno RECAUDACIÓN_SALA; recaudación RECAUDACIÓN PELÍCULA: recaud_película
--*** SALA: sala AFORO: aforo NÚMERO DE PELÍCULAS PROYECTADA:num
--****** TÍTULO: titulo_p FECHA_ESTRENO: fecha_estreno RECAUDACIÓN_SALA; recaudación RECAUDACIÓN PELÍCULA: recaud_película
--******* TÍTULO: titulo_p FECHA_ESTRENO: fecha_estreno RECAUDACIÓN_SALA; recaudación RECAUDACIÓN PELÍCULA: recaud_película
--******* TÍTULO: titulo_p FECHA_ESTRENO: fecha_estreno RECAUDACIÓN_SALA; recaudación RECAUDACIÓN PELÍCULA: recaud_película
--El listado debe salir ordenados alfabéticamente por cine y por sala. Para las películas que se han proyectado en
--una sala deben salir primero aquellas que se han estrenado más recientemente.

CREATE OR REPLACE 
PROCEDURE mostrarCines AS 
	CURSOR c AS 
		SELECT P.TITULO_P, PR.FECHA_ESTRENO , S.SALA, S.AFORO, COUNT(PR.CIP) NUM, COUNT(S.SALA) NUM_SALAS, C.CINE, C.CIUDAD_CINE, C.DIRECCION_CINE  
		FROM PELICULA P, PROYECCION PR, SALA S, CINE C
BEGIN 
	DBSM.OUTPOUT()
	
END mostrarCines;

BEGIN 
	mostrarCines();
END;


--Ejercicio 2 (2 puntos) :
--Crea una tabla llamada auditoria_peliculas con un campo llamado descripción que sea una cadena de 300
--caracteres donde se almacenará una entrada en la tabla auditoria_peliculas con la fecha del suceso, valor
--antiguo y valor nuevo de cada campo, así como el tipo de operación realizada (-inserción, -modificación,
---borrado).
CREATE TABLE AUDITORIA_PELICULAS (descripcion varchar2(300));

CREATE OR REPLACE 
TRIGGER modificarPeliculas
AFTER INSERT OR DELETE OR UPDATE ON PELICULA
FOR EACH ROW

DECLARE 
cadena varchar2(200);

BEGIN 

	IF INSERTING THEN
		cadena:= 'INSERCION'||' '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS'));
	
		IF inserting('CIP') THEN
			cadena:= cadena|| 'Nuevo CIP: '|| :new.CIP;
		END IF;
		IF inserting('TITULO_P') THEN
				cadena:= cadena|| 'Nuevo título principal: '|| :new.TITULO_P;
		END IF;
		IF inserting('ANO_PRODUCCION') THEN
				cadena:= cadena|| 'Nuevo año de producción: '|| :new.ANO_PRODUCCION;
		END IF;
		IF inserting('TITULO_S') THEN
				cadena:= cadena|| 'Nuevo título secundario: '|| :new.TITULO_S;
		END IF;
		IF inserting('NACIONALIDAD') THEN
				cadena:= cadena|| 'Nueva nacionalidad: '|| :new.NACIONALIDAD;
		END IF;
		IF inserting('PRESUPUESTO') THEN
				cadena:= cadena|| 'Nuevo presupuesto: '|| :new.PRESUPUESTO;
		END IF;
		IF inserting('DURACION') THEN
				cadena:= cadena|| 'Nueva duración: '|| :new.DURACION;
		END IF;
		
	ELSIF DELETING THEN
		cadena:= 'ELIMINACION'||' '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS'));
	
		IF deleting('CIP') THEN
			cadena:= cadena|| 'Nuevo CIP: '|| :new.CIP;
		END IF;
		IF deleting('TITULO_P') THEN
				cadena:= cadena|| 'Título principal eliminado: '|| :old.TITULO_P;
		END IF;
		IF deleting('ANO_PRODUCCION') THEN
				cadena:= cadena|| 'Año de producción eliminado: '|| :old.ANO_PRODUCCION;
		END IF;
		IF deleting('TITULO_S') THEN
				cadena:= cadena|| 'Título secundario eliminado: '|| :old.TITULO_S;
		END IF;
		IF deleting('NACIONALIDAD') THEN
				cadena:= cadena|| 'Nacionalidad eliminada: '|| :old.NACIONALIDAD;
		END IF;
		IF deleting('PRESUPUESTO') THEN
				cadena:= cadena|| 'Presupuesto eliminado: '|| :old.PRESUPUESTO;
		END IF;
		IF deleting('DURACION') THEN
				cadena:= cadena|| 'Duración eliminada: '|| :old.DURACION;
		END IF;
		
	
	ELSIF UPDATING THEN
		cadena:= 'MODIFICACION'||' '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS');
	
		IF updating('CIP') THEN
			cadena:= cadena|| 'CIP: '|| :old.CIP||' '||'->'||' '|| :NEW.CIP;
		END IF;
		IF updating('TITULO_P') THEN
			cadena:= cadena|| 'Título principal: '|| :old.TITULO_P||' '||'->'||' '|| :NEW.TITULO_P;
		END IF;
		IF updating('ANO_PRODUCCION') THEN
			cadena:= cadena|| 'Año de producción: '|| :old.ANO_PRODUCCION||' '||'->'||' '|| :NEW.ANO_PRODUCCION;
		END IF;
		IF updating('TITULO_S') THEN
			cadena:= cadena|| 'Título secundario: '|| :old.TITULO_S||' '||'->'||' '|| :NEW.TITULO_S;
		END IF;
		IF updating('NACIONALIDAD') THEN
			cadena:= cadena|| 'Nacionalidad: '|| :old.NACIONALIDAD||' '||'->'||' '|| :NEW.NACIONALIDAD;
		END IF;
		IF updating('PRESUPUESTO') THEN
			cadena:= cadena|| 'Presupuesto: '|| :old.PRESUPUESTO||' '||'->'||' '|| :NEW.PRESUPUESTO;
		END IF;
		IF updating('DURACION') THEN
			cadena:= cadena|| 'Duracion: '|| :old.DURACION||' '||'->'||' '|| :NEW.DURACION;
		END IF;
	
	END IF;

	INSERT INTO AUDITORIA_PELICULAS VALUES(cadena);

	EXCEPTION
		WHEN NO_DATA_FOUND THEN 
			RAISE_APPLICATION_ERROR('ERROR');

END modificarPeliculas;

INSERT INTO PELICULA (CIP) VALUES ('1N');
DELETE FROM PELICULA(TITULO_P) VALUES ('El proyecto de la Bruja Blair');


--Ejercicio 3 (3 puntos):
--Dada la siguiente vista:

CREATE VIEW VISTA_PROYECCIONES (proyeccion_cine, proyeccion_sala, proyeccion_cip,
proyeccion_fechaestreno, salacine,sala,sala_aforo) AS
	SELECT p.CINE,p.SALA, p.CIP, p.FECHA_ESTRENO, s.CINE, s.SALA, s.AFORO
	FROM PROYECCION p, SALA s
	WHERE p.CINE =s.CINE
	AND p.SALA =s.SALA;

--Deseamos operar sobre los datos correspondientes a la vista anterior. Crea el trigger necesario para realizar
--inserciones, eliminaciones y modificaciones en la vista anterior.

CREATE OR REPLACE
TRIGGER actualizarProyecciones
INSTEAD OF DELETE OR INSERT OR UPDATE ON VISTA_PROYECCIONES
FOR EACH ROW

BEGIN

	IF UPDATING THEN
		UPDATE PROYECCION
		SET SALA = :new.SALA, CIP = :new.CIP, FECHA_ESTRENO = :NEW.FECHA_ESTRENO
		WHERE CINE = :old.CINE;
	
		UPDATE SALA
		SET SALA = :new.SALA, AFORO = :new.AFORO
		WHERE CINE = :old.CINE;

	ELSIF DELETING THEN
		DELETE SALA WHERE CINE = :old.CINE;
		DELETE PROYECCION WHERE CINE = :old.CINE;

	ELSIF INSERTING THEN
		INSERT INTO PROYECCION VALUES(proyeccion_cine, proyeccion_sala, proyeccion_cip, proyeccion_fechaestreno);
		INSERT INTO SALA VALUES(salacine,sala,sala_aforo);

	ELSE
		RAISE_APPLICATION_ERROR(-20500, 'Error en la actualización');
	END IF;

END actualizarProyecciones;

DELETE FROM PROYECCION WHERE CINE='El Arcangel';


--Ejercicio 4 ( 2 puntos):
--Crear el trigger necesario para impedir que un cine tenga más de 5 salas. En el caso de no cumplir la casuística
--deberá lanzar una excepción que interrumpa el proceso. El error será -20007: Un cine no puede tener más
--de 5 salas.

CREATE OR REPLACE 
TRIGGER cincoSalas
BEFORE INSERT OR UPDATE ON SALA
DECLARE 
numSalas NUMBER;

BEGIN 
	SELECT COUNT(S.SALA) INTO numSalas
	FROM CINE C, SALA S
	WHERE C.CINE = S.CINE;
	
	EXCEPTION 
	WHEN numSalas>5 THEN 
		RAISE_APPLICATION_ERROR(-20007, 'Un cine no puede tener más de 5 salas');
	
END cincoSalas;

INSERT INTO SALA(CINE, SALA) VALUES('El Arcangel',6);


