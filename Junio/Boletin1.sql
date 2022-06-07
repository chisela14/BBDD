--1. Realiza los siguientes cursores (implícitos o explícitos)
	--a) Realiza un bloque de programa en PL-SQL que visualice el apellido y el oficio del
	--empleado de código 127.

	CREATE OR REPLACE 
	PROCEDURE verEmpleadoCod (cod EMPLEADO.EMP_NO%TYPE) IS 
		apellido EMPLEADO.APELLIDO%TYPE;  
		oficio EMPLEADO.OFICIO%TYPE;
	--solo se va a generar un registro, (de dos campos) asi que nos vale con un cursor implicito
	BEGIN
		SELECT APELLIDO, OFICIO INTO apellido, oficio
		FROM EMPLEADO
		WHERE EMP_NO = cod;
		DBMS_OUTPUT.PUT_LINE ('Apellido del empleado: '|| apellido);
		DBMS_OUTPUT.PUT_LINE ('Oficio del empleado: '|| oficio);
	END verEmpleadoCod;


	BEGIN 
		--verEmpleadoCod(127);--NO DATA FOUND 
		verEmpleadoCod(1);--funciona
	END;
	
	--b) Crea un bloque de programa que visualice los apellidos de los empleados
	--pertenecientes al departamento 20.

	CREATE OR REPLACE 
	PROCEDURE verApellidosDept (cod DEPARTAMENTO.NUM_DEP%TYPE) IS 
		CURSOR apellidos IS 
			SELECT E.APELLIDO FROM EMPLEADO E, DEPARTAMENTO D
			WHERE D.NUM_DEP = E.NUM_DEP
			AND D.NUM_DEP = cod; 
	BEGIN 
		FOR registro IN apellidos LOOP
			DBMS_OUTPUT.PUT_LINE(registro.APELLIDO ||' pertenece al departamento '||cod);
		end LOOP;
	END verApellidosDept;
	
	INSERT INTO EMPLEADO VALUES(4,'GUTIERREZ',700,'CONTABLE','18-aug-2004',2,2);
	BEGIN
		--verApellidosDept(20);--no hay ninguno
		verApellidosDept(2);
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

--me da un fallo que no entiendo
CREATE OR REPLACE 
TRIGGER valores_sueldo
BEFORE INSERT OR UPDATE ON EMPLEADO 
FOR EACH ROW 
DECLARE
	v_sueldoMIN EMPLEADO.SALARIO%TYPE; 
	v_sueldoMAX EMPLEADO.SALARIO%TYPE;
BEGIN 
	SELECT MAX(SALARIO) INTO v_sueldoMAX FROM EMPLEADO WHERE OFICIO = :NEW.OFICIO;
	SELECT MIN(SALARIO) INTO v_sueldoMIN FROM EMPLEADO WHERE OFICIO = :NEW.OFICIO;

	IF (:NEW.OFICIO != 'PRESIDENTE') == true THEN
		IF :NEW.SALARIO IS NOT BETWEEN(v_sueldoMIN,v_sueldoMAX) THEN
			RAISE_APPLICATION_ERROR(-20020,'No se puede annadir un sueldo que no es encuentre entre el sueldo minimo y el sueldo maximo.');
		END IF;
	END IF;
END valores_sueldo;


--4. Crea triggers que permitan actualizar en cascada el campo tipo de la tabla tipos_pieza en
--caso de que sea modificado con una instrucción UPDATE.
	--Propaga esa actualización por las tablas piezas, existencias y suministros (harán falta
	--varios triggers).

--5. Crea una tabla llamada suministros_audit con los campos tipo de pieza, modelo de pieza, cif,
--precio viejo, precio nuevo y fecha (todos con los mismos tipos de datos que los equivalentes en
--la tabla suministros).
	--Consigue que cada vez que se modifica un precio en la tabla suministros se almacene un
	--registros en la tabla suministros_audit con el precio viejo, el nuevo y la fecha del cambio.

--6. Crear un trigger para la tabla de piezas que prohíba modificar el precio de venta de una pieza
--a un precio más pequeño que el del menor precio de compra para esa pieza (debe provocar un
--error si se produce esa situación, la modificación del precio no se realizará).

--7. Visualiza mediante un procedimiento los apellidos de los empleados de un departamento
--cualquiera. Usa un cursor con variables de acoplamiento.

--8. Visualiza utilizando un WHILE un bloque PL/SQL que visualice el apellido y la fecha de alta de
--todos los empleados ordenados por fecha de alta.
	--Crea posteriormente un bloque PL/SQL que realice lo mismo, pero usando un cursor
	--“FOR..LOOP”. Usa la tabla EMPLEADOS (emp_no, apellido, salario, num_dep, fecha_alta).

--9. Realizar una función que reciba como parámetro el nombre y el apellido de un empleado,
--también debe recibir un parámetro que podrá ser un uno (debe insertarlo un empleado) o un
--dos (debe borrar al empleado cuyo nombre y apellido coincidan). La función deberá devolver un
--1 si se ha podido realizar la inserción, y un cero si ha ocurrido algún error. Pon el bloque anónimo
--donde pruebes la ejecución de la función para las distintas casuísticas y muestra por consola los
--valores.

--10. Añade una columna a la tabla Departamentos llamada totalempleados. Rellénala a partir de
--los datos de la tabla empleados y haz el trigger que creas conveniente para mantener
--actualizada posteriormente la nueva columna.

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

