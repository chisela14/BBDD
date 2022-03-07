--1. Cuantos costes basicos hay.
SELECT COUNT(nvl(COSTEBASICO, 0)) FROM ASIGNATURA;
--en el caso de que tuviera nulo lo cuenta

--2. Para cada titulacion mostrar el numero de asignaturas que hay junto con el nombre de la titulacion.
SELECT T.NOMBRE, COUNT (ASIG.IDASIGNATURA) FROM TITULACION T, ASIGNATURA ASIG
WHERE ASIG.IDTITULACION = T.IDTITULACION
GROUP BY T.NOMBRE;

--3. Para cada titulacion mostrar el nombre de la titulacion junto con el precio total de todas sus asignaturas.
SELECT T.NOMBRE, SUM (ASIG.COSTEBASICO) FROM TITULACION T, ASIGNATURA ASIG
WHERE ASIG.IDTITULACION = T.IDTITULACION
GROUP BY T.NOMBRE;

--4. Cual seria el coste global de cursar la titulacion de Matematicas si el coste de cada asignatura fuera incrementado en un 7%.
 SELECT SUM (COSTEBASICO*1.07) COSTEGLOBAL FROM TITULACION T, ASIGNATURA ASIG
 WHERE ASIG.IDTITULACION = T.IDTITULACION
 AND T.NOMBRE = 'Matematicas';

--5. Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura. 
SELECT COUNT (ALAS.IDALUMNO) NUMALUMNOS, ALAS.IDASIGNATURA FROM ALUMNO_ASIGNATURA ALAS, ALUMNO A
WHERE ALAS.IDALUMNO = A.IDALUMNO
GROUP BY ALAS.IDASIGNATURA;

--6. Igual que el anterior pero mostrando el nombre de la asignatura.
SELECT COUNT (ALAS.IDALUMNO) NUMALUMNOS, ASIG.NOMBRE FROM ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS, ALUMNO A
WHERE ASIG.IDASIGNATURA = ALAS.IDASIGNATURA 
AND ALAS.IDALUMNO = A.IDALUMNO
GROUP BY ASIG.NOMBRE;

--7. Mostrar para cada alumno, el nombre del alumno junto con lo que tendria que pagar por el total de todas las asignaturas en 
--las que esta matriculado. Recuerda que el precio de la matricula tiene un incremento de un 10% por cada año en el que este matriculado. 
SELECT P.NOMBRE, SUM (ASIG.COSTEBASICO* POWER (1.1,ALAS.NUMEROMATRICULA-1)) COSTETOTAL 
FROM ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS, ALUMNO A, PERSONA P
WHERE ASIG.IDASIGNATURA = ALAS.IDASIGNATURA 
AND ALAS.IDALUMNO = A.IDALUMNO
AND A.DNI = P.DNI 
GROUP BY P.NOMBRE;
-- SUM (ASIG.COSTEBASICO* POWER (1.1,ALAS.NUMEROMATRICULA-1))
--((ASIG.COSTEBASICO*ALAS.NUMEROMATRICULA)*0.10)
--MIRAR

--8. Coste medio de las asignaturas de cada titulacion, para aquellas titulaciones en el que el coste total de la 1a matricula sea mayor que 60 euros. 
SELECT AVG (ASIG.COSTEBASICO), T.NOMBRE FROM ASIGNATURA ASIG, TITULACION T, ALUMNO_ASIGNATURA ALAS
WHERE ALAS.IDASIGNATURA = ASIG.IDASIGNATURA 
AND ASIG.IDTITULACION = T.IDTITULACION 
AND ALAS.NUMEROMATRICULA = 1
--pongo esto para ver mejor el resultado
GROUP BY T.NOMBRE
HAVING SUM (ASIG.COSTEBASICO) > 60;

--9. Nombre de las titulaciones que tengan mas de tres alumnos.
SELECT T.NOMBRE FROM TITULACION T, ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS
WHERE ALAS.IDASIGNATURA = ASIG.IDASIGNATURA 
AND ASIG.IDTITULACION = T.IDTITULACION 
GROUP BY T.NOMBRE
HAVING COUNT (ALAS.IDALUMNO) > 3;

--10. Nombre de cada ciudad junto con el numero de personas que viven en ella.
SELECT P.CIUDAD, COUNT (P.DNI) FROM PERSONA P GROUP BY P.CIUDAD;

--11. Nombre de cada profesor junto con el numero de asignaturas que imparte.
SELECT P.NOMBRE, COUNT (ASIG.IDASIGNATURA) FROM PERSONA P, PROFESOR PR, ASIGNATURA ASIG
WHERE P.DNI = PR.DNI 
AND PR.IDPROFESOR = ASIG.IDPROFESOR 
GROUP BY P.NOMBRE;

