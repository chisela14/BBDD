--Consultas multitabla (composici�n interna)

--1 Obt�n un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT DISTINCT C.NOMBRE_CLIENTE CLIENTE, E.NOMBRE || ' ' || E.APELLIDO1 || ' ' || E.APELLIDO2  REPRESENTANTE
FROM CLIENTE C, EMPLEADO E
WHERE C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO;

--2 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
--representantes de ventas.
SELECT DISTINCT C.NOMBRE_CLIENTE CLIENTE, E.NOMBRE || ' ' || E.APELLIDO1 || ' ' || E.APELLIDO2 REPRESENTANTE 
FROM EMPLEADO E, CLIENTE C, PAGO P
WHERE C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO
AND C.CODIGO_CLIENTE = P.CODIGO_CLIENTE; 

--3 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus
--representantes de ventas.
SELECT DISTINCT C.NOMBRE_CLIENTE CLIENTE, E.NOMBRE || ' ' || E.APELLIDO1 || ' ' || E.APELLIDO2 REPRESENTANTE
FROM CLIENTE C, EMPLEADO E
WHERE C.CODIGO_CLIENTE NOT IN (SELECT CL.CODIGO_CLIENTE
								FROM CLIENTE CL, PAGO P
								WHERE CL.CODIGO_CLIENTE = P.CODIGO_CLIENTE)
AND C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO;

--SIN SUBCONSULTA
SELECT DISTINCT C.NOMBRE_CLIENTE CLIENTE, E.NOMBRE || ' ' || E.APELLIDO1 || ' ' || E.APELLIDO2 REPRESENTANTE
FROM EMPLEADO E, CLIENTE C, PAGO P
WHERE C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO
AND C.CODIGO_CLIENTE = P.CODIGO_CLIENTE (+)
AND P.CODIGO_CLIENTE IS NULL;

--4 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto
--con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT C.NOMBRE_CLIENTE CLIENTE, E.NOMBRE || ' ' || E.APELLIDO1 || ' ' || E.APELLIDO2 REPRESENTANTE, O.CIUDAD  
FROM EMPLEADO E, CLIENTE C, PAGO P, OFICINA O
WHERE C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO
AND C.CODIGO_CLIENTE = P.CODIGO_CLIENTE
AND E.CODIGO_OFICINA = O.CODIGO_OFICINA; 

--5 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes
--junto con la ciudad de la oficina a la que pertenece el representante.
--SIN SUBCONSULTA 
SELECT DISTINCT C.NOMBRE_CLIENTE CLIENTE, E.NOMBRE || ' ' || E.APELLIDO1 || ' ' || E.APELLIDO2 REPRESENTANTE, O.CIUDAD
FROM EMPLEADO E, CLIENTE C, PAGO P, OFICINA O
WHERE C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO
AND C.CODIGO_CLIENTE = P.CODIGO_CLIENTE (+)
AND E.CODIGO_OFICINA = O.CODIGO_OFICINA
AND P.CODIGO_CLIENTE IS NULL;

--6 Lista la direcci�n de las oficinas que tengan clientes en Fuenlabrada.
SELECT DISTINCT O.LINEA_DIRECCION1 || ' ' || O.LINEA_DIRECCION2 
FROM OFICINA O, EMPLEADO E, CLIENTE C
WHERE O.CODIGO_OFICINA = E.CODIGO_OFICINA  
AND E.CODIGO_EMPLEADO = C.CODIGO_EMPLEADO_REP_VENTAS 
AND UPPER(C.CIUDAD) LIKE '%FUENLABRADA%'; 
--SE PUEDE COMPARAR CON LINEA_DIRECCION 1 Y 2 Y REGION (CON OR Y EN PARENTESIS TODOS) Y PONER MAS DATOS EN EL SELECT (SALEN 5)

--7 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la
--oficina a la que pertenece el representante.
SELECT DISTINCT C.NOMBRE_CLIENTE CLIENTE, E.NOMBRE || ' ' || E.APELLIDO1 || ' ' || E.APELLIDO2 REPRESENTANTE, O.CIUDAD 
FROM CLIENTE C, EMPLEADO E, OFICINA O
WHERE C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO 
AND E.CODIGO_OFICINA = O.CODIGO_OFICINA; 

--8 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
SELECT E.NOMBRE EMPLEADO, EJ.NOMBRE JEFE
FROM EMPLEADO E, EMPLEADO EJ
WHERE E.CODIGO_EMPLEADO = EJ.CODIGO_JEFE; 

--9 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT DISTINCT C.NOMBRE_CLIENTE 
FROM CLIENTE C, PEDIDO P
WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE 
AND P.FECHA_ENTREGA > P.FECHA_ESPERADA; 

--10 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT DISTINCT PR.GAMA, C.CODIGO_CLIENTE  
FROM CLIENTE C, PEDIDO P, DETALLE_PEDIDO DP, PRODUCTO PR
WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE 
AND P.CODIGO_PEDIDO = DP.CODIGO_PEDIDO 
AND DP.CODIGO_PRODUCTO = PR.CODIGO_PRODUCTO; 


