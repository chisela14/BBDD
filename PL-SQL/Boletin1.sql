--1. Crea un procedimiento llamado ESCRIBE para mostrar por pantalla el mensaje HOLA MUNDO.
CREATE OR REPLACE 
PROCEDURE ESCRIBE IS 
BEGIN 
	DBMS_OUTPUT.PUT_LINE ('Hola Mundo');
END;

BEGIN 
	ESCRIBE;
END;

--2. Crea un procedimiento llamado ESCRIBE_MENSAJE que tenga un
--parámetro de tipo VARCHAR2 que recibe un texto y lo muestre por pantalla.
CREATE OR REPLACE 
PROCEDURE ESCRIBE_MENSAJE (mensaje varchar2) IS 
BEGIN 
	DBMS_OUTPUT.PUT_LINE (mensaje);
END;

BEGIN
	ESCRIBE_MENSAJE ('HOLA');
END;

--3. Crea un procedimiento llamado SERIE que muestre por pantalla una serie de
--números desde un mínimo hasta un máximo con un determinado paso.
CREATE OR REPLACE 
PROCEDURE SERIE (minimo NUMBER, maximo NUMBER, paso NUMBER) IS 
i  BINARY_INTEGER := minimo; --aquí se declaran las variables
BEGIN 
	WHILE i<= maximo LOOP 
	DBMS_OUTPUT.PUT_LINE (i); 
	i := i+paso;
	END LOOP;
END;

BEGIN 
	SERIE (1,20,2);
END;

--4. Crea una función AZAR que reciba dos parámetros y genere un número al
--azar entre un mínimo y máximo indicado.
CREATE OR REPLACE
FUNCTION AZAR (num1 NUMBER, num2 NUMBER)
RETURN NUMBER IS 
BEGIN 
	RETURN DBMS_RANDOM.VALUE(num1, num2);
END;

--otra forma
CREATE OR REPLACE
FUNCTION AZAR2 (minimo NUMBER, maximo NUMBER)
RETURN NUMBER IS
rango NUMBER := maximo - minimo;
BEGIN 
	RETURN MOD(ABS(DBMS_RANDOM.RANDOM),rango)+minimo;
END;

SELECT AZAR(2,10) FROM DUAL;
SELECT AZAR2(2,10) FROM DUAL;

--5. Crea una función NOTA que reciba un parámetro que será una nota numérica
--entre 0 y 10 y devuelva una cadena de texto con la calificación (Suficiente,
--Bien, Notable, ...). 
CREATE OR REPLACE 
FUNCTION NOTA (nota NUMBER)
RETURN VARCHAR2 IS
BEGIN
  IF  nota = 10 OR nota = 9 THEN
    RETURN DBMS_OUTPUT.PUT_LINE('Sobresaliente');
  ELSIF nota = 8 OR nota = 7 THEN
    RETURN DBMS_OUTPUT.PUT_LINE('Notable');
  ELSIF nota = 6 THEN
    RETURN DBMS_OUTPUT.PUT_LINE('Bien');
  ELSIF nota = 5 THEN
    RETURN DBMS_OUTPUT. PUT_LINE('Suficiente');
  ELSIF nota < 5 AND nota >=0 THEN
    RETURN DBMS_OUTPUT.PUT_LINE('Insuficiente');
  ELSE
    RETURN DBMS_OUTPUT.PUT_LINE('Nota no válida');
  END IF;
END;

--otra forma 
CREATE OR REPLACE 
FUNCTION NOTA (nota NUMBER)
RETURN VARCHAR2 IS
BEGIN
CASE 
    WHEN nota=10 THEN RETURN 'Sobresaliente';
    WHEN 9  THEN DBMS_OUTPUT.PUT_LINE('Sobresaliente');
    WHEN 8  THEN DBMS_OUTPUT.PUT_LINE('Notable');
    WHEN 7  THEN DBMS_OUTPUT.PUT_LINE('Notable');
    WHEN 6  THEN DBMS_OUTPUT.PUT_LINE('Bien');
    WHEN 5  THEN DBMS_OUTPUT.PUT_LINE('Suficiente');
    WHEN 4  THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    WHEN 3  THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    WHEN 2  THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    WHEN 1  THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    WHEN 0  THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    ELSE DBMS_OUTPUT.PUT_LINE('Nota no válida');
  END CASE;
 END NOTA; 
--corregir con captura

SELECT NOTA(5) FROM DUAL;

--El codigo de los procedimientos se puede borrar después porque se queda guardado











