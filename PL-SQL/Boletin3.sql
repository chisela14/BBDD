--1. Realiza un procedimiento que reciba un número de departamento y muestre por pantalla su
--nombre y localidad.
CREATE OR REPLACE
PROCEDURE MOSTRARDEPT (num DEPT.DEPTNO%TYPE) IS 
	nombre DEPT.DNAME%TYPE;
	loc DEPT.LOC%TYPE;
BEGIN 
	SELECT DNAME, LOC INTO nombre, loc FROM DEPT
	WHERE DEPTNO = num;
	DBMS_OUTPUT.PUT_LINE ('Nombre del departamento: '|| nombre);
	DBMS_OUTPUT.PUT_LINE ('Localidad del departamento: '|| loc);
END MOSTRARDEPT;

BEGIN
	MOSTRARDEPT(10);
END;

--2. Realiza una función devolver_sal que reciba un nombre de departamento y devuelva la suma
--de sus salarios.
CREATE OR REPLACE
FUNCTION devolver_sal (nombre DEPT.DNAME%TYPE) 
RETURN NUMBER IS 
BEGIN 
	SELECT SUM(E.SAL) INTO suma
	FROM EMP E, DEPT D
	WHERE E.DEPTNO = D.DEPTNO 
	DBMS_OUTPUT.PUT_LINE ('La suma de todos los salarios es: '|| suma);
END devolver_sal;

BEGIN
	devolver_sal ('SALES');
END;
--sin acabar


--3. Realiza un procedimiento MostrarAbreviaturas que muestre las tres primeras letras del
--nombre de cada empleado.

--4. Realiza un procedimiento que reciba un número de departamento y muestre una lista de sus
--empleados.

--5. Realiza un procedimiento MostrarJefes que reciba el nombre de un departamento y muestre
--los nombres de los empleados de ese departamento que son jefes de otros empleados.Trata las
--excepciones que consideres necesarias.

--6. Hacer un procedimiento que muestre el nombre y el salario del empleado cuyo código es
--7082.

--7. Realiza un procedimiento llamado HallarNumEmp que recibiendo un nombre de
--departamento, muestre en pantalla el número de empleados de dicho departamento
--Si el departamento no tiene empleados deberá mostrar un mensaje informando de ello. Si el
--departamento no existe se tratará la excepción correspondiente.

--8. Hacer un procedimiento que reciba como parámetro un código de empleado y devuelva su
--nombre.
CREATE OR REPLACE
PROCEDURE MOSTRARNOMBREEMP (cod EMP.EMPNO%TYPE) IS 
	nombre EMP.ENAME%TYPE;
BEGIN 
	SELECT ENAME INTO nombre FROM EMP
	WHERE EMPNO = cod;
	DBMS_OUTPUT.PUT_LINE ('Nombre del empleado: '|| nombre);
END MOSTRARNOMBREEMP;

BEGIN
	MOSTRARNOMBREEMP(7369);
END;

--9. Codificar un procedimiento que reciba una cadena y la visualice al revés.

--10. Escribir un procedimiento que reciba una fecha y escriba el año, en número, correspondiente a
--esa fecha.

--11. Realiza una función llamada CalcularCosteSalarial que reciba un nombre de departamento y
--devuelva la suma de los salarios y comisiones de los empleados de dicho departamento.

--12. Codificar un procedimiento que permita borrar un empleado cuyo número se pasará en la
--llamada. Si no existiera dar el correspondiente mensaje de error.
CREATE OR REPLACE 
PROCEDURE borrarEmp (num EMP.EMPNO%TYPE) IS 
	c EMP.EMPNO%TYPE;
BEGIN 
	SELECT EMPNO INTO c FROM EMP WHERE EMPNO = num;
	
	DELETE FROM EMP
	WHERE EMPNO = num;
	
	EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('El número de empleado no existe');
	
END borrarEmp;

BEGIN
	borrarEmp(2550);
END;

--13. Realiza un procedimiento MostrarCostesSalariales que muestre los nombres de todos los
--departamentos y el coste salarial de cada uno de ellos.

--14. Escribir un procedimiento que modifique la localidad de un departamento. El procedimiento
--recibirá como parámetros el número del departamento y la localidad nueva.

--15. Realiza un procedimiento MostrarMasAntiguos que muestre el nombre del empleado más
--antiguo de cada departamento junto con el nombre del departamento. Trata las excepciones
--que consideres necesarias.

