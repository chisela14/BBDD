--1. Para cada titulacion ordenar por coste mostrando primero las asignaturas mas caras y 
--para las asignaturas del mismo coste mostrar por orden alfabetico de nombre de asignatura. 
SELECT T.NOMBRE, A.NOMBRE, A.COSTEBASICO FROM TITULACION T, ASIGNATURA A
WHERE T.IDTITULACION = A.IDTITULACION 
ORDER BY A.COSTEBASICO DESC, A.NOMBRE ASC;

--2. Mostrar el nombre y los apellidos de los profesores. 
SELECT P.NOMBRE, P.APELLIDO FROM PERSONA P, PROFESOR PR WHERE P.DNI = PR.DNI;

--3. Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla.
SELECT A.NOMBRE FROM ASIGNATURA A, PERSONA P, PROFESOR PR 
WHERE A.IDPROFESOR = PR.IDPROFESOR 
AND P.DNI = PR.DNI 
AND CIUDAD LIKE 'Sevilla';

--4. Mostrar el nombre y los apellidos de los alumnos.
SELECT P.NOMBRE, P.APELLIDO FROM PERSONA P, ALUMNO A WHERE P.DNI = A.DNI;

--5. Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla. 
SELECT P.DNI, P.NOMBRE, P.APELLIDO FROM PERSONA P, ALUMNO A WHERE P.DNI = A.DNI AND CIUDAD LIKE 'Sevilla';

--6. Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial". 
SELECT P.DNI, P.NOMBRE, P.APELLIDO FROM PERSONA P, ALUMNO A, ALUMNO_ASIGNATURA ALAS, ASIGNATURA ASIG 
WHERE P.DNI = A.DNI 
AND A.IDALUMNO = ALAS.IDALUMNO 
AND ASIG.IDASIGNATURA= ALAS.IDASIGNATURA 
AND ASIG.NOMBRE = 'Seguridad Vial';

--7. Mostrar el Id de las titulaciones en las que esta matriculado el alumno con DNI 20202020A. 
--Un alumno esta matriculado en una titulacion si esta matriculado en una asignatura de la titulacion.
SELECT DISTINCT T.IDTITULACION FROM TITULACION T, ALUMNO A, ALUMNO_ASIGNATURA ALAS, ASIGNATURA ASIG 
WHERE A.IDALUMNO = ALAS.IDALUMNO 
AND ASIG.IDASIGNATURA= ALAS.IDASIGNATURA 
AND ASIG.IDTITULACION = T.IDTITULACION 
AND A.DNI = '20202020A';

--8. Obtener el nombre de las asignaturas en las que esta matriculada Rosa Garcia.
SELECT ASIG.NOMBRE FROM ASIGNATURA ASIG, ALUMNO A, ALUMNO_ASIGNATURA ALAS, PERSONA P 
WHERE ASIG.IDASIGNATURA= ALAS.IDASIGNATURA 
AND A.IDALUMNO = ALAS.IDALUMNO 
AND P.DNI = A.DNI 
AND P.NOMBRE = 'Rosa' AND P.APELLIDO = 'Garcia';

--9. Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz.
SELECT A.DNI FROM ALUMNO A, ALUMNO_ASIGNATURA ALAS, ASIGNATURA ASIG, PROFESOR PR, PERSONA P 
WHERE A.IDALUMNO = ALAS.IDALUMNO 
AND ALAS.IDASIGNATURA = ASIG.IDASIGNATURA 
AND ASIG.IDPROFESOR = PR.IDPROFESOR 
AND  PR.DNI = P.DNI 
AND P.NOMBRE = 'Jorge' AND P.APELLIDO = 'Saenz';

--10. Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Saenz.
SELECT A.DNI, P1.NOMBRE, P1.APELLIDO FROM ALUMNO A, ALUMNO_ASIGNATURA ALAS, ASIGNATURA ASIG, PROFESOR PR, PERSONA P1, PERSONA P2 
WHERE A.IDALUMNO = ALAS.IDALUMNO 
AND ALAS.IDASIGNATURA = ASIG.IDASIGNATURA 
AND ASIG.IDPROFESOR = PR.IDPROFESOR 
AND PR.DNI = P2.DNI 
AND A.DNI = P1.DNI
AND P2.NOMBRE = 'Jorge' AND P2.APELLIDO = 'Saenz'; 

