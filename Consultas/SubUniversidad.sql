--1. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la '150212' y la '130113'.
SELECT IDALUMNO 
FROM ALUMNO_ASIGNATURA 
WHERE IDASIGNATURA NOT IN ('150212', '130113');

--CON SUBCONSULTA (MAL)
SELECT DISTINCT IDALUMNO 
FROM ALUMNO_ASIGNATURA 
WHERE IDALUMNO NOT IN (SELECT IDASIGNATURA FROM ALUMNO_ASIGNATURA
						WHERE IDASIGNATURA NOT LIKE '150212'
						OR IDASIGNATURA NOT LIKE '130113');

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
SELECT DISTINCT IDALUMNO 
FROM ALUMNO_ASIGNATURA 
WHERE IDASIGNATURA IN ('150212','130113');

--SC
SELECT DISTINCT IDALUMNO 
FROM 
				
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
--
--10. Mostrar el nombre de las asignaturas que tengan más créditos. 
--
--11. Lista de asignaturas en las que no se ha matriculado nadie. 
--
--12. Ciudades en las que vive algún profesor y también algún alumno. 
