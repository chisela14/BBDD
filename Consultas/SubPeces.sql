--Pez1

--1. Nombre, apellido y teléfono de todos los afiliados que sean hombres y que hayan nacido antes del
--1 de enero de 1070
SELECT NOMBRE, APELLIDOS, TELF  
FROM AFILIADOS 
WHERE SEXO = 'H' 
AND NACIMIENTO < TO_DATE ('01/01/1070', 'DD/MM/YYYY');
--1070 NINGUNO, 1970 19

--2. Peso, talla y nombre de todos los peces que se han pescado por con talla inferior o igual a 45. Los
--datos deben salir ordenados por el nombre del pez, y para el mismo pez por el peso (primero los
--más grandes) y para el mismo peso por la talla (primero los más grandes).

--UNION
SELECT PEZ, PESO, TALLA 
FROM CAPTURASSOLOS 
WHERE TALLA <= 45
UNION 
SELECT PEZ, PESO, TALLA 
FROM CAPTURASEVENTOS  
WHERE TALLA <= 45
ORDER BY PEZ, PESO DESC, TALLA DESC;

--3. Obtener los nombres y apellidos de los afiliados que o bien tienen la licencia de pesca que
--comienzan con una A (mayúscula o minúscula), o bien el teléfono empieza en 9 y la dirección
--comienza en Avda.
SELECT DISTINCT A.NOMBRE, A.APELLIDOS 
FROM AFILIADOS A, PERMISOS P
WHERE A.FICHA = P.FICHA 
AND UPPER(P.LICENCIA) LIKE 'A%'
OR (A.TELF LIKE '9%'
AND A.DIRECCION LIKE 'Avda.%');

--4. Lugares del cauce “Rio Genil” que en el campo de observaciones no tengan valor.
--OBERVACIONES DE LA TABLA LUGARES
SELECT LUGAR
FROM LUGARES 
WHERE UPPER(CAUCE) LIKE 'RIO GENIL'
AND OBSERVACIONES IS NULL;

--OBSERVACIONES DE LA TABLA CAUCES
SELECT L.LUGAR
FROM LUGARES L, CAUCES C
WHERE L.CAUCE = C.CAUCE 
AND UPPER(C.CAUCE) LIKE 'RIO GENIL'
AND C.OBSERVACIONES IS NULL;

--5. Mostrar el nombre y apellidos de cada afiliado, junto con la ficha de los afiliados que lo han
--avalado alguna vez como primer avalador.
SELECT A.NOMBRE, A.APELLIDOS, C.AVAL1  
FROM AFILIADOS A, CAPTURASSOLOS C
WHERE A.FICHA = C.FICHA (+); 

--6. Obtén los cauces y en qué lugar de ellos han encontrado tencas (tipo de pez) cuando nuestros
--afiliados han ido a pescar solos, indicando la comunidad a la que pertenece dicho lugar. (no deben
--salir valores repetidos)
SELECT DISTINCT L.CAUCE, L.LUGAR, L.COMUNIDAD 
FROM LUGARES L, CAPTURASSOLOS C
WHERE L.LUGAR = C.LUGAR 
AND UPPER(C.PEZ) = 'TENCA';

--7. Mostrar el nombre y apellido de los afiliados que han conseguido alguna copa. Los datos deben
--salir ordenador por la fecha del evento, mostrando primero los eventos más antiguos.
SELECT A.NOMBRE, A.APELLIDOS, E.FECHA_EVENTO  
FROM AFILIADOS A, PARTICIPACIONES P, EVENTOS E
WHERE A.FICHA = P.FICHA 
AND P.EVENTO = E.EVENTO 
ORDER BY E.FECHA_EVENTO;

--8. Obtén la ficha, nombre, apellidos, posición y trofeo de todos los participantes del evento 'Super
--Barbo' mostrándolos según su clasificación.
SELECT A.FICHA, A.NOMBRE, A.APELLIDOS, P.POSICION, P.TROFEO  
FROM AFILIADOS A, PARTICIPACIONES P
WHERE A.FICHA = P.FICHA 
AND UPPER(P.EVENTO) LIKE 'SUPER BARBO'
ORDER BY P.POSICION;

--9. Mostrar el nombre y apellidos de cada afiliado, junto con el nombre y apellidos de los afiliados
--que lo han avalado alguna vez como segundo avalador.
--MAL
SELECT A.NOMBRE, A.APELLIDOS, AVAL.NOMBRE, AVAL.APELLIDOS  
FROM AFILIADOS A, CAPTURASSOLOS C, AFILIADOS AVAL
WHERE A.FICHA = C.FICHA (+)
AND AVAL.FICHA = C.FICHA (+)
AND C.AVAL2 IS NOT NULL; 

SELECT DISTINCT FICHA FROM CAPTURASSOLOS;

--10. Indica todos los eventos en los que participó el afiliado 3796 en 1995 que no consiguió
--trofeo, ordenados descendentemente por fecha.
SELECT P.EVENTO 
FROM PARTICIPACIONES P, EVENTOS E
WHERE P.EVENTO = E.EVENTO 
AND P.FICHA = 3796
AND EXTRACT (YEAR FROM E.FECHA_EVENTO) = 1995
AND P.TROFEO IS NULL 
ORDER BY E.FECHA_EVENTO DESC; 




