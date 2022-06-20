--alter session set "_oracle_script"=true;   
--create user EJTRIG1 identified by EJTRIG1;
--GRANT CONNECT, RESOURCE, DBA TO EJTRIG1;

--1.- Cree las tablas con las siguientes estructuras:
--SIN PK NI FK NI NADA?
create table libros(
codigo number(6),
titulo varchar2(40),
autor varchar2(30),
editorial varchar2(20),
precio number(6,2) );

create table ofertas(
titulo varchar2(40),
autor varchar2(30),
precio number(6,2) );

create table control(
usuario varchar2(30),
fecha date );

--2.- Cree un disparador que se dispare cuando se ingrese un nuevo registro en "ofertas"; el
--trigger debe ingresar en la tabla "control", el nombre del usuario, la fecha y la hora en la
--cual se realizó un "insert" sobre "ofertas".

CREATE OR REPLACE
TRIGGER CONTROL_OFERTAS
BEFORE INSERT ON OFERTAS
FOR EACH ROW
BEGIN
	INSERT INTO CONTROL VALUES(USER, SYSDATE);
END CONTROL_OFERTAS;

--COMPROBAR
INSERT INTO OFERTAS VALUES ('El camino de los reyes', 'Brandon Sanderson', 18);


--3.- Ingrese los siguientes registros en "libros".
insert into libros values(100,'Uno','Richard Bach','Planeta',25.100);
insert into libros values(103,'El aleph','Borges','Emece',28.0);
insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12.50);
insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55.200);
insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35.10);

--Crear un trigger a nivel de fila que se dispara "antes" que se ejecute un "insert" o un
--"update" sobre el campo "precio" de la tabla "libros". Se activa solamente si el nuevo
--precio que se ingresa o se modifica es superior a 50, en caso de serlo, se modifica el valor
--ingresado redondeándolo a entero.

CREATE OR REPLACE
TRIGGER PRECIO_LIBRO
BEFORE INSERT OR UPDATE OF PRECIO ON LIBROS
FOR EACH ROW WHEN (new.precio>50) --TAMBIEN SE PUEDE PONER IF EN EL CUERPO
BEGIN
	:NEW.PRECIO := ROUND(:NEW.PRECIO);
END PRECIO_LIBRO;

--comprobar
INSERT INTO libros VALUES (150,'El camino de los reyes','Brandon Sanderson','Nova',60.10);
UPDATE libros SET precio= 52.50 WHERE titulo = 'El camino de los reyes';

--4.- Cree un trigger a nivel de fila que se dispare "antes" que se ejecute un "update" sobre
--la tabla "libros". En el cuerpo del trigger se debe averiguar el campo que ha sido
--modificado. En caso de modificarse:
	--- el código, debe rechazarse la modificación con un mensaje de error.
	--- el "precio", se controla si es mayor o igual a cero, si lo es, debe dejarse el precio
	--  anterior y mostrar un mensaje de error.
	--- el stock, debe controlarse que no se ingrese un número negativo ni superior a
	--  1000, en tal caso, debe rechazarse con un mensaje de error. 

CREATE OR REPLACE
TRIGGER ACTUALIZAR_LIBROS
BEFORE UPDATE ON LIBROS
FOR EACH ROW
BEGIN
	IF UPDATING('CODIGO') THEN
		RAISE_APPLICATION_ERROR(-20001, 'El código no puede modificarse');
	ELSIF UPDATING ('PRECIO') THEN
   		IF :NEW.PRECIO <= 0 THEN --MAYOR O IGUAL QUE CERO NO TIENE MUCHO SENTIDO, PONGO MENOR O IGUAL
   		RAISE_APPLICATION_ERROR(-20002, 'No puedes cambiar el precio a 0 o a un número negativo');
   		END IF;
	--ELSE
		--NO HAY CAMPO STOCK, TENGO QUE CREAR UN CAMPO STOCK?
  	END IF;
END ACTUALIZAR_LIBROS;

