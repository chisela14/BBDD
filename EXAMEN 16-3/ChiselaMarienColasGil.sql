--PRUEBA CONSULTAS SIMPLES, UNIÓN DE TABLAS Y AGRUPACIÓN
--Ejecuta el script proporcionado en Moodle y realiza las siguientes consultas a la base de datos 
--PELÍCULAS cuyo script de creación está colgado en la plataforma, las consultas no serán válidas si
--utilizan más tablas de las necesarias y no son óptimas. Deberás entregar un script que contenga 
--las consultas solicitadas indicando el enunciado correspondiente al que pertenece cada una.

--1. Obtener las diferentes nacionalidades de películas que existen en la base de datos.
SELECT DISTINCT NACIONALIDAD FROM PELICULA;

--2. Mostrar el código de la película, la fecha de estreno y la recaudación de las películas ordenadas
--por su recaudación de mayor a menor estrenadas antes del 22 de septiembre de 1997.
SELECT CIP, FECHA_ESTRENO, RECAUDACION  
FROM PROYECCION 
WHERE  FECHA_ESTRENO < TO_DATE('22/09/1997', 'DD/MM/YYYY') 
ORDER BY RECAUDACION DESC;

--3. Mostrar el código de las películas, la recaudación y el número de espectadores
--cuyo número de espectadores sea mayor que 3000 o cuya recaudación sea mayor o
--igual que 2000000, ordenadas de mayor a menor número de espectadores.
SELECT CIP, RECAUDACION, ESPECTADORES  
FROM PROYECCION 
WHERE ESPECTADORES > 3000
OR RECAUDACION >= 2000000
ORDER BY ESPECTADORES DESC;

--4. Obtener el nombre de los cines que contengan la cadena "ar" en mayúsculas o minúsculas en su dirección.
SELECT CINE 
FROM CINE
WHERE UPPER (DIRECCION_CINE) LIKE '%AR%';

--5. Mostrar los cines y su aforo total cuyo aforo total sea mayor que 600 ordenados
--por su aforo total de forma descendente.
SELECT CINE, AFORO 
FROM SALA
WHERE AFORO > 600
ORDER BY AFORO DESC;

/*Apartado 5: incorrecto. Lo correcto sería: 
SELECT CINE , SUM(nvl(AFORO,0))
FROM SALA s
GROUP BY CINE
HAVING SUM(nvl(AFORO,0))>600
ORDER BY SUM(nvl(AFORO,0)) DESC;*/

--6. Obtener el título de las películas estrenadas en la primera quincena de cualquier mes.
SELECT P.TITULO_P 
FROM PELICULA P, PROYECCION P2  
WHERE P.CIP = P2.CIP 
AND EXTRACT(DAY FROM P2.FECHA_ESTRENO) BETWEEN 1 AND 15; 

--7. Muestra la nacionalidad de las películas junto con la media del presupuesto por
--cada nacionalidad teniendo en cuenta los valores nulos y teniendo en cuenta sólo
--aquellas películas cuyo presupuesto es mayor que 500.
SELECT NACIONALIDAD, AVG(NVL(PRESUPUESTO, 0))
FROM PELICULA 
WHERE PRESUPUESTO > 500
GROUP BY NACIONALIDAD;

--8. Obtener el nombre y el sexo de todos los personajes cuyo nombre termine en 'n',
--'s' o 'e' y no tengan sexo asignado.
SELECT NOMBRE_PERSONA, SEXO_PERSONA  
FROM PERSONAJE 
WHERE (NOMBRE_PERSONA LIKE '%n' OR NOMBRE_PERSONA LIKE '%s' OR NOMBRE_PERSONA LIKE '%e')
AND SEXO_PERSONA IS NULL;

--9. Mostrar el nombre de las películas que el número total de días que se han
--estrenado sea mayor de 50.
SELECT DISTINCT P.TITULO_P 
FROM PELICULA P, PROYECCION PR
WHERE P.CIP = PR.CIP 
AND PR.DIAS_ESTRENO > 50;

