--1. Realizar un paquete que contenga todos los procedimientos y funciones que se piden en este
--ejercicio. A continuación deberás incluir las sentencias necesarias para probar todas las funcionalidades del paquete (0,5 puntos).

CREATE OR REPLACE 
PACKAGE PKG_CICLISTAS IS
	PROCEDURE LISTADO;
	FUNCTION VICTORIAS(V_EQUIPO VARCHAR2) RETURN NUMBER;
	FUNCTION agregarCiclista(v_nombre CICLISTAS.NOMBRE%TYPE, v_nacionalidad CICLISTAS.NACIONALIDAD%TYPE, v_fecha CICLISTAS.FECHANACIMIENTO%TYPE, v_codEquipo CICLISTAS.CODEQUIPO%TYPE, v_nombreEq EQUIPOS.NOMBRE%TYPE) RETURN NUMBER;
	FUNCTION ordenarCiclistas(v_equipo CICLISTAS.CODEQUIPO%TYPE) RETURN NUMBER;
END PKG_CICLISTAS;

CREATE OR REPLACE
PACKAGE BODY PKG_CICLISTAS IS

	--2. Realiza un procedimiento llamado listado que muestre todos los equipos y los jugadores que
	--pertenecen a cada equipo con el siguiente formato (3 puntos)
	
		--Nombre: nombreEquipo Nacionalidad: nacionalidad Nombre del director: nombre
		--NombreCiclista1º Fecha nacimiento
		--NombreCiclista2º Fecha nacimiento
		------------------------------------------------------
		--NombreCiclistaN Fecha nacimiento
		--Nº Total de ciclistas en el equipos: X
		--Nombre: nombreEquipo Nacionalidad: nacionalidad Nombre del director: nombre
		--NombreCiclista1º Fecha nacimiento
		--NombreCiclista2º Fecha nacimiento
		------------------------------------------------------

	PROCEDURE LISTADO IS
		CURSOR C_EQUIPOS IS
			SELECT CODEQUIPO, NOMBRE, NACIONALIDAD, NOMBREDIRECTOR FROM EQUIPOS;
		CURSOR C_CICLISTAS(V_EQUIPO EQUIPOS.CODEQUIPO%TYPE) IS
			SELECT NOMBRE, FECHANACIMIENTO FROM CICLISTAS WHERE CODEQUIPO = V_EQUIPO;
		v_num_ciclistas NUMBER;
	BEGIN
		FOR registro IN C_EQUIPOS LOOP
			DBMS_OUTPUT.PUT_LINE('Nombre: '||registro.NOMBRE||' Nacionalidad: '||registro.NACIONALIDAD||' Nombre del director: '||registro.NOMBREDIRECTOR);
			FOR registroCic IN C_CICLISTAS(registro.CODEQUIPO) LOOP
				DBMS_OUTPUT.PUT_LINE('NombreCiclista: '||registroCic.NOMBRE||' Fecha nacimiento: '||registroCic.FECHANACIMIENTO);
			END LOOP;
			SELECT count(dorsal) INTO v_num_ciclistas FROM ciclistas WHERE CODEQUIPO = registro.CODEQUIPO;
			DBMS_OUTPUT.PUT_LINE('Total de ciclistas en el equipo: '||v_num_ciclistas);
			DBMS_OUTPUT.PUT_LINE('----------------------------------');
		END LOOP;
	END LISTADO;

	
	--3. Crear una función que devuelva el número de carreras que han ganado los corredores de un
	--equipo. El nombre del equipo se le pasará por parámetro. Si no existe el equipo deberá generar
	--una excepción con una única instrucción con el código de error -200004. (1,5 punto)
	
	FUNCTION VICTORIAS(V_EQUIPO VARCHAR2) RETURN NUMBER IS
		CURSOR C_CICLISTAS(VC_EQUIPO VARCHAR2) IS
			SELECT C.DORSAL FROM CICLISTAS C, EQUIPOS E WHERE C.CODEQUIPO = E.CODEQUIPO AND E.NOMBRE = VC_EQUIPO;
		v_vic_ciclista NUMBER := 0;
		total NUMBER := 0;
		comprobarEquipo NUMBER:= 0;
	BEGIN
		SELECT count(NOMBRE) INTO comprobarEquipo FROM EQUIPOS WHERE NOMBRE = V_EQUIPO;
		IF comprobarEquipo = 0 THEN
			RAISE_APPLICATION_ERROR(-20004,'El equipo no existe');
			total:= -1;
		ELSE
			FOR registro IN C_CICLISTAS(V_EQUIPO) LOOP
				SELECT COUNT(NUMETAPA) INTO v_vic_ciclista FROM CLASIFICACIONETAPAS WHERE POSICION = '1' AND DORSAL = registro.DORSAL;
				total := total + v_vic_ciclista;
			END LOOP;
		END IF;
	
		RETURN total;
	END VICTORIAS;

	--4. Realizar una función agregarciclista que reciba como parámetros el nombre, nacionalidad, fecha
	--de nacimiento, codigo_equipo y nombre del equipo al que pertenece. En el caso de no existir
	--el equipo deberá mostrar por consola el mensaje “No existe el equipo. Procedemos a crearlo” y
	--se deberá crear el nuevo equipo. Posteriormente se agregará el nuevo ciclista al equipo que
	--corresponda. La función devolverá el código del nuevo ciclista agregado. Si hay algún fallo debe
	--dejar base de datos como estaba. Si la nacionalidad no tiene ningún valor se le pondrá
	--“ESPAÑOL”. Debes controlar las posibles excepciones, por ejemplo si el ciclista ya existe deberás
	--lanzar una excepción personalizada indicando el mensaje “El caballo que está intentando insertar
	--ya existe ” (2 puntos)
	
	FUNCTION agregarCiclista(v_nombre CICLISTAS.NOMBRE%TYPE, v_nacionalidad CICLISTAS.NACIONALIDAD%TYPE, v_fecha CICLISTAS.FECHANACIMIENTO%TYPE, v_codEquipo CICLISTAS.CODEQUIPO%TYPE, v_nombreEq EQUIPOS.NOMBRE%TYPE) RETURN NUMBER IS
		comprobar NUMBER := 0;
		ultimoCodigo NUMBER := 0;
		nombreEq EQUIPOS.NOMBRE%TYPE;
		nuevaNacionalidad CICLISTAS.NACIONALIDAD%TYPE;
	BEGIN
		--comprobar que existe el equipo
		SELECT count(NOMBRE) INTO comprobar FROM EQUIPOS WHERE CODEQUIPO = v_codEquipo;
		IF comprobar = 0 THEN
			--no se ha introducido bien el equipo
			SELECT nombre INTO nombreEq FROM EQUIPOS WHERE CODEQUIPO = v_codEquipo;
			IF nombreEq != v_nombreEq THEN
				RAISE_APPLICATION_ERROR(-20007,'El nombre del equipo no coincide con su código');
			ELSE
				DBMS_OUTPUT.PUT_LINE('No existe el equipo. Procedemos a crearlo');
				INSERT INTO EQUIPOS(CODEQUIPO, NOMBRE) VALUES(v_codEquipo,v_nombreEq);
			END IF;
		END IF;
		--si la nacionalidad no tiene valor sera “ESPAÑOL”.
		IF v_nacionalidad IS NULL THEN
			nuevaNacionalidad := 'Español';
		ELSE
			nuevaNacionalidad := v_nacionalidad;
		END IF;
		--comprobar que no existe el ciclista
		SELECT count(NOMBRE) INTO comprobar FROM CICLISTAS WHERE NOMBRE = v_nombre AND FECHANACIMIENTO = v_fecha;
		IF comprobar > 0 THEN
			RAISE_APPLICATION_ERROR(-20005, 'El caballo que está intentando insertar ya existe');
		ELSE
			SELECT max(DORSAL)+1 INTO ultimoCodigo FROM CICLISTAS;
			INSERT INTO CICLISTAS VALUES (ultimoCodigo,v_nombre,nuevaNacionalidad,v_codEquipo,v_fecha);
		END IF;
	
		RETURN ultimoCodigo;
	END agregarCiclista;

	--5. Crea una función que para cada equipo ordene alfabéticamente a sus ciclistas y muestre los 2
	--primeros de cada equipo por consola. Para cada uno de los ciclistas mostrados en consola
	--se va a actualizar la nacionalidad al valor ‘Inglesa’. La función devolverá el número de filas
	--actulizadas en total. En el caso de producirse un error devolverá -1 (3 puntos)

	FUNCTION ordenarCiclistas(v_equipo CICLISTAS.CODEQUIPO%TYPE) RETURN NUMBER IS
		CURSOR c_ciclistas(vc_equipo CICLISTAS.CODEQUIPO%TYPE) IS
			SELECT * FROM CICLISTAS WHERE CODEQUIPO = vc_equipo ORDER BY NOMBRE;
		contador NUMBER := 0;
	BEGIN 
		FOR registro IN c_ciclistas(v_equipo) LOOP 
			UPDATE CICLISTAS SET NACIONALIDAD = 'Inglesa' WHERE DORSAL = registro.DORSAL;
			DBMS_OUTPUT.PUT_LINE(contador +1||'.- '||registro.dorsal||' '||registro.nombre||' '||registro.nacionalidad);
			contador:= contador+1;
			EXIT WHEN contador = 2;
		END LOOP;
	
		RETURN contador;
	
		EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			contador := -1;
			RETURN contador;
		
	END ordenarCiclistas;