--12. Nombre de cada profesor junto con el numero de alumnos que tiene, para aquellos profesores que tengan dos o mas de 2 alumnos.
SELECT P.NOMBRE, COUNT (ALAS.IDALUMNO) NUMALUMNOS FROM PERSONA P, PROFESOR PR, ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS 
WHERE P.DNI = PR.DNI 
AND PR.IDPROFESOR = ASIG.IDPROFESOR
AND ASIG.IDASIGNATURA = ALAS.IDASIGNATURA 
GROUP BY P.NOMBRE
HAVING COUNT (ALAS.IDALUMNO) >= 2;

--13. Obtener el maximo de las sumas de los costesbasicos de cada cuatrimestre.
SELECT MAX(SUM(COSTEBASICO)) FROM ASIGNATURA GROUP BY CUATRIMESTRE; 

--14. Suma del coste de las asignaturas.
SELECT SUM(COSTEBASICO) FROM ASIGNATURA;

--15. Cuantas asignaturas hay.
SELECT COUNT (IDASIGNATURA) FROM ASIGNATURA;

--16. Coste de la asignatura mas cara y de la mas barata.
SELECT MAX(COSTEBASICO), MIN (COSTEBASICO) FROM ASIGNATURA;

--17. Cuantas posibilidades de creditos de asignatura hay.
SELECT COUNT (DISTINCT CREDITOS) FROM ASIGNATURA;

--18. Cuantos cursos hay.
SELECT COUNT (DISTINCT CURSO) FROM ASIGNATURA;

--19. Cuantas ciudades hay.
SELECT COUNT (DISTINCT CIUDAD) FROM PERSONA;

--20. Nombre y numero de horas de todas las asignaturas (1cred.=10 horas).
SELECT NOMBRE, CREDITOS*10 NUMHORAS FROM ASIGNATURA;

--21. Mostrar las asignaturas que no pertenecen a ninguna titulacion.
SELECT NOMBRE FROM ASIGNATURA WHERE IDTITULACION IS NULL;

--22. Listado del nombre completo de las personas, sus telefonos y sus direcciones, llamando a la columna del nombre 
-- "NombreCompleto" y a la de direcciones "Direccion".
SELECT NOMBRE ||' '|| APELLIDO NOMBRECOMPLETO, TELEFONO, DIRECCIONCALLE ||' '|| DIRECCIONNUM DIRECCION FROM PERSONA;

--23. Cual es el dia siguiente al dia en que nacieron las personas de la B.D.
SELECT FECHA_NACIMIENTO+1 FROM PERSONA; 

--24. Anyos de las personas de la Base de Datos, esta consulta tiene que valor para cualquier momento.
SELECT EXTRACT (YEAR FROM SYSDATE)-EXTRACT (YEAR FROM FECHA_NACIMIENTO) FROM PERSONA;
-- TRUNC ((SYSDATE - FECHA_NACIMIENTO) /365)

--25. Listado de personas mayores de 25 anyos ordenadas por apellidos y nombre, esta consulta tiene que valor para cualquier momento.
SELECT * FROM PERSONA 
WHERE EXTRACT (YEAR FROM SYSDATE)-EXTRACT (YEAR FROM FECHA_NACIMIENTO) > 25
ORDER BY APELLIDO ASC, NOMBRE ASC;

--26. Nombres completos de los profesores que ademas son alumnos.
SELECT P.NOMBRE ||' '|| P.APELLIDO NOMBRECOMPLETO FROM PERSONA P, PROFESOR PR, ALUMNO A
WHERE PR.DNI = P.DNI 
AND A.DNI = P.DNI;

--27. Suma de los creditos de las asignaturas de la titulacion de Matematicas.
SELECT SUM (ASIG.CREDITOS) FROM ASIGNATURA ASIG, TITULACION T
WHERE ASIG.IDTITULACION = T.IDTITULACION 
AND T.NOMBRE = 'Matematicas';

--28. Numero de asignaturas de la titulacion de Matematicas.
SELECT COUNT (ASIG.IDASIGNATURA) FROM ASIGNATURA ASIG, TITULACION T
WHERE ASIG.IDTITULACION = T.IDTITULACION 
AND T.NOMBRE = 'Matematicas';

--29. �Cuanto paga cada alumno por su matricula?
SELECT SUM (ASIG.COSTEBASICO), ALAS.IDALUMNO FROM ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS
WHERE ASIG.IDASIGNATURA = ALAS.IDASIGNATURA 
GROUP BY ALAS.IDALUMNO;

--30. �Cuantos alumnos hay matriculados en cada asignatura?
SELECT COUNT (ALAS.IDALUMNO), ALAS.IDASIGNATURA FROM ALUMNO_ASIGNATURA ALAS GROUP BY ALAS.IDASIGNATURA;
