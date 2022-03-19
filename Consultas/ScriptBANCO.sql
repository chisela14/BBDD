--ALTER session set "_oracle_script"=true;
--CREATE USER BANCO IDENTIFIED BY BANCO;
--GRANT CONNECT, RESOURCE, DBA TO BANCO;

--DROP TABLE MOVIMIENTO;
--DROP TABLE TIPO_MOVIMIENTO;
--DROP TABLE CUENTA;
--DROP TABLE SUCURSAL;
--DROP TABLE CLIENTE;


CREATE TABLE CLIENTE(
  COD_CLIENTE VARCHAR(20) CONSTRAINT PK_CLIENTE PRIMARY KEY,
  APELLIDOS VARCHAR(50) NOT NULL,
  NOMBRE VARCHAR (30) NOT NULL,
  DIRECCION VARCHAR (50) NOT NULL
);

CREATE TABLE SUCURSAL(
  COD_SUCURSAL NUMBER(6) CONSTRAINT PK_SUCURSAL PRIMARY KEY,
  DIRECCION VARCHAR (50) NOT NULL,
  CAPITAL_ANIO_ANTERIOR NUMBER(14,2)
);

CREATE TABLE TIPO_MOVIMIENTO(
  COD_TIPO_MOVIMIENTO VARCHAR(6) CONSTRAINT PK_TIPO_MOVIMIENTO PRIMARY KEY,
  DESCRIPCION VARCHAR(200),
  SALIDA VARCHAR(3) CHECK(SALIDA='S?' OR SALIDA='No'));

CREATE TABLE CUENTA(
  COD_CUENTA NUMBER(10) CONSTRAINT PK_CUENTA PRIMARY KEY,
  SALDO NUMBER (10,2) NOT NULL,
  INTERES NUMBER (5,4) NOT NULL CHECK (INTERES < 1),
  COD_CLIENTE VARCHAR(20),
  COD_SUCURSAL NUMBER(6),
 CONSTRAINT FK_CUENTA_CLIENTE FOREIGN KEY (COD_CLIENTE) REFERENCES CLIENTE (COD_CLIENTE),
  CONSTRAINT FK_CUENTA_SUCURSAL FOREIGN KEY (COD_SUCURSAL) REFERENCES SUCURSAL (COD_SUCURSAL) 
);

CREATE TABLE MOVIMIENTO(
  COD_CUENTA NUMBER(10),
  MES NUMBER (2) CHECK (MES >= 1 AND MES <= 12),
  NUM_MOV_MES NUMBER(6),
  IMPORTE NUMBER(12,2) NOT NULL,
  FECHA_HORA TIMESTAMP NOT NULL,
  COD_TIPO_MOVIMIENTO VARCHAR(6),
  CONSTRAINT PK_MOVIMIENTO PRIMARY KEY(COD_CUENTA, MES, NUM_MOV_MES),
  CONSTRAINT FK_MOVIMIENTO_CUENTA FOREIGN KEY (COD_CUENTA) REFERENCES CUENTA(COD_CUENTA) ON DELETE CASCADE,
  CONSTRAINT FK_MOVIMIENTO_TIPO_MOVIMIENTO FOREIGN KEY (COD_TIPO_MOVIMIENTO) REFERENCES  TIPO_MOVIMIENTO (COD_TIPO_MOVIMIENTO) 
);
  
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion) VALUES ('ARUBIO', 'Rubio Caballero', 'Ana', 'C/ Col?n, 10');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('ASOTILLO', 'Sotillo Roda', '?ngeles', 'C/ Donoso Cort?s, 1');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('CALONSO', 'Alonso Cordero', 'Carlos', 'Ctra. De la Playa, 67');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('CLUENGO', 'Luengo G?mez', 'Cristina', 'C/ Lepanto, 17');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('EPEREZ', 'P?rez Honda', 'Eusebio', 'Paseo Castellana, 230');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('FSANTOS', 'Santos P?rez', 'Fernando', 'Avda. Juan Carlos I, 10');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion) VALUES ('IBUADES', 'Buades Avaro', 'Ignacio', 'Avda. San Antonio, 4');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('JALONSO', 'Alonso Alfaro', 'Jer?nimo', 'Avda. Santa Marina, 31');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('JARANAZ', 'Aranaz Rodr?guez', 'Juan Luis', 'C/ Virgen del ?guila, 8');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('JBECERRA', 'Becerra S?nchez', 'Jos?', 'C/ Col?n, 10');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('JGOMEZ', 'G?mez Trillar', 'Joaqu?n', 'C/ Donoso Cort?s, 1');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('JMARTINEZ', 'Mart?nez Moraes', 'Juan', 'Ctra. De la Playa, 67');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion) VALUES ('JSALINAS', 'Salinas del Mar', 'Javier', 'C/ Lepanto, 17');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('JSANTOS', 'Santos P?rez', 'Jaime', 'Paseo Castellana, 230');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('MCARDO', 'Cardo Merita', 'Mar?a', 'Avda. Juan Carlos I, 10');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('MFRANCO', 'Franco Alonso', 'Mar?a', 'Avda. San Antonio, 4');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('MGUTIERREZ', 'Guti?rrez Carro', 'Mar?a', 'Avda. Santa Marina, 31');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion ) VALUES ('OLUENGO', 'Luengo Casta?o', 'Ofelia', 'C/ Virgen del ?guila, 8');
INSERT INTO CLIENTE (cod_cliente, apellidos, nombre, direccion) VALUES ('PALVAREZ', '?lvarez Morr?n', 'Paloma', 'C/ Virgen del ?guila, 8');

