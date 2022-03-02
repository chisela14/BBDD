--1. Cuantos costes basicos hay.
SELECT COUNT(COSTEBASICO) FROM ASIGNATURA;

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
SELECT P.NOMBRE, SUM (ASIG.COSTEBASICO* POWER (1.1,ALAS.NUMEROMATRICULA-1)) COSTETOTAL FROM ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS, ALUMNO A, PERSONA P
WHERE ASIG.IDASIGNATURA = ALAS.IDASIGNATURA 
AND ALAS.IDALUMNO = A.IDALUMNO
AND A.DNI = P.DNI 
GROUP BY P.NOMBRE;

--8. Coste medio de las asignaturas de cada titulacion, para aquellas titulaciones en el que el coste total de la 1a matricula sea mayor que 60 euros. 
SELECT AVG (ASIG.COSTEBASICO), T.NOMBRE FROM ASIGNATURA ASIG, TITULACION T
WHERE ASIG.IDTITULACION = T.IDTITULACION 
AND ASIG.COSTEBASICO > 60
--pongo esto para ver mejor el resultado
GROUP BY T.NOMBRE;

--9. Nombre de las titulaciones que tengan mas de tres alumnos.
SELECT T.NOMBRE FROM TITULACION T, ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS
WHERE ALAS.IDASIGNATURA = ASIG.IDASIGNATURA 
AND ASIG.IDTITULACION = T.IDTITULACION 
AND COUNT (ALAS.IDALUMNO) > 3;

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
HAVING COUNT (ALAS.IDALUMNO) >= 2
GROUP BY P.NOMBRE;

--13. Obtener el maximo de las sumas de los costesbasicos de cada cuatrimestre.
SELECT MAX(SUM(COSTEBASICO)) FROM ASIGNATURA GROUP BY CUATRIMESTRE; 
--MAL

--14. Suma del coste de las asignaturas.
SELECT SUM(COSTEBASICO) FROM ASIGNATURA;

--15. Cuantas asignaturas hay.
SELECT COUNT (IDASIGNATURA) FROM ASIGNATURA;

--16. Coste de la asignatura mas cara y de la mas barata.
SELECT MAX(COSTEBASICO), MIN (COSTEBASICO) FROM ASIGNATURA;

--17. Cuantas posibilidades de creditos de asignatura hay.
SELECT COUNT ( DISTINCT CREDITOS) FROM ASIGNATURA;

--18. Cuantos cursos hay.
SELECT COUNT (DISTINCT CURSO) FROM ASIGNATURA;

--19. Cuantas ciudades hay.
SELECT COUNT (DISTINCT CIUDAD) FROM PERSONA;

--20. Nombre y numero de horas de todas las asignaturas.
SELECT 
Mostrar las asignaturas que no pertenecen a ninguna titulaci�n.
Listado del nombre completo de las personas, sus tel�fonos y sus direcciones, llamando a la columna del nombre "NombreCompleto" y a la de direcciones "Direccion".
Cual es el d�a siguiente al d�a en que nacieron las personas de la B.D.
A�os de las personas de la Base de Datos, esta consulta tiene que valor para cualquier momento
Listado de personas mayores de 25 a�os ordenadas por apellidos y nombre, esta consulta tiene que valor para cualquier momento
Nombres completos de los profesores que adem�s son alumnos
Suma de los cr�ditos de las asignaturas de la titulaci�n de Matem�ticas
N�mero de asignaturas de la titulaci�n de Matem�ticas
�Cu�nto paga cada alumno por su matr�cula?
�Cu�ntos alumnos hay matriculados en cada asignatura?
