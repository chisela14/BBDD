--SUBCONSULTAS
--1. Mostrar el nombre y distrito de la/s estación/es que tiene/n un menor número de
--accesos.
SELECT NOMBRE, DISTRITO
FROM ESTACION 
WHERE CODIGO = (SELECT MIN(COUNT(NUMERO_ACCESO))FROM ACCESO GROUP BY ESTACION);
--*

--2. Mostrar todos los datos de la estación/es que no tiene/n acceso norte.
SELECT *
FROM ESTACION 
WHERE CODIGO NOT IN (SELECT ESTACION FROM ACCESO WHERE ORIENTACION = 'N');

--3. Seleccionar todos los datos de la línea por donde pase el tren o trenes cuyo
--número de cochera asignado sea el mayor.
SELECT * 
FROM LINEA 
WHERE CODIGO = (SELECT LINEA FROM TREN WHERE COCHERA = (SELECT MAX(COCHERA) FROM TREN));
--*

--4. Mostrar cada uno de los distritos junto con el número de trenes con una velocidad
--máxima de 100 k/h que pasan por cualquier estación que pertenezca a ese distrito,
--siempre y cuando pasen más de tres trenes con una velocidad máxima de 100
--kilómetros por hora.
--IGUAL QUE EL 14 PERO CON SUBCONSULTA


--5. Mostrar la estación por la que solo pasan líneas con cobertura CENTRO.
SELECT ESTACION 
FROM LINEA_ESTACION 
WHERE LINEA IN (SELECT CODIGO FROM LINEA WHERE COBERTURA = 'CENTRO');
--*

--6. Mostrar el nombre y distrito de la estación por la que pasan más líneas.
SELECT NOMBRE, DISTRITO
FROM ESTACION 
WHERE CODIGO = (SELECT ESTACION FROM LINEA_ESTACION WHERE LINEA = (SELECT MAX(LINEA)FROM LINEA_ESTACION));

SELECT ESTACION FROM LINEA_ESTACION HAVING MAX(COUNT(DISTINCT LINEA)) = (SELECT MAX(COUNT(DISTINCT LINEA)) FROM LINEA_ESTACION GROUP BY ESTACION);
SELECT MAX(COUNT(DISTINCT LINEA)) FROM LINEA_ESTACION GROUP BY ESTACION;
--*MAL

--7. Muestra las diferentes orientaciones de los accesos de la estación donde se
--guarda el tren más nuevo.  
SELECT DISTINCT A.ORIENTACION 
FROM ACCESO A, ESTACION E, COCHERA C, TREN T
WHERE A.ESTACION = E.CODIGO 
AND E.CODIGO  = C.ESTACION 
AND C.CODIGO = T.COCHERA 
AND T.FECHA_ENTRADA = (SELECT MAX(FECHA_ENTRADA) FROM TREN);

--8. Mostrar el modelo del tren que pasa por más estaciones distintas.
SELECT MODELO 
FROM TREN 
WHERE CODIGO = (SELECT T.CODIGO FROM TREN T, COCHERA C, ESTACION E
				WHERE T.COCHERA = C.CODIGO 
				AND C.ESTACION = E.CODIGO 
				HAVING E.CODIGO = (SELECT COUNT(DISTINCT E.CODIGO) FROM ESTACION)
				GROUP BY E.CODIGO);
--MAL

--9. Mostrar el nombre de la estación junto con el nombre de las líneas que pasan por esa
--estación, y el modelo y velocidad máxima de los trenes que tienen esa línea, junto con
--la localización de la cochera en la que duerme el tren y el nombre de la estación a la
--que pertenece la cochera. Ordenar los datos por línea y estación.
SELECT DISTINCT E.NOMBRE, L.NOMBRE, T.MODELO, T.VELOCIDAD_MAXIMA, C.LOCALIZACION 
FROM ESTACION E, LINEA_ESTACION LE, LINEA L, TREN T, COCHERA C
WHERE E.CODIGO = LE.ESTACION 
AND LE.LINEA = L.CODIGO
AND L.CODIGO = T.LINEA 
AND T.COCHERA = C.CODIGO
AND C.ESTACION = E.CODIGO
ORDER BY E.NOMBRE, L.NOMBRE; 

--10. Mostrar el nombre y distrito de las estaciones cuya capacidad en sus cocheras supere a
--la media de capacidad por estación.
SELECT E.NOMBRE, E.DISTRITO 
FROM ESTACION E, COCHERA C
WHERE E.CODIGO = C.ESTACION 
AND C.CAPACIDAD > (SELECT AVG(C.CAPACIDAD)FROM ESTACION E, COCHERA C
					WHERE E.CODIGO = C.ESTACION);

--11. Añadir un campo numLineas a la tabla estacion, este campo contendrá el número de
--líneas que pasan por dicha estación. Rellena este campo con los datos existentes en la
--base de datos.
ALTER TABLE ESTACION ADD NUMLINEAS NUMBER(2);

SELECT COUNT(DISTINCT LINEA), ESTACION  
FROM LINEA_ESTACION 
GROUP BY ESTACION
ORDER BY ESTACION; 

