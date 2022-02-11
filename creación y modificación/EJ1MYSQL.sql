CREATE TABLE DEPARTAMENTO (
	codigo INT (10),
	nombre VARCHAR (100) not null,
	presupuesto DOUBLE not null,
	PRIMARY KEY (codigo)
);

CREATE TABLE EMPLEADO (
	codigo INT (10),
	nif VARCHAR (9) not null,
	nombre VARCHAR (100) not null,
	apellido1 VARCHAR (100) not null,
	apellido2 VARCHAR (100),
	codigo_departamento INT (10),
	PRIMARY KEY (codigo),
	FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo)
);

