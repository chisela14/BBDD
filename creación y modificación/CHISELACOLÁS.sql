ALTER session set "_oracle_script"=true;
CREATE USER COLASCHISELAEJE1 IDENTIFIED BY COLASCHISELAEJE1;
GRANT CONNECT, RESOURCE, DBA TO COLASCHISELAEJE1;

CREATE TABLE T_CARGOS(
	idcargo VARCHAR2(2),
	descripcioncargo VARCHAR2(50),
	CONSTRAINT pk_t_cargos PRIMARY KEY (idcargo),
	CONSTRAINT ch_t_cargos CHECK (idcargo IN ('FC','RC','RF','CO'))
);

CREATE TABLE T_ESTRATOS(
	estrato NUMBER (5),
	descripcion VARCHAR2(50),
	totalusuarios NUMBER (5) DEFAULT 0,
	CONSTRAINT pk_t_estratos PRIMARY KEY (estrato),
	CONSTRAINT ch_estrato CHECK (estrato > 39),
	CONSTRAINT ch_usuarios_positivos CHECK (totalusuarios > 0)
);

CREATE TABLE T_SERVICIOS(
	servicio VARCHAR2(3),
	nservicio NUMBER(4),
	descripcionservicio VARCHAR2(200) NOT NULL,
	cupousuarios NUMBER (6),
	nusuarios NUMBER (10) DEFAULT 0,
	testrato NUMBER (5),
	importefijo NUMBER (8,2),
	valorconsumo NUMBER (10,2),
	CONSTRAINT pk_t_servicios PRIMARY KEY (servicio, nservicio),
	CONSTRAINT ch_nusuarios CHECK (nusuarios >= 0),
	CONSTRAINT fk_t_servicios FOREIGN KEY (testrato) REFERENCES T_ESTRATOS (estrato)
);

CREATE TABLE T_MOVIMIENTOS(
	id_cliente NUMBER(5),
	fechaimporte DATE DEFAULT SYSDATE,
	fechamovimiento DATE, 
	cargo_aplicado VARCHAR2(2) NOT NULL,
	servicio VARCHAR2(3) NOT NULL,
	nservicio NUMBER(4) NOT NULL,
	consumo NUMBER (10,2) NOT NULL,
	importefac NUMBER (10,2) NOT NULL,
	importerec NUMBER (10,2) NOT NULL,
	impmorterefa NUMBER (10,2) NOT NULL,
	importeconv NUMBER (10,2) NOT NULL,
	CONSTRAINT pk_t_movimientos PRIMARY KEY (id_cliente, cargo_aplicado, servicio, nservicio),
	CONSTRAINT fk_t_movimientos FOREIGN KEY (cargo_aplicado) REFERENCES T_CARGOS (idcargo),
	CONSTRAINT fk2_t_movimmientos FOREIGN KEY (servicio, nservicio) REFERENCES T_SERVICIOS (servicio, nservicio)
);

CREATE TABLE T_MAESTRO(
	suscripcion NUMBER(5),
	alta DATE,
	nombre VARCHAR2(20) NOT NULL,
	direccion VARCHAR2(30),
	barrio VARCHAR2(16),
	saldoactual NUMBER (10,2),
	estrato NUMBER(5),
	mail VARCHAR2(80) UNIQUE,
	fechaalta DATE DEFAULT SYSDATE,
	CONSTRAINT pk_t_maestro PRIMARY KEY (suscripcion),
	CONSTRAINT ch_suscripcion CHECK (suscripcion > 0),
	CONSTRAINT fk2_t_maestro FOREIGN KEY (estrato) REFERENCES T_ESTRATOS (estrato),
	CONSTRAINT ch_fechaalta CHECK (fechaalta > (to_date ('01/01/1990', 'dd/mm/yyyy')))
);
-- Esta instrucción me daba fallo dentro de la tabla así que la he sacado para al menos poder crear la tabla y que se vea en el diagrama
ALTER TABLE T_MAESTRO ADD CONSTRAINT fk_t_maestro FOREIGN KEY (suscripcion) REFERENCES T_MOVIMIENTOS (id_cliente);

ALTER TABLE T_MAESTRO ADD dni VARCHAR2(9) UNIQUE;
ALTER TABLE T_MAESTRO DROP COLUMN barrio;
ALTER TABLE T_ESTRATOS MODIFY descripcion VARCHAR2(60);

DROP TABLE T_CARGOS CASCADE CONSTRAINTS;
DROP TABLE T_ESTRATOS CASCADE CONSTRAINTS;
DROP TABLE T_SERVICIOS CASCADE CONSTRAINTS;
DROP TABLE T_MOVIMIENTOS CASCADE CONSTRAINTS;
DROP TABLE T_MAESTRO CASCADE CONSTRAINTS;


