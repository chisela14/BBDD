--1. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la '150212' y la '130113'.
SELECT IDALUMNO 
FROM ALUMNO_ASIGNATURA 
WHERE IDASIGNATURA NOT IN ('150212', '130113');

--CON SUBCONSULTA
SELECT DISTINCT IDALUMNO 
FROM ALUMNO 
WHERE IDALUMNO IN (SELECT IDALUMNO FROM ALUMNO_ASIGNATURA
						WHERE IDASIGNATURA NOT LIKE '150212'
						AND IDASIGNATURA NOT LIKE '130113');

--2. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 
SELECT A.NOMBRE 
FROM ASIGNATURA A, ASIGNATURA A2
WHERE A2.CREDITOS >

--SC
SELECT NOMBRE 
FROM ASIGNATURA 
WHERE CREDITOS > (SELECT CREDITOS FROM ASIGNATURA 
					WHERE UPPER(NOMBRE) LIKE 'SEGURIDAD VIAL');
					
--3. Obtener el Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez. 
--NO SÉ
SELECT DISTINCT A1.IDALUMNO 
FROM ALUMNO_ASIGNATURA A1, ALUMNO_ASIGNATURA A2
WHERE A1.IDASIGNATURA = A2.IDASIGNATURA 
AND A1.IDALUMNO = A2.IDALUMNO 
AND A1.NUMEROMATRICULA = A2.NUMEROMATRICULA 
AND A1.IDASIGNATURA LIKE '150212'
AND A2.IDASIGNATURA LIKE '130113';

--SC
SELECT DISTINCT IDALUMNO 
FROM 

--A02, A03
				
--4. Mostrar el Id de los alumnos matriculados en las asignatura "150212" ó "130113", en una o en otra pero no en ambas a la vez. 
--
--5. Mostrar el nombre de las asignaturas de la titulación "130110" cuyos costes básicos sobrepasen el coste básico promedio 
--por asignatura en esa titulación.
--
--6. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la "150212" y la "130113”
--
--7. Mostrar el Id de los alumnos matriculados en la asignatura "150212" pero no en la "130113". 
--
--8. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 
--


--9. Mostrar las personas que no son ni profesores ni alumnos.
SELECT P.*
FROM PERSONA P, ALUMNO A, PROFESOR PR
WHERE P.DNI = A.DNI (+)
AND A.IDALUMNO IS NULL
AND PR.DNI (+) = P.DNI
AND PR.IDPROFESOR IS NULL;

--SC 
SELECT *
FROM PERSONA 
WHERE (DNI NOT IN (SELECT DNI FROM PROFESOR)
AND DNI NOT IN (SELECT DNI FROM ALUMNO));

--ALUMNO Y PROFESOR A LA VEZ
SELECT P.* 
FROM PERSONA P, PROFESOR PR, ALUMNO A
WHERE PR.DNI = P.DNI 
AND P.DNI = A.DNI; 

--10. Mostrar el nombre de las asignaturas que tengan más créditos. 
SELECT NOMBRE 
FROM ASIGNATURA
WHERE CREDITOS = (SELECT MAX(CREDITOS) FROM ASIGNATURA);

--11. Lista de asignaturas en las que no se ha matriculado nadie. 
SELECT ASIG.NOMBRE 
FROM ASIGNATURA ASIG, ALUMNO_ASIGNATURA AA
WHERE ASIG.IDASIGNATURA = AA.IDASIGNATURA (+)
AND AA.IDALUMNO IS NULL;

--SC 
SELECT NOMBRE 
FROM ASIGNATURA 
WHERE IDASIGNATURA NOT IN (SELECT IDASIGNATURA FROM ALUMNO_ASIGNATURA);

--12. Ciudades en las que vive algún profesor y también algún alumno. 
--(VIVEN AMBOS)
SELECT DISTINCT CIUDAD 
FROM PERSONA 
WHERE CIUDAD IN (SELECT P.CIUDAD FROM PERSONA P, PROFESOR PR 
				WHERE P.DNI = PR.DNI)
AND CIUDAD IN (SELECT P.CIUDAD FROM PERSONA P, ALUMNO A 
				WHERE P.DNI = A.DNI);