--Pez2
--1. Mostrar el nombre y apellidos de todos los afiliados que tengan una licencia que empieza por A.
--2. Mostrar los nombres de los peces que se han capturado en los eventos celebrados durante el año
--de 1998 indicando el nombre de la comunidad en la que se celebraron junto con el nombre y
--apellido del afiliado que lo capturó. La información debe aparecer ordenada por comunidad, luego
--por peces y por último por apellido del afiliado.
--3. Mostrar los eventos, el lugar y los cauces en los que se han celebrado eventos internacionales (el
--nombre del evento contiene la palabra internacional en mayúsculas o minúsculas). Hay que hacer
--esta sentencia con JOIN.
--4. Para cada uno de los peces que ha sido pescado por un afiliado en solitario, mostrar el nombre del
--pez, la talla, la fecha de pesca y la hora de la pesca, mostrando los datos ordenador por peces y
--luego los más grandes.
--5. Mostrar todos los cauces en los que alguna vez algún afiliado ha pescado alguna vez un pez en
--solitario, siempre que el la relación talla/peso sea mayor que 3.
--6. Mostrar el nombre y el apellido de los afiliados que han pescado algún pez en un evento y que en
--el campo de observaciones esté recogido que su hábitat es ríos.
--7. Mostrar el nombre y el apellido del afiliado o afiliados que ha sido el primer avalador del afiliado
--con código 1000.
--8. Mostrar los eventos que se han celebrado en un lugar en el que el campo de observaciones no tiene
--valor.
--9. Muestra el nombre y apellidos de todos las parejas de avales que existen en la base de datos. Es
--decir, debes mostrar el nombre y apellido del primer aval y el nombre y apellido del segundo aval.
--10. Mostrar el nombre y apellido del afiliado o afiliados que han quedado en algunas de las
--cuatro primeras posiciones en algún evento o que participado en algún evento celebrado en el
--Coto De Dilar o en el Coto De Fardes. (hay que hacer esta consulta sin utilizar JOIN)

--Pez3
--1. Nombre y teléfono de todos los afiliados que sean hombres.
--2. Peso y talla de todos los peces que se han pescado por libre antes de las 10:00 de la mañana, con
--talla inferior o igual a 45.
--3. Nombre de los eventos celebrados durante el mes de marzo.
--4. Lugares del cauce “Rio Genil” que no contengan la palabra “muerte” en mayúsculas o minúsculas.
--5. Obtener los nombres y apellidos de los afiliados que tienen la licencia de pesca que comienzan
--con una A o con una D.
--6. Obtén un listado de todos los concursos en los que no se pesca la especie 'Black-Bass' y que la
--talla mínima del pez sea mayor que 15. El listado estará ordenado por nombre de evento y nombre
--de pez.
--7. Obtén los cauces y en qué lugar de ellos se pueden encontrar tencas (tipo de pez), indicando la
--comunidad a la que pertenece dicho lugar.
--8. Obtén los cauces y en qué lugar de ellos se pueden encontrar tencas (tipo de pez), indicando la
--comunidad a la que pertenece dicho lugar.
--9. Obtén la ficha, nombre, apellidos, posición y trofeo de todos los participantes del evento 'Super
--Barbo' clasificados entre los tres primeros.
--10. Indica todos los eventos en los que participó el afiliado 3796 en 1995 que no consiguió
--trofeo, ordenados descendentemente por fecha.
--11. Mostrar el número de peces distintos que se han capturado fuera de concurso.
--12. Mostrar el nombre de los cauces que tengan más de un lugar.
--13. Mostrar los peces capturados en concursos que superen la media de peso.
--14. Obtener el número de capturas totales que se ha realizado en cada comunidad dentro de las
--competiciones. Debe aparecer la comunidad y el número de capturas ordenados por orden
--alfabético.
--15. Obtener el nombre de los afiliados que hayan pescado algún pez en más de dos lugares
--distintos en un evento.
--16. Obtener el nombre de los afiliados que hayan pescado más de dos tipos distintos de pez
--fuera de concurso.


--Pez4
--1. Mostrar el nombre de los peces que únicamente se hayan capturado por libre.
--2. A la siguiente consulta la llamaremos el pez madrugador, debes mostrar el pez que ha sido
--capturado más temprano por libre.
--3. Obtén la mejor posición alcanzada en competición a lo largo de su vida por el afiliado 1002. Debe
--aparecer, además de la posición, el evento en que la alcanzó y el trofeo obtenido.
--4. Obtén el nombre y apellidos de todas las personas que en alguno de los eventos '1er Encuentro
--Lures and Pikes' hayan realizado capturas de un peso superior a la media que se registró en dicho
--evento.
--5. Obtén todas las personas que han realizado una captura en solitario pero que nunca han avalado la
--captura de otro.
--6. Confirma si alguien ha capturado más de 5 peces en el evento 'Super Barbo', mostrando el número
--de ficha, el pez capturado y la cantidad de capturas. Si nadie ha infringido las normas, el resultado
--de la consulta es 'ninguna fila'.
--7. Elimina las capturas de los aquellos usuarios que se hayan avalado a sí mismos.
--8. Actualiza el peso de la trucha con mayor peso de capturasolos al peso de la trucha más pesada en
--el evento 'La Gran Trucha'.
--9. Se ha detectado un error en la báscula de 0.5 kg en el evento “Super Carpa”, por lo que hay que
--actualizar el peso (sumando 0.5 kg) a todas las capturas de dicho evento.
--10. Se desea modificar la tabla participaciones añadiendo un campo premio, a continuación
--deberás dejar en el campo trofeo solo copa y en el campo premio el importe del premio.
