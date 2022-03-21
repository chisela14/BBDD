--Consultas multitabla (composici�n interna)

--1 Obt�n un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

--2 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
--representantes de ventas.

--3 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus
--representantes de ventas.

--4 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto
--con la ciudad de la oficina a la que pertenece el representante.

--5 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes
--junto con la ciudad de la oficina a la que pertenece el representante.

--6 Lista la direcci�n de las oficinas que tengan clientes en Fuenlabrada.

--7 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la
--oficina a la que pertenece el representante.

--8 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

--9 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

--10 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.



--Consultas multitabla (composici�n externa)

--1 Devuelve un listado que muestre solamente los clientes que no han realizado ning�n pago.

--2 Devuelve un listado que muestre solamente los clientes que no han realizado ning�n pedido.

--3 Devuelve un listado que muestre los clientes que no han realizado ning�n pago y los que no han
--realizado ning�n pedido.

--4 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

--5 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

--6 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no
--tienen un cliente asociado.

--7 Devuelve un listado de los productos que nunca han aparecido en un pedido.

--8 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes
-- de ventas de alg�n cliente que haya realizado la compra de alg�n producto de la gama Frutales.

--9 Devuelve un listado con los clientes que han realizado alg�n pedido, pero no han realizado ning�n pago.

--10 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre
--de su jefe asociado.



--Consultas resumen

--1 �Cu�ntos empleados hay en la compa��a?

--2 �Cu�ntos clientes tiene cada pa�s?

--3 �Cu�l fue el pago medio en 2009?

--4 �Cu�ntos pedidos hay en cada estado? Ordena el resultado de forma descendente por el n�mero de pedidos.

--5 Calcula el precio de venta del producto m�s caro y m�s barato en una misma consulta.

--6 Calcula el n�mero de clientes que tiene la empresa.

--7 �Cu�ntos clientes tiene la ciudad de Madrid?

--8 �Calcula cu�ntos clientes tiene cada una de las ciudades que empiezan por M?

--9 Devuelve el c�digo de empleado y el n�mero de clientes al que atiende cada representante de ventas.

--10 Calcula el n�mero de clientes que no tiene asignado representante de ventas.

--11 Calcula la fecha del primer y �ltimo pago realizado por cada uno de los clientes.

--12 Calcula el n�mero de productos diferentes que hay en cada uno de los pedidos.

--13 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

--14 Devuelve un listado de los 20 c�digos de productos m�s vendidos y el n�mero total de unidades que se
--han vendido de cada uno. El listado deber� estar ordenado por el n�mero total de unidades vendidas.

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

--5 Los clientes cuyo l�mite de cr�dito sea mayor que los pagos que haya realizado.
SELECT *
FROM CLIENTE 
WHERE LIMITE_CREDITO > (SELECT SUM(TOTAL) FROM PAGO P, CLIENTE C WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE);
						
--6 El producto que m�s unidades tiene en stock y el que menos unidades tiene.
SELECT P1.CODIGO_PRODUCTO, P2.CODIGO_PRODUCTO 
FROM PRODUCTO P1, PRODUCTO P2 
WHERE 
SELECT MAX(CANTIDAD_EN_STOCK), MIN(CANTIDAD_EN_STOCK) FROM PRODUCTO;
--SIN ACABAR

--7 Devuelve el nombre, los apellidos y el email de los empleados a cargo de Alberto Soria.
SELECT NOMBRE, APELLIDO1, APELLIDO2, EMAIL 
FROM EMPLEADO e 



--Consultas variadas
--1 Devuelve el listado de clientes indicando el nombre del cliente y cu�ntos pedidos ha realizado.
--Tenga en cuenta que pueden existir clientes que no han realizado ning�n pedido.
--2 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga
--en cuenta que pueden existir clientes que no han realizado ning�n pago.
--3 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfab�ticamente
--de menor a mayor.