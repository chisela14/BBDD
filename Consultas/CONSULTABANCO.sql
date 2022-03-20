--1. Mostrar el saldo medio de todas las cuentas de la entidad bancaria con dos decimales y
--la suma de los saldos de todas las cuentas bancarias.
SELECT  ROUND(AVG(SALDO), 2), SUM(SALDO)
FROM CUENTA; 

--2. Mostrar el saldo mínimo, máximo y medio de todas las cuentas bancarias.
SELECT MIN(SALDO), MAX(SALDO), AVG(SALDO)
FROM CUENTA;

--3. Mostrar la suma de los saldos y el saldo medio de las cuentas bancarias por cada
--código de sucursal.
SELECT SUM(C.SALDO), AVG(C.SALDO)
FROM CUENTA C, SUCURSAL S
WHERE C.COD_SUCURSAL = S.COD_SUCURSAL 
GROUP BY S.COD_SUCURSAL;

--4. Para cada cliente del banco se desea conocer su código, la cantidad total que tiene
--depositada en la entidad y el número de cuentas abiertas.
SELECT CL.COD_CLIENTE, SUM(C.SALDO), COUNT (C.COD_CUENTA) 
FROM CLIENTE CL, CUENTA C
WHERE CL.COD_CLIENTE = C.COD_CLIENTE 
GROUP BY CL.COD_CLIENTE; 

--5. Retocar la consulta anterior para que aparezca el nombre y apellidos de cada cliente en
--vez de su código de cliente.
SELECT CL.NOMBRE, CL.APELLIDOS, SUM(C.SALDO), COUNT (C.COD_CUENTA) 
FROM CLIENTE CL, CUENTA C
WHERE CL.COD_CLIENTE = C.COD_CLIENTE 
GROUP BY CL.NOMBRE, CL.APELLIDOS; 

--6. Para cada sucursal del banco se desea conocer su dirección, el número de cuentas que
--tiene abiertas y la suma total que hay en ellas.
SELECT S.DIRECCION, COUNT (C.COD_CUENTA), SUM (C.SALDO) 
FROM SUCURSAL S, CUENTA C
WHERE S.COD_SUCURSAL = C.COD_SUCURSAL 
GROUP BY S.DIRECCION; 

--7. Mostrar el saldo medio y el interés medio de las cuentas a las que se le aplique un
--interés mayor del 10%, de las sucursales 1 y 2.
SELECT AVG(SALDO), AVG(INTERES)
FROM CUENTA 
WHERE INTERES > 0.1
AND COD_SUCURSAL = 1 OR COD_SUCURSAL = 2
GROUP BY COD_SUCURSAL;
--??

--8. Mostrar los tipos de movimientos de las cuentas bancarias, sus descripciones y el
--volumen total de dinero que se manejado en cada tipo de movimiento.
SELECT TM.COD_TIPO_MOVIMIENTO, TM.DESCRIPCION, SUM(M.IMPORTE) 
FROM MOVIMIENTO M, TIPO_MOVIMIENTO TM
WHERE TM.COD_TIPO_MOVIMIENTO = M.COD_TIPO_MOVIMIENTO
GROUP BY TM.COD_TIPO_MOVIMIENTO, TM.DESCRIPCION; 

--9. Mostrar cuál es la cantidad media que los clientes de nuestro banco tienen en el
--epígrafe “Retirada por cajero automático”.
SELECT AVG(M.IMPORTE)
FROM CLIENTE CL, CUENTA C, MOVIMIENTO M, TIPO_MOVIMIENTO TM
WHERE CL.COD_CLIENTE = C.COD_CLIENTE 
AND C.COD_CUENTA = M.COD_CUENTA 
AND M.COD_TIPO_MOVIMIENTO = TM.COD_TIPO_MOVIMIENTO 
AND UPPER(TM.DESCRIPCION) LIKE 'RETIRADA POR CAJERO AUTOM%TICO';

