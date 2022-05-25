--Previamente deberemos crear una tabla AUDITORIA_EMPLEADOS para registrar los
--eventos a auditar que ocurran sobre la tabla EMPLEADOS.
CREATE TABLE AUDITORIA_EMPLEADOS (descripcion VARCHAR2(200));

--Y también crearemos una vista SEDE_DEPARTAMENTOS acerca de los departamentos y
--su localización.
CREATE VIEW SEDE_DEPARTAMENTOS AS
SELECT C.NUMCE, C.NOMCE, C.DIRCE,
D.NUMDE, D.NOMDE, D.PRESU, D.DIREC, D.TIDIR, D.DEPDE
FROM CENTROS C JOIN DEPARTAMENTOS D ON C.NUMCE=D.NUMCE;

--También insertaremos en la tabla DEPARTAMENTOS uno llamado TEMP donde serán
--movidos los empleados cuyo departamento desaparezca.
INSERT INTO DEPARTAMENTOS VALUES (0, 10, 260, 'F', 10, 100, 'TEMP');

--EJERCICIOS
--7.1. Crea un trigger que, cada vez que se inserte o elimine un empleado, registre
--una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del suceso,
--número y nombre de empleado, así como el tipo de operación realizada
--(INSERCIÓN o ELIMINACIÓN).

/*
--MODIFICAR TABLA AUDITORIA
ALTER TABLE AUDITORIA_EMPLEADOS ADD fecha_suceso DATE;
ALTER TABLE AUDITORIA_EMPLEADOS ADD num_emp NUMBER(3);
ALTER TABLE AUDITORIA_EMPLEADOS ADD nom_emp VARCHAR2(30);

--CREAR TRIGGER (MAS DE UN CAMPO)
CREATE OR REPLACE 
TRIGGER ins_el_empleados
AFTER INSERT OR DELETE ON EMPLEADOS
FOR EACH ROW

BEGIN 
	IF INSERTING THEN
		INSERT INTO AUDITORIA_EMPLEADOS VALUES('INSERCION', SYSDATE, :NEW.NUMEM, :NEW.NOMEM);
		
	ELSIF DELETING THEN
	INSERT INTO AUDITORIA_EMPLEADOS VALUES('ELIMINACION', SYSDATE, :NEW.NUMEM, :NEW.NOMEM);
	END IF;
	
END ins_el_empleados;


ALTER TABLE AUDITORIA_EMPLEADOS DROP COLUMN nom_emp;
ALTER TABLE AUDITORIA_EMPLEADOS DROP COLUMN num_emp;
ALTER TABLE AUDITORIA_EMPLEADOS DROP COLUMN fecha_suceso;
*/

--CREAR TRIGGER (UN CAMPO)
CREATE OR REPLACE 
TRIGGER ins_el_empleados
AFTER INSERT OR DELETE ON EMPLEADOS
FOR EACH ROW

