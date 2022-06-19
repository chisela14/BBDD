--1. Realiza los siguientes cursores (implícitos o explícitos)
	--a) Realiza un bloque de programa en PL-SQL que visualice el apellido y el oficio del
	--empleado de código 127.

	--127 no data found, pruebo con 1
	DECLARE 
		v_cod NUMBER := 1;
		v_apellido EMPLEADO.APELLIDO%TYPE;  
		v_oficio EMPLEADO.OFICIO%TYPE;
	BEGIN
		SELECT APELLIDO, OFICIO INTO v_apellido, v_oficio
		FROM EMPLEADO
		WHERE EMP_NO = v_cod;
		DBMS_OUTPUT.PUT_LINE ('Apellido del empleado: '|| v_apellido);
		DBMS_OUTPUT.PUT_LINE ('Oficio del empleado: '|| v_oficio);
	END;
	
	--b) Crea un bloque de programa que visualice los apellidos de los empleados
	--pertenecientes al departamento 20.

	--20 no data found, pruebo 1
	DECLARE
		v_cod NUMBER := 1;
		CURSOR c_apellidos IS 
				SELECT E.APELLIDO FROM EMPLEADO E, DEPARTAMENTO D
				WHERE D.NUM_DEP = E.NUM_DEP
				AND D.NUM_DEP = v_cod;
	BEGIN 
		FOR registro IN c_apellidos LOOP
			DBMS_OUTPUT.PUT_LINE(registro.APELLIDO ||' pertenece al departamento '||v_cod);
		end LOOP;
	END;

--2. Usando un cursor escribe un bloque PL/SQL que visualice el apellido y la fecha de alta de
--todos los empleados ordenados por fecha de alta.

CREATE OR REPLACE 
PROCEDURE verFechaAlta IS 
	CURSOR c IS 
		SELECT APELLIDO, FECHA_ALTA FROM EMPLEADO
		ORDER BY FECHA_ALTA;
BEGIN
	FOR registro IN c LOOP 
		DBMS_OUTPUT.PUT_LINE('El empleado '||registro.APELLIDO ||' fue dado de alta el '||registro.FECHA_ALTA);
	END LOOP;
END verFechaAlta;

BEGIN
	verFechaAlta;
END;

--3. Crea un trigger que impida que se agregue o modifique un empleado con el sueldo mayor o
--menor que los valores máximo y mínimo respectivamente para su cargo. Se agrega la
--restricción de que el trigger no se disparará si el oficio es PRESIDENTE.

CREATE OR REPLACE 
TRIGGER valores_sueldo
BEFORE INSERT OR UPDATE OF SALARIO ON EMPLEADO 
FOR EACH ROW 
DECLARE
	v_sueldoMIN EMPLEADO.SALARIO%TYPE; 
	v_sueldoMAX EMPLEADO.SALARIO%TYPE;
BEGIN 
	SELECT MAX(NVL(SALARIO,0)) INTO v_sueldoMAX FROM EMPLEADO WHERE OFICIO = :NEW.OFICIO;
	SELECT MIN(NVL(SALARIO,0)) INTO v_sueldoMIN FROM EMPLEADO WHERE OFICIO = :NEW.OFICIO;
	--NO TENGO PRESIDENTE AÑADIDO, PRUEBO CON DIRECTOR
	IF (:NEW.OFICIO != 'DIRECTOR') THEN
		--mejor con > and <
		IF :NEW.SALARIO NOT BETWEEN v_sueldoMIN AND v_sueldoMAX THEN
			RAISE_APPLICATION_ERROR(-20020,'No se puede annadir un sueldo que no es encuentre entre el sueldo minimo y el sueldo maximo.');
		END IF;
	END IF;
END valores_sueldo;

--COMPROBAR
INSERT INTO EMPLEADO VALUES(7,'GIL',600,'MECANICO',SYSDATE,1,3);
INSERT INTO EMPLEADO VALUES(7,'GIL',800,'MECANICO',SYSDATE,1,3);
INSERT INTO EMPLEADO VALUES(8,'GIL',1800,'DIRECTOR',SYSDATE,1,3);
--MUTANTE
UPDATE EMPLEADO SET SALARIO = 500 WHERE EMP_NO = 3;

--4. Crea triggers que permitan actualizar en cascada el campo tipo de la tabla tipos_pieza en
--caso de que sea modificado con una instrucción UPDATE.
	--Propaga esa actualización por las tablas piezas, existencias y suministros (harán falta
	--varios triggers).

