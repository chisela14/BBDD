--1. Realizar un paquete que contenga todos los procedimientos y funciones que se piden en este
--ejercicio. A continuación deberás incluir las sentencias necesarias para probar todas lasfuncionalidades del paquete (0,5 puntos).

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
	--NombreCiclistaN Fecha nacimiento
	--Nº Total de ciclistas en el equipos: X
	--Nº Total de equipos en el listado: X
	--….
--3. Crear una función que devuelva el número de carreras que han ganado los corredores de un
--equipo. El nombre del equipo se le pasará por parámetro. Si no existe el equipo deberá generar
--una excepción con una única instrucción con el código de error -200004. (1,5 punto)

--4. Realizar una función agregarciclista que reciba como parámetros el nombre, nacionalidad, fecha
--de nacimiento, codigo_equipo y nombre del equipo al que pertenece. En el caso de no existir
--el equipo deberá mostrar por consola el mensaje “No existe el equipo. Procedemos a crearlo” y
--se deberá crear el nuevo equipo. Posteriormente se agregará el nuevo ciclista al equipo que
--corresponda. La función devolverá el código del nuevo ciclista agregado. Si hay algún fallo debe
--dejar base de datos como estaba. Si la nacionalidad no tiene ningún valor se le pondrá
--“ESPAÑOL”. Debes controlar las posibles excepciones, por ejemplo si el ciclista ya existe deberás
--lanzar una excepción personalizada indicando el mensaje “El caballo que está intentando insertar
--ya existe ” (2 puntos)

--5. Crea una función que para cada equipo ordene alfabéticamente a sus ciclistas y muestre los 2
--primeros de cada equipo por consola. Para cada uno de los ciclistas mostrados en consola
--se va a actualizar la nacionalidad al valor ‘Inglesa’. La función devolverá el número de filas
--actulizadas en total. En el caso de producirse un error devolverá -1 (3 puntos)