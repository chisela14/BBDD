--ALTER session set "_oracle_script"=true;
--CREATE USER RELACION3 IDENTIFIED BY RELACION3;
--GRANT CONNECT, RESOURCE, DBA TO RELACION3;

DROP TABLE PRESTAMOS;
DROP TABLE LIBROS;
DROP TABLE EDITORIALES;
DROP TABLE AUTORES;
DROP TABLE LECTORES;

CREATE TABLE LECTORES(
	COD_LE NUMBER(6) PRIMARY KEY,
	APELLIDOS_LE VARCHAR2(30),
	NOMBRE_LE VARCHAR2(15),
	TIPO_LE CHAR(10), --NOT NULL, --EN PRINCIPO ES NOT NULL PERO NO SE QUÉ QUIERE GUARDAR Y NO AFECTA A LOS EJERCICIOS
	SEXO_LE CHAR(1) DEFAULT 'H' NOT NULL CHECK (SEXO_LE IN('H','M')),--LE PONGO DEFAULT PARA NO COMPLICAR LOS INSERTS DE PRUEBA
	MOROSO_LE DATE DEFAULT NULL,
	-- Fecha de levantamiento de la sanción
	SANCIONES_LE NUMBER(2)
	-- Nº de sanciones hasta la fecha
);

CREATE TABLE AUTORES(
	COD_AU NUMBER(6) PRIMARY KEY,
	NOMBRE_AU VARCHAR2(30)
);

CREATE TABLE EDITORIALES(
	COD_ED NUMBER(6) PRIMARY KEY,
	NOMBRE_ED VARCHAR2(30)
);

CREATE TABLE LIBROS(
	COD_LI NUMBER(6) PRIMARY KEY,
	AUTOR_LI NUMBER(6) REFERENCES AUTORES,
	TITULO_LI VARCHAR2(50),
	EDITORIAL_LI NUMBER(6) REFERENCES EDITORIALES,
	ESTADO_LI NUMBER(2),-- no se que guarda esto, le pondre 1 a todos los libros que inserte
	PRESTADO_LI CHAR(1) DEFAULT ('N')
);

CREATE TABLE PRESTAMOS(
	CODLEC_PR NUMBER(6) REFERENCES LECTORES,
	CODLIB_PR NUMBER(6) REFERENCES LIBROS,
	FECHA_PR DATE DEFAULT SYSDATE,
	DEVOL_PR DATE DEFAULT NULL, -- Fecha de devolución
	PRIMARY KEY ( CODLEC_PR, CODLIB_PR, FECHA_PR),
	CONSTRAINT CH_FECHA CHECK (DEVOL_PR > FECHA_PR)
);

INSERT INTO AUTORES VALUES(1, 'Brandon Sanderson');
INSERT INTO EDITORIALES VALUES(1,'NOVA');
INSERT INTO LIBROS VALUES(1,1,'El camino de los reyes',1,1,'N');
INSERT INTO LIBROS VALUES(2,1,'Palabras radiantes',1,1,'S');
INSERT INTO LECTORES(COD_LE, NOMBRE_LE, MOROSO_LE, SANCIONES_LE) VALUES(0,'SANCIONADO', '11-jul-2022', 1);
INSERT INTO LECTORES(COD_LE, NOMBRE_LE, SANCIONES_LE) VALUES(1,'PRIMERA', 0);
INSERT INTO LECTORES(COD_LE, NOMBRE_LE, SANCIONES_LE) VALUES(2,'SEGUNDA', 1);
INSERT INTO LECTORES(COD_LE, NOMBRE_LE, SANCIONES_LE) VALUES(3,'TERCERA', 2);
INSERT INTO LECTORES(COD_LE, NOMBRE_LE, SANCIONES_LE) VALUES(4,'CUARTA', 3);