/*Apartado 9: incorrecto. Lo correcto sería: 
SELECT p.TITULO_P FROM PELICULA p , PROYECCION p2
WHERE p.CIP =p2.CIP
GROUP BY p.TITULO_P
HAVING sum(nvl(p2.DIAS_ESTRENO,0))>50;*/

--10. Mostrar el nombre del cine, junto con su dirección y la ciudad en la que está, junto con la sala
--y el aforo de la sala, y el nombre de las películas que se han proyectado en esa sala.
--Los datos deben salir ordenados por el nombre del cine, la sala del cine y por último el
--nombre de la película (puedes usar el nombre en versión original o en español como quieras).
SELECT C.CINE, C.DIRECCION_CINE , C.CIUDAD_CINE, S.SALA, S.AFORO, P.TITULO_P  
FROM CINE C, SALA S, PROYECCION PR, PELICULA P
WHERE C.CINE = S.CINE 
AND S.CINE = PR.CINE 
AND S.SALA = PR.SALA 
AND PR.CIP = P.CIP
ORDER BY C.CINE ASC, S.SALA ASC, P.TITULO_P ASC;

--11. Realizar una consulta que muestre por cada uno de los posibles trabajos(tareas) que se pueden
--realizar en nuestra base de datos, el número de personas que han realizado dicho trabajo.
--Ten en cuenta que si una persona ha realizado dos veces el mismo trabajo sólo deberá salir una vez.
SELECT T.TAREA, COUNT (DISTINCT TR.NOMBRE_PERSONA) 
FROM TAREA T, TRABAJO TR
WHERE T.TAREA = TR.TAREA
GROUP BY T.TAREA; 

--12. Mostrar todos los datos de las películas estrenadas entre el 20 de septiembre de
--1995 y el 15 de diciembre de 1995. Si la película se ha estrenado dos o más veces
--en esas fechas sólo debe salir una vez.
SELECT DISTINCT P.*
FROM PELICULA P, PROYECCION PR
WHERE P.CIP = PR.CIP
AND PR.FECHA_ESTRENO BETWEEN TO_DATE('20/09/1995', 'DD/MM/YYYY') AND TO_DATE('15/12/1995', 'DD/MM/YYYY');

--13. Mostrar el nombre de los cines y la ciudad en la que se han proyectado 22 o
--más películas distintas en todas sus salas.
SELECT C.CINE, C.CIUDAD_CINE  
FROM CINE C, SALA S, PROYECCION PR
WHERE C.CINE = S.CINE 
AND S.CINE = PR.CINE 
AND S.SALA = PR.SALA 
HAVING COUNT (PR.CIP) >= 22
GROUP BY C.CINE, C.CIUDAD_CINE; 
--me falta el distinct

/*Apartado 13: incorrecto. Lo correcto sería:
SELECT c.CINE,c.CIUDAD_CINE, count(DISTINCT p.CIP)
FROM CINE c,SALA s, PROYECCION p
WHERE c.CINE =s.CINE
AND s.CINE =p.CINE
AND s.SALA =p.SALA
GROUP BY c.CINE,c.CIUDAD_CINE
HAVING count(DISTINCT p.CIP)>=22;*/

--14. Obtener el nombre de la película y el presupuesto de todas las películas
--americanas estrenadas en un cine de Córdoba, sabiendo que Córdoba está escrito
--sin tilde en la base de datos y puede estar en mayúsculas o minúsculas.
SELECT P.TITULO_P, SUM (P.PRESUPUESTO)  
FROM PELICULA P, PROYECCION PR, SALA S, CINE C
WHERE P.CIP = PR.CIP 
AND PR.CINE = S.CINE 
AND PR.SALA = S.SALA 
AND S.CINE = C.CINE 
AND P.NACIONALIDAD = 'EE.UU'
AND UPPER(C.CIUDAD_CINE) LIKE 'CORDOBA' 
GROUP BY P.TITULO_P; 

