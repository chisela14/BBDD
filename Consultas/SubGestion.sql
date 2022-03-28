
--1. Número de clientes que tienen alguna factura con IVA 16%.
SELECT COUNT (CODCLI)
FROM CLIENTES 
WHERE CODCLI IN (SELECT CODCLI FROM FACTURAS WHERE IVA = 16);

--2. Número de clientes que no tienen ninguna factura con un 16% de IVA.
SELECT COUNT (CODCLI)
FROM CLIENTES 
WHERE CODCLI IN (SELECT CODCLI FROM FACTURAS WHERE IVA != 16);

--219 NO TIENE QUE SALIR (9)
SELECT CODCLI FROM FACTURAS WHERE IVA = ANY (SELECT IVA FROM FACTURAS WHERE IVA!=16);

--3. Número de clientes que en todas sus facturas tienen un 16% de IVA (los clientes deben tener al menos una factura).
SELECT COUNT (CODCLI)
FROM CLIENTES 
WHERE CODCLI = ALL (SELECT CODCLI FROM FACTURAS WHERE IVA = 16);
--CODCLI 219 TIENE DOS FACTURAS (12)

SELECT *
FROM FACTURAS 
ORDER BY CODCLI;

--4. Fecha de la factura con mayor importe (sin tener en cuenta descuentos ni impuestos).
--5. Número de pueblos en los que no tenemos clientes.
--6. Número de artículos cuyo stock supera las 20 unidades, con precio superior a 15 euros y de los que no hay ninguna 
--factura en el último trimestre del año pasado.
--7. Obtener el número de clientes que en todas las facturas del año pasado han pagado IVA (no se ha pagado IVA si es cero o nulo).
--8. Clientes (código y nombre) que fueron preferentes durante el mes de noviembre del año pasado y que en diciembre de ese mismo año 
--no tienen ninguna factura. Son clientes preferentes de un mes aquellos que han solicitado más de 60,50 euros en facturas durante ese mes, 
--sin tener en cuenta descuentos ni impuestos.
--9. Código, descripción y precio de los diez artículos más caros.
--10. Nombre de la provincia con mayor número de clientes.
--11. Código y descripción de los artículos cuyo precio es mayor de 90,15 euros y se han vendido menos de 10 unidades (o ninguna) durante el año pasado.
--12. Código y descripción de los artículos cuyo precio es más de tres mil veces mayor que el precio mínimo de cualquier artículo.
--13. Nombre del cliente con mayor facturación.
--14. Código y descripción de aquellos artículos con un precio superior a la media y que hayan sido comprados por más de 5 clientes.
