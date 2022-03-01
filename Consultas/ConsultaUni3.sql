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
--las que esta matriculado. Recuerda que el precio de la matricula tiene un incremento de un 10% por cada a�o en el que este matriculado. 
SELECT P.NOMBRE, SUM (ASIG.COSTEBASICO* POWER (1.1,ALAS.NUMEROMATRICULA-1)) COSTETOTAL FROM ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS, ALUMNO A, PERSONA P
WHERE ASIG.IDASIGNATURA = ALAS.IDASIGNATURA 
AND ALAS.IDALUMNO = A.IDALUMNO
AND A.DNI = P.DNI 
GROUP BY P.NOMBRE;

--8. Coste medio de las asignaturas de cada titulacion, para aquellas titulaciones en el que el coste total de la 1� matricula sea mayor que 60 euros. 
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


Nombre de cada ciudad junto con el n�mero de personas que viven en ella.

Nombre de cada profesor junto con el n�mero de asignaturas que imparte.

Nombre de cada profesor junto con el n�mero de alumnos que tiene, para aquellos profesores que tengan dos o m�s de 2 alumnos.

Obtener el m�ximo de las sumas de los costesb�sicos de cada cuatrimestre

Suma del coste de las asignaturas
�Cu�ntas asignaturas hay?
Coste de la asignatura m�s cara y de la m�s barata
�Cu�ntas posibilidades de cr�ditos de asignatura hay?
�Cu�ntos cursos hay?
�Cu�ntas ciudades hau?
Nombre y n�mero de horas de todas las asignaturas.
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