INSERT INTO ESTACION (NUMLINEAS) VALUES (2);--1
INSERT INTO ESTACION (NUMLINEAS) VALUES (2);--2
INSERT INTO ESTACION (NUMLINEAS) VALUES (3);--3
INSERT INTO ESTACION (NUMLINEAS) VALUES (3);--4
INSERT INTO ESTACION (NUMLINEAS) VALUES (2);--5
INSERT INTO ESTACION (NUMLINEAS) VALUES (2);--6
INSERT INTO ESTACION (NUMLINEAS) VALUES (3);--7
INSERT INTO ESTACION (NUMLINEAS) VALUES (2);--8
INSERT INTO ESTACION (NUMLINEAS) VALUES (2);--9
INSERT INTO ESTACION (NUMLINEAS) VALUES (1);--10
INSERT INTO ESTACION (NUMLINEAS) VALUES (2);--11
INSERT INTO ESTACION (NUMLINEAS) VALUES (1);--12
INSERT INTO ESTACION (NUMLINEAS) VALUES (2);--13
INSERT INTO ESTACION (NUMLINEAS) VALUES (1);--14
INSERT INTO ESTACION (NUMLINEAS) VALUES (1);--15
INSERT INTO ESTACION (NUMLINEAS) VALUES (1);--16
INSERT INTO ESTACION (NUMLINEAS) VALUES (0);--17


--CONSULTAS VARIAS
--12. Obtener el número de trenes que entraron entre los meses de enero y abril del año
--pasado.
SELECT COUNT(CODIGO)
FROM TREN 
WHERE FECHA_ENTRADA >= TO_DATE('01/01/2021', 'DD/MM/YYYY')
AND FECHA_ENTRADA <= TO_DATE('30/4/2021', 'DD/MM/YYYY');

--13. Mostrar el número de accesos que hay de cada orientación menos del tipo 'S'
--mostrando también la orientación.
SELECT COUNT(NUMERO_ACCESO), ORIENTACION 
FROM ACCESO 
WHERE ORIENTACION != 'S'
GROUP BY ORIENTACION; 

--14. Mostrar cada uno de los distritos junto con el número de trenes con una velocidad máxima de
--100 k/h que pasan por cualquier estación que pertenezca a ese distrito, siempre y cuando
--pasen más de tres trenes con una velocidad máxima de 100 kilómetros por hora.
SELECT DISTINCT E.DISTRITO, COUNT(T.CODIGO)
FROM ESTACION E, LINEA_ESTACION LE, LINEA L, TREN T
WHERE E.CODIGO = LE.ESTACION 
AND LE.LINEA = L.CODIGO 
AND L.CODIGO = T.LINEA 
AND T.VELOCIDAD_MAXIMA = 100
GROUP BY E.DISTRITO; 
--siempre y cuando
--pasen más de tres trenes con una velocidad máxima de 100 kilómetros por hora.*

--15. Mostrar el nombre de la estación junto con el nombre de las líneas que pasan por esa
--estación, y el modelo y velocidad máxima de los trenes que tienen esa línea, junto con
--la localización de la cochera en la que duerme el tren y el nombre de la estación a la
--que pertenece la cochera. Ordenar los datos por línea y estación.


--16. Mostrar el número total de “huecos” que hay en todas las cocheras de la base de
--datos. Es decir, que nos diga el número total de huecos.
--HAY QUE CALCULAR


--17. Sin realizar subconsultas deberás mostrar el nombre de las estaciones que no tengan
--ningún acceso.
SELECT E.NOMBRE 
FROM ESTACION E, ACCESO A 
WHERE E.CODIGO = A.ESTACION (+)
AND A.NUMERO_ACCESO IS NULL;

--18. Utilizando la sintaxis del INNER JOIN, realiza la siguiente consulta: Mostrar el
--nombre de la estación junto con el nombre de las líneas que pasan por esa estación, y
--el modelo y velocidad máxima de los trenes que tienen esa línea, junto con la
--localización de la cochera en la que duerme el tren y el nombre de la estación a la que
--pertenece la cochera.Ordenar los datos por línea y estación.


--19. Sin realizar subconsultas y utilizando OUTER JOIN pero sin usar (+) deberás
--mostrar el nombre de las estaciones que no tengan ningún acceso.


--20. ¿Qué palabra reservada permite unir dos consultas SELECT de modo que el resultado
--serán las filas que estén presentes en ambas consultas? Explícalo e indica una consulta
--de ejemplo donde la utilices.
/*La palabra reservada es UNION. 
Por ejemplo en este caso coge los resultados de ambas consultas, que quieren mostrar el pez y el
peso siempre que la talla sea menor o igual a 15, pero en diferentes tablas sin tener que hacer un join.

SELECT PEZ, PESO 
FROM CAPTURASSOLOS 
WHERE TALLA <= 15
UNION 
SELECT PEZ, PESO
FROM CAPTURASEVENTOS  
WHERE TALLA <= 15;
*/
