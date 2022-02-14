-- Creación de usuario
ALTER session set "_oracle_script"=true;
CREATE USER DMLCHISELA IDENTIFIED BY DMLCHISELA;
GRANT CONNECT, RESOURCE, DBA TO DMLCHISELA;

--Apartado 1
CREATE TABLE profesor (
	idprofesor NUMBER (7),
	nif_p VARCHAR2 (9),
	nombre VARCHAR2 (30),
	especialidad VARCHAR2 (20),
	telefono VARCHAR2 (9),
	CONSTRAINT pk_profesor PRIMARY KEY (idprofesor)
);

CREATE TABLE asignatura (
	codasignatura VARCHAR2 (8),
	nombre VARCHAR2 (20),
	idprofesor NUMBER (7),
	CONSTRAINT pk_asignatura PRIMARY KEY (codasignatura),
	CONSTRAINT fk_asignatura FOREIGN KEY (idprofesor) REFERENCES profesor (idprofesor)
);

CREATE TABLE alumno (
	nummatricula NUMBER (8),
	nombre VARCHAR2 (30),
	fechanacimiento DATE,
	telefono VARCHAR2 (9),
	CONSTRAINT pk_alumno PRIMARY KEY (nummatricula)
);

CREATE TABLE recibe (
	nummatricula NUMBER (8),
	codasignatura VARCHAR2 (8),
	cursoescolar VARCHAR2 (9),
	CONSTRAINT pk_recibe PRIMARY KEY (nummatricula, codasignatura, cursoescolar),
	CONSTRAINT fk_recibe FOREIGN KEY (nummatricula) REFERENCES alumno (nummatricula),
	CONSTRAINT fk2_recibe FOREIGN KEY (codasignatura) REFERENCES asignatura (codasignatura)
);

--Apartado 2
INSERT INTO profesor (idprofesor, nif_p, nombre) VALUES (1234567, '25441209N','Juan Carlos Calero');
INSERT INTO profesor (idprofesor, nif_p, nombre) VALUES (1234568, '12598476P','Inmaculada Olías');
INSERT INTO asignatura (codasignatura, nombre, idprofesor) VALUES ('12A587D6', 'Lenguajes de marca', 1234567);
INSERT INTO asignatura (codasignatura, nombre, idprofesor) VALUES ('85J587D6', 'Programación', 1234568);
INSERT INTO asignatura (codasignatura, nombre) VALUES ('85J964D8', 'Bases de datos');
INSERT INTO asignatura (codasignatura, nombre) VALUES ('64J964K5', 'Sistemas informátic');
INSERT INTO alumno (nummatricula, nombre, fechanacimiento, telefono) VALUES (87654321, 'Chisela Colás', TO_DATE ('30/09/1999', 'dd/mm/yyyy'), '612345678');
INSERT INTO alumno (nummatricula, nombre, fechanacimiento, telefono) VALUES (87654322, 'Laura Pérez', TO_DATE ('30/09/1998', 'dd/mm/yyyy'), '612345677');
INSERT INTO alumno (nummatricula, nombre, fechanacimiento, telefono) VALUES (87654323, 'Benito García', TO_DATE ('30/09/2000', 'dd/mm/yyyy'), '612345676');
INSERT INTO alumno (nummatricula, nombre, fechanacimiento, telefono) VALUES (87654324, 'Alejandro Martínez', TO_DATE ('30/09/2001', 'dd/mm/yyyy'), '612345675');
INSERT INTO alumno (nummatricula, nombre, fechanacimiento, telefono) VALUES (87654325, 'Paula Gil', TO_DATE ('30/09/2002', 'dd/mm/yyyy'), '612345674');
INSERT INTO alumno (nummatricula, nombre, fechanacimiento, telefono) VALUES (87654326, 'María Naranjo', TO_DATE ('30/09/2003', 'dd/mm/yyyy'), '612345673');
INSERT INTO alumno (nummatricula, nombre, fechanacimiento, telefono) VALUES (87654327, 'David Domínguez', TO_DATE ('30/09/1997', 'dd/mm/yyyy'), '612345672');
INSERT INTO alumno (nummatricula, nombre, fechanacimiento, telefono) VALUES (87654328, 'Jose Manuel Segovia', TO_DATE ('30/09/1996', 'dd/mm/yyyy'), '612345671');
INSERT INTO alumno (nummatricula, nombre, fechanacimiento, telefono) VALUES (87654329, 'Inés Vela', TO_DATE ('30/09/2004', 'dd/mm/yyyy'), '612345670');
INSERT INTO alumno (nummatricula, nombre, fechanacimiento, telefono) VALUES (87654330, 'Antonio López', TO_DATE ('30/09/2005', 'dd/mm/yyyy'), '612345669');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654321,'12A587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654321,'85J587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654322,'12A587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654322,'85J587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654323,'12A587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654323,'85J587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654324,'12A587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654324,'85J587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654325,'12A587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654325,'85J587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654326,'12A587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654326,'85J587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654327,'12A587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654327,'85J587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654328,'12A587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654328,'85J587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654329,'12A587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654329,'85J587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654330,'12A587D6', '2021/2022');
INSERT INTO recibe (nummatricula, codasignatura, cursoescolar) VALUES (87654330,'85J587D6', '2021/2022');

--Apartado 3
INSERT INTO alumno (nummatricula, nombre) VALUES (87654331, 'Jose Méndez');
INSERT INTO alumno (nummatricula, nombre) VALUES (87654331, 'Adrián Hurtado');
--Al introducir el segundo da error (constraint violada) porque no puedes introducir los mismos valores en un campo que es primary key

--Apartado 4
INSERT INTO alumno (nummatricula, nombre) VALUES (87654332, 'Alba Blanco');
INSERT INTO alumno (nummatricula, nombre) VALUES (87654333, 'Marina Ferrández');
INSERT INTO alumno (nummatricula, nombre) VALUES (87654334, 'Pedro Nerges');

--Apartado 5
UPDATE alumno SET telefono = '612345667' WHERE nummatricula = 87654332;
UPDATE alumno SET telefono = '612345666' WHERE nummatricula = 87654333;
UPDATE alumno SET telefono = '612345665' WHERE nummatricula = 87654334;

--Apartado 6
UPDATE alumno SET fechanacimiento = to_date ('22/07/1981', 'dd/mm/yyyy') WHERE EXTRACT (YEAR FROM (fechanacimiento)) > 2000;

--Apartado 7 
UPDATE profesor SET especialidad = 'Informática' WHERE telefono = '%' AND nif_p NOT IN ('9%');

--Apartado 8
DELETE FROM recibe WHERE codasignatura = '85J587D6';

--Apartado 9
DELETE FROM asignatura WHERE codasignatura = '85J587D6';

--Apartado 10
TRUNCATE TABLE asignatura;
--Si quiero borrar los datos me da el fallo de que se referencian claves primarias el otras tablas (con fk) así que hay que borrar las foreign key antes.
--Se podría solucionar cambiando el tipo de borrado en el diseño

--Apartado 11
TRUNCATE TABLE profesor;
--Pasa lo mismo que en el caso anterior

--Apartado 12
UPDATE alumno SET nombre = upper (nombre);

--Apartado 13 
CREATE TABLE alumno_backup (
	nummatricula NUMBER (8),
	nombre VARCHAR2 (30),
	fechanacimiento DATE,
	telefono VARCHAR2 (9),
	CONSTRAINT pk_alumnobu PRIMARY KEY (nummatricula)
);

INSERT INTO alumno_backup (nummatricula, nombre, fechanacimiento, telefono) SELECT*FROM alumno;

