--11. Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 creditos. 
SELECT 	T.NOMBRE FROM TITULACION T, ASIGNATURA ASIG WHERE T.IDTITULACION = ASIG.IDTITULACION AND ASIG.CREDITOS >= 4;

--12. Mostrar el nombre y los creditos de las asignaturas del primer cuatrimestre 
--junto con el nombre de la titulacion a la que pertenecen. 
SELECT ASIG.NOMBRE ASIGNATURA, ASIG.CREDITOS, T.NOMBRE TITULACION FROM ASIGNATURA ASIG, TITULACION T 
WHERE T.IDTITULACION = ASIG.IDTITULACION AND ASIG.CUATRIMESTRE = 1;

--13. Mostrar el nombre y el coste basico de las asignaturas de mas de 4,5 creditos 
--junto con el nombre de las personas matriculadas.
SELECT ASIG.NOMBRE, ASIG.COSTEBASICO, P.NOMBRE FROM ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS, ALUMNO A, PERSONA P
WHERE ASIG.IDASIGNATURA = ALAS.IDASIGNATURA 
AND ALAS.IDALUMNO = A.IDALUMNO 
AND A.DNI = P.DNI 
AND CREDITOS > 4.5;

--14. Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos.
SELECT P.NOMBRE FROM ASIGNATURA ASIG, PROFESOR PR, PERSONA P
WHERE ASIG.IDPROFESOR = PR.IDPROFESOR 
AND PR.DNI = P.DNI
AND ASIG.COSTEBASICO BETWEEN 25 AND 35;

--15. Mostrar el nombre de los alumnos matriculados en la asignatura '150212' o en la '130113' o en ambas.
SELECT P.NOMBRE FROM ALUMNO_ASIGNATURA ALAS, ALUMNO A, PERSONA P
WHERE ALAS.IDALUMNO = A.IDALUMNO 
AND A.DNI = P.DNI 
AND (ALAS.IDASIGNATURA = '150212' OR ALAS.IDASIGNATURA = '130113' OR (ALAS.IDASIGNATURA = '150212' AND ALAS.IDASIGNATURA = '130113'));

--16. Mostrar el nombre de las asignaturas del 2 cuatrimestre que no sean de 6 creditos, 
--junto con el nombre de la titulacion a la que pertenece.
SELECT ASIG.NOMBRE ASIGNATURA, T.NOMBRE TITULACION FROM ASIGNATURA ASIG, TITULACION T
WHERE ASIG.IDTITULACION = T.IDTITULACION 
AND (ASIG.CUATRIMESTRE = 2 AND ASIG.CREDITOS != 6);

--17. Mostrar el nombre y el numero de horas de todas las asignaturas. (1cred.=10 horas) 
--junto con el dni de los alumnos que estan matriculados.
SELECT ASIG.NOMBRE, ASIG.CREDITOS*10 NUMHORAS, A.DNI FROM ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS, ALUMNO A
WHERE ASIG.IDASIGNATURA = ALAS.IDASIGNATURA 
AND ALAS.IDALUMNO = A.IDALUMNO
--lo ordeno para ver el resultado mas claro
ORDER BY ASIG.NOMBRE;

--18. Mostrar el nombre de todas las mujeres que viven en Sevilla y que estan matriculadas en alguna asignatura.
SELECT P.NOMBRE FROM ASIGNATURA ASIG, ALUMNO_ASIGNATURA ALAS, ALUMNO A, PERSONA P
WHERE ASIG.IDASIGNATURA = ALAS.IDASIGNATURA 
AND ALAS.IDALUMNO = A.IDALUMNO
AND A.DNI = P.DNI 
AND P.VARON = 0 AND P.CIUDAD = 'Sevilla'
AND ASIG.IDASIGNATURA IS NOT NULL;

--19. Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.
SELECT ASIG.NOMBRE FROM ASIGNATURA ASIG, PROFESOR PR
WHERE ASIG.IDPROFESOR = PR.IDPROFESOR 
AND ASIG.CURSO = 1 AND ASIG.IDPROFESOR = 'P101';

--20. Mostrar el nombre de los alumnos que se ha matriculado tres o mas veces en alguna asignatura.
SELECT P.NOMBRE FROM ALUMNO_ASIGNATURA ALAS, ALUMNO A, PERSONA P
WHERE ALAS.IDALUMNO  = A.IDALUMNO 
AND A.DNI = P.DNI 
AND ALAS.NUMEROMATRICULA >= 3;
