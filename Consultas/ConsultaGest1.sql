--1. Codigo, fecha y doble del descuento de las facturas con iva cero.
SELECT CODFAC, FECHA, NVL(DTO*2,0) FROM FACTURAS
WHERE IVA = 0;

--2. Codigo de las facturas con iva nulo.
SELECT CODFAC FROM FACTURAS 
WHERE IVA IS NULL;

--3. Codigo y fecha de las facturas sin iva (iva cero o nulo).
SELECT CODFAC, FECHA FROM FACTURAS
WHERE IVA IS NULL 
OR IVA = 0;

--4. Codigo de factura y de articulo de las lineas de factura en las que la cantidad solicitada es menor de 5
--unidades y ademas se ha aplicado un descuento del 25% o mayor.
SELECT CODFAC, CODART FROM LINEAS_FAC  
WHERE CANT < 5
AND DTO <= 25;

--5. Obtener la descripcion de los articulos cuyo stock esta por debajo del stock minimo, dado tambien la
--cantidad en unidades necesaria para alcanzar dicho minimo.
SELECT DESCRIP FROM ARTICULOS
WHERE STOCK < STOCK_MIN;

--6. Ivas distintos aplicados a las facturas.

--7. CÃ³digo, descripciÃ³n y stock mÃ­nimo de los artÃ­culos de los que se desconoce la cantidad de stock. Cuando
--se desconoce la cantidad de stock de un artÃ­culo, el stock es nulo.

--8. Obtener la descripciÃ³n de los artÃ­culos cuyo stock es mÃ¡s de tres veces su stock mÃ­nimo y cuyo precio
--supera los 6 euros.

--9. CÃ³digo de los artÃ­culos (sin que salgan repetidos) comprados en aquellas facturas cuyo cÃ³digo estÃ¡ entre 8 y 10.

--10. Mostrar el nombre y la direcciÃ³n de todos los clientes.

--11. Mostrar los distintos cÃ³digos de pueblos en donde tenemos clientes.

--12. Obtener los cÃ³digos de los pueblos en donde hay clientes con cÃ³digo de cliente menor que el cÃ³digo 25.
--No deben salir cÃ³digos repetidos.

--13. Nombre de las provincias cuya segunda letra es una 'O' (bien mayÃºscula o minÃºscula).

--14. CÃ³digo y fecha de las facturas del aÃ±o pasado para aquellos clientes cuyo cÃ³digo se encuentra entre 50 y 100.

--15. Nombre y direcciÃ³n de aquellos clientes cuyo cÃ³digo postal empieza por â€œ12â€�.

--16. Mostrar las distintas fechas, sin que salgan repetidas, de las factura existentes de clientes cuyos
--cÃ³digos son menores que 50.

--17. CÃ³digo y fecha de las facturas que se han realizado durante el mes de junio del aÃ±o 2004.

--18. CÃ³digo y fecha de las facturas que se han realizado durante el mes de junio del aÃ±o 2004 para
--aquellos clientes cuyo cÃ³digo se encuentra entre 100 y 250.

--19. CÃ³digo y fecha de las facturas para los clientes cuyos cÃ³digos estÃ¡n entre 90 y 100 y no tienen iva.
--NOTA: una factura no tiene iva cuando Ã©ste es cero o nulo.

--20. Nombre de las provincias que terminan con la letra 's' (bien mayÃºscula o minÃºscula).

--21. Nombre de los clientes cuyo cÃ³digo postal empieza por â€œ02â€�, â€œ11â€� Ã³ â€œ21â€�.

--22. ArtÃ­culos (todas las columnas) cuyo stock sea mayor que el stock mÃ­nimo y no haya en stock mÃ¡s de
--5 unidades del stock_min.

--23. Nombre de las provincias que contienen el texto â€œMAâ€� (bien mayÃºsculas o minÃºsculas).

--24. Se desea promocionar los artÃ­culos de los que se posee un stock grande. Si el artÃ­culo es de mÃ¡s de 6000 â‚¬ y el stock 
--supera los 60000 â‚¬, se harÃ¡ un descuento del 10%. Mostrar un listado de los artÃ­culos que van a entrar en la promociÃ³n,
--con su cÃ³digo de artÃ­culo, nombre del articulo, precio actual y su precio en la promociÃ³n.
