--1. Realizar un paquete que contenga todos los procedimientos y funciones que se piden en este ejercicio (0,5
--puntos)

CREATE OR REPLACE 
PACKAGE PELICULAS IS 
	PROCEDURE 
	FUNCTION 
END PELICULAS;

CREATE OR REPLACE 
PACKAGE BODY PELICULAS IS 

	--2. Crear un procedimiento para que aparezca un listado de las películas y los personajes que aparecen en
	--cada película. El procedimiento deberá mostrar la información en el siguiente formato (3 puntos)
	
	--Película: título Nacionalidad: nacionalidad
	--** Nombre personaje Tarea: tarea
	--** Nombre personaje Tarea: tarea
	--** Nombre personaje Tarea: tarea
	--Total de personajes: 3
	--…………………………………………...
	--Película: título Nacionalidad: nacionalidad
	--** Nombre personaje Tarea: tarea
	--** Nombre personaje Tarea: tarea
	--…………………………………..
	--** Nombre personaje Tarea: tarea
	--Total de personajes: x

	--hacer vista?
	PROCEDURE listarPeliculas IS 
		CURSOR peliculas IS 
			SELECT P.TITULO_P, P.NACIONALIDAD, T.NOMBRE_PERSONA, T.TAREA  
			FROM PELICULA P, TRABAJO T
			WHERE P.CIP = T.CIP; 
	BEGIN 
		FOR registro IN peliculas LOOP
			
		end loop
		
		
	END
	
	--3. Crear una función que devuelva el número de películas en las que ha participado un personaje cuyo
	--nombre recibirá por parámetro. Si no existe el personaje o no ha participado en ninguna película deberá
	--generar una excepción (Cada una con un código y un mensaje diferente). (1,5 punto)
	
	
	
END PELICULAS;

--4. Realiza un trigger o trigger que creas necesario para impedir que un personaje trabaje más de una vez en
--la misma película. Si ya ha trabajado deberá lanzar una exception (2 puntos)

--5. Crear un trigger para que cuando se inserte un personaje el nombre siempre se inserte en mayúsculas. (1
--punto)

--6. Crea una tabla llamada log con un único campo de tipo varchar llamado descripcion y realizar un trigger
--o los trigger que creas necesario para las modificaciones que sufre la tabla personaje. Debe registrarse “El
--usuario nombreUsuario en la fecha fecha modificó el personaje nombre_personaje” pudiendo ser
--modificó, inserto o eliminó. (2 puntos)



