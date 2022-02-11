CREATE TABLE fabricante (
	codigo NUMBER (10),
	nombre varchar2 (100),
	CONSTRAINT pk_fabricante PRIMARY KEY (codigo)
);

CREATE TABLE producto (
	codigo NUMBER (10),
	nombre varchar2 (100),
	precio NUMBER (4,2),
	codigo_fabricante NUMBER (10),
	CONSTRAINT pk_producto PRIMARY KEY (codigo),
	CONSTRAINT fk_producto FOREIGN KEY  (codigo_fabricante) REFERENCES fabricante (codigo)
);

INSERT INTO FABRICANTE (nombre)
VALUES ('Asus');
INSERT INTO FABRICANTE (nombre)
VALUES ('Lenovo');
INSERT INTO FABRICANTE (nombre)
VALUES ('Hewlett-Packard');
INSERT INTO FABRICANTE (nombre)
VALUES ('Samsung');
INSERT INTO FABRICANTE (nombre)
VALUES ('Seagate');
INSERT INTO FABRICANTE (nombre)
VALUES ('Crucial');
INSERT INTO FABRICANTE (nombre)
VALUES ('Gigabyte');
INSERT INTO FABRICANTE (nombre)
VALUES ('Huawei');
INSERT INTO FABRICANTE (nombre)
VALUES ('Xiaomi');