--el tipo de pieza se actualiza cuando se cambia en tipo_pieza
CREATE OR REPLACE
TRIGGER ACTUALIZAR_TIPO
BEFORE UPDATE ON TIPO_PIEZA
FOR EACH ROW
BEGIN
	UPDATE PIEZA
	SET TIPO = :NEW.TIPO
	WHERE TIPO = :OLD.TIPO;
END ACTUALIZAR_TIPO;
--el tipo en suministro y existencia se actualiza cuando se cambia en pieza (arriba)
CREATE OR REPLACE 
TRIGGER ACTUALIZAR_TIPO_SUM
BEFORE UPDATE ON PIEZA
FOR EACH ROW
BEGIN
	UPDATE SUMINISTRO
	SET TIPO = :NEW.TIPO
	WHERE TIPO = :OLD.TIPO;
END ACTUALIZAR_TIPO_SUM;
--el recorrido se aprecia mejor en el diagrama
CREATE OR REPLACE 
TRIGGER ACTUALIZAR_TIPO_EX
BEFORE UPDATE ON PIEZA
FOR EACH ROW
BEGIN
	UPDATE EXISTENCIA
	SET TIPO = :NEW.TIPO
	WHERE TIPO = :OLD.TIPO;
END ACTUALIZAR_TIPO_SUM;

--comprobar
UPDATE TIPO_PIEZA SET TIPO = 'B2' WHERE TIPO = 'C';


--5. Crea una tabla llamada suministros_audit con los campos tipo de pieza, modelo de pieza, cif,
--precio viejo, precio nuevo y fecha (todos con los mismos tipos de datos que los equivalentes en
--la tabla suministros).
	--Consigue que cada vez que se modifica un precio en la tabla suministros se almacene un
	--registros en la tabla suministros_audit con el precio viejo, el nuevo y la fecha del cambio.

CREATE TABLE SUMINISTRO_AUDIT(
	CIF VARCHAR2(9), 
	TIPO VARCHAR2(2), 
	MODELO NUMBER(2), 
	PRECIO_VIEJO NUMBER(11,4), 
	PRECIO_NUEVO NUMBER(11,4), 
	FECHA_CAMBIO DATE,
	CONSTRAINT fk_suministro_aud FOREIGN KEY (CIF,TIPO,MODELO) REFERENCES SUMINISTRO(CIF,TIPO,MODELO),
	CONSTRAINT pk_suministro_aud PRIMARY KEY (CIF,TIPO,MODELO) 
);

CREATE OR REPLACE
TRIGGER MODIFICAR_PRECIO_SUM
BEFORE UPDATE OF PRECIO_COMPRA ON SUMINISTRO
FOR EACH ROW
BEGIN
	--LA CLAVE PRIMARIA NO PUEDE QUEDARSE VACIA
	INSERT INTO SUMINISTRO_AUDIT VALUES(:OLD.CIF,:OLD.TIPO,:OLD.MODELO,:OLD.PRECIO_COMPRA,:NEW.PRECIO_COMPRA,SYSDATE);
END MODIFICAR_PRECIO_SUM;

--COMPROBAR
UPDATE SUMINISTRO SET PRECIO_COMPRA = 2 WHERE PRECIO_COMPRA = 1;


--6. Crear un trigger para la tabla de piezas que prohíba modificar el precio de venta de una pieza
--a un precio más pequeño que el del menor precio de compra para esa pieza (debe provocar un
--error si se produce esa situación, la modificación del precio no se realizará).

--como la clave primaria no incluye el precio de compra, una pieza de una empresa solo podra tener un precio de compra
--(no hace falta sacar el min)
CREATE OR REPLACE
TRIGGER PRECIO_VENTA_MENOR_COMPRA
BEFORE UPDATE OF PRECIO_VENTA ON PIEZA
FOR EACH ROW
DECLARE
	V_PRECIO_COMPRA SUMINISTRO.PRECIO_COMPRA%TYPE;
BEGIN
	SELECT PRECIO_COMPRA INTO V_PRECIO_COMPRA 
	FROM SUMINISTRO 
	WHERE TIPO = :OLD.TIPO
	AND MODELO = :OLD.MODELO;

	IF :NEW.PRECIO_VENTA < V_PRECIO_COMPRA THEN
		RAISE_APPLICATION_ERROR(-20030, 'No se puede cambiar el precio de venta por uno menor al precio de compra');
	END IF;
