--Apartado 1
INSERT INTO PERSONA (DNI, NOMBRE, APELLIDO, CIUDAD, FECHA_NACIMIENTO, VARON) VALUES ('72995247D', 'CHISELA', 'COLÁS', 'SEVILLA', TO_DATE ('30/09/1999', 'DD/MM/YYYY'), 0);
INSERT INTO ALUMNO  VALUES ('A123456', '72995247D');
INSERT INTO ALUMNO_ASIGNATURA VALUES ('A123456', '160002', 1);

--Apartado 2
INSERT INTO PERSONA VALUES ('77222122K', 'MARTA', 'LÓPEZ MARTOS', 'SEVILLA', 'CALLE TARFIA', 9, '615891432', TO_DATE ('22/07/1981', 'DD/MM/YYYY'), 0);
INSERT INTO PROFESOR VALUES ('P250', '77222122K');
UPDATE ASIGNATURA SET IDPROFESOR = 'P250' WHERE IDASIGNATURA = '160002';
DELETE FROM PROFESOR WHERE IDPROFESOR = 'P117';
DELETE FROM PERSONA WHERE DNI = '25252525A';

--Apartado 3
CREATE TABLE ALUMNOS_MUYREPETIDORES (
	IDALUMNO VARCHAR2 (11),
	IDASIGNATURA VARCHAR2 (6),
	NOMBRE VARCHAR2 (30),
	APELLIDO VARCHAR2 (30),
	TELEFONO VARCHAR2 (9),
	CONSTRAINT pk_alumnosrepetidores PRIMARY KEY (IDASIGNATURA, IDALUMNO),
	CONSTRAINT fk_alumnosrepetidores FOREIGN KEY (IDASIGNATURA) REFERENCES ASIGNATURA (IDASIGNATURA),
	CONSTRAINT fk2_alumnosrepetidores FOREIGN KEY (IDALUMNO) REFERENCES ALUMNO (IDALUMNO)
);
ALTER TABLE ALUMNOS_MUYREPETIDORES ADD NUMEROMATRICULA NUMBER (1);
INSERT INTO ALUMNOS_MUYREPETIDORES (IDALUMNO, IDASIGNATURA, NUMEROMATRICULA) SELECT*FROM ALUMNO_ASIGNATURA WHERE NUMEROMATRICULA >= 3;

--Apartado 4
ALTER TABLE ALUMNOS_MUYREPETIDORES ADD OBSERVACIONES VARCHAR2 (50);
UPDATE ALUMNOS_MUYREPETIDORES SET OBSERVACIONES = 'Se encuentra en seguimiento' WHERE IDALUMNO IN (SELECT IDALUMNO FROM PERSONA p, ALUMNO a WHERE CIUDAD LIKE 'SEVILLA' AND p.dni = a.dni);

--Apartado 5
DELETE FROM ALUMNOS_MUYREPETIDORES WHERE IDALUMNO IN (SELECT IDALUMNO FROM PERSONA p, ALUMNO a WHERE FECHA_NACIMIENTO  LIKE '1971-11-%' AND p.dni = a.dni);

--Apartado 6
CREATE TABLE RESUMEN_TITULACIONES (
	ID_TITULACION VARCHAR2(6),
	NOMBRE_TITULACION VARCHAR2 (30),
	CONSTRAINT pk_resumtitulaciones PRIMARY KEY (ID_TITULACION)
);
INSERT INTO RESUMEN_TITULACIONES SELECT*FROM TITULACION;

--Apartado 7
--7.1 No porque los datos estarán guardados en mi ordenador pero no en el acceso local común para ambos.
--7.2 No porque los datos estarán guardados en mi ordenador pero no en el acceso local común para ambos.
--7.3 Si he creado un savepoint antes de meter los datos podré volver a él pero depende de cuando lo haya creado tendré unos datos u otros (si lo creo al principio no tendré nada)
--7.4
--7.5
--7.6 Consiste en crear un punto de identificación en una transacción para poder volver luego a ese punto.