BEGIN 
	IF INSERTING THEN
		INSERT INTO AUDITORIA_EMPLEADOS 
		VALUES('INSERCION'||' '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS')||' '|| :NEW.NUMEM||' '|| :NEW.NOMEM);
		
	ELSIF DELETING THEN
		INSERT INTO AUDITORIA_EMPLEADOS 
		VALUES('ELIMINACION'||' '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS')||' '|| :NEW.NUMEM||' '|| :NEW.NOMEM);
	END IF;

END ins_el_empleados;

INSERT INTO EMPLEADOS (NUMEM, NOMEM) 
VALUES (115, 'marta');

--7.2. Crea un trigger que, cada vez que se modifiquen datos de un empleado,
--registre una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del
--suceso, valor antiguo y valor nuevo de cada campo, así como el tipo de operación
--realizada (en este caso MODIFICACIÓN).
CREATE OR REPLACE 
TRIGGER mod_empleados
AFTER UPDATE ON EMPLEADOS
FOR EACH ROW

DECLARE 
	cadena varchar2(200);

BEGIN 
	cadena:= 'MODIFICACIÓN'||' '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS');

	IF updating('NUMEM') THEN
		cadena:= cadena|| 'Num. Empleado: '|| :old.NUMEM||' '||'->'||' '|| :NEW.NUMEM;
	END IF;

	IF updating('EXTEL') THEN
		cadena:= cadena|| 'Extensión: '|| :old.EXTEL||' '||'->'||' '|| :NEW.EXTEL;
	END IF;

	IF updating('SALAR') THEN
		cadena:= cadena|| 'Salario: '|| :old.SALAR||' '||'->'||' '|| :NEW.SALAR;
	END IF;

	IF updating('COMIS') THEN
		cadena:= cadena|| 'Comisión: '|| :old.COMIS||' '||'->'||' '|| :NEW.COMIS;
	END IF;

	IF updating('NUMHI') THEN
		cadena:= cadena|| 'Num. Hijos: '|| :old.NUMHI||' '||'->'||' '|| :NEW.NUMHI;
	END IF;
	
	IF updating('NOMEM') THEN
		cadena:= cadena|| 'Nom. Empleado: '|| :old.NOMEM||' '||'->'||' '|| :NEW.NOMEM;
	END IF;

	IF updating('NUMDE') THEN
		cadena:= cadena|| 'Num. Departamento: '|| :old.NUMDE||' '||'->'||' '|| :NEW.NUMDE;
	END IF;

	INSERT INTO AUDITORIA_EMPLEADOS VALUES(cadena);

END mod_empleados;

--7.3. Crea un trigger para que registre en la tabla AUDITORIA_EMPLEADOS las
--subidas de salarios superiores al 5%.
CREATE OR REPLACE
TRIGGER subida_salarios
AFTER UPDATE OF SALAR ON EMPLEADOS 
FOR EACH ROW 

BEGIN 
	IF (:NEW.SALAR - :OLD.SALAR) > (:OLD.SALAR *0.05) THEN
		INSERT INTO AUDITORIA_EMPLEADOS 
		VALUES(TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS')||'SUBIDA SALARIO MAYOR AL 5%'||' '||:old.SALAR||' '||'->'||' '|| :NEW.SALAR);
	END IF;
	
END subida_salarios;

--7.4. Deseamos operar sobre los datos de los departamentos y los centros donde
--se hallan. Para ello haremos uso de la vista SEDE_DEPARTAMENTOS creada
--anteriormente. Al tratarse de una vista que involucra más de una tabla,
--necesitaremos crear un trigger de sustitución para gestionar las operaciones de
--actualización de la información. Crea el trigger necesario para realizar inserciones,
--eliminaciones y modificaciones en la vista anterior.

/* Está escrita y ejecutada arriba
CREATE VIEW SEDE_DEPARTAMENTOS AS
SELECT C.NUMCE, C.NOMCE, C.DIRCE,
D.NUMDE, D.NOMDE, D.PRESU, D.DIREC, D.TIDIR, D.DEPDE
FROM CENTROS C JOIN DEPARTAMENTOS D ON C.NUMCE=D.NUMCE;
*/
CREATE OR REPLACE 
TRIGGER gestion_sede_departamentos
INSTEAD OF INSERT OR DELETE OR UPDATE ON SEDE_DEPARTAMENTOS

BEGIN 
	IF INSERTING THEN 
		INSERT INTO CENTROS(NUMCE, NOMCE, DIRCE) 
		VALUES()
		
		INSERT INTO DEPARTAMENTOS(NUMDE, NOMDE, PRESU, DIREC, TIDIR, DEPDE)
		VALUES()
	
	ELSIF DELETING THEN 
	ELSIF UPDATING THEN 
	END IF;
	
END gestion_sede_departamentos;

--bien
CREATE OR REPLACE
TRIGGER Actualizacion_departamento
INSTEAD OF DELETE OR INSERT OR UPDATE ON SEDE_DEPARTAMENTOS
FOR EACH ROW
DECLARE
cantidad NUMBER(3);

BEGIN
-- Modificamos datos
IF UPDATING THEN
UPDATE CENTROS
SET NOMCE = :new.NOMCE, DIRCE = :new.DIRCE
WHERE NUMCE = :old.NUMCE;
UPDATE DEPARTAMENTOS
SET NUMCE = :new.NUMCE, NOMDE = :new.NOMDE, DIREC = :new.DIREC,
TIDIR = :new.TIDIR, PRESU = :new.PRESU, DEPDE = :new.DEPDE
WHERE NUMCE = :old.NUMCE AND NUMDE = :old.NUMDE;
-- Borramos datos
ELSIF DELETING THEN
-- Si el departamento tiene empleados
-- los movemos al departamento 'TEMP', luego borramos el partamento
-- Si el centro tiene departamentos, no borramos el centro.
SELECT COUNT(NUMDE) INTO cantidad
FROM EMPLEADOS WHERE NUMDE = :old.NUMDE;
IF cantidad > 0 THEN
UPDATE EMPLEADOS SET NUMDE = 0 WHERE NUMDE = :old.NUMDE;
END IF;
DELETE DEPARTAMENTOS WHERE NUMDE = :old.NUMDE;
SELECT COUNT(NUMCE) INTO cantidad
FROM DEPARTAMENTOS WHERE NUMCE = :old.NUMCE;
IF cantidad = 0 THEN
DELETE CENTROS WHERE NUMCE = :old.NUMCE;
END IF;
-- Insertamos datos
ELSIF INSERTING THEN
-- Si el centro o el departamento no existe lo damos de alta,
-- en otro caso actualizamos los datos
SELECT COUNT(NUMCE) INTO cantidad
FROM CENTROS WHERE NUMCE = :new.NUMCE;
IF cantidad = 0 THEN
INSERT INTO CENTROS
VALUES(:new.NUMCE, :new.NOMCE, :new.DIRCE);
ELSE
UPDATE CENTROS
SET NOMCE = :new.NOMCE, DIRCE = :new.DIRCE
WHERE NUMCE = :new.NUMCE;
END IF;
SELECT COUNT(NUMDE) INTO cantidad
FROM DEPARTAMENTOS WHERE NUMDE = :new.NUMDE;
IF cantidad = 0 THEN
INSERT INTO DEPARTAMENTOS
VALUES(:new.NUMDE, :new.NUMCE, :new.DIREC, :new.TIDIR,
:new.PRESU, :new.DEPDE, :new.NOMDE);
ELSE
UPDATE DEPARTAMENTOS

SET NUMCE = :new.NUMCE, DIREC = :new.DIREC, TIDIR = :new.TIDIR,
PRESU = :new.PRESU, DEPDE = :new.DEPDE, NOMDE = :new.NOMDE
WHERE NUMCE = :new.NUMCE;
END IF;
ELSE
RAISE_APPLICATION_ERROR(-20500, 'Error en la actualización');
END IF;
END Actualizacion_departamento;
/


--7.5. Realiza las siguientes operaciones para comprobar si el disparador anterior
--funciona correctamente.

-- Inserción de datos
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (30, 310, 'NUEVO1');
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (30, 320, 'NUEVO2');
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (30, 330, 'NUEVO3');
SELECT * FROM CENTROS;
SELECT * FROM DEPARTAMENTOS;
-- Borrado de datos
DELETE FROM SEDE_DEPARTAMENTOS WHERE NUMDE=310;
SELECT * FROM SEDE_DEPARTAMENTOS;
DELETE FROM SEDE_DEPARTAMENTOS WHERE NUMCE=30;
SELECT * FROM SEDE_DEPARTAMENTOS;
-- Modificación de datos
UPDATE SEDE_DEPARTAMENTOS
SET NOMDE='CUENTAS', TIDIR='F', NUMCE=20 WHERE NOMDE='FINANZAS';
SELECT * FROM DEPARTAMENTOS;
UPDATE SEDE_DEPARTAMENTOS
SET NOMDE='FINANZAS', TIDIR='P', NUMCE=10 WHERE NOMDE='CUENTAS';
SELECT * FROM DEPARTAMENTOS;