END PRECIO_VENTA_MENOR_COMPRA;

--COMPROBAR
UPDATE PIEZA SET PRECIO_VENTA = 0.2 WHERE TIPO='A' AND MODELO='1';


--7. Visualiza mediante un procedimiento los apellidos de los empleados de un departamento
--cualquiera. Usa un cursor con variables de acoplamiento.(VAR DE PARAMETRO)

CREATE OR REPLACE 
PROCEDURE VER_APELLIDOS_DEP(V_DEP DEPARTAMENTO.NUM_DEP%TYPE) IS
	CURSOR C_APELLIDOS IS
		SELECT APELLIDO FROM EMPLEADO WHERE NUM_DEP = V_DEP;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Al departamento '||V_ACOP||' pertenecen los siguientes empleados: ');
	FOR registro IN C_APELLIDOS LOOP
		DBMS_OUTPUT.PUT_LINE(registro.APELLIDO);
	END LOOP;
END VER_APELLIDOS_DEP;

BEGIN
	VER_APELLIDOS_DEP(3);
END;


--8. Visualiza utilizando un WHILE un bloque PL/SQL que visualice el apellido y la fecha de alta de
--todos los empleados ordenados por fecha de alta.
	--Crea posteriormente un bloque PL/SQL que realice lo mismo, pero usando un cursor
	--“FOR..LOOP”. Usa la tabla EMPLEADOS (emp_no, apellido, salario, num_dep, fecha_alta).

--WHILE OBLIGA A USAR OPEN FETCH
DECLARE
	CURSOR C_AP_FECHA IS
		SELECT APELLIDO, FECHA_ALTA FROM EMPLEADO ORDER BY FECHA_ALTA;
	registro C_AP_FECHA%ROWTYPE;
	contador NUMBER := 0;
	v_num_empleados NUMBER := 0;
BEGIN	
	SELECT COUNT(EMP_NO) INTO v_num_empleados FROM EMPLEADO;
	OPEN C_AP_FECHA;
	WHILE contador < v_num_empleados LOOP
		FETCH C_AP_FECHA INTO registro;
		DBMS_OUTPUT.PUT_LINE('El empleado '||registro.APELLIDO||' fue dado de alta en '||registro.FECHA_ALTA);
		contador:=contador+1;
	end LOOP;
END;

DECLARE
CURSOR C_AP_FECHA IS
	SELECT APELLIDO, FECHA_ALTA FROM EMPLEADO ORDER BY FECHA_ALTA;
BEGIN
	FOR registro IN C_AP_FECHA LOOP
		DBMS_OUTPUT.PUT_LINE('El empleado '||registro.APELLIDO||' fue dado de alta en '||registro.FECHA_ALTA);
	END LOOP;
END;


--9. Realizar una función que reciba como parámetro el nombre y el apellido de un empleado,
--también debe recibir un parámetro que podrá ser un uno (debe insertarlo un empleado) o un
--dos (debe borrar al empleado cuyo nombre y apellido coincidan). La función deberá devolver un
--1 si se ha podido realizar la inserción, y un cero si ha ocurrido algún error. Pon el bloque anónimo
--donde pruebes la ejecución de la función para las distintas casuísticas y muestra por consola los
--valores.

--el empleado no tiene nombre en la tabla, pongo el numero
CREATE OR REPLACE
FUNCTION INSERTAR_BORRAR_EMP(V_NUM EMPLEADO.EMP_NO%TYPE, V_APELLIDO EMPLEADO.APELLIDO%TYPE, instruccion NUMBER) 
RETURN NUMBER IS
	RESULTADO NUMBER:=1;
BEGIN
	IF INSTRUCCION = 1 THEN
		INSERT INTO EMPLEADO(EMP_NO, APELLIDO) VALUES(V_NUM, V_APELLIDO);
	ELSIF INSTRUCCION = 2 THEN
		DELETE FROM EMPLEADO WHERE EMP_NO = V_NUM AND APELLIDO = V_APELLIDO;
	ELSE
		RESULTADO := 0;
	END IF;
	RETURN RESULTADO;
END INSERTAR_BORRAR_EMP;

--COMPROBAR
--(cannot perform a DML operation inside a query )
--SELECT INSERTAR_BORRAR_EMP(4,'VICENTE',1) FROM DUAL;
DECLARE
 RESULTADO NUMBER;