--COMPROBAR
UPDATE LIBROS SET CODIGO = 50 WHERE TITULO = 'Uno';
UPDATE LIBROS SET PRECIO = 0 WHERE TITULO = 'Uno';
UPDATE LIBROS SET PRECIO = 20 WHERE TITULO = 'Uno';

--5.- Crear un disparador a nivel de sentencia, que se dispare cada vez que se ingrese,
--actualice o elimine un registro de la tabla "libros". El trigger ingresa en la tabla "control",
--el nombre del usuario, la fecha y la hora en la cual se realizó la modificación y el tipo de
--operación que se realizó:
	--- si se realizó una inserción (insert), se almacena "inserción";
	--- si se realizó una actualización (update), se almacena "actualización" y
	--- si se realizó una eliminación (delete) se almacena "borrado"

ALTER TABLE CONTROL ADD DESCRIPCION VARCHAR2(20);
--ENTIENDO QUE EL DE SENTENCIA ES EL DE INSTRUCCION
CREATE OR REPLACE
TRIGGER REGISTRO_LIBROS
AFTER INSERT OR UPDATE OR DELETE ON LIBROS
DECLARE 
BEGIN
	IF INSERTING THEN
		INSERT INTO CONTROL VALUES(USER, SYSDATE, 'INSERCIÓN');
	END IF;
	IF UPDATING THEN
		INSERT INTO CONTROL VALUES(USER, SYSDATE, 'ACTUALIZACIÓN');
	END IF;
	IF DELETING THEN
		INSERT INTO CONTROL VALUES(USER, SYSDATE, 'BORRADO');
	END IF;
END REGISTRO_LIBROS;

--COMPROBAR
UPDATE LIBROS SET PRECIO = 25 WHERE TITULO = 'Uno';
INSERT INTO LIBROS(CODIGO) VALUES(200);
DELETE FROM LIBROS WHERE CODIGO = 200;


--6.- El gerente permite:
	--- ingresar o borrar libros de la tabla "libros" únicamente los sábados de 8 a 12 hs.
	--- actualizar los precios de los libros de lunes a viernes de 8 a 18 hs. y sábados entre laS 8 y 12 hs.
--Cree un disparador para los tres eventos que controle la hora en que se realizan las
--operaciones sobre "libros". Si se intenta eliminar, ingresar o actualizar registros de
--"libros" fuera de los días y horarios permitidos, debe aparecer un mensaje de error. Si la
--operación de ingreso, borrado o actualización de registros se realiza, se debe almacenar
--en "control", el nombre del usuario, la fecha y el tipo de operación ejecutada.

--SI LA OPERACION SE REALIZA EL TRIGGER ANTERIOR INSERTARÁ EN CONTROL
CREATE OR REPLACE
TRIGGER CONTROL_HORAS
BEFORE INSERT OR DELETE OR UPDATE OF PRECIO ON LIBROS
FOR EACH ROW
BEGIN
	IF INSERTING OR DELETING THEN
		if ((to_char(sysdate,'dy','nls_date_language=SPANISH') not in ('sáb')) and (to_number(to_char(sysdate,'HH24')) not between 8 and 12)) then
			RAISE_APPLICATION_ERROR(-20003, 'Sólo se pueden añadir o borrar libros los sábados de 8 a 12');
		END IF;
	ELSE
		IF ((to_char(sysdate,'dy','nls_date_language=SPANISH') NOT IN ('lun','mar','mié','jue','vie')) and (to_number(to_char(sysdate,'HH24')) not between 8 and 18)) 
		OR ((to_char(sysdate,'dy','nls_date_language=SPANISH') NOT IN ('sáb')) and (to_number(to_char(sysdate,'HH24')) not between 8 and 12)) THEN 
			RAISE_APPLICATION_ERROR(-20004, 'Sólo se pueden actualizar los precios de los libros de lunes a viernes de 8 a 18 y los sábados de 8 a 12');
		END IF;
	END IF;
END CONTROL_HORAS;

INSERT INTO LIBROS(TITULO) VALUES('PRUEBA');
DELETE FROM LIBROS WHERE TITULO = 'Uno';
UPDATE LIBROS SET PRECIO = 30 WHERE TITULO = 'Uno';
















