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
		
		--JEFE = MGR
		CREATE OR REPLACE
		TRIGGER COMPROBAR_JEFE
		BEFORE INSERT ON EMP
		FOR EACH ROW
		DECLARE
			v_jefe EMP.DEPTNO%TYPE;
		BEGIN
			SELECT DEPTNO INTO v_jefe FROM EMP WHERE EMPNO = :NEW.MGR;
			IF v_jefe != :NEW.DEPTNO THEN
				RAISE_APPLICATION_ERROR(-20002,'El departamento del empleado no es el mismo que el del jefe');
			END IF;
		
			--PONGO ESTA EXCEPTION PARA PROBAR EL SIGUIENTE TRIGGER SIN AÑADIR UN JEFE
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					DBMS_OUTPUT.PUT_LINE('No se han introducido suficientes datos para comprobar si el jefe pertenece al mismo departamento');
				
		END COMPROBAR_JEFE;
		
		--comprobar
		INSERT INTO emp(empno,mgr,deptno) values(8001,7900,30);--mismo dep
		INSERT INTO emp(empno,mgr,deptno) values(8002,7900,20);--distinto dep
		
	
--    5. Haz un trigger que sólo permita tener comisiones a los vendedores.

		CREATE OR REPLACE
		TRIGGER COMISIONES_VENDEDORES
		BEFORE INSERT OR UPDATE ON EMP
		FOR EACH ROW
		BEGIN
			IF :NEW.JOB != 'SALESMAN' AND :NEW.COMM IS NOT NULL THEN
				RAISE_APPLICATION_ERROR(-20003,'Un empleado que no sea vendedor no puede tener comisión');
			END IF;
		END COMISIONES_VENDEDORES;
	
		--COMPROBAR
		INSERT INTO EMP(EMPNO, JOB, COMM) VALUES(8005,'SALESMAN',40);
		INSERT INTO EMP(EMPNO, JOB, COMM) VALUES(8006,'CLERK',40);
		UPDATE EMP SET COMM = 20 WHERE EMPNO = 7844;--EMP SALESMAN
		UPDATE EMP SET COMM = 20 WHERE EMPNO = 7902;--EMP NO SALESMAN
		
		
--    6. Registrar todas las operaciones sobre la tabla EMP de SCOOT en una tabla llamada AUDIT_EMP 
--    donde se guarde usuario, fecha y tipo de operación.
		
		CREATE TABLE AUDIT_EMP(
			USUARIO VARCHAR2(30),
			FECHA DATE,
			TIPO_OPERACION VARCHAR2(10)
		);
	
		CREATE OR REPLACE
		TRIGGER EMP_AUD
		BEFORE INSERT OR DELETE OR UPDATE ON EMP
		BEGIN
			IF INSERTING THEN
				INSERT INTO AUDIT_EMP VALUES(USER,SYSDATE,'INSERT');
			END IF;
			IF DELETING THEN
				INSERT INTO AUDIT_EMP VALUES(USER,SYSDATE,'DELETE');
			END IF;
			IF UPDATING THEN
				INSERT INTO AUDIT_EMP VALUES(USER,SYSDATE,'UPDATE');
			END IF;
		END EMP_AUD;
	
		--COMPROBAR
		INSERT INTO EMP(EMPNO) VALUES(8010);
		UPDATE EMP SET ENAME = 'PEPE' WHERE EMPNO = 8010;
		DELETE FROM EMP WHERE EMPNO = 8010;
		