--10. Calcular la cantidad total de dinero que emite la entidad bancaria clasificada según los
--tipos de movimientos de salida.
SELECT SUM(M.IMPORTE)
FROM SUCURSAL S, CUENTA C, MOVIMIENTO M, TIPO_MOVIMIENTO TM
WHERE S.COD_SUCURSAL = C.COD_SUCURSAL 
AND C.COD_CUENTA = M.COD_CUENTA 
AND TM.COD_TIPO_MOVIMIENTO = M.COD_TIPO_MOVIMIENTO 
AND UPPER(TM.SALIDA) LIKE 'S%' 
GROUP BY M.COD_TIPO_MOVIMIENTO; 

--11. Calcular la cantidad total de dinero que ingresa cada cuenta bancaria clasificada según los tipos
--de movimientos de entrada mostrando además la descripción del tipo de movimiento.
SELECT SUM(M.IMPORTE), TM.DESCRIPCION 
FROM CUENTA C, MOVIMIENTO M, TIPO_MOVIMIENTO TM
WHERE C.COD_CUENTA = M.COD_CUENTA 
AND TM.COD_TIPO_MOVIMIENTO = M.COD_TIPO_MOVIMIENTO 
AND UPPER(TM.SALIDA) LIKE 'NO' 
GROUP BY M.COD_TIPO_MOVIMIENTO, TM.DESCRIPCION;


--12. Calcular la cantidad total de dinero que sale de la sucursal de Paseo Castellana.
SELECT SUM(M.IMPORTE)
FROM SUCURSAL S, CUENTA C, MOVIMIENTO M, TIPO_MOVIMIENTO TM
WHERE S.COD_SUCURSAL = C.COD_SUCURSAL 
AND C.COD_CUENTA = M.COD_CUENTA 
AND TM.COD_TIPO_MOVIMIENTO = M.COD_TIPO_MOVIMIENTO 
AND UPPER(TM.SALIDA) LIKE 'S%' 
AND UPPER(S.DIRECCION) LIKE 'PASEO CASTELLANA%';

--13. Mostrar la suma total por tipo de movimiento de las cuentas bancarias de los clientes del banco.
--Se deben mostrar los siguientes campos: apellidos, nombre, cod_cuenta, descripción del
--tipo movimiento y el total acumulado de los movimientos de un mismo tipo.
SELECT CL.APELLIDOS, CL.NOMBRE, C.COD_CUENTA, TM.DESCRIPCION, SUM(M.IMPORTE) 
FROM CLIENTE CL, CUENTA C, MOVIMIENTO M, TIPO_MOVIMIENTO TM
WHERE CL.COD_CLIENTE = C.COD_CLIENTE 
AND C.COD_CUENTA = M.COD_CUENTA 
AND TM.COD_TIPO_MOVIMIENTO = M.COD_TIPO_MOVIMIENTO
GROUP BY TM.COD_TIPO_MOVIMIENTO, CL.APELLIDOS, CL.NOMBRE, C.COD_CUENTA, TM.DESCRIPCION; 

--14. Contar el número de cuentas bancarias que no tienen asociados movimientos.
SELECT COUNT(C.COD_CUENTA)
FROM CUENTA C, MOVIMIENTO M
WHERE M.COD_CUENTA (+) = C.COD_CUENTA
AND M.MES IS NULL;

--15. Por cada cliente, contar el número de cuentas bancarias que posee sin movimientos. Se
--deben mostrar los siguientes campos: cod_cliente, num_cuentas_sin_movimiento.
SELECT COUNT(C.COD_CUENTA) AS NUM_CUENTAS_SIN_MOVIMIENTO, CL.COD_CLIENTE 
FROM CLIENTE CL, CUENTA C, MOVIMIENTO M
WHERE CL.COD_CLIENTE = C.COD_CLIENTE 
AND M.COD_CUENTA (+) = C.COD_CUENTA
AND M.MES IS NULL
GROUP BY CL.COD_CLIENTE;

--16. Mostrar el código de cliente, la suma total del dinero de todas sus cuentas y el número
--de cuentas abiertas, sólo para aquellos clientes cuyo capital supere los 35.000 euros.
SELECT CL.COD_CLIENTE, SUM(C.SALDO), COUNT(C.COD_CUENTA)
FROM CLIENTE CL, CUENTA C
WHERE CL.COD_CLIENTE = C.COD_CLIENTE 
GROUP BY CL.COD_CLIENTE
HAVING SUM(C.SALDO) > 35000; 

