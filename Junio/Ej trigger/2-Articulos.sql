--alter session set "_oracle_script"=true;   
--create user EJTRIG2 identified by EJTRIG2;
--GRANT CONNECT, RESOURCE, DBA TO EJTRIG2;

--1.- Cree las tablas con las siguientes estructuras:

create table articulos(
codigo number(4) not null,
descripcion varchar2(40),
precio number (6,2),
stock number(4),
constraint PK_articulos_codigo primary key (codigo) );

create table ventas(
codigo number(4),
cantidad number(4),
fecha date,
constraint FK_ventas_articulos foreign key (codigo) references articulos(codigo)
);

--2.- Cree una secuencia llamada "sec_codigoart", estableciendo que comience en 1, sus
--valores estén entre 1 y 9999 y se incrementen en 1. Antes elimínela por si existe.

drop sequence sec_codigoart;
create sequence sec_codigoart start with 1 increment by 1;

--3.- Cree un trigger que coloque el siguiente valor de una secuencia para el código de
--"articulos" cada vez que se ingrese un nuevo artículo. Podemos ingresar un nuevo registro
--en "articulos" sin incluir el código porque lo ingresará el disparador luego de calcularlo.
--Si al ingresar un registro en "articulos" incluimos un valor para código, será ignorado y
--reemplazado por el valor calculado por el disparador.

CREATE OR REPLACE
TRIGGER ANNADIR_COD_ARTICULO
BEFORE INSERT ON ARTICULOS 
FOR EACH ROW
BEGIN
    SELECT sec_codigoart.nextval INTO :NEW.CODIGO FROM DUAL;
END ANNADIR_COD_ARTICULO;

--4.- Ingrese algunos registros en "articulos" sin incluir el código:
insert into articulos (descripcion, precio, stock) values ('cuaderno rayado 24h',4.5,100);
insert into articulos (descripcion, precio, stock) values ('cuaderno liso 12h',3.5,150);
insert into articulos (descripcion, precio, stock) values ('lapices color x6',8.4,60);

--5.- Ingrese algunos registros en "articulos" incluyendo el código:
insert into articulos values(160,'regla 20cm.',6.5,40);
insert into articulos values(173,'compas metal',14,35);
insert into articulos values(234,'goma lapiz',0.95,200);

--6.- Cree un trigger a nivel de fila sobre la tabla "ventas" para el evento se inserción. 
--Cada vez que se realiza un"insert" sobre "ventas", el disparador se ejecuta. El disparador controla 
--que la cantidad que se intenta vender sea menor o igual al stock del artículo y actualiza el campo "stock" 
--de "articulos", restando al valor anterior la cantidad vendida. Si la cantidad supera el stock, 
--debe producirse un error, revertirse la acción y mostrar un mensaje.

CREATE OR REPLACE
TRIGGER INSERTAR_VENTAS
BEFORE INSERT ON VENTAS
FOR EACH ROW
DECLARE
    v_stock ARTICULOS.STOCK%TYPE;
BEGIN
    SELECT STOCK INTO v_stock FROM ARTICULOS WHERE CODIGO = :NEW.CODIGO;
    IF :NEW.CANTIDAD>v_stock THEN
        RAISE_APPLICATION_ERROR(-20001, 'No hay suficientes artículos en stock');
    ELSE
        UPDATE ARTICULOS SET STOCK = STOCK - :NEW.CANTIDAD WHERE CODIGO = :NEW.CODIGO;
    END IF;
END INSERTAR_VENTAS;

--COMPROBAR (TAMBIEN VALE PARA EL 7)
INSERT INTO VENTAS VALUES(20, 3, SYSDATE); --COD INCORRECTO
INSERT INTO VENTAS VALUES(2, 5, SYSDATE); --COD CORRECTO VENTA CORRECTA
INSERT INTO VENTAS VALUES(2, 300, SYSDATE); --NO HAY STOCK

--7.- El comercio quiere que se realicen las ventas de lunes a viernes de 8 a 18 hs. Reemplace
--el trigger creado anteriormente para que no permita que se realicen
--ventas fuera de los días y horarios especificados y muestre un mensaje de error.

