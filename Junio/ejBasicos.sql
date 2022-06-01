--EJERCICIOS BÁSICOS PROCEDIMIENTOS Y FUNCIONES

--1. Realizar un procedure que muestre los números múltiplos de 5 de 0 a 100.

CREATE OR REPLACE 
PROCEDURE multiplosCinco AS 

BEGIN 
	FOR i IN 5..100 LOOP 
		IF (MOD(i,5) = 0) THEN
		DBMS_OUTPUT.PUT_LINE(i);
		END IF;
		
	END LOOP;
END multiplosCinco;

BEGIN 
	multiplosCinco;
END;


--2. Procedure que muestre por pantalla todos los números comprendidos entre 1 y 100 que son
--múltiplos de 7 o de 13.

CREATE OR REPLACE 
PROCEDURE multiplosSieteTrece AS 

BEGIN 
	FOR i IN 1..100 LOOP 
		IF (MOD(i,7) = 0) OR (MOD(i,13) = 0) THEN
		DBMS_OUTPUT.PUT_LINE(i);
		END IF;
		
	END LOOP;
END multiplosSieteTrece ;

BEGIN 
	multiplosSieteTrece ;
END;


--3. Realizar un procedure que muestre los número múltiplos del primer parámetro que van desde el
--segundo parámetro hasta el tercero.

CREATE OR REPLACE 
PROCEDURE multiplosParametros(num NUMBER, inicio NUMBER, limite NUMBER) AS 

BEGIN 
	FOR i IN inicio..limite LOOP 
		IF (MOD(i,num) = 0) THEN
		DBMS_OUTPUT.PUT_LINE(i);
		END IF;
		
	END LOOP;
END multiplosParametros;

BEGIN 
	multiplosParametros(3, 6, 30);
END;


--4. Procedure que reciba un número entero por parámetro y visualice su tabla de multiplicar.

CREATE OR REPLACE 
PROCEDURE tablaMultiplicar(num NUMBER) AS 
resultado NUMBER; 
BEGIN 
	FOR i IN 0..10 LOOP 
		resultado := num*i; 
		DBMS_OUTPUT.PUT_LINE(num||' x '||i||' = '||resultado);
	END LOOP;
END tablaMultiplicar;

BEGIN 
	tablaMultiplicar(7);
END;


--5. Realizar un procedure que muestre los número comprendidos desde el primer parámetro hasta
--el segundo.

CREATE OR REPLACE 
PROCEDURE mostrarNum(inicio NUMBER, limite NUMBER) AS 

BEGIN 
	FOR i IN inicio..limite LOOP 
		DBMS_OUTPUT.PUT_LINE(i);
	END LOOP;
END mostrarNum;

BEGIN 
	mostrarNum(48, 62);
END;


--6. Realizar un procedure que cuente de 20 en 20, desde el primer parámetro hasta el segundo.

CREATE OR REPLACE 
PROCEDURE mostrarNum20(inicio NUMBER, limite NUMBER) AS 
contador NUMBER := inicio; 

BEGIN 
	WHILE contador <= limite LOOP  
		DBMS_OUTPUT.PUT_LINE(contador);
		contador := contador+20;
	END LOOP;

END mostrarNum20;

BEGIN 
	mostrarNum20(48, 248);
END;


--7. Realizar un procedure que reciba dos números como parámetro, y muestre el resultado de
--elevar el primero parámetro al segundo.

CREATE OR REPLACE 
PROCEDURE elevar(uno NUMBER, dos NUMBER) IS 
resultado NUMBER;

BEGIN 
	resultado := power(uno,dos);
	DBMS_OUTPUT.PUT_LINE(resultado);
END elevar;

BEGIN 
	elevar(2,3);
END;


--8. Realizar un procedure que reciba dos números como parámetro y muestre el resultado de elevar
--el primero número a 1, a 2... hasta el segundo número.

CREATE OR REPLACE 
PROCEDURE elevarListando(num NUMBER, limite NUMBER) IS 
resultado NUMBER; 

BEGIN
	FOR i IN 1..limite LOOP 
		resultado := power(num,i);
		DBMS_OUTPUT.PUT_LINE(num||' elevado a '||i||' = '||resultado);
	END LOOP;
END elevarListando;

BEGIN 
	elevarListando(2,3);
END;


--9. Procedure que tome un número N que se le pasa por parámetro y muestre la suma de los N
--primeros números.

CREATE OR REPLACE 
PROCEDURE sumarNumeros(num NUMBER) IS 
suma NUMBER := 0;

BEGIN 
	FOR i IN 1..num LOOP
		suma:= suma +i;
	END LOOP; 
	DBMS_OUTPUT.PUT_LINE(suma);
END sumarNumeros;

BEGIN
	sumarNumeros(3);
END;


--10. Función que tome como parámetros dos números enteros A y B, y calcule el producto de A y B
--mediante sumas, mostrando el resultado y devolviéndolo.

CREATE OR REPLACE 
FUNCTION multiplicarSumando(a NUMBER, b NUMBER) 
RETURN NUMBER 
IS 
resultado NUMBER := 0;

BEGIN 
	FOR i IN 1..b LOOP 
		resultado := resultado + a;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE(resultado);
	RETURN resultado;
END multiplicarSumando;

SELECT multiplicarSumando(2,3) FROM dual; 


--11. Procedure que tome como parámetros dos números B y E enteros positivos, y calcule la potencia
--(B elevado a E) a través de productos.

CREATE OR REPLACE 
PROCEDURE potenciaMultiplicando(b NUMBER, e NUMBER) 
IS 
resultado NUMBER := 1;

BEGIN 
	FOR i IN 1..e LOOP 
		resultado := resultado*b;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(resultado);
END potenciaMultiplicando;

BEGIN 
	potenciaMultiplicando(2,3); 
END;


--12. Realizar un procedure que reciba como parámetro un número entero positivo N y calcule el
--factorial.
--Factorial (0)= 1
--Factorial (1)= 1
--Factorial (N) = N * Factorial(N – 1)

CREATE OR REPLACE 
PROCEDURE factorial(num NUMBER) IS 
factorial NUMBER := 1;
BEGIN 
	IF num<0 THEN
		DBMS_OUTPUT.PUT_LINE('Error, el número introducido no es positivo.');
	ELSIF num=0 OR num=1 THEN 
		factorial := 1;
	ELSE 
		FOR i IN 1..num LOOP
			factorial := factorial*i;
		END LOOP; 
	DBMS_OUTPUT.PUT_LINE(factorial);
	END IF; 
END factorial;

BEGIN 
	factorial(3);
	factorial(-3);
END;


--13. Realizar un procedure que reciba como parámetro un número N entero positivo y calcule la suma
--del inverso de N y los números anteriores a N, es decir:
--1/1 + 1/2 + 1/3 + 1/4 + ...... 1/N

CREATE OR REPLACE 
PROCEDURE sumaInversos(n NUMBER) IS 
resultado NUMBER := 0;

BEGIN
	IF n<=0 THEN
		DBMS_OUTPUT.PUT_LINE('Error, el número introducido no es positivo.');
	ELSE
		FOR i IN 1..n LOOP
			resultado := resultado + 1/i;	
		END LOOP; 
		DBMS_OUTPUT.PUT_LINE(resultado);
	END IF; 
END sumaInversos;

BEGIN
	sumaInversos(3);
	sumaInversos(0);
END; 


