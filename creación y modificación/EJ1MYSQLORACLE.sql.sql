CREATE TABLE DEPARTAMENTO (
	codigo NUMBER (10),
	nombre VARCHAR2 (100) not null,
	presupuesto binary_DOUBLE not null,
	CONSTRAINT pk_departamento PRIMARY KEY (codigo)
);

CREATE TABLE EMPLEADO (
	codigo number (10),
	nif VARCHAR2 (9) not null,
	nombre VARCHAR2 (100) not null,
	apellido1 VARCHAR2 (100) not null,
	apellido2 VARCHAR2 (100),
	codigo_departamento number (10),
	CONSTRAINT pk_empleado PRIMARY KEY (codigo),
	CONSTRAINT fk_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo)
);