--15. Obtener el título y la recaudación total obtenida por películas que contengan en
--su TITULO_P la cadena 'vi' en minúsculas o el número 7.
SELECT P.TITULO_P, SUM(PR.RECAUDACION) 
FROM PELICULA P, PROYECCION PR
WHERE P.CIP = PR.CIP 
AND P.TITULO_P LIKE '%vi%'
OR P.TITULO_P LIKE '%7%'
GROUP BY P.TITULO_P; 
--DUDA
--lo lógico sería con paréntesis

--Apartado 15: faltan los parentesis despues del And y eso cambia el resultado.

--16. Obtener el presupuesto máximo y el presupuesto mínimo para las películas.
--Deberás utilizar los alias necesarios.
SELECT MAX(PRESUPUESTO) AS Presupuesto_máximo, MIN(PRESUPUESTO) AS Presupuesto_mínimo
FROM PELICULA;

--17. Explica en qué consiste el OUTER JOIN e indica un ejemplo justificándolo e
--incluyendo la sentencia correspondiente.

/*Un OUTER JOIN se utiliza cuando queremos consultar datos de varias tablas y alguno de los campos 
de una de ellas es nulo pero queremos que cuente para que aparezcan otros datos. 
Por ejemplo tenemos una base de datos con la tabla empleado y la tabla departamento que comparten un campo
de código de departamento, y en el departamento 40 NO hay ningún empleado pero queremos que aparezca este 
departamento en la consulta;

SELECT E.NOMBRE, D.NUMDEP, D.NOMBRE
FROM EMPLEADO E, DEPARTAMENTO D
WHERE E.CODDEP (+) = D.CODDEP

El outer JOIN se indica con (+) en el lado donde vaya a haber campos nulos.*/

--18. Se desea obtener un listado de todas las proyecciones, adicionalmente deberá
--aparecer en el listado otra columna que se llame fecha_estimada y cuyos valores a
--mostrar sean la fecha de estreno con un incremento de 2 meses.
SELECT P.*, ADD_MONTHS(P.FECHA_ESTRENO, 2) AS FECHA_ESTIMADA
FROM PROYECCION P;

--19. Mostrar todos los datos de películas junto con los datos de sus proyecciones. En
--este listado deben aparecer tanto las películas que tienes proyecciones como las
--que no tienen proyección.
SELECT *
FROM PELICULA P, PROYECCION PR
WHERE PR.CIP (+) = P.CIP; 

--20. Muestra el número de personajes que trabajan por cada película junto a su título
--principal ordenados por nombre de película (titulo_p) de forma ascendente.
SELECT COUNT(TR.NOMBRE_PERSONA) AS NUM_PERSONAJES, P.TITULO_P 
FROM TRABAJO TR, PELICULA P
WHERE TR.CIP = P.CIP
GROUP BY P.TITULO_P
ORDER BY P.TITULO_P ASC; 


/*Corrección
Apartado 5: incorrecto. Lo correcto sería SELECT CINE , SUM(nvl(AFORO,0))
FROM SALA s
GROUP BY CINE
HAVING SUM(nvl(AFORO,0))>600
ORDER BY SUM(nvl(AFORO,0)) DESC;

Apartado 9: incorrecto. Lo correcto sería : SELECT p.TITULO_P FROM PELICULA p , PROYECCION p2
WHERE p.CIP =p2.CIP
GROUP BY p.TITULO_P
HAVING sum(nvl(p2.DIAS_ESTRENO,0))>50;

Apartado 13: incorrecto. Lo correcto sería SELECT c.CINE,c.CIUDAD_CINE, count(DISTINCT p.CIP)
FROM CINE c,SALA s, PROYECCION p
WHERE c.CINE =s.CINE
AND s.CINE =p.CINE
AND s.SALA =p.SALA
GROUP BY c.CINE,c.CIUDAD_CINE
HAVING count(DISTINCT p.CIP)>=22;

Apartado 15: faltan los parentesis despues del And y eso cambia el resultado.*/
 
