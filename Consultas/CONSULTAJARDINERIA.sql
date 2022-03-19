--Consultas multitabla (composición interna)

--1 Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

--2 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
--representantes de ventas.

--3 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus
--representantes de ventas.

--4 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto
--con la ciudad de la oficina a la que pertenece el representante.

--5 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes
--junto con la ciudad de la oficina a la que pertenece el representante.

--6 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

--7 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la
--oficina a la que pertenece el representante.

--8 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

--9 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

--10 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.



--Consultas multitabla (composición externa)

--1 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

--2 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

--3 Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han
--realizado ningún pedido.

--4 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

--5 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

--6 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no
--tienen un cliente asociado.

--7 Devuelve un listado de los productos que nunca han aparecido en un pedido.

--8 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes
-- de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

--9 Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado ningún pago.

--10 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre
--de su jefe asociado.



--Consultas resumen

--1 ¿Cuántos empleados hay en la compañía?

--2 ¿Cuántos clientes tiene cada país?

--3 ¿Cuál fue el pago medio en 2009?

--4 ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.

--5 Calcula el precio de venta del producto más caro y más barato en una misma consulta.

--6 Calcula el número de clientes que tiene la empresa.

--7 ¿Cuántos clientes tiene la ciudad de Madrid?

--8 ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?

--9 Devuelve el código de empleado y el número de clientes al que atiende cada representante de ventas.

--10 Calcula el número de clientes que no tiene asignado representante de ventas.

--11 Calcula la fecha del primer y último pago realizado por cada uno de los clientes.

--12 Calcula el número de productos diferentes que hay en cada uno de los pedidos.

--13 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

--14 Devuelve un listado de los 20 códigos de productos más vendidos y el número total de unidades que se
--han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.

--15 La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y
--el total facturado. La base imponible se calcula sumando el coste del producto por el número de
--unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
--suma de los dos campos anteriores.

--16 La misma información que en la pregunta anterior, pero agrupada por código de producto.

--17 La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada
--por los códigos que empiecen por OR.

--18 Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el
--nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).



--Subconsultas
--1 Devuelve el nombre del cliente con mayor límite de crédito.
--2 Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
--3 Devuelve el nombre del producto que tenga el precio de venta más caro.
--4 Devuelve el nombre del producto del que se han vendido más unidades. (Ten en cuenta que
--tendrás que calcular cuál es el número total de unidades que se han vendido de cada producto a
--partir de los datos de la tabla detalle_pedido. Una vez que sepas cuál es el código del producto,
--puedes obtener su nombre fácilmente.)
--5 Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado.
--6 El producto que más unidades tiene en stock y el que menos unidades tiene.
--7 Devuelve el nombre, los apellidos y el email de los empleados a cargo de Alberto Soria.


--Consultas variadas
--1 Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado.
--Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
--2 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga
--en cuenta que pueden existir clientes que no han realizado ningún pago.
--3 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente
--de menor a mayor.