--Consultas multitabla (composici�n externa) DEBERIAN HACERSE SIN SUBCONSULTA

--1 Devuelve un listado que muestre solamente los clientes que no han realizado ning�n pago.
SELECT DISTINCT C.NOMBRE_CLIENTE 
FROM CLIENTE C, PAGO P
WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE (+)
AND P.CODIGO_CLIENTE IS NULL;

--CON SUBCONSULTA 
SELECT DISTINCT C.NOMBRE_CLIENTE 
FROM CLIENTE C
WHERE C.CODIGO_CLIENTE NOT IN (SELECT P.CODIGO_CLIENTE FROM PAGO P);

--LEFT JOIN
SELECT DISTINCT C.NOMBRE_CLIENTE 
FROM CLIENTE C
LEFT JOIN PAGO P ON C.CODIGO_CLIENTE = P.CODIGO_CLIENTE 
WHERE P.CODIGO_CLIENTE IS NULL;

--2 Devuelve un listado que muestre solamente los clientes que no han realizado ning�n pedido.
SELECT 
FROM 
WHERE

--3 Devuelve un listado que muestre los clientes que no han realizado ning�n pago y los que no han
--realizado ning�n pedido.
--DOBLE OUTER JOIN
SELECT 
FROM 
WHERE

--4 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT NOMBRE
FROM EMPLEADO 
WHERE CODIGO_OFICINA NOT IN (SELECT CODIGO_OFICINA FROM OFICINA);

--5 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT NOMBRE
FROM EMPLEADO 
WHERE CODIGO_EMPLEADO NOT IN (SELECT CODIGO_EMPLEADO_REP_VENTAS FROM CLIENTE);

--6 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no
--tienen un cliente asociado.
SELECT NOMBRE
FROM EMPLEADO 
WHERE CODIGO_EMPLEADO NOT IN (SELECT CODIGO_EMPLEADO_REP_VENTAS FROM CLIENTE)
AND CODIGO_OFICINA NOT IN (SELECT CODIGO_OFICINA FROM OFICINA);

--7 Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT DISTINCT P.CODIGO_PRODUCTO, P.NOMBRE 
FROM PRODUCTO P, DETALLE_PEDIDO DP 
WHERE P.CODIGO_PRODUCTO = DP.CODIGO_PRODUCTO (+)
AND DP.CODIGO_PEDIDO IS NULL;

--8 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes
-- de ventas de alg�n cliente que haya realizado la compra de alg�n producto de la gama Frutales.
SELECT DISTINCT O.CODIGO_OFICINA, O.CIUDAD, O.PAIS  
FROM OFICINA O, (SELECT DISTINCT E.CODIGO_EMPLEADO, E.CODIGO_OFICINA 
				FROM EMPLEADO E, CLIENTE C, PEDIDO P, DETALLE_PEDIDO DP, PRODUCTO PR
				WHERE UPPER(PR.GAMA) LIKE 'FRUTALES'
				AND PR.CODIGO_PRODUCTO = DP.CODIGO_PRODUCTO 
				AND DP.CODIGO_PEDIDO = P.CODIGO_PEDIDO 
				--HACER TODOS JOIN
				) EF
WHERE O.CODIGO_OFICINA = EF.CODIGO_OFICINA (+)
AND EF.CODIGO_OFICINA IS NULL;O

--9 Devuelve un listado con los clientes que han realizado alg�n pedido, pero no han realizado ning�n pago.
SELECT 
FROM 
WHERE

--10 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre
--de su jefe asociado.
SELECT 
FROM 
WHERE



--Consultas resumen

--1 �Cu�ntos empleados hay en la compa��a?

--2 �Cu�ntos clientes tiene cada pa�s?

--3 �Cu�l fue el pago medio en 2009?
SELECT ROUND(AVG(NVL(TOTAL,O)),3)
FROM PAGO 
WHERE 

--TO CHAR
SELECT TO_CHAR(AVG(TOTAL), '999G99099L')
FROM PAGO 
WHERE EXTRACT (YEAR FROM FECHA_PAGO)=2009;

--4 �Cu�ntos pedidos hay en cada estado? Ordena el resultado de forma descendente por el n�mero de pedidos.

--5 Calcula el precio de venta del producto m�s caro y m�s barato en una misma consulta.

--6 Calcula el n�mero de clientes que tiene la empresa.

--7 �Cu�ntos clientes tiene la ciudad de Madrid?

--8 �Calcula cu�ntos clientes tiene cada una de las ciudades que empiezan por M?

--9 Devuelve el c�digo de empleado y el n�mero de clientes al que atiende cada representante de ventas.

--10 Calcula el n�mero de clientes que no tiene asignado representante de ventas.

--11 Calcula la fecha del primer y �ltimo pago realizado por cada uno de los clientes.
SELECT 
FROM