CREATE OR REPLACE
TRIGGER INSERTAR_VENTAS
BEFORE INSERT ON VENTAS
FOR EACH ROW
DECLARE
    v_stock ARTICULOS.STOCK%TYPE;
BEGIN
    IF (to_char(sysdate, 'DY','nls_date_language=SPANISH') in ('LUN','MAR','MIE','JUE','VIE')) 
    AND (to_number(to_char(sysdate, 'HH24')) between 8 and 18) THEN
        SELECT STOCK INTO v_stock FROM ARTICULOS WHERE CODIGO = :NEW.CODIGO;
        IF :NEW.CANTIDAD>v_stock THEN
            RAISE_APPLICATION_ERROR(-20001, 'No hay suficientes artículos en stock');
        ELSE
            UPDATE ARTICULOS SET STOCK = STOCK - :NEW.CANTIDAD WHERE CODIGO = :NEW.CODIGO;
        END IF;
    ELSE
        raise_application_error(-20002,'Solo se pueden realizar ventas de lunes a viernes de 8 a 18.');
    END IF; 
END INSERTAR_VENTAS;

--8.- El comercio quiere que los registros de la tabla "articulos" puedan ser ingresados,
--modificados y/o eliminados únicamente los sábados de 8 a 12 hs. Cree un trigger
--"tr_articulos" que No permita que se realicen inserciones, actualizaciones ni
--eliminaciones en "articulos" fuera del horario especificado los días sábados, mostrando
--un mensaje de error. Recuerde que al ingresar un registro en "ventas", se actualiza el
--"stock" en "articulos"; el trigger debe permitir las actualizaciones del campo "stock" en
--"articulos" de lunes a viernes de 8 a 18 hs. (horario de ventas)

CREATE OR REPLACE 
TRIGGER TR_ARTICULOS
BEFORE INSERT OR UPDATE OR DELETE ON ARTICULOS
FOR EACH ROW
BEGIN
    IF UPDATING ('STOCK') THEN
        IF (to_char(sysdate, 'DY','nls_date_language=SPANISH') not in ('LUN','MAR','MIE','JUE','VIE')) AND (to_number(to_char(sysdate, 'HH24')) not between 8 and 18) THEN
            RAISE_APPLICATION_ERROR(-20002,'Solo se pueden realizar ventas de lunes a viernes de 8 a 18.');
        END IF;
    ELSE
        IF ((to_char(sysdate,'dy','nls_date_language=SPANISH') not in ('sáb')) and (to_number(to_char(sysdate,'HH24')) not between 8 and 12)) THEN
            RAISE_APPLICATION_ERROR(-20004,'Sólo se pueden hacer operaciones los sábados de 8 a 12');
        END IF;
    END IF;
END TR_ARTICULOS;

--9. Diseñar un disparador que al insertar un nuevo empleado, automáticamente quede
--actualizado el presupuesto total del departamento al que el empleado pertenece,
--añadiéndole el salario asignado al nuevo empleado.
--Diseñar un disparador que al modificar el salario de un empleado,
--automáticamente quede actualizado el presupuesto total del departamento al que
--el empleado pertenece, en función del nuevo salario asignado al empleado.

CREATE TABLE DEPARTAMENTO(
    NUM_DEP VARCHAR2(10),
    NOMBRE VARCHAR2(10),
    PRESUPUESTO NUMBER(20,1),
    CONSTRAINT pk_departamento PRIMARY KEY(NUM_DEP)
)

CREATE TABLE EMPLEADO(
    NSS NUMBER(8),
    NOMBRE VARCHAR2(10),
    SALARIO NUMBER(4,1),
    NUM_DEP VARCHAR2(10),
    CONSTRAINT pk_empleado PRIMARY KEY(NSS),
    CONSTRAINT fk_empleado FOREIGN KEY(NUM_DEP) REFERENCES DEPARTAMENTO(NUM_DEP)
);

CREATE OR REPLACE
TRIGGER PRESUPUESTO_DEPT
AFTER INSERT OR UPDATE OF SALARIO ON EMPLEADO
BEGIN
    UPDATE DEPARTAMENTO SET PRESUPUESTO = PRESUPUESTO + :NEW.SALARIO WHERE NUM_DEP = :NEW.NUM_DEP;
END PRESUPUESTO_DEPT;



