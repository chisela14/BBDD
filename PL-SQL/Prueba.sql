/*--estructura sencilla
BEGIN
  DBMS_OUTPUT.PUT_LINE ('Hola Mundo');
END;

--estructura general
DECLARE
  fecha DATE;
BEGIN
  SELECT sysdate INTO fecha FROM dual;
  dbms_output.put_line
  (
    to_CHAR(fecha,'day", "dd" de "month" de "yyyy", a las "hh24:mi:ss')
  );
  dbms_output.put_line(fecha);
END;
*/
/*
--Crear tabla hotel y definir procedimiento
CREATE TABLE HOTEL (ID NUMBER(2) PRIMARY KEY, NHABS NUMBER(3));

INSERT INTO HOTEL VALUES (1, 10);
INSERT INTO HOTEL VALUES (2, 60);
INSERT INTO HOTEL VALUES (3, 200);
INSERT INTO HOTEL VALUES (99, NULL);

CREATE OR REPLACE --poner siempre OR replace
PROCEDURE TAMHOTEL (cod Hotel.ID%TYPE)
AS
  NumHabitaciones  Hotel.Nhabs%TYPE;
  Comentario       VARCHAR2(40);
BEGIN
  -- Número de habitaciones del Hotel cuyo ID es cod
  SELECT Nhabs INTO NumHabitaciones
  FROM Hotel WHERE ID=cod;

  IF NumHabitaciones IS NULL THEN
    Comentario := 'de tamaño indeterminado';
  ELSIF NumHabitaciones < 50 THEN
    Comentario := 'Pequeño';
  ELSIF NumHabitaciones < 100 THEN
    Comentario := 'Mediano';
  ELSE
    Comentario := 'Grande';
  END IF;

  DBMS_OUTPUT.PUT_LINE ('El hotel con ID '|| cod ||' es '|| Comentario);
END;

BEGIN
   TAMHOTEL(1);
   TAMHOTEL(2);
   TAMHOTEL(3);
   TAMHOTEL(99);
END;
--el procedimiento se encuentra en la carpeta procedures 
--editor nuevo para los create
*/
--funciones
CREATE OR REPLACE
FUNCTION SUMA (NUM1 NUMBER, NUM2 NUMBER)
RETURN NUMBER
IS
BEGIN
  RETURN NUM1+NUM2;
END SUMA;

SELECT SUMA(5.7, 9.3)           FROM DUAL;
SELECT SUMA(5.7, 9.3)*3         FROM DUAL;
SELECT 150/(SUMA(5.7, 9.3)*3)   FROM DUAL;
SELECT SYSDATE+SUMA(10,2)-2     FROM DUAL;



