--1. Realizar un paquete que contenga todos los procedimientos y funciones que se piden en este ejercicio (0,5
--puntos)

CREATE OR REPLACE 
PACKAGE PKG_PELICULAS IS 
	PROCEDURE listarPeliculas;
	FUNCTION numPeliculas(personaje TRABAJO.NOMBRE_PERSONA%TYPE) RETURN NUMBER;
END PKG_PELICULAS;

CREATE OR REPLACE 
PACKAGE BODY PKG_PELICULAS IS 

	--2. Crear un procedimiento para que aparezca un listado de las películas y los personajes que aparecen en
	--cada película. El procedimiento deberá mostrar la información en el siguiente formato (3 puntos)
	
	--Película: título Nacionalidad: nacionalidad
	--** Nombre personaje Tarea: tarea
	--** Nombre personaje Tarea: tarea
	--** Nombre personaje Tarea: tarea
	--Total de personajes: 3
	--…………………………………………

	PROCEDURE listarPeliculas IS 
		CURSOR c_peliculas IS 
			SELECT CIP, TITULO_P, NACIONALIDAD FROM PELICULA;
		CURSOR c_personajes(v_CIP PELICULA.CIP%TYPE) IS 
			SELECT NOMBRE_PERSONA, TAREA FROM TRABAJO
			--IMPORTANTE V_CIP, si le pones el mismo nombre lo interpretara como true y mostrara todo
			WHERE CIP = v_CIP;
		--se puede hacer asi o con cursor, si el enunciado no dice nada es como yo quiera
		numPersonajes NUMBER := 0;
			
	BEGIN 
		FOR registro IN c_peliculas LOOP
			DBMS_OUTPUT.PUT_LINE('Pelicula: '||registro.TITULO_P||' Nacionalidad: '||registro.NACIONALIDAD);
			FOR filaPersonaje IN c_personajes(registro.CIP) LOOP
				DBMS_OUTPUT.PUT_LINE('	Nombre personaje: '||filaPersonaje.NOMBRE_PERSONA||' Tarea: '||filaPersonaje.TAREA);
				numPersonajes := numPersonajes + 1;
			END LOOP;
			DBMS_OUTPUT.PUT_LINE('Total de personajes: '||numPersonajes);
			DBMS_OUTPUT.PUT_LINE('……………………………………………………………………………………');
			numPersonajes := 0;
		end LOOP;
	END listarPeliculas;
	
	--3. Crear una función que devuelva el número de películas en las que ha participado un personaje cuyo
	--nombre recibirá por parámetro. Si no existe el personaje o no ha participado en ninguna película deberá
	--generar una excepción (Cada una con un código y un mensaje diferente). (1,5 punto)

	FUNCTION numPeliculas(personaje TRABAJO.NOMBRE_PERSONA%TYPE) RETURN NUMBER IS
		comprobarPersonaje NUMBER :=0;
		resultado NUMBER := 0;
		personaje_no_existe EXCEPTION;
		no_participa EXCEPTION;
	BEGIN
		SELECT count(NOMBRE_PERSONA) INTO comprobarPersonaje FROM TRABAJO WHERE NOMBRE_PERSONA = personaje;
			IF comprobarPersonaje = 0 THEN
				RAISE personaje_no_existe;
			END IF;
		SELECT count(DISTINCT CIP) INTO resultado FROM TRABAJO WHERE NOMBRE_PERSONA = personaje;
			IF resultado = 0 THEN
				RAISE no_participa;
			ELSE
				RETURN resultado;
			END IF;
	
		EXCEPTION
		WHEN no_participa THEN 
			DBMS_OUTPUT.PUT_LINE ('Error -20000: El personaje no ha participado en ninguna pelicula.');
	
		WHEN personaje_no_existe THEN
			DBMS_OUTPUT.PUT_LINE ('Error -20001: El personaje no existe.');
		
	END numPeliculas;
	
	
END PKG_PELICULAS;

--comprobar
BEGIN
	PKG_PELICULAS.listarPeliculas;
END;
SELECT PKG_PELICULAS.numPeliculas('Daniel Myrick') FROM DUAL;

--4. Realiza un trigger o trigger que creas necesario para impedir que un personaje trabaje más de una vez en
--la misma película. Si ya ha trabajado deberá lanzar una exception (2 puntos)
--?
CREATE OR REPLACE 
TRIGGER comprobarTrabajos IS 
	CURSOR c_personajes IS 
		SELECT NOMBRE_PERSONA FROM TRABAJO;
	ha_trabajado EXCEPTION;
	comprobar NUMBER := 0;
BEGIN 
	--COMPROBAR SI YA HA TRABAJADO
	FOR registro IN c_personajes LOOP
		SELECT COUNT(NOMBRE_PERSONA) INTO comprobar FROM TRABAJO WHERE NOMBRE_PERSONA = registro.NOMBRE_PERSONA;
			IF comprobar >= 2 THEN
				RAISE ha_trabajado;
			END IF;
	end loop
	
	
END


--5. Crear un trigger para que cuando se inserte un personaje el nombre siempre se inserte en mayúsculas. (1
--punto)

CREATE OR REPLACE 
TRIGGER personajeMayus 
AFTER INSERT ON PERSONAJE 
BEGIN 
	UPDATE PERSONAJE SET NOMBRE_PERSONA = UPPER(NOMBRE_PERSONA); 
END personajeMayus;
--NO FUNCIONA
INSERT INTO PERSONAJE(NOMBRE_PERSONA) VALUES('prueba');

--6. Crea una tabla llamada log con un único campo de tipo varchar llamado descripcion y realizar un trigger
--o los trigger que creas necesario para las modificaciones que sufre la tabla personaje. Debe registrarse “El
--usuario nombreUsuario en la fecha fecha modificó el personaje nombre_personaje” pudiendo ser
--modificó, inserto o eliminó. (2 puntos)

 CREATE TABLE PERSONAJE_LOG (descripcion VARCHAR2(200);