END PKG_CICLISTAS;

--2
BEGIN
	PKG_CICLISTAS.listado;
END;
--3
SELECT PKG_CICLISTAS.VICTORIAS('kass') FROM DUAL;
SELECT PKG_CICLISTAS.VICTORIAS('Reynolds') FROM DUAL;
--4
--(v_nombre CICLISTAS.NOMBRE%TYPE, v_nacionalidad CICLISTAS.NACIONALIDAD%TYPE, v_fecha
	--CICLISTAS.FECHANACIMIENTO%TYPE, v_codEquipo CICLISTAS.CODEQUIPO%TYPE, v_nombreEq EQUIPOS.NOMBRE%TYPE)
DECLARE
	RESULTADO NUMBER;
BEGIN
	RESULTADO:= PKG_CICLISTAS.agregarCiclista('Angelis','Italiano',to_date('11/02/1990','dd/mm/yyyy'),3,'Faema');
	DBMS_OUTPUT.PUT_LINE('Dorsal del nuevo ciclista: '||resultado);
	--REVISAR
	RESULTADO:= PKG_CICLISTAS.agregarCiclista('Vicente','',to_date('11/02/1995','dd/mm/yyyy'),7,'Jacaranda');
	DBMS_OUTPUT.PUT_LINE('Dorsal del nuevo ciclista: '||resultado);
END;
	--DORSAL = RESULTADO
	SELECT * FROM ciclistas WHERE DORSAL = 17;
--5
DECLARE
	RESULTADO NUMBER;
BEGIN
	RESULTADO:= PKG_CICLISTAS.ordenarCiclistas(1);
	DBMS_OUTPUT.PUT_LINE('Filas actualizadas: '||RESULTADO);
END;