--12 Calcula el n�mero de productos diferentes que hay en cada uno de los pedidos.

--13 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

--14 Devuelve un listado de los 20 c�digos de productos m�s vendidos y el n�mero total de unidades que se
--han vendido de cada uno. El listado deber� estar ordenado por el n�mero total de unidades vendidas.
SELECT * 
FROM (SELECT)
WHERE ROWNUM <= 20;

--15 La facturaci�n que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y
--el total facturado. La base imponible se calcula sumando el coste del producto por el n�mero de
--unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
--suma de los dos campos anteriores.

--16 La misma informaci�n que en la pregunta anterior, pero agrupada por c�digo de producto.

--17 La misma informaci�n que en la pregunta anterior, pero agrupada por c�digo de producto filtrada
--por los c�digos que empiecen por OR.


--18 Lista las ventas totales de los productos que hayan facturado m�s de 3000 euros. Se mostrar� el
--nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).



--Subconsultas
--1 Devuelve el nombre del cliente con mayor l�mite de cr�dito.
SELECT NOMBRE_CLIENTE 
FROM CLIENTE
WHERE LIMITE_CREDITO = (SELECT MAX(LIMITE_CREDITO) FROM CLIENTE);

--2 Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ning�n cliente.
SELECT NOMBRE, APELLIDO1, PUESTO
FROM EMPLEADO
WHERE CODIGO_EMPLEADO NOT IN (SELECT CODIGO_EMPLEADO_REP_VENTAS FROM CLIENTE);

--3 Devuelve el nombre del producto que tenga el precio de venta m�s caro.
SELECT NOMBRE 
FROM PRODUCTO
WHERE PRECIO_VENTA = (SELECT MAX(PRECIO_VENTA) FROM PRODUCTO);

--4 Devuelve el nombre del producto del que se han vendido m�s unidades. (Ten en cuenta que
--tendr�s que calcular cu�l es el n�mero total de unidades que se han vendido de cada producto a
--partir de los datos de la tabla detalle_pedido. Una vez que sepas cu�l es el c�digo del producto,
--puedes obtener su nombre f�cilmente.)
SELECT P. NOMBRE 
FROM PRODUCTO P
WHERE P.CODIGO_PRODUCTO = (SELECT CODIGO_PRODUCTO FROM DETALLE_PEDIDO
							WHERE CANTIDAD >= ALL (SELECT CANTIDAD FROM DETALLE_PEDIDO));
						--ESTA MAL

--5 Los clientes cuyo l�mite de cr�dito sea mayor que los pagos que haya realizado.
SELECT C.*
FROM CLIENTE C
WHERE C.LIMITE_CREDITO > (SELECT SUM(P.TOTAL) FROM PAGO P WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE);
						
--6 El producto que m�s unidades tiene en stock y el que menos unidades tiene.
SELECT NOMBRE 
FROM PRODUCTO
WHERE CANTIDAD_EN_STOCK = (SELECT MAX(CANTIDAD_EN_STOCK) FROM PRODUCTO)
OR CANTIDAD_EN_STOCK = (SELECT MIN(CANTIDAD_EN_STOCK) FROM PRODUCTO);

--7 Devuelve el nombre, los apellidos y el email de los empleados a cargo de Alberto Soria.
SELECT NOMBRE, APELLIDO1, APELLIDO2, EMAIL 
FROM EMPLEADO 
WHERE CODIGO_JEFE = (SELECT J.CODIGO_EMPLEADO
					FROM EMPLEADO J
					WHERE UPPER(J.NOMBRE) LIKE '%ALBERTO%'
					AND UPPER(J.APELLIDO1) LIKE '%SORIA%');

--Consultas variadas
--1 Devuelve el listado de clientes indicando el nombre del cliente y cu�ntos pedidos ha realizado.
--Tenga en cuenta que pueden existir clientes que no han realizado ning�n pedido.
SELECT C.NOMBRE_CLIENTE, NVL(COUNT(P.CODIGO_PEDIDO),0)
FROM CLIENTE C, PEDIDO P
WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE (+)
GROUP BY C.NOMBRE_CLIENTE; 

--2 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga
--en cuenta que pueden existir clientes que no han realizado ning�n pago.
SELECT C.NOMBRE_CLIENTE, NVL(SUM(P.TOTAL), 0)
FROM CLIENTE C, PAGO P
WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE (+)
GROUP BY C.NOMBRE_CLIENTE; 

--3 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfab�ticamente
--de menor a mayor.
SELECT DISTINCT C.NOMBRE_CLIENTE 
FROM CLIENTE C, PEDIDO P 
WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE 
AND EXTRACT(YEAR FROM P.FECHA_PEDIDO) = 2008
ORDER BY C.NOMBRE_CLIENTE ASC;

--4 Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el
--número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan
--realizado ningún pago.


--5 Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido
--de su representante de ventas y la ciudad donde está su oficina.


--6 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean
--representante de ventas de ningún cliente.


--7 Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados
--que tiene.