BEGIN 
	RESULTADO := INSERTAR_BORRAR_EMP(5,'VICENTE',1);
	DBMS_OUTPUT.PUT_LINE(RESULTADO);
	RESULTADO := INSERTAR_BORRAR_EMP(5,'VICENTE',2);
	DBMS_OUTPUT.PUT_LINE(RESULTADO);
	RESULTADO := INSERTAR_BORRAR_EMP(5,'VICENTE',0);
	DBMS_OUTPUT.PUT_LINE(RESULTADO);
END;


--10. Añade una columna a la tabla Departamentos llamada totalempleados. Rellénala a partir de
--los datos de la tabla empleados y haz el trigger que creas conveniente para mantener
--actualizada posteriormente la nueva columna.

ALTER TABLE DEPARTAMENTO ADD TOTAL_EMPLEADOS NUMBER(5);

--RELLENAR (TAMBIEN FUNCIONA PARA ACTUALIZAR)
DECLARE
	CURSOR C_DEPT IS
		SELECT NUM_DEP FROM DEPARTAMENTO;
	numEMPLEADOS NUMBER:=0;
BEGIN
	FOR registro IN C_DEPT LOOP
		SELECT COUNT(EMP_NO) INTO NUMEMPLEADOS FROM EMPLEADO WHERE NUM_DEP = REGISTRO.NUM_DEP;
		UPDATE DEPARTAMENTO SET TOTAL_EMPLEADOS = NUMEMPLEADOS WHERE NUM_DEP = REGISTRO.NUM_DEP;
	END LOOP;
END;

CREATE OR REPLACE
TRIGGER DEPT_TOTAL_EMPLEADOS
BEFORE INSERT OR DELETE OR UPDATE ON EMPLEADO
FOR EACH ROW
BEGIN
	IF DELETING OR UPDATING THEN
		UPDATE DEPARTAMENTO SET TOTAL_EMPLEADOS = TOTAL_EMPLEADOS - 1 WHERE NUM_DEP = :OLD.NUM_DEP;
	END IF;
	UPDATE DEPARTAMENTO SET TOTAL_EMPLEADOS = TOTAL_EMPLEADOS + 1 WHERE NUM_DEP = :NEW.NUM_DEP;
END DEPT_TOTAL_EMPLEADOS;

--COMPROBAR
INSERT INTO EMPLEADO VALUES(6,'MARQUEZ',400,'MECANICO','10-oct-2007',1,3);
DELETE FROM EMPLEADO WHERE EMP_NO = 6;


--11. Realizar un procedimiento que reciba un número entero y positivo (si no es así mostrar un
--mensaje de error y salir), y dos letras distintas (si no son distintas mostrar mensaje de error y
--salir) y muestre por consola n veces la primera letra, luego otra fila con n veces la segunda letra,
--otra fila con n veces la primera fila, y así hasta completar n filas.
	--Por ejemplo, si llamo a la función con el número 6 y la letra A y B deberá aparecer algo
	--como esto:
		--AAAAAA
		--BBBBBB
		--AAAAAA
		--BBBBBB
		--AAAAAA
		--BBBBBB
	--Si la llamo con el número 5 y la letra A y B deberá aparecer algo como esto:
		--AAAAA
		--BBBBB
		--AAAAA
		--BBBBB
		--AAAAA

CREATE OR REPLACE
PROCEDURE MOSTRAR_LETRAS(V_NUM NUMBER, V_LETRA VARCHAR2, V_LETRA2 VARCHAR2) IS
	FILA VARCHAR2(100);
BEGIN
	IF V_NUM<=0 THEN
		RAISE_APPLICATION_ERROR(-20500, 'El numero introducido tiene que ser mayor que 0');
	ELSIF upper(v_letra)= upper(v_letra2) THEN
		RAISE_APPLICATION_ERROR(-20501, 'Las letras tienen que ser diferentes');
	ELSE 
		FOR i IN 1..V_NUM LOOP
			IF MOD(i,2) != 0 THEN
				FILA := V_LETRA;
				FOR j IN 1..V_NUM LOOP
					FILA := FILA||V_LETRA;
				END LOOP;
				DBMS_OUTPUT.PUT_LINE(FILA);
			ELSE 
				FILA := V_LETRA2;
				FOR k IN 1..V_NUM LOOP
					FILA := FILA||V_LETRA2;
				END LOOP;
				DBMS_OUTPUT.PUT_LINE(FILA);
			END IF;
		END LOOP;
	END IF;
END MOSTRAR_LETRAS;

BEGIN
	MOSTRAR_LETRAS(6,'A','B');
END;

