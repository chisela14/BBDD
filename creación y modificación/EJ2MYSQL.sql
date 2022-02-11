CREATE TABLE comercial (
	id INT (10),
	nombre VARCHAR (100) not null,
	apellido1 VARCHAR (100) not null,
	apellido2 VARCHAR (100),
	ciudad VARCHAR (100),
	comision FLOAT,
	PRIMARY KEY (id)
);

CREATE TABLE cliente (
	id INT (10),
	nombre VARCHAR (100) not null,
	apellido1 VARCHAR (100) not null,
	apellido2 VARCHAR (100),
	ciudad VARCHAR (100),
	categoria INT (10),
	PRIMARY KEY (id)
);

CREATE TABLE pedido (
	id INT (10),
	cantidad DOUBLE not null,
	fecha DATE, 
	id_cliente INT (10),
	id_comercial INT (10),
	PRIMARY KEY (id),
	FOREIGN KEY (id_cliente) REFERENCES cliente (id),
	FOREIGN KEY (id_comercial) REFERENCES comercial (id)
);