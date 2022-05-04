--1.- Desarrollar un procedimiento que visualice el nombre, apellidos y puesto
--de todos los empleados, ordenados por primer apellido.
CREATE OR REPLACE 
PROCEDURE verEmpleados IS 
	CURSOR empleados IS 
		SELECT NOMBRE, APELLIDO1|| ' ' || APELLIDO2 APELLIDOS, PUESTO 
		FROM EMPLEADO
		ORDER BY APELLIDO1;
BEGIN
	FOR registro IN empleados
	LOOP 
		DBMS_OUTPUT.PUT_LINE ('Nombre del empleado: '|| registro.NOMBRE || ' Apellidos: '|| registro.APELLIDOS
		|| ' Puesto de trabajo: '|| registro.PUESTO);
	END LOOP;

	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE ('No hay más empleados');
	
END verEmpleados;

BEGIN
	verEmpleados;
END;

--2.- Desarrollar un procedimiento que muestre el código de cada oficina y el
--número de empleados que tiene.
CREATE OR REPLACE 
PROCEDURE mostrarCodigoYEmp IS 
	CURSOR oficina IS 
		SELECT O.CODIGO_OFICINA, COUNT(E.CODIGO_EMPLEADO) numEmpleados
		FROM OFICINA O, EMPLEADO E
		WHERE O.CODIGO_OFICINA = E.CODIGO_OFICINA
		GROUP BY O.CODIGO_OFICINA;
BEGIN
	FOR registro IN oficina
	LOOP
		DBMS_OUTPUT.PUT_LINE ('La oficina '||registro.CODIGO_OFICINA||' tiene '||registro.numEmpleados|| ' empleados');
	END LOOP;
	
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE ('No hay oficinas que mostrar');
	
END mostrarCodigoYEmp;

BEGIN
	mostrarCodigoYEmp;
END;

--3.- Desarrollar un procedimiento que reciba como parámetro una cadena de
--texto y muestre el código de cliente y nombre de cliente de todos los
--clientes cuyo nombre contenga la cadena especificada. Al finalizar debe
--mostrar el número de clientes mostrados.
CREATE OR REPLACE 
PROCEDURE mostrarSegunCadena (cadena VARCHAR2) IS 
	CURSOR clientes (cadena VARCHAR2) IS 
		SELECT CODIGO_CLIENTE, NOMBRE_CLIENTE FROM CLIENTE
		WHERE NOMBRE_CLIENTE LIKE '%'||cadena||'%';
	--sin acabar

--4.- Escribir un programa que muestre el código de producto, nombre y gama
--de los 5 productos más vendidos.

--5.- Desarrollar un procedimiento que aumente el límite de crédito en un
--50% a aquellos clientes que cuyo valor sea inferior al límite de crédito
--medio actual.

--6.- Diseñar una función que dado un código de producto retorne el número
--de unidades vendidas del producto. En caso de introducir un producto
--inexistente retornará -1.

--7.- Diseñar una función que dado un código de cliente y un año retorne la
--cantidad total pagada por el cliente durante el periodo indicado. En caso de
--introducir un cliente inexistente retornará -1.

--8.- Diseñar una función que dado un código de cliente elimine todos sus
--pedidos realizados. La función retornará el número de pedidos borrados.

--9.- Desarrollar un procedimiento que actualice el precio de venta de todos
--los productos de una determinada gama. El procedimiento recibirá como
--parámetro la gama, y actualizará el precio de venta como el precio de
--proveedor + 70%. Al finalizar el procedimiento indicará el número de
--productos actualizados y su gama.

--10.- Diseñar una aplicación que simule un listado de empleados según el
--siguiente formato:
--************************************************************
--Clientes del empleado: ............(1) Oficina: .............(2) Puesto: ...........(3)
--No total de clientes representados: .............(4)
---------- Cliente: ...............(5) Total pagos: ..........(6) Total pedidos: ..........(7)
--************************************************************
--Donde:
-- -(1) Nombre y apellidos del empleado
-- -(2) Código y ciudad de la oficina
-- -(3) Puesto del empleado
-- -(4) No de clientes representados
-- -(5) Código y nombre del cliente
-- -(6) Suma de los pagos realizados por el cliente
-- -(7) No de pedidos realizados por el cliente
--IMPORTANTE: (5), (6) y (7) debe aparecer para cada cliente
--representado por el empleado.