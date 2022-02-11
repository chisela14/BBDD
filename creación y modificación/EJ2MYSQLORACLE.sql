CREATE TABLE comercial (
	id number (10),
	nombre VARCHAR2 (100) not null,
	apellido1 VARCHAR2 (100) not null,
	apellido2 VARCHAR2 (100),
	ciudad VARCHAR2 (100),
	comision NUMBER (4,2),
	CONSTRAINT pk_comercial PRIMARY KEY (id)
);

CREATE TABLE cliente (
	id number(10),
	nombre VARCHAR2 (100) not null,
	apellido1 VARCHAR2 (100) not null,
	apellido2 VARCHAR2 (100),
	ciudad VARCHAR2 (100),
	categoria number(10),
	CONSTRAINT pk_cliente PRIMARY KEY (id)
);

-- r.clase (no funcionaria porque categoria es number)
ALTER TABLE CLIENTE ADD CONSTRAINT ch_categoria CHECK (categoria IN ('primera', 'segunda', 'tercera'));
--CAMBIAMOS TIPO DE DATO
ALTER TABLE CLIENTE MODIFY categoria VARCHAR2(25);
-- DESACTIVAR CONTRAINT
ALTER TABLE CLIENTE DISABLE CONSTRAINT ch_categoria;

CREATE TABLE pedido (
	id number (10),
	cantidad binary_DOUBLE not null,
	fecha DATE DEFAULT sysdate, -- restriccion puesta en clase
	id_cliente number (10),
	id_comercial number (10),
	CONSTRAINT pk_pedido PRIMARY KEY (id),
	CONSTRAINT fk_pedido FOREIGN KEY (id_cliente) REFERENCES cliente (id),
	CONSTRAINT fk2_pedido FOREIGN KEY (id_comercial) REFERENCES comercial (id)
);