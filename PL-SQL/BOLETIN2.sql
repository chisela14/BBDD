/*1. Escribe un procedimiento que muestre el número de empleados y el salario
mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
uso de cursores implícitos, es decir utilizar SELECT ... INTO.*/

CREATE OR REPLACE
PROCEDURE Finanzas AS
	numero NUMBER;
	maximo NUMBER;
	minimo NUMBER;
	media NUMBER;
	dpto NUMBER;
BEGIN
SELECT NUMDE INTO dpto FROM DEPARTAMENTOS
WHERE UPPER(NOMDE) = 'FINANZAS';

SELECT COUNT(*), MAX(SALAR), MIN(SALAR), ROUND(AVG(SALAR), 2)
INTO numero, maximo, minimo, media
FROM EMPLEADOS WHERE NUMDE = dpto;

DBMS_OUTPUT.PUT_LINE('Departamento de FINANZAS');
DBMS_OUTPUT.PUT_LINE(numero || ' Empleados');
DBMS_OUTPUT.PUT_LINE(maximo || ' C es el salario máximo');
DBMS_OUTPUT.PUT_LINE(minimo || ' C es el salario mínimo');
DBMS_OUTPUT.PUT_LINE(media || ' C es el salario medio');
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('No se han encontrado datos');
END Finanzas;
/

/*2. Escribe un procedimiento que suba un 10% el salario a los EMPLEADOS
con más de 2 hijos y que ganen menos de 2000 €. Para cada empleado se
mostrar por pantalla el código de empleado, nombre, salario anterior y final.
Utiliza un cursor explícito. La transacción no puede quedarse a medias. Si
por cualquier razón no es posible actualizar todos estos salarios, debe
deshacerse el trabajo a la situación inicial.*/

CREATE OR REPLACE
PROCEDURE SubirSalarios AS
	CURSOR c IS
		SELECT NUMEM, NOMEM, SALAR, ROWID
		FROM EMPLEADOS WHERE NUMHI > 2 AND SALAR < 2000;
	sal_nuevo NUMBER;
BEGIN
	FOR registro IN c LOOP
		sal_nuevo := registro.SALAR*1.10;
	
		UPDATE EMPLEADOS SET SALAR = registro.SALAR*1.10
		WHERE ROWID = registro.ROWID;
	
		--SI NO SE HA VISTO ACTUALIZADA NINGUNA FILA
		--sql en vez de cursor porque quiero preguntar si se han actualizado datos
		IF SQL%NOTFOUND THEN
			DBMS_OUTPUT.PUT_LINE('Actualización no completada');
		END IF;
		DBMS_OUTPUT.PUT_LINE(registro.NUMEM || ' ' || registro.NOMEM
			|| ' : ' || registro.SALAR || ' --> ' || sal_nuevo);
	END LOOP;
	COMMIT;

	EXCEPTION
		WHEN OTHERS THEN
		ROLLBACK;
	--aquí se puede añadir un mensaje
END SubirSalarios;
/

/*3. Escribe un procedimiento que reciba dos parámetros (número de
departamento, hijos). Debera crearse un cursor explícito al que se le pasarán
estos parámetros y que mostrara los datos de los empleados que pertenezcan
al departamento y con el número de hijos indicados. Al final se indicara el
número de empleados obtenidos.*/

CREATE OR REPLACE
PROCEDURE EmpleadosHijos (numero EMPLEADOS.NUMDE%TYPE, hijos EMPLEADOS.NUMHI%TYPE) IS
	CURSOR c(numero EMPLEADOS.NUMDE%TYPE, hijos EMPLEADOS.NUMHI%TYPE) IS 
		SELECT NUMEM, NUMDE, NUMHI FROM EMPLEADOS 
		WHERE NUMDE = numero
		AND NUMHI = hijos;
	numEmp NUMBER;
BEGIN 
	numEmp:= 0;
	FOR registro IN c (numero, hijos)
	LOOP
		DBMS_OUTPUT.PUT_LINE(registro.NUMEM || registro.NUMDE || registro.NUMHI)
		numEmp := numEmp +1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Se han encontrado '||numEmp||' empleados');
	
END EmpleadosHijos;

BEGIN
	EmpleadosHijos(121, 3);
END;


/*4. Escribe un procedimiento con un parámetro para el nombre de empleado,
que nos muestre la edad de dicho empleado en años, meses y días.*/

CREATE OR REPLACE 
PROCEDURE EdadEmpleado (nombre EMPLEADOS.NOMEM%TYPE)IS 
	CURSOR edad (nombre EMPLEADOS.NOMEM%TYPE) IS 
		SELECT FECNA FROM EMPLEADOS 
		WHERE NOMEM = nombre;
BEGIN 
	dias NUMBER;
	meses NUMBER;
	anyos NUMBER;
	FOR registro IN c (nombre)
	LOOP
	anyos := SYSDATE - registro.FECNA;
	meses := months_between(sysdate, registro.FECNA);
	dias := meses*30;
	DBMS_OUTPUT.PUT_LINE(registro.NOMEM || anyos || meses || dias);
	END LOOP;
END EdadEmpleado;

BEGIN 
	EdadEmpleado('AUGUSTO');
END;




