--ALTER session set "_oracle_script"=true;
--CREATE USER BOLETIN1 IDENTIFIED BY BOLETIN1;
--GRANT CONNECT, RESOURCE, DBA TO BOLETIN1;

--DROP TABLE EMPLEADO;
--DROP TABLE DEPARTAMENTO;
--DROP TABLE SUMINISTRO;
--DROP TABLE EXISTENCIA;
--DROP TABLE PIEZA;
--DROP TABLE ALMACEN;
--DROP TABLE EMPRESA;
--DROP TABLE TIPO_PIEZA;

CREATE TABLE TIPO_PIEZA ( 
	TIPO VARCHAR2(2), 
	DESCRIPCION VARCHAR2(25), 
	CONSTRAINT pk_tipo_pieza PRIMARY KEY (TIPO) 
	);
	
CREATE TABLE EMPRESA ( 
	CIF VARCHAR2(9), 
	NOMBRE VARCHAR2(50), 
	--EN EL ENUNCIADO PONE NUMBER(11,4) PERO NO ENTIENDO POR QUÉ, ASÍ QUE LO PONGO A VARCHAR2
	TELEFONO VARCHAR2(9), 
	DIRECCION VARCHAR2(50), 
	LOCALIDAD VARCHAR2(50), 
	PROVINCIA VARCHAR2(50), 
	CONSTRAINT pk_empresa PRIMARY KEY (CIF)
	);
	
CREATE TABLE ALMACEN ( 
	N_ALMACEN NUMBER(2), 
	DESCRIPCION VARCHAR2(1000), 
	DIRECCION VARCHAR2(100), 
	CONSTRAINT pk_almacen PRIMARY KEY (N_ALMACEN) 
	);

CREATE TABLE PIEZA ( 
	TIPO VARCHAR2(2), 
	MODELO NUMBER(2), 
	PRECIO_VENTA NUMBER(11,4), 
	CONSTRAINT fk_pieza FOREIGN KEY (TIPO) REFERENCES TIPO_PIEZA(TIPO), 
	CONSTRAINT pk_pieza PRIMARY KEY (TIPO,MODELO)
	);

 CREATE TABLE EXISTENCIA ( 
	TIPO VARCHAR2(2), 
	MODELO NUMBER(2), 
	N_ALMACEN NUMBER(2), 
	CANTIDAD NUMBER(9), 
	CONSTRAINT fk_existencia FOREIGN KEY (TIPO,MODELO) REFERENCES PIEZA(TIPO,MODELO), 
	CONSTRAINT fk2_existencia FOREIGN KEY (N_ALMACEN) REFERENCES ALMACEN(N_ALMACEN), 
	CONSTRAINT pk_existencia PRIMARY KEY (TIPO,MODELO,N_ALMACEN) 
	);

CREATE TABLE SUMINISTRO ( 
	CIF VARCHAR(9), 
	TIPO VARCHAR2(2), 
	MODELO NUMBER(2), 
	PRECIO_COMPRA NUMBER(11,4), 
	CONSTRAINT fk_suministro FOREIGN KEY (CIF) REFERENCES EMPRESA(CIF), 
	CONSTRAINT fk2_suministro FOREIGN KEY (TIPO,MODELO) REFERENCES PIEZA(TIPO,MODELO), 
	CONSTRAINT pk_suministro PRIMARY KEY (CIF,TIPO,MODELO) 
	);

CREATE TABLE DEPARTAMENTO (
	NUM_DEP NUMBER(3),
	NOMBRE VARCHAR2(50),
	CONSTRAINT pk_departamento PRIMARY KEY (NUM_DEP)
	);

CREATE TABLE EMPLEADO (
	EMP_NO NUMBER(3),
	APELLIDO VARCHAR2(50),
	SALARIO NUMBER(6,2),
	OFICIO VARCHAR2(50),
	FECHA_ALTA DATE,
	N_ALMACEN NUMBER(2),
	NUM_DEP NUMBER(3),
	CONSTRAINT fk_empleado FOREIGN KEY (N_ALMACEN) REFERENCES ALMACEN(N_ALMACEN),
	CONSTRAINT fk2_empleado FOREIGN KEY (NUM_DEP) REFERENCES DEPARTAMENTO(NUM_DEP),
	CONSTRAINT pk_empleado PRIMARY KEY (EMP_NO)
	);

--INSERTAR DATOS DE EJEMPLO

INSERT INTO TIPO_PIEZA VALUES('A','TABLA');
INSERT INTO TIPO_PIEZA VALUES('B','BARRA');
INSERT INTO TIPO_PIEZA VALUES('C','BLOQUE');

INSERT INTO EMPRESA VALUES('12345678A','CITROEN','976111222','AV. JOSE LAGUILLO','SEVILLA','SEVILLA');
INSERT INTO EMPRESA VALUES('12345678B','FORD','976111333','C. RAPAZALLA','CAMAS','SEVILLA');
INSERT INTO EMPRESA VALUES('12345678C','HONDA','976333222','C. POSTIGOS','MALAGA','MALAGA');

INSERT INTO ALMACEN VALUES(1,'POLIGONO','C. ECONOMIA');
INSERT INTO ALMACEN VALUES(2,'CENTRO','C. MAYO');
INSERT INTO ALMACEN VALUES(3,'POLIGONO','C.TRABAJO');

INSERT INTO PIEZA VALUES('A',1,2);
INSERT INTO PIEZA VALUES('B',5,5);
INSERT INTO PIEZA VALUES('C',3,10);

INSERT INTO EXISTENCIA VALUES('A',1,1,50);
INSERT INTO EXISTENCIA VALUES('B',5,2,20);
INSERT INTO EXISTENCIA VALUES('C',3,3,10);

INSERT INTO SUMINISTRO VALUES('12345678A','A',1,0.50);
INSERT INTO SUMINISTRO VALUES('12345678B','B',5,1);
INSERT INTO SUMINISTRO VALUES('12345678C','C',3,3);

INSERT INTO DEPARTAMENTO VALUES (1,'DIRECCION');
INSERT INTO DEPARTAMENTO VALUES (2,'COMERCIAL');
INSERT INTO DEPARTAMENTO VALUES (3,'GESTION');

--FECHAS: DD-MON-YYYY
INSERT INTO EMPLEADO VALUES(3,'GARCIA',700,'MECANICO','11-oct-2007',1,3);
INSERT INTO EMPLEADO VALUES(2,'DOMINGUEZ',800,'CONTABLE','18-jul-2004',2,2);
INSERT INTO EMPLEADO VALUES(1,'LOPEZ',1000,'DIRECTOR','20-mar-2002',3,1);

COMMIT

