--    1. Nuestra empresa ha cambiado la política de sueldos y ha decidido que los suelos no llevarán céntimos, 
--    para lo cual se debe crear uno o varios triggers que garanticen que el sueldo sólo tiene un decimal, 
--    si tiene dos se redondeará el valor. (mira la función round).
		
		CREATE OR REPLACE
		TRIGGER REDONDEAR_SUELDO
		BEFORE INSERT OR UPDATE OF SAL ON EMP
		FOR EACH ROW
		BEGIN
			:NEW.SAL := ROUND(:NEW.SAL,1);
		END REDONDEAR_SUELDO;
	
		--COMPROBAR
		INSERT INTO EMP(EMPNO,SAL) VALUES(7950,800.52);--800.5
		UPDATE EMP SET SAL = 950.77 WHERE EMPNO = 7900;--950->950.8

--    2. Crea los trigger que creas necesario para que el campo deptno se asigne de forma automática, 
--    sea dado algún valor por el usuario o no. Además hay que impedir que el usuario modifique esté valor.

		CREATE OR REPLACE
		TRIGGER CAMBIAR_DEPARTAMENTO
		BEFORE INSERT OR UPDATE OF DEPTNO ON DEPT
		FOR EACH ROW	
		BEGIN
			IF INSERTING THEN
				SELECT MAX(DEPTNO)+10 INTO :NEW.deptno FROM DEPT;
			END IF;
			IF UPDATING THEN
				RAISE_APPLICATION_ERROR(-20001, 'El campo DEPTNO no se puede modificar');
			END IF;
		END CAMBIAR_DEPARTAMENTO;
	
		--COMPROBAR
		INSERT INTO dept(dname,loc) values('pruebas','sevilla');
		INSERT INTO dept values(01,'pruebas2','sevilla');
		UPDATE dept SET deptno = 01 WHERE deptno = 10;
		
--    3. Crear un nuevo campo en la tabla deptno que se llame num_empleados y crear los trigger que sean 
--    necesarioS para mantener actualizado esos campos. Antes que nada rellenar el campo num_empleado 
--    con los valores adecuados, si es necesario crea un procedure para ello.

		ALTER TABLE DEPT ADD NUM_EMPLEADOS NUMBER(3);
	
		--RELLENAR TABLA 
		CREATE OR REPLACE
		PROCEDURE rellenar_tabla IS 
			CURSOR c_dept IS SELECT deptno FROM dept;
			numEmpleados NUMBER := 0;
		BEGIN
			FOR registro IN c_dept LOOP
				SELECT count(EMPNO) INTO numEmpleados FROM EMP WHERE DEPTNO = registro.deptno;
				UPDATE dept SET num_empleados = numEmpleados WHERE DEPTNO = registro.deptno;
			end LOOP;
		END rellenar_tabla;
		
		BEGIN
		rellenar_tabla;
		END;

		--TRIGGER
		CREATE OR REPLACE
		TRIGGER ACTUALIZAR_NUM_EMP
		BEFORE INSERT OR DELETE OR UPDATE OF DEPTNO ON EMP
		FOR EACH ROW
		BEGIN
			IF UPDATING OR DELETING THEN
				UPDATE DEPT SET NUM_EMPLEADOS = NUM_EMPLEADOS - 1 WHERE DEPTNO = :OLD.DEPTNO;
			END IF;
			UPDATE DEPT SET NUM_EMPLEADOS = NUM_EMPLEADOS + 1 WHERE DEPTNO = :NEW.DEPTNO;
		END ACTUALIZAR_NUM_EMP;
	
		--COMPROBAR
		INSERT INTO EMP(EMPNO, DEPTNO) VALUES(8000,40);
		UPDATE EMP SET DEPTNO = 20 WHERE EMPNO = 7950;
		DELETE FROM EMP WHERE EMPNO = 7950;
	
	
--    4. Crea un trigger de forma que si se va a insertar a un empleado compruebe que su jefe está en el mismo departamento. 
--    Si no está lance una exception y no deje que se inserte.
		--REVISAR TRIGGER EJECUTAR
		--JEFE = MGR
		CREATE OR REPLACE
		TRIGGER COMPROBAR_JEFE
		BEFORE INSERT ON EMP
		FOR EACH ROW
		DECLARE
			JEFE EMP.MGR%TYPE;
		BEGIN
			SELECT EMPNO, DEPTNO INTO JEFE FROM EMP WHERE EMPNO = :NEW.MGR;
			IF JEFE.DEPTNO != :NEW.DEPTNO THEN
				RAISE_APPLICATION_ERROR(-20002,'El departamento del empleado no es el mismo que el del jefe');
			END IF;
		END COMPROBAR_JEFE;
		
		--comprobar
		INSERT INTO emp(empno,mgr,deptno) values(8001,7900,30);--mismo dep
		INSERT INTO emp(empno,mgr,deptno) values(8002,7900,20);--distinto dep
		
	
--    5. Haz un trigger que sólo permita tener comisiones a los vendedores.

--    6. Registrar todas las operaciones sobre la tabla EMP de SCOOT en una tabla llamada AUDIT_EMP 
--    donde se guarde usuario, fecha y tipo de operación.

--    7. Haz un trigger que controle los sueldos de las siguientes categorías. Si se pasa de este rango poner 
--    el valor mínimo o el máximo según corresponda.
--		CLERK: 800 - 1100
--		ANALYST: 1200 -1600
--		MANAGER: 1800 - 2000

--    8. Haz un trigger que le suba un 10% el sueldo a los empleados cuando cambia la localidad donde trabajan.

--    9. Haz un trigger que impidan que un departamento se quede sin empleados.