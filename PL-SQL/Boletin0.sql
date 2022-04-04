--1. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
IF 10 > 5 THEN
DBMS_OUTPUT.PUT_LINE ('Cierto');
ELSE
DBMS_OUTPUT.PUT_LINE ('Falso');
END IF;
END;
--Si se da la condicion mostrara por pantalla "cierto", y sino mostrará "falso".
--En este caso se dará la condición siempre.

--2. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
IF 10 > 5 AND 5 > 1 THEN
DBMS_OUTPUT.PUT_LINE ('Cierto');
ELSE
DBMS_OUTPUT.PUT_LINE ('Falso');
END IF;
END;
--Si se cumplen la condicion con dos elementos muestra "cierto" sino "falso".
--En este caso se cumple la condición siempre.

--3. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
IF 10 > 5 AND 5 > 50 THEN
DBMS_OUTPUT.PUT_LINE ('Cierto');
ELSE
DBMS_OUTPUT.PUT_LINE ('Falso');
END IF;
END;
--Si se cumple la condicion con dos elementos muestra "cierto", sino "falso".
--En este caso se cumple el primer elemento pero no el segundo, así que no se cumple.

--4. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
CASE
WHEN 10 > 5 AND 5 > 50 THEN
DBMS_OUTPUT.PUT_LINE ('Cierto');
ELSE
DBMS_OUTPUT.PUT_LINE ('Falso');
END CASE;
END;
--Es el mismo caso que el ejercicio anterior pero con otra sintaxis.

--5. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
FOR i IN 1..10 LOOP
DBMS_OUTPUT.PUT_LINE (i);
END LOOP;
END;
--Muestra por pantalla la variable i dentro de un bucle.

--6. Ejecuta el siguiente bloque. Indica cuál es la salida.
BEGIN
FOR i IN REVERSE 1..10 LOOP
DBMS_OUTPUT.PUT_LINE (i);
END LOOP;
END;
--Muestra por pantalla la variable i dentro de un bucle reverso.

--7. Ejecuta el siguiente bloque. Indica cuál es la salida.
DECLARE
num NUMBER(3) := 0;
BEGIN
WHILE num<=100 LOOP
DBMS_OUTPUT.PUT_LINE (num);
num:= num+2;
END LOOP;
END;
--Mientras el numero sea menor o igual a 100 se hara el bucle (mostrar valor y sumar 2 al numero).

--8. Ejecuta el siguiente bloque. Indica cuál es la salida.
DECLARE
num NUMBER(3) := 0;
BEGIN
LOOP
DBMS_OUTPUT.PUT_LINE (num);
IF num > 100 THEN EXIT; END IF;
num:= num+2;
END LOOP;
END;
--El mismo caso del ejercicio anterior pero con diferente sintaxis. En este caso el bucle
--acaba cuando el numero sea mayor que 100, así que muestra del 0 al 102 (de dos en dos).
--Abre un bucle y solo saldra si se da la condicion (numero mayor que 100).

--9. Ejecuta el siguiente bloque. Indica cuál es la salida.
DECLARE
num NUMBER(3) := 0;
BEGIN
LOOP
DBMS_OUTPUT.PUT_LINE (num);
EXIT WHEN num > 100;
num:= num+2;
END LOOP;
END;
--El mismo caso del ejercicio anterior pero con diferente sintaxis. Aquí abre un bucle 
--que salga cuando el numero sea mayor de 100.
