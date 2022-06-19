--Crear los disparadores necesarios para mantener los préstamos con los siguientes criterios:

--1. Cuando se realiza un préstamo, se comprueba que el libro no esté prestado (PRESTADO_LI
--= 'N') y se modifica el valor del campo PRESTADO_LI al valor 'S', para próximos
--préstamos, en caso contrario no se puede efectuar el préstamo.
--2. También se comprueba que el lector no esté sancionado, es decir, la fecha de sanción, si
--existe, es anterior al día de hoy, en caso contrario no se puede efectuar el préstamo.

CREATE OR REPLACE
TRIGGER COMPROBAR_PRESTAMO
BEFORE INSERT ON PRESTAMOS
FOR EACH ROW
DECLARE
	v_estado_libro LIBROS.PRESTADO_LI%TYPE;
	v_lector_sancionado LECTORES.MOROSO_LE%TYPE;
BEGIN
	SELECT PRESTADO_LI INTO v_estado_libro FROM LIBROS WHERE COD_LI = :NEW.CODLIB_PR;
	SELECT MOROSO_LE INTO v_lector_sancionado FROM LECTORES WHERE COD_LE = :NEW.CODLEC_PR;
	IF v_estado_libro = 'S' THEN
		RAISE_APPLICATION_ERROR(-20001, 'El libro no está disponible ahora mismo');
	ELSIF v_lector_sancionado > SYSDATE THEN
		RAISE_APPLICATION_ERROR(-20002, 'El lector tiene una sanción activa');
	ELSE 
		UPDATE LIBROS SET PRESTADO_LI = 'S' WHERE COD_LI = :NEW.CODLIB_PR;
	END IF;
END COMPROBAR_PRESTAMO;

--COMPROBAR
INSERT INTO PRESTAMOS(CODLIB_PR, CODLEC_PR) VALUES(2,1);--LIBRO EN PRESTAMO
INSERT INTO PRESTAMOS(CODLIB_PR, CODLEC_PR) VALUES(1,0);--PERSONA CON SANCIÓN
INSERT INTO PRESTAMOS(CODLIB_PR, CODLEC_PR) VALUES(1,1);--SIN PROBLEMAS

--3. Cuando se devuelve un libro (actualización del campo DEVOL_PR a la fecha de
--devolución) se modifica el valor del campo PRESTADO_LI al valor 'N' para futuros
--préstamos.
--4. También se comprueba que la duración del préstamo no es superior a 15 días, en caso
--contrario se procederá a sancionar al lector (incrementar el valor del campo
--SANCIONES_LE y se pondrá en el campo MOROSO_LE la fecha hasta la cual no podrá
--hacer ningún préstamo) con los siguientes criterios:
--	- La 1ª vez, quince días, a partir de la fecha de devolución del libro.
--	- La 2ª vez, un mes.
--	- La 3ª vez, seis meses.
--	- La 4ª y sucesivas veces, un año.

CREATE OR REPLACE
TRIGGER DEVOLVER_LIBRO
AFTER UPDATE OF DEVOL_PR ON PRESTAMOS
FOR EACH ROW
DECLARE
	v_duracion_prestamo NUMBER := 0;
	v_numSanciones LECTORES.SANCIONES_LE%TYPE;
BEGIN
	--MODIFICAR LIBRO
	UPDATE LIBROS SET PRESTADO_LI = 'N' WHERE COD_LI = :OLD.CODLIB_PR;
	--comprobar que la duracion del prestamo y sancionar si hace falta
	v_duracion_prestamo := ROUND(:NEW.DEVOL_PR - :OLD.FECHA_PR, 1);
	DBMS_OUTPUT.PUT_LINE (v_duracion_prestamo);
	IF v_duracion_prestamo > 15 THEN
		SELECT SANCIONES_LE INTO v_numSanciones FROM LECTORES WHERE COD_LE = :OLD.CODLEC_PR;
		IF v_numSanciones = 0 THEN
			UPDATE LECTORES SET MOROSO_LE = :NEW.DEVOL_PR + 15 WHERE COD_LE = :OLD.CODLEC_PR; 
		ELSIF v_numSanciones = 1 THEN
			UPDATE LECTORES SET MOROSO_LE = ADD_MONTHS(:NEW.DEVOL_PR, 1) WHERE COD_LE = :OLD.CODLEC_PR;
		ELSIF v_numSanciones = 2 THEN
			UPDATE LECTORES SET MOROSO_LE = ADD_MONTHS(:NEW.DEVOL_PR, 6) WHERE COD_LE = :OLD.CODLEC_PR;
		ELSE
			UPDATE LECTORES SET MOROSO_LE = ADD_MONTHS(:NEW.DEVOL_PR, 12) WHERE COD_LE = :OLD.CODLEC_PR;
		END IF;
		UPDATE LECTORES SET SANCIONES_LE = SANCIONES_LE + 1 WHERE COD_LE = :OLD.CODLEC_PR;
	END IF;
END  DEVOLVER_LIBRO;

--COMPROBAR
--1 VEZ (INSERT HECHO ARRIBA)
UPDATE PRESTAMOS SET DEVOL_PR = SYSDATE + 16 WHERE CODLEC_PR = 1 AND CODLIB_PR = 1;
--2 VEZ
INSERT INTO PRESTAMOS(CODLIB_PR, CODLEC_PR) VALUES(1,2);
UPDATE PRESTAMOS SET DEVOL_PR = SYSDATE + 16 WHERE CODLEC_PR = 2 AND CODLIB_PR = 1;
--3 VEZ
INSERT INTO PRESTAMOS(CODLIB_PR, CODLEC_PR) VALUES(1,3);
UPDATE PRESTAMOS SET DEVOL_PR = SYSDATE + 16 WHERE CODLEC_PR = 3 AND CODLIB_PR = 1;
--4 VEZ
INSERT INTO PRESTAMOS(CODLIB_PR, CODLEC_PR) VALUES(1,4);
UPDATE PRESTAMOS SET DEVOL_PR = SYSDATE + 16 WHERE CODLEC_PR = 4 AND CODLIB_PR = 1;


--5. El campo SANCIONES_LE sólo podrá incrementarse, NUNCA decrementar.

CREATE OR REPLACE 
TRIGGER AUMENTAR_SANCIONES
BEFORE UPDATE OF SANCIONES_LE ON LECTORES
FOR EACH ROW
BEGIN
	IF :NEW.SANCIONES_LE< :OLD.SANCIONES_LE THEN
		RAISE_APPLICATION_ERROR(-20003,'El número de sanciones no puede disminuir');
	END IF;
END AUMENTAR_SANCIONES;

--COMPROBAR
UPDATE LECTORES SET SANCIONES_LE = 0 WHERE NOMBRE_LE = 'SANCIONADO';