INSERT INTO SUCURSAL (cod_sucursal, direccion, capital_anio_anterior ) VALUES (1, 'Avda. Juan Carlos I, 10', 120347);
INSERT INTO SUCURSAL (cod_sucursal, direccion, capital_anio_anterior ) VALUES (2, 'Paseo Castellana, 230', 259089);
INSERT INTO SUCURSAL (cod_sucursal, direccion, capital_anio_anterior ) VALUES (3, 'Ctra. De la Playa, 67', 100786);
INSERT INTO SUCURSAL (cod_sucursal, direccion, capital_anio_anterior ) VALUES (4, 'C/ Lepanto, 17', 70531);
INSERT INTO SUCURSAL (cod_sucursal, direccion, capital_anio_anterior ) VALUES (5, 'C / Juan de la Cosa', 500000);

INSERT INTO TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida ) VALUES ('IE', 'Ingreso en efectivo', 'No');
INSERT INTO TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida ) VALUES ('PR', 'Pago de recibo', 'S?');
INSERT INTO TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida ) VALUES ('PT', 'Pago con tarjeta', 'S?');
INSERT INTO TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida ) VALUES ('RC', 'Retirada por cajero autom?tico', 'S?');
INSERT INTO TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida ) VALUES ('TR-E', 'Transferencia-Entrada', 'No');
INSERT INTO TIPO_MOVIMIENTO (cod_tipo_movimiento, descripcion, salida ) VALUES ('TR-S', 'Transferencia-Salida', 'S?' );

INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (121229, 'EPEREZ', 12300, 0.12, '1');

INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (121221, 'EPEREZ', 12300, 0.12, 1);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (121222, 'CLUENGO', 3690, 0.03, 4);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (121231, 'ASOTILLO', 31980, 0.06, 2);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (121236, 'ARUBIO', 36900, 0.05, 1);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (121237, 'CALONSO', 12300, 0.07, 3);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (121255, 'EPEREZ', 36900, 0.01, 3);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (121574, 'JBECERRA', 184500, 0.1, 2);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (124334, 'IBUADES', 15375, 0.01, 3);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (131274, 'EPEREZ', 14760, 0.11, 1);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (156234, 'JALONSO', 4920, 0.03, 4);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (185964, 'EPEREZ', 36900, 0.025, 4);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (199234, 'FSANTOS', 49200, 0.11, 2);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (331234, 'FSANTOS', 15375, 0.01, 2);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (881234, 'ASOTILLO', 7380, 0.031, 4);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (921234, 'FSANTOS', 29520, 0.2, 3);
INSERT INTO CUENTA (cod_cuenta, cod_cliente, saldo, interes, cod_sucursal) VALUES (961234, 'JARANAZ', 73800, 0.014, 1);

INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 1, 'IE', 120, TO_TIMESTAMP('23/1/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 2, 'TR-S', 300, TO_TIMESTAMP('30/1/2007 22:00:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 3, 'RC', 300, TO_TIMESTAMP('23/1/2007 21:05:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 4, 'PT', 1500, TO_TIMESTAMP('22/1/2007 14:55:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 5, 'IE', 600, TO_TIMESTAMP('21/1/2007 12:43:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 6, 'IE', 40, TO_TIMESTAMP('20/1/2007 23:30:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 7, 'TR-S', 125, TO_TIMESTAMP('1/1/2007 22:14:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 8, 'RC', 125, TO_TIMESTAMP('13/1/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 9, 'PT', 100, TO_TIMESTAMP('12/1/2007 22:00:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 10, 'IE', 240, TO_TIMESTAMP('12/1/2007 23:30:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 1, 11, 'TR-S', 400, TO_TIMESTAMP('11/1/2007 22:14:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 2, 1, 'TR-S', 125, TO_TIMESTAMP('1/2/2007 22:14:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 2, 2, 'RC', 125, TO_TIMESTAMP('13/2/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 2, 3, 'PT', 100, TO_TIMESTAMP('12/2/2007 22:00:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 2, 4, 'TR-S', 400, TO_TIMESTAMP('2/2/2007 14:55:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121221, 2, 5, 'RC', 60, TO_TIMESTAMP('13/2/2007 12:43:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121231, 1, 1, 'PR', 300, TO_TIMESTAMP('1/1/2007 12:45:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121231, 1, 2, 'IE', 30, TO_TIMESTAMP('11/1/2007 21:05:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121231, 2, 1, 'RC', 260, TO_TIMESTAMP('2/2/2007 13:20:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121231, 2, 2, 'PT', 100, TO_TIMESTAMP('12/2/2007 22:00:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121231, 2, 3, 'TR-S', 125, TO_TIMESTAMP('1/2/2007 22:14:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121231, 2, 4, 'IE', 40, TO_TIMESTAMP('20/2/2007 23:30:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121231, 3, 1, 'TR-S', 100, TO_TIMESTAMP('3/3/2007 14:15:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121231, 3, 2, 'RC', 125, TO_TIMESTAMP('13/3/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121236, 1, 1, 'IE', 600, TO_TIMESTAMP('21/1/2007 12:43:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121236, 1, 2, 'TR-S', 300, TO_TIMESTAMP('30/1/2007 22:00:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121236, 2, 1, 'PT', 1500, TO_TIMESTAMP('22/2/2007 14:55:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121236, 2, 2, 'IE', 120, TO_TIMESTAMP('23/2/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121236, 2, 3, 'IE', 240, TO_TIMESTAMP('12/2/2007 23:30:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121236, 2, 4, 'RC', 60, TO_TIMESTAMP('13/2/2007 12:43:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121236, 3, 1, 'RC', 300, TO_TIMESTAMP('23/3/2007 21:05:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121236, 3, 2, 'TR-S', 400, TO_TIMESTAMP('11/3/2007 22:14:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 2, 1, 'TR-S', 125, TO_TIMESTAMP('1/2/2007 22:14:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 2, 2, 'RC', 125, TO_TIMESTAMP('13/2/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 2, 3, 'PT', 100, TO_TIMESTAMP('12/2/2007 22:00:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 2, 4, 'TR-S', 400, TO_TIMESTAMP('2/2/2007 14:55:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 3, 1, 'RC', 60, TO_TIMESTAMP('13/3/2007 12:43:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 3, 2, 'IE', 240, TO_TIMESTAMP('12/3/2007 23:30:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 3, 3, 'TR-S', 400, TO_TIMESTAMP('11/3/2007 22:14:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 3, 4, 'IE', 120, TO_TIMESTAMP('23/3/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 3, 5, 'TR-S', 300, TO_TIMESTAMP('30/3/2007 22:00:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 3, 6, 'RC', 300, TO_TIMESTAMP('23/3/2007 21:05:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 3, 7, 'PT', 1500, TO_TIMESTAMP('22/3/2007 14:55:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 3, 8, 'IE', 600, TO_TIMESTAMP('21/3/2007 12:43:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (121574, 3, 9, 'IE', 40, TO_TIMESTAMP('20/3/2007 23:30:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 1, 1, 'RC', 300, TO_TIMESTAMP('23/1/2007 21:05:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 1, 2, 'PT', 1500, TO_TIMESTAMP('22/1/2007 14:55:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 1, 3, 'IE', 600, TO_TIMESTAMP('21/1/2007 12:43:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 1, 4, 'IE', 40, TO_TIMESTAMP('20/1/2007 23:30:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 1, 5, 'TR-S', 125, TO_TIMESTAMP('1/1/2007 22:14:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 1, 6, 'RC', 125, TO_TIMESTAMP('13/1/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 2, 1, 'RC', 125, TO_TIMESTAMP('13/2/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 2, 2, 'PT', 100, TO_TIMESTAMP('12/2/2007 22:00:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 2, 3, 'TR-S', 400, TO_TIMESTAMP('2/2/2007 14:55:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 2, 4, 'RC', 60, TO_TIMESTAMP('13/2/2007 12:43:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 2, 5, 'IE', 240, TO_TIMESTAMP('12/2/2007 23:30:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 2, 6, 'TR-S', 400, TO_TIMESTAMP('11/2/2007 22:14:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 2, 7, 'IE', 120, TO_TIMESTAMP('23/2/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 2, 8, 'TR-S', 300, TO_TIMESTAMP('28/2/2007 22:00:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 3, 1, 'IE', 120, TO_TIMESTAMP('23/3/2007 16:33:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 3, 2, 'TR-S', 300, TO_TIMESTAMP('30/3/2007 22:00:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 3, 3, 'IE', 40, TO_TIMESTAMP('20/3/2007 23:30:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (156234, 3, 4, 'TR-S', 125, TO_TIMESTAMP('1/3/2007 22:14:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (881234, 1, 1, 'TR-S', 400, TO_TIMESTAMP('2/1/2007 14:55:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (881234, 1, 2, 'TR-S', 150, TO_TIMESTAMP('11/1/2007 13:20:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (881234, 3, 1, 'IE', 100, TO_TIMESTAMP('3/3/2007 12:45:00', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTO (cod_cuenta, mes, num_mov_mes, cod_tipo_movimiento, importe, fecha_hora) VALUES (881234, 3, 2, 'IE', 300, TO_TIMESTAMP('12/3/2007 14:15:00', 'DD/MM/YYYY HH24:MI:SS'));

COMMIT;