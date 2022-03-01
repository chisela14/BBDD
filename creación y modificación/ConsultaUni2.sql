--1. Para cada titulación ordenar por coste mostrando primero las asignaturas más caras y para las asignaturas del mismo coste mostrar por orden alfabético de nombre de asignatura. 
SELECT T.NOMBRE, A.NOMBRE, A.COSTEBASICO FROM TITULACION T, ASIGNATURA A WHERE T.IDTITULACION = A.IDTITULACION ORDER BY A.COSTEBASICO DESC, A.NOMBRE ASC;

--2. Mostrar el nombre y los apellidos de los profesores. 
SELECT P.NOMBRE, P.APELLIDO FROM PERSONA P, PROFESOR PR WHERE P.DNI = PR.DNI;

--3. Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla.
SELECT A.NOMBRE FROM ASIGNATURA A, PERSONA P, PROFESOR PR WHERE A.IDPROFESOR = PR.IDPROFESOR AND P.DNI = PR.DNI AND CIUDAD LIKE 'Sevilla';

--4. Mostrar el nombre y los apellidos de los alumnos.
SELECT P.NOMBRE, P.APELLIDO FROM PERSONA P, ALUMNO A WHERE P.DNI = A.DNI;

--5. Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla. 
SELECT P.DNI, P.NOMBRE, P.APELLIDO FROM PERSONA P, ALUMNO A WHERE P.DNI = A.DNI AND CIUDAD LIKE 'Sevilla';

--6. Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial". 
SELECT P.DNI, P.NOMBRE, P.APELLIDO FROM PERSONA P, ALUMNO A, ALUMNO_ASIGNATURA ALAS, ASIGNATURA ASIG WHERE P.DNI = A.DNI AND A.IDALUMNO = ALAS.IDALUMNO AND ASIG.IDASIGNATURA= ALAS.IDASIGNATURA AND ASIG.NOMBRE = 'Seguridad Vial';

--7. Mostrar el Id de las titulaciones en las que está matriculado el alumno con DNI 20202020A. Un alumno está matriculado en una titulación si está matriculado en una asignatura de la titulación.
SELECT DISTINCT T.IDTITULACION FROM TITULACION T, ALUMNO A, ALUMNO_ASIGNATURA ALAS, ASIGNATURA ASIG WHERE A.IDALUMNO = ALAS.IDALUMNO AND ASIG.IDASIGNATURA= ALAS.IDASIGNATURA AND ASIG.IDTITULACION = T.IDTITULACION AND A.DNI = '20202020A';

--8. Obtener el nombre de las asignaturas en las que está matriculada Rosa Garcia.
SELECT ASIG.NOMBRE FROM ASIGNATURA ASIG, ALUMNO A, ALUMNO_ASIGNATURA ALAS, PERSONA P WHERE ASIG.IDASIGNATURA= ALAS.IDASIGNATURA AND A.IDALUMNO = ALAS.IDALUMNO AND P.DNI = A.DNI AND P.NOMBRE = 'Rosa' AND P.APELLIDO = 'Garcia';

Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz. 

Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Sáenz. 

Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 créditos. 

Mostrar el nombre y los créditos de las asignaturas del primer cuatrimestre junto con el nombre de la titulación a la que pertenecen. 

Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos junto con el nombre de las personas matriculadas

Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos

Mostrar el nombre de los alumnos matriculados en la asignatura '150212' ó en la '130113' ó en ambas.

Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos, junto con el nombre de la titulación a la que pertenece.

Mostrar el nombre y el número de horas de todas las asignaturas. (1cred.=10 horas) junto con el dni de los alumnos que están matriculados.

Mostrar el nombre de todas las mujeres que viven en “Sevilla” y que estén matriculados de alguna asignatura

Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.

Mostrar el nombre de los alumnos que se ha matriculado tres o más veces en alguna asignatura.