--17. Mostrar los apellidos, el nombre y el número de cuentas abiertas sólo de aquellos
--clientes que tengan más de 2 cuentas.
SELECT CL.APELLIDOS, CL.NOMBRE, COUNT(C.COD_CUENTA) 
FROM CLIENTE CL, CUENTA C
WHERE CL.COD_CLIENTE = C.COD_CLIENTE 
GROUP BY CL.APELLIDOS, CL.NOMBRE
HAVING COUNT(C.COD_CUENTA) > 2; 

--18. Mostrar el código de sucursal, dirección, capital del año anterior y la suma de los
--saldos de sus cuentas, sólo de aquellas sucursales cuya suma de los saldos de las
--cuentas supera el capital del año anterior ordenadas por sucursal.
SELECT S.COD_SUCURSAL, S.DIRECCION, S.CAPITAL_ANIO_ANTERIOR, SUM(C.SALDO)
FROM SUCURSAL S, CUENTA C
WHERE S.COD_SUCURSAL = C.COD_SUCURSAL 
GROUP BY S.COD_SUCURSAL, S.DIRECCION, S.CAPITAL_ANIO_ANTERIOR
HAVING SUM(C.SALDO) > S.CAPITAL_ANIO_ANTERIOR 
ORDER BY S.COD_SUCURSAL ASC;

--19. Mostrar el código de cuenta, su saldo, la descripción del tipo de movimiento y la suma
--total de dinero por movimiento, sólo para aquellas cuentas cuya suma total de dinero
--por movimiento supere el 20% del saldo.
SELECT C.COD_CUENTA, C.SALDO, TM.DESCRIPCION, SUM(M.IMPORTE) 
FROM CUENTA C, MOVIMIENTO M, TIPO_MOVIMIENTO TM
WHERE C.COD_CUENTA = M.COD_CUENTA 
AND M.COD_TIPO_MOVIMIENTO = TM.COD_TIPO_MOVIMIENTO 
GROUP BY C.COD_CUENTA, C.SALDO, TM.DESCRIPCION
HAVING SUM(M.IMPORTE) > C.SALDO*0.20;

--20. Mostrar los mismos campos del ejercicio anterior pero ahora sólo de aquellas cuentas
--cuya suma de importes por movimiento supere el 10% del saldo y no sean de la
--sucursal 4.
SELECT C.COD_CUENTA, C.SALDO, TM.DESCRIPCION, SUM(M.IMPORTE) 
FROM CUENTA C, MOVIMIENTO M, TIPO_MOVIMIENTO TM
WHERE C.COD_CUENTA = M.COD_CUENTA 
AND M.COD_TIPO_MOVIMIENTO = TM.COD_TIPO_MOVIMIENTO 
AND C.COD_SUCURSAL NOT IN '4'
GROUP BY C.COD_CUENTA, C.SALDO, TM.DESCRIPCION
HAVING SUM(M.IMPORTE) > C.SALDO*0.10; 

--21. Mostrar los datos de aquellos clientes para los que el saldo de sus cuentas suponga al
--menos el 20% del capital del año anterior de su sucursal.
SELECT CL.*
FROM CLIENTE CL, CUENTA C, SUCURSAL S
WHERE CL.COD_CLIENTE = C.COD_CLIENTE 
AND C.COD_SUCURSAL = S.COD_SUCURSAL 
GROUP BY CL.COD_CLIENTE, S.CAPITAL_ANIO_ANTERIOR 
HAVING SUM(C.SALDO) > S.CAPITAL_ANIO_ANTERIOR*0.20;
--ASI DA FALLO PORQUE CL.* NO ES FUNCION DE GRUPO
--??

SELECT CL.COD_CLIENTE, CL.APELLIDOS, CL.NOMBRE, CL.DIRECCION 
FROM CLIENTE CL, CUENTA C, SUCURSAL S
WHERE CL.COD_CLIENTE = C.COD_CLIENTE 
AND C.COD_SUCURSAL = S.COD_SUCURSAL 
GROUP BY CL.COD_CLIENTE, CL.APELLIDOS, CL.NOMBRE, CL.DIRECCION, S.CAPITAL_ANIO_ANTERIOR 
HAVING SUM(C.SALDO) > S.CAPITAL_ANIO_ANTERIOR*0.20;
 
