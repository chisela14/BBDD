CREATE TABLE PERSONA (
	id NUMBER(10),
	nif VARCHAR2(9),
	nombre VARCHAR2(25),
	apellido1 VARCHAR2(50),
	apellido2 VARCHAR2(50),
	ciudad VARCHAR2(25),
	direccion VARCHAR2(50),
	telefono VARCHAR2(9),
	fecha_nacimiento DATE,
	sexo VARCHAR2 (1),
	tipo varchar2 (1),
	CONSTRAINT pk_persona PRIMARY KEY (id),
	CONSTRAINT ch_sexo CHECK (sexo IN ('M','H')),
	CONSTRAINT ch_tipo CHECK (tipo IN ('A','B'))
);

CREATE TABLE DEPARTAMENTO (
	id NUMBER(10),
	nombre VARCHAR2(50),
	CONSTRAINT pk_departamento PRIMARY KEY (id)
);

CREATE TABLE PROFESOR (
	id_profesor NUMBER(10),
	id_departamento NUMBER(10),
	CONSTRAINT pk_profesor PRIMARY KEY (id_profesor),
	CONSTRAINT fk_profesor FOREIGN KEY (id_profesor) REFERENCES PERSONA (id),
	CONSTRAINT fk2_profesor FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO (id)
);

CREATE TABLE CURSO_ESCOLAR (
	id NUMBER(10),
	anyo_inicio DATE,
	anyo_fin DATE, 
	CONSTRAINT pk_curso_escolar PRIMARY KEY (id),
	--constraint ch_a_inicio check (anyo_inicio = extract(year from anyo_inicio)),
	--constraint ch_a_fin check (anyo_fin = extract(year from anyo_fin))
);

CREATE TABLE GRADO (
	id NUMBER(10),
	nombre VARCHAR2(100),
	CONSTRAINT pk_grado PRIMARY KEY (id),
);

CREATE TABLE ASIGNATURA(
	id NUMBER(10),
	nombre VARCHAR2(100),
	creditos NUMBER(4,2),
	tipo varchar2 (1)
	curso NUMBER(3),
	cuatrimestre NUMBER(3),
	id_profesor NUMBER(10),
	id_grado NUMBER(10),
	CONSTRAINT pk_asignatura PRIMARY KEY (id),
	CONSTRAINT ch_tipo CHECK (tipo IN ('A','B'))
	CONSTRAINT fk_asignatura FOREIGN KEY (id_profesor) REFERENCES PROFESOR (id_profesor),
	CONSTRAINT fk2_asignatura FOREIGN KEY (id_grado) REFERENCES GRADO (id_grado),
);

CREATE TABLE ALUMNO_SE_MATRICULA_ASIGNATURA (
	id_alumno NUMBER(10),
	id_asignatura NUMBER(10),
	id_curso_escolar NUMBER(10),
	CONSTRAINT pk_alumno_asignatura (id_alumno, id_asignatura, id_curso_escolar),
	CONSTRAINT fk_alumno_asignatura FOREIGN KEY (id_alumno) REFERENCES PERSONA (id),
	CONSTRAINT fk2_alumno_asignatura FOREIGN KEY (id_asignatura) REFERENCES ASIGNATURA (id),
	CONSTRAINT fk3_alumno_asignatura FOREIGN KEY (id_curso_escolar) REFERENCES CURSO_ESCOLAR (id)
);