--    7. Haz un trigger que controle los sueldos de las siguientes categorías. Si se pasa de este rango poner 
--    el valor mínimo o el máximo según corresponda.
--		CLERK: 800 - 1100
--		ANALYST: 1200 -1600
--		MANAGER: 1800 - 2000
	
		CREATE OR REPLACE
		TRIGGER CONTROLAR_SUELDOS
		BEFORE INSERT OR UPDATE ON EMP
		FOR EACH ROW
		BEGIN
			IF :NEW.JOB = 'CLERK' AND (:NEW.SAL<800 OR :NEW.SAL>1100) THEN
				RAISE_APPLICATION_ERROR(-20004,'El salario de un clerk no puede ser menor a 800 ni mayor a 1100');
			END IF;
			IF :NEW.JOB = 'ANALYST' AND (:NEW.SAL<1200 OR :NEW.SAL>1600) THEN
					RAISE_APPLICATION_ERROR(-20005,'El salario de un analyst no puede ser menor a 1200 ni mayor a 1600');
				END IF;
			IF :NEW.JOB = 'MANAGER' AND (:NEW.SAL<1800 OR :NEW.SAL>2600) THEN
					RAISE_APPLICATION_ERROR(-20006,'El salario de un manager no puede ser menor a 1800 ni mayor a 2600');
				END IF;
		END CONTROLAR_SUELDOS;
		
		--COMPROBAR
		--INSERT
		INSERT INTO EMP(EMPNO, JOB, SAL) VALUES(8010, 'CLERK',700);
		INSERT INTO EMP(EMPNO, JOB, SAL) VALUES(8010, 'CLERK',1200);
		INSERT INTO EMP(EMPNO, JOB, SAL) VALUES(8011, 'ANALYST',700);
		INSERT INTO EMP(EMPNO, JOB, SAL) VALUES(8011, 'ANALYST',1700);
		INSERT INTO EMP(EMPNO, JOB, SAL) VALUES(8012, 'MANAGER',700);
		INSERT INTO EMP(EMPNO, JOB, SAL) VALUES(8012, 'MANAGER',2700);
		--VALIDOS
		INSERT INTO EMP(EMPNO, JOB, SAL) VALUES(8010, 'CLERK',900);
		INSERT INTO EMP(EMPNO, JOB, SAL) VALUES(8011, 'ANALYST',1300);
		INSERT INTO EMP(EMPNO, JOB, SAL) VALUES(8012, 'MANAGER',2000);
		--UPDATE 
		UPDATE EMP SET SAL = 700 WHERE EMPNO = 8010;
		UPDATE EMP SET SAL = 1200 WHERE EMPNO = 8010;
		UPDATE EMP SET SAL = 700 WHERE EMPNO = 8011;
		UPDATE EMP SET SAL = 1700 WHERE EMPNO = 8011;
		UPDATE EMP SET SAL = 700 WHERE EMPNO = 8012;
		UPDATE EMP SET SAL = 2700 WHERE EMPNO = 8012;
	

--    8. Haz un trigger que le suba un 10% el sueldo a los empleados cuando cambia la localidad donde trabajan.
		
		--guardar datos que se referencian que pueden causar problemas
		CREATE OR REPLACE PACKAGE PCK_LOC AS
			nueva_loc DEPT.LOC%TYPE;
			vieja_loc DEPT.LOC%TYPE;
			v_emp EMP.EMPNO%TYPE;
		END;
		
		--crear trigger BEFORE a nivel de fila, guardando los valores de las variables
		CREATE OR REPLACE
		TRIGGER DESPLAZAMIENTO_VALORES
		--LA LOCALIDAD CAMBIARÁ CUANDO CAMBIEN DE DEPARTAMENTO
		BEFORE UPDATE OF DEPTNO ON EMP
		FOR EACH ROW
		BEGIN
			SELECT LOC INTO PCK_LOC.nueva_loc FROM DEPT WHERE DEPTNO = :NEW.DEPTNO;
			SELECT LOC INTO PCK_LOC.vieja_loc FROM DEPT WHERE DEPTNO = :OLD.DEPTNO;
			SELECT :NEW.EMPNO INTO PCK_LOC.v_emp FROM DUAL;
		END DESPLAZAMIENTO_VALORES;	
		
		--crear trigger AFTER donde se referencia a las variables
		CREATE OR REPLACE
		TRIGGER DESPLAZAMIENTO
		AFTER UPDATE OF DEPTNO ON EMP
		BEGIN
			IF PCK_LOC.nueva_loc != PCK_LOC.vieja_loc THEN
				UPDATE EMP SET SAL = SAL*1.10 WHERE EMPNO = PCK_LOC.v_emp;
			END IF;
		END DESPLAZAMIENTO;
	
		--COMPROBAR
		INSERT INTO EMP(EMPNO, JOB, SAL, DEPTNO) VALUES (8013, 'CLERK', 900, 10);
		--DELETE FROM emp WHERE empno = 8013;
		UPDATE EMP SET DEPTNO = 20 WHERE EMPNO = 8013;
		--hay alguna manera de hacerlo sin manejar tablas mutantes?
	
--    9. Haz un trigger que impidan que un departamento se quede sin empleados.
		
		CREATE OR REPLACE
		TRIGGER DEPARTAMENTO_VACIO
		BEFORE DELETE OR UPDATE OF DEPTNO ON EMP
		FOR EACH ROW
		DECLARE
			v_numEmp DEPT.NUM_EMPLEADOS%TYPE;
		BEGIN
			SELECT NUM_EMPLEADOS INTO v_numEmp FROM DEPT WHERE DEPTNO = :OLD.DEPTNO;
			IF v_numEmp = 1 THEN
				RAISE_APPLICATION_ERROR(-20007, 'El empleado es el último del departamento. Un departamento no puede qudarse vacío.');
			END IF;	
		END DEPARTAMENTO_VACIO;
		
	--COMPROBAR
	--EL DEPT 40 AHORA MISMO NO TIENE A NADIE, PONGO A ALGUIEN Y LO INTENTO QUITAR
	UPDATE EMP SET DEPTNO = 40 WHERE EMPNO = 8013;
	UPDATE EMP SET DEPTNO = 20 WHERE EMPNO = 8013;
	DELETE EMP WHERE EMPNO = 8013;



	
	
	
	
	
	
	
	