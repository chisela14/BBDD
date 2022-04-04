--estructura sencilla
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