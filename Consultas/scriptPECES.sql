--ALTER SESSION set "_oracle_script"=true;
--CREATE USER PECES IDENTIFIED BY PECES;
--GRANT CONNECT, RESOURCE, DBA TO PECES;

DROP TABLE CapturasEventos;
DROP TABLE Participaciones;
DROP TABLE Permisos;
DROP TABLE Licencias;
DROP TABLE CapturasSolos;
DROP TABLE Afiliados;
DROP TABLE Eventos;
DROP TABLE Peces;
DROP TABLE Lugares;
DROP TABLE Cauces;

CREATE TABLE Afiliados ( 
  ficha NUMBER(4) NOT NULL,  
  nombre VARCHAR2(20) NOT NULL,  
  apellidos VARCHAR2(30) NOT NULL,  
  direccion VARCHAR2(30),  
  telf NUMBER(9),  
  sexo CHAR(1),  
  nacimiento DATE, 
  observaciones CLOB ) ;

CREATE TABLE Licencias (
  licencia VARCHAR2(9) NOT NULL) ;

CREATE TABLE Permisos ( 
  ficha NUMBER(4) NOT NULL,  
  licencia VARCHAR2(9) NOT NULL); 

CREATE TABLE Cauces  ( 
  cauce VARCHAR2(50) not null,  
  observaciones CLOB ); 

CREATE TABLE Lugares ( 
  lugar VARCHAR2(50) NOT NULL,  
  comunidad VARCHAR2(20) NOT NULL,  
  observaciones CLOB,
  cauce varchar2(50)); 

CREATE TABLE Eventos  ( 
  evento VARCHAR2(60) not null,  
  fecha_evento DATE not null,  
  lugar VARCHAR2(50),  
  observaciones CLOB ); 

CREATE TABLE Peces ( 
  pez VARCHAR2(30),  
  observaciones CLOB ); 

CREATE TABLE Participaciones ( 
  ficha NUMBER(4) nOT NULL,  
  evento VARCHAR2(60) NOT NULL,  
  posicion NUMBER(3),  
  trofeo VARCHAR2(30) ) ;

CREATE TABLE CapturasSolos ( 
  ficha NUMBER(4) NOT NULL,  
  pez VARCHAR2(30)  NOT NULL,  
  fecha_pesca DATE NOT NULL,  
  hora_pesca DATE NOT NULL,  
  peso NUMBER(5,3),  
  talla NUMBER(3),  
  foto BLOB,  
  lugar VARCHAR2(40),  
  aval1 NUMBER(4),  
  aval2 NUMBER(4) ) ;

CREATE TABLE CapturasEventos  ( 
  ficha NUMBER(4) NOT NULL,  
  pez VARCHAR2(30) NOT NULL,  
  fecha_pesca DATE NOT NULL,  
  hora_pesca DATE NOT NULL,  
  peso NUMBER(5,3),  
  talla NUMBER(3),  
  foto BLOB,  
  evento VARCHAR2(60) NOT NULL,  
  puntos NUMBER(4) ) ;

/* Se definen las claves de las tablas */
ALTER TABLE Afiliados  
  ADD CONSTRAINT pks  
    PRIMARY KEY (ficha);
ALTER TABLE Licencias  
  ADD CONSTRAINT pk_lic  
    PRIMARY KEY (licencia);
ALTER TABLE Permisos  
  ADD CONSTRAINT pk_Permisos  
    PRIMARY KEY (ficha, licencia);
ALTER TABLE Cauces  
  ADD CONSTRAINT pk_Cauces  
    PRIMARY KEY (cauce);
ALTER TABLE Lugares  
  ADD CONSTRAINT pk_lugar  
    PRIMARY KEY (lugar);
ALTER TABLE Eventos  
  ADD CONSTRAINT pk_evento  
    PRIMARY KEY (evento);
ALTER TABLE Peces
  ADD CONSTRAINT pk_Peces  
    PRIMARY KEY (pez);
ALTER TABLE Participaciones  
  ADD CONSTRAINT pk_Participaciones  
    PRIMARY KEY (ficha,evento);
ALTER TABLE CapturasSolos  
  ADD CONSTRAINT pk_CapturasSolos  
    PRIMARY KEY (ficha, pez, fecha_pesca, hora_pesca,lugar);
ALTER TABLE CapturasEventos  
  ADD CONSTRAINT pk_CapturasEventos  
    PRIMARY KEY (ficha, pez, fecha_pesca, hora_pesca);

/* Se definen las restricciones de integridad de referencia */
ALTER TABLE Permisos  
  ADD CONSTRAINT fk_per_afi  
    FOREIGN KEY (ficha)  
REFERENCES Afiliados(ficha)  
ON DELETE CASCADE;
ALTER TABLE Permisos  
  ADD CONSTRAINT fk_per_lic  
    FOREIGN KEY (licencia)  
REFERENCES Licencias(licencia)  
ON DELETE CASCADE; 
ALTER TABLE Participaciones  
  ADD CONSTRAINT fk_par_aso  
    FOREIGN KEY (ficha)  
    REFERENCES Afiliados(ficha)  
    ON DELETE CASCADE;
ALTER TABLE Participaciones  
  ADD CONSTRAINT fk_par_eve  
    FOREIGN KEY (evento)  
    REFERENCES Eventos(evento)  
    ON DELETE CASCADE; 
ALTER TABLE CapturasSolos
  ADD CONSTRAINT fk_cps_af1  
    FOREIGN KEY (ficha)  
    REFERENCES Afiliados(ficha)  
    ON DELETE CASCADE;
ALTER TABLE CapturasSolos  
  ADD CONSTRAINT fk_cps_pez  
    FOREIGN KEY (pez)  
    REFERENCES Peces(pez)  
    ON DELETE CASCADE;
ALTER TABLE CapturasSolos  
  ADD CONSTRAINT fk_cps_lug  
    FOREIGN KEY (lugar)  
    REFERENCES Lugares(lugar)  
    ON DELETE CASCADE;
ALTER TABLE CapturasSolos  
  ADD CONSTRAINT fk_cps_af2  
    FOREIGN KEY (aval1)  
    REFERENCES Afiliados(ficha);
ALTER TABLE CapturasSolos  
  ADD CONSTRAINT fk_cps_af3  
    FOREIGN KEY (aval2)  
    REFERENCES Afiliados(ficha);
ALTER TABLE CapturasEventos  
  ADD CONSTRAINT fk_cpe_afi  
    FOREIGN KEY (ficha)  
    REFERENCES Afiliados(ficha)  
    ON DELETE CASCADE;
ALTER TABLE CapturasEventos  
  ADD CONSTRAINT fk_cpe_pez  
    FOREIGN KEY (pez)  
    REFERENCES Peces(pez)  
    ON DELETE CASCADE;
ALTER TABLE CapturasEventos  
  ADD CONSTRAINT fk_cpe_eve  
    FOREIGN KEY (evento)  
    REFERENCES Eventos(evento)  
    ON DELETE CASCADE; 
ALTER TABLE Lugares
  ADD CONSTRAINT fk_lug_cau
      FOREIGN KEY (cauce)
      REFERENCES Cauces(cauce)
      ON DELETE CASCADE;
ALTER TABLE Eventos
  ADD CONSTRAINT fk_eve_lug
    FOREIGN KEY (lugar)
    REFERENCES Lugares(lugar)
    ON DELETE CASCADE;

/* Se definen las restricciones de dominio */
ALTER TABLE Licencias  
  ADD CONSTRAINT ck_lic  
    CHECK (licencia = UPPER(licencia));
ALTER TABLE Cauces  
  ADD CONSTRAINT ck_cau  
    CHECK (cauce = INITCAP(cauce)); 
ALTER TABLE Lugares  
  ADD CONSTRAINT ck_lug  
    CHECK (lugar = INITCAP(lugar));
ALTER TABLE Lugares  
  ADD CONSTRAINT ck_comun  
    CHECK (comunidad = UPPER(comunidad));
ALTER TABLE Afiliados  
  ADD CONSTRAINT ck_nap  
    CHECK (apellidos = INITCAP(apellidos));
ALTER TABLE Afiliados  
  ADD CONSTRAINT ck_saf  
    CHECK (sexo IN ('H','M'));
ALTER TABLE Afiliados  
  ADD CONSTRAINT ck_naf  
    CHECK (nombre = INITCAP(nombre));
ALTER TABLE Peces
  ADD CONSTRAINT ck_pez  
    CHECK (pez = INITCAP(pez)); 
ALTER TABLE CapturasSolos  
  ADD CONSTRAINT ck_pso  
    CHECK (peso > 0);
ALTER TABLE CapturasSolos  
  ADD CONSTRAINT ck_tal  
    CHECK (talla > 0); 
ALTER TABLE CapturasEventos  
  ADD CONSTRAINT ck_ps2  
    CHECK (peso > 0);
ALTER TABLE CapturasEventos  
  ADD CONSTRAINT ck_ta2  
    CHECK (talla > 0); 
   
-- Se inserta en la tabla Afiliados
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (1000,'Enrique','Lozano Conde',
         'C\Paz,30 Bajo A',957666666,'H',
         TO_DATE('18/04/1973','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (1001,'Alfonso','Lopez Perez',
         'Avda. El Brillante s/n',958256325,'H',
         TO_DATE('25/05/1960','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (1002,'Alfonsa','Lozano Conde',
         'Avda. El Brillante s/n',356858584,'M',
         TO_DATE('02/02/1962','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (1003,'Jose','Lopez Garcia',
         'Avda. El Brillante s/n',91758582,'H',
         TO_DATE('21/03/1952','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (1004,'Juana','Gonzalez Garcia',
         'Avda. El Brillante s/n',95825256,'M',
         TO_DATE('26/02/1971','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (1005,'Antonio','Fernandez Lorente',
         'C\Carlos III,3, 1� IZQ',92655282,'H',
         TO_DATE('25/01/1963','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (1006,'Pedro','Lopez Lorente',
         'Republica Argentina,20',9824552,'H',
         TO_DATE('01/01/1953','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (3456,'Rafael','Gonzalez Lorente',
         'C\Carlos III,5,2� DCHA',9825235,'H',
         TO_DATE('04/06/1965','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (1008,'Felipe','Lopez Espinola',
         'Avda.America, 25',96723545,'H',
         TO_DATE('03/02/1967','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (1009,'Carlos','Fernandez Espinola',
         'Republica Argentina,26,Bajo A',98282165,'H',
         TO_DATE('21/06/1960','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (1010,'Jose','Gonzalez Espinola',
         'C\Carlos III,20,3� IZQ',95425151,'H',
         TO_DATE('06/08/1968','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (2000,'Jose','Lopez Espinola',
         'Cardenal Cisnero, 28, 1D',95628825,'H',
         TO_DATE('07/08/1954','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (2001,'Jose','Fernandez Espinola',
         'Pepin Romero, 50, BAJO C',392858251,'H',
         TO_DATE('08/09/1950','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (2002,'Francisco','Lopez Gomez',
         'Cardenal Cisneros, 10',24554575,'H',
         TO_DATE('01/05/1958','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (2003,'Alonso','Gonzalez Gomez',
         'Las Moreras, 25',45541522,'H',
         TO_DATE('03/04/1962','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (2004,'Manuel','Fernandez Gonzalez',
         'Benito Infante,25',2154252,'H',
         TO_DATE('09/10/1963','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (3796,'Rafael','Fernandez Gomez',
         'C\Carlos III,5,2D',15154545,'H',
         TO_DATE('01/05/1963','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (2006,'Miguel','Lopez Sillero',
         'C\Carlos III,50,3A',12252455,'H',
         TO_DATE('07/07/1957','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (2007,'David','Fernandez Sillero',
         'Urbanizacion Las Lomas s/n',57245326,'H',
         TO_DATE('25/10/1966','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (2008,'Antonio','Lopez Sillero',
         'Las Palmeras, 20, 2�A',25455356,'H',
         TO_DATE('01/05/1962','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (2009,'Jesus','Fernandez Tamayo',
         'Camino del Rio, 25',4554665,'H',
         TO_DATE('23/05/1954','DD/MM/YYYY'),'');
INSERT
  INTO Afiliados (ficha, nombre, apellidos,
       direccion, telf, sexo,
       nacimiento, observaciones)
  VALUES (2010,'Bernardo','Fernandez Gonzalez',
         'Paseo de la Catellana, 60',4527522,'H',
         TO_DATE('06/08/1966','DD/MM/YYYY'),'');

-- Se inserta en la tabla Licencias
INSERT
  INTO Licencias (Licencia)
  VALUES ('A-1111111');
INSERT
  INTO Licencias (Licencia)
  VALUES ('B-1111111');
INSERT
  INTO Licencias (Licencia)
  VALUES ('C-1111111');
INSERT
  INTO Licencias (Licencia)
  VALUES ('D-1111111');
INSERT
  INTO Licencias (Licencia)
  VALUES ('E-1111111');

-- Se inserta en la tabla Permisos
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1000,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1000,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1000,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1001,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1001,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1001,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1002,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1002,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1003,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1003,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1003,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1003,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1003,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1004,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1004,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1004,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1005,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1005,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1005,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1006,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1006,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (3456,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (3456,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (3456,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (3456,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (3456,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1008,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1008,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1008,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1008,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1009,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1009,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1010,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1010,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1010,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1010,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (1010,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2000,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2000,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2000,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2000,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2000,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2001,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2001,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2001,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2002,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2002,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2002,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2003,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2003,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2003,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2003,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2003,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2004,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2004,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2004,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (3796,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (3796,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (3796,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2006,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2006,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2007,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2007,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2007,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2007,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2007,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2008,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2008,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2008,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2008,'E-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2009,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2009,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2010,'A-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2010,'B-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2010,'C-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2010,'D-1111111');
INSERT
  INTO Permisos (ficha,licencia)
  VALUES (2010,'E-1111111');

-- Se inserta en la tabla Cauces
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Andarax','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Mojaceite','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Embalse De Santa Maria','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Embalse De Beznar','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Embalse De Colomera','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Embalse De Cubillas','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Embalse De Quentar','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Embalse De San Rafael De Navallana','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Embalse De San Clemente','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Aguas Blancas','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Alhama','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Cacin','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Castril','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Dilar','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Fardes','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Frailes','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Frio','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Genazar','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Genil','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Maitena','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Riofrio','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Trevelez','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Aguadero','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Aguamela','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Albuniel','');
INSERT
  INTO Cauces (cauce, observaciones)
  VALUES ('Rio Borosa','');

-- Se inserta en la tabla Lugares
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De El Bosque','ANDALUCIA','Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Mojaceite';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De San Rafael','ANDALUCIA',
         'Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Embalse De San Rafael De Navallana';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Embalse De Santa Maria','ANDALUCIA',
         'Coto De Ciprinidos',cauce
    FROM Cauces s
    WHERE cauce='Embalse De Santa Maria';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Embalse De Beznar','ANDALUCIA',
         'Coto De Ciprinidos',cauce
    FROM Cauces s
    WHERE cauce='Embalse De Beznar';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto Del Embalse De Colomera','ANDALUCIA',
         'Coto De Ciprinidos',cauce
    FROM Cauces s
    WHERE cauce='Embalse De Colomera';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto Del Embalse De Cubillas','ANDALUCIA',
         'Coto De Ciprinidos',cauce
    FROM Cauces s
    WHERE cauce='Embalse De Cubillas';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto Del Embalse Quentar','ANDALUCIA',
         'Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Embalse De Quentar';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Aguas Blancas','ANDALUCIA',
         'Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Aguas Blancas';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Alhama','ANDALUCIA','Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Alhama';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Cacin','ANDALUCIA','',cauce
    FROM Cauces s
    WHERE cauce='Rio Cacin';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Cacin Segundo','ANDALUCIA','Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Cacin';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Castril','ANDALUCIA','Coto sin Muerte',cauce
    FROM Cauces s
    WHERE cauce='Rio Castril';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Dilar','ANDALUCIA','Coto tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Dilar';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Fardes','ANDALUCIA','Coto tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Fardes';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Velillos','ANDALUCIA','Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Frailes';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Riofrio Normal','ANDALUCIA','Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Frio';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Genazar','ANDALUCIA','Rio Genazar',cauce
    FROM Cauces s
    WHERE cauce='Rio Genazar';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Genil','ANDALUCIA','Coto Sin Muerte',cauce
    FROM Cauces s
    WHERE cauce='Rio Genil';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Pinillos','ANDALUCIA','Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Genil';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Maitena','ANDALUCIA','Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Maitena';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Riofrio Intensivo','ANDALUCIA',
         'Coto Intensivo',cauce
    FROM Cauces s
    WHERE cauce='Rio Riofrio';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Trevelez','ANDALUCIA','Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Trevelez';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Aguadero Hondo','ANDALUCIA',
         'Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Aguadero';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Aguamula','ANDALUCIA','Coto Sin Muerte',cauce
    FROM Cauces s
    WHERE cauce='Rio Aguamela';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Arbuniel','ANDALUCIA','Coto Tradicional',cauce
    FROM Cauces s
    WHERE cauce='Rio Albuniel';
INSERT
  INTO Lugares (lugar, comunidad, observaciones,cauce)
  SELECT 'Coto De Borosa','ANDALUCIA','Coto Sin Muerte',cauce
    FROM Cauces s
    WHERE cauce='Rio Borosa';

-- Se inserta en la tabla Eventos
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '1er Encuentro Lures And Pikes',
         TO_DATE('21/03/1994','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De El Bosque';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '2� Encuentro Lures And Pikes',
         TO_DATE('15/03/1995','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De El Bosque';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '3er Encuentro Lures And Pikes',
         TO_DATE('15/03/1995','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Dilar';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '4� Encuentro Lures And Pikes',
         TO_DATE('17/03/1996','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Dilar';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '1er  Encuentro Internacional.CASPE BASS',
         TO_DATE('10/05/1992','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Fardes';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '2�  Encuentro Internacional.CASPE BASS',
         TO_DATE('13/05/1994','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Fardes';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '3er  Encuentro Internacional.CASPE BASS',
         TO_DATE('13/05/1996','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Fardes';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '4�  Encuentro Internacional.CASPE BASS',
         TO_DATE('13/05/1998','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Fardes';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '5�  Encuentro Internacional.CASPE BASS',
         TO_DATE('14/05/2000','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Fardes';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '1� Campeonato de ANDALUCIA de Pesca de Bass',
         TO_DATE('16/03/1997','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De San Rafael';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '2� Campeonato de ANDALUCIA de Pesca de Bass',
         TO_DATE('13/03/1998','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De San Rafael';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '3� Campeonato de ANDALUCIA de Pesca de Bass',
         TO_DATE('16/03/1999','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De San Rafael';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '4� Campeonato de ANDALUCIA de Pesca de Bass',
         TO_DATE('16/03/2000','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De San Rafael';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '1� Encuentro Nacional de Pesca del Barbo',
         TO_DATE('01/03/1996','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Embalse De Santa Maria';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '2� Encuentro Nacional de Pesca del Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Embalse De Santa Maria';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '3� Encuentro Nacional de Pesca del Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Embalse De Santa Maria';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '4� Encuentro Nacional de Pesca del Barbo',
         TO_DATE('03/03/1999','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Embalse De Beznar';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '5� Encuentro Nacional de Pesca del Barbo',
         TO_DATE('01/03/2000','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Embalse De Beznar';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT 'Super Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto Del Embalse De Colomera';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT 'Trucha Total',
         TO_DATE('22/05/1998','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Riofrio Intensivo';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT 'Pesca del Barbo',
         TO_DATE('25/04/1996','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Genil';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '1� Encuentro Provincial',
         TO_DATE('28/06/1995','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Aguas Blancas';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '2� Encuentro Provincial',
         TO_DATE('20/05/1996','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Maitena';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '1� Concurso de Pesca Ciudad de Granada',
         TO_DATE('06/04/1995','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto Del Embalse De Cubillas';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '2� Concurso de Pesca Ciudad de Granada',
         TO_DATE('06/05/1996','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto Del Embalse De Cubillas';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '3� Concurso de Pesca Ciudad de Granada',
         TO_DATE('08/05/1997','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto Del Embalse De Cubillas';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '4� Concurso de Pesca Ciudad de Granada',
         TO_DATE('01/03/1998','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto Del Embalse De Cubillas';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT 'Super Barbo Dos',
         TO_DATE('06/10/2000','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto Del Embalse Quentar';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT 'La Gran Trucha',
         TO_DATE('08/05/1999','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Alhama';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '1� Concurso de Pesca de Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Cacin';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '2� Concurso de Pesca de Perca-Sol',
         TO_DATE('06/10/1997','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Cacin Segundo';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT 'Super Pez Gato',
         TO_DATE('01/02/1997','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Castril';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '1� Encuentro de Pesca de Cacho',
         TO_DATE('15/07/1992','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Velillos';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT '2� Encuentro de Pesca de Cacho',
         TO_DATE('02/06/1993','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Riofrio Normal';
INSERT
  INTO Eventos (evento, fecha_evento,lugar)
  SELECT 'Super Carpa',
         TO_DATE('21/03/1999','DD/MM/YYYY'), lugar
    FROM Lugares s
    WHERE lugar='Coto De Genazar';

-- Se inserta en la tabla Peces
INSERT
  INTO Peces (pez,observaciones)
  VALUES ('Barbo','Especie muy comun en los rios de Espana. Como
         principalmente gusanos, pececillos, algas, gusanos,
         lombriz y miga de pan.Habitat:augas oxigendas y curso
         medio de los rios');
INSERT
  INTO Peces (pez,observaciones)
  VALUES ('Black-Bass','En norteamerica presenta unas grandes
         dimenisiones, aunque en Europa, su dimension es menor.
         Pica bien a la lombriz, cucharilla y pez vivo. Habitat:
         aguas de curso lento y zonas con vegetacion o rocas.');
INSERT
  INTO Peces (pez,observaciones)
  VALUES ('Cacho','Muy abundante en Espana y de costumbres
         gregarias. Alcanzan unos 25 cm ya hasta 1,5kgr. Habita:
         aguas corrientes y lagos.');
INSERT
  INTO Peces (pez,observaciones)
  VALUES ('Carpa','. Se trata de una especie originaria de Asia,
         se halla extendida por tobservacionesa Europa. Alcanza los 100 cms y
         los 30 Kgs de peso. Se alimenta de plantas acuaticas,
         moluscos, larvas, gusanos, pececillos y masillas de
         cerreales');
INSERT
  INTO Peces (pez,observaciones)
  VALUES ('Lucio','Prototipo depredador de agua dulce. Puede medir
         115 cm y pesar 34 kgs. Pica con otros peces vivos,
         cucharillas, mosca, invertebrados y casi cualquier animal
         que caiga al agua, incluso pequenas aves. Habitat: aguas
         lentas con obstaculos, pantanos y lagos');
INSERT
  INTO Peces (pez,observaciones)
  VALUES ('Perca-Sol','Uno de los azotes de rios y pantanos, ya
         que devora huevos y fezadas de otras especies. Mide de 10
         a 30 cms. y en EEUU puede pesar hasta 3 kgs. Come larvas,
         insectos, alevines y huevos de otros peces. Habitat:aguas
         lentas con vegetacion, lagos y pantanos.');
INSERT
  INTO Peces (pez,observaciones)
  VALUES ('Pez Gato','Muy resistente a la contaminacion, ocho
         barbillones le robservacionesean la boca. Mide de 20 a 40 cms. y
         llega a pesar hasta 2 kgs. Come larvas, moluscos, huevos,
         pececillos y ranas. Habitat: lagos y rios de curso
         lento');
INSERT
  INTO Peces (pez,observaciones)
  VALUES ('Salmon','Se desarrolla en el mar pero desova en los
         rios, donde permanencen de 1 a 5 anos. Pesan de 4 a 6
         kgs. y a veces miden mas de 40 cms de largo. Pican con
         pececillos muertos, lombrices, crustaceos y a mosca.
         Habitat: rios y torrentes de montana');
INSERT
  INTO Peces (pez,observaciones)
  VALUES ('Tenca','Pez robusto, bastante asustadizo, muy
         resistente a la falta de oxigeno. Puede pesar unos 2
         kgs., llegando a medir 30 cms. Se alimenta de larvas y
         gusanos, huevos de pez y caracolillos. Habitat: aguas
         quietas o lentas, lagos y estanques');
INSERT
  INTO Peces (pez,observaciones)
  VALUES ('Trucha','Uno de los peces mas populares y cotizados, es
         de costumbres sedentarias. Llega a pesar 15 kgs. y medir
         100 cms. Come insectos, gusanos, larvas, crustaceos,
         alevines y huevos de peces. Habitat: rios y lagos de
         aguas frias y oxigenadas');

-- Se inserta en la tabla Participaciones
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2001,'La Gran Trucha',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'La Gran Trucha',4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'La Gran Trucha',3,'Copa y 25000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'La Gran Trucha',2,'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3456,'Pesca del Barbo',24,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'Pesca del Barbo',22,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'Pesca del Barbo',20,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'Pesca del Barbo',19,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'Pesca del Barbo',18,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'Pesca del Barbo',15,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2010,'Pesca del Barbo',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'Pesca del Barbo',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'Pesca del Barbo',1,'Copa y 100000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2004,'Super Barbo',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1008,'Super Barbo',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2003,'Super Barbo',11,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'Super Barbo',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'Super Barbo',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2009,'Super Barbo',3,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'Super Barbo',2,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'Super Barbo',1,'Copa y 20000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'Super Barbo Dos',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'Super Barbo Dos',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2001,'Super Barbo Dos',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'Super Barbo Dos',4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1010,'Super Barbo Dos',2,'Copa y 25000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2002,'Super Barbo Dos',1,'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2010,'Super Carpa',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'Super Carpa',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2001,'Super Carpa',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'Super Carpa',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2009,'Super Carpa',1,'Copa y 100000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'Super Pez Gato',11,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'Super Pez Gato',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2010,'Super Pez Gato',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1004,'Super Pez Gato',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'Super Pez Gato',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2003,'Super Pez Gato',4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1008,'Super Pez Gato',3,'Copa');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2004,'1� Campeonato de ANDALUCIA de Pesca de Bass',
        7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1001,'1� Campeonato de ANDALUCIA de Pesca de Bass',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'1� Campeonato de ANDALUCIA de Pesca de Bass',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2006,'1� Campeonato de ANDALUCIA de Pesca de Bass',4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'1� Campeonato de ANDALUCIA de Pesca de Bass',2,'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'1� Concurso de Pesca Ciudad de Granada',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2002,'1� Concurso de Pesca Ciudad de Granada',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2006,'1� Concurso de Pesca Ciudad de Granada',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'1� Concurso de Pesca Ciudad de Granada',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'1� Concurso de Pesca Ciudad de Granada',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3456,'1� Concurso de Pesca Ciudad de Granada',4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'1� Concurso de Pesca Ciudad de Granada',3,'Copa');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'1� Concurso de Pesca Ciudad de Granada',1,
        'Copa y 60000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'1� Concurso de Pesca de Perca-Sol',19,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2002,'1� Concurso de Pesca de Perca-Sol',18,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'1� Concurso de Pesca de Perca-Sol',17,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1008,'1� Concurso de Pesca de Perca-Sol',15,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'1� Concurso de Pesca de Perca-Sol',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'1� Concurso de Pesca de Perca-Sol',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2010,'1� Concurso de Pesca de Perca-Sol',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2004,'1� Concurso de Pesca de Perca-Sol',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2003,'1� Concurso de Pesca de Perca-Sol',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3456,'1� Encuentro de Pesca de Cacho',20,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'1� Encuentro de Pesca de Cacho',19,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2001,'1� Encuentro de Pesca de Cacho',18,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'1� Encuentro de Pesca de Cacho',17,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'1� Encuentro de Pesca de Cacho',15,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2006,'1� Encuentro de Pesca de Cacho',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'1� Encuentro de Pesca de Cacho',11,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2010,'1� Encuentro de Pesca de Cacho',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3456,'1� Encuentro Nacional de Pesca del Barbo',17,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'1� Encuentro Nacional de Pesca del Barbo',16,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'1� Encuentro Nacional de Pesca del Barbo',11,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'1� Encuentro Nacional de Pesca del Barbo',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2002,'1� Encuentro Nacional de Pesca del Barbo',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1004,'1� Encuentro Nacional de Pesca del Barbo',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'1� Encuentro Nacional de Pesca del Barbo',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'1� Encuentro Nacional de Pesca del Barbo',4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'1� Encuentro Nacional de Pesca del Barbo',3,'Copa');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2006,'1� Encuentro Provincial',19,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'1� Encuentro Provincial',18,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2010,'1� Encuentro Provincial',15,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'1� Encuentro Provincial',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2003,'1� Encuentro Provincial',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'1� Encuentro Provincial',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1008,'1� Encuentro Provincial',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1001,'1� Encuentro Provincial',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1010,'1� Encuentro Provincial',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'1� Encuentro Provincial',4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'1� Encuentro Provincial',3,'Copa');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'1� Encuentro Provincial',2,'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'1er  Encuentro Internacional.CASPE BASS',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'1er  Encuentro Internacional.CASPE BASS',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1010,'1er  Encuentro Internacional.CASPE BASS',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'1er  Encuentro Internacional.CASPE BASS',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2001,'1er  Encuentro Internacional.CASPE BASS',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2006,'1er  Encuentro Internacional.CASPE BASS',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'1er  Encuentro Internacional.CASPE BASS',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2004,'1er Encuentro Lures And Pikes',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'1er Encuentro Lures And Pikes',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2009,'1er Encuentro Lures And Pikes',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'1er Encuentro Lures And Pikes',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'1er Encuentro Lures And Pikes',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'1er Encuentro Lures And Pikes',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1004,'1er Encuentro Lures And Pikes',3,'Copa');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'1er Encuentro Lures And Pikes',2,'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2010,'1er Encuentro Lures And Pikes',1,'Copa y 100000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1008,'2�  Encuentro Internacional.CASPE BASS',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2009,'2�  Encuentro Internacional.CASPE BASS',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'2�  Encuentro Internacional.CASPE BASS',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'2�  Encuentro Internacional.CASPE BASS',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2004,'2� Campeonato de ANDALUCIA de Pesca de Bass',
        13,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'2� Campeonato de ANDALUCIA de Pesca de Bass',
        12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'2� Campeonato de ANDALUCIA de Pesca de Bass',
        9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'2� Campeonato de ANDALUCIA de Pesca de Bass',
        7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'2� Campeonato de ANDALUCIA de Pesca de Bass',
        6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1004,'2� Campeonato de ANDALUCIA de Pesca de Bass',
        5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'2� Campeonato de ANDALUCIA de Pesca de Bass',
        4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2004,'2� Concurso de Pesca Ciudad de Granada',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'2� Concurso de Pesca Ciudad de Granada',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2001,'2� Concurso de Pesca Ciudad de Granada',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'2� Concurso de Pesca Ciudad de Granada',4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1010,'2� Concurso de Pesca Ciudad de Granada',3,
        'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2010,'2� Concurso de Pesca Ciudad de Granada',2,
        'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'2� Concurso de Pesca Ciudad de Granada',1,
        'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'2� Concurso de Pesca de Perca-Sol',19,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1001,'2� Concurso de Pesca de Perca-Sol',18,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'2� Concurso de Pesca de Perca-Sol',17,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'2� Concurso de Pesca de Perca-Sol',15,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3456,'2� Concurso de Pesca de Perca-Sol',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'2� Concurso de Pesca de Perca-Sol',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1008,'2� Concurso de Pesca de Perca-Sol',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2003,'2� Encuentro de Pesca de Cacho',40,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2009,'2� Encuentro de Pesca de Cacho',37,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2004,'2� Encuentro de Pesca de Cacho',35,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'2� Encuentro de Pesca de Cacho',32,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'2� Encuentro de Pesca de Cacho',30,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2010,'2� Encuentro de Pesca de Cacho',28,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'2� Encuentro de Pesca de Cacho',26,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'2� Encuentro de Pesca de Cacho',25,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2009,'2� Encuentro Lures And Pikes',16,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'2� Encuentro Lures And Pikes',15,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2001,'2� Encuentro Lures And Pikes',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3456,'2� Encuentro Lures And Pikes',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1001,'2� Encuentro Lures And Pikes',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'2� Encuentro Lures And Pikes',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1010,'2� Encuentro Lures And Pikes',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'2� Encuentro Lures And Pikes',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'2� Encuentro Lures And Pikes',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'2� Encuentro Nacional de Pesca del Barbo',18,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'2� Encuentro Nacional de Pesca del Barbo',17,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1008,'2� Encuentro Nacional de Pesca del Barbo',16,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'2� Encuentro Nacional de Pesca del Barbo',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2002,'2� Encuentro Nacional de Pesca del Barbo',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'2� Encuentro Nacional de Pesca del Barbo',11,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'2� Encuentro Nacional de Pesca del Barbo',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1001,'2� Encuentro Nacional de Pesca del Barbo',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2006,'2� Encuentro Nacional de Pesca del Barbo',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'2� Encuentro Nacional de Pesca del Barbo',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2001,'2� Encuentro Provincial',17,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'2� Encuentro Provincial',16,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'2� Encuentro Provincial',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2004,'2� Encuentro Provincial',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'2� Encuentro Provincial',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'2� Encuentro Provincial',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3456,'2� Encuentro Provincial',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'2� Encuentro Provincial',1,'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'3� Campeonato de ANDALUCIA de Pesca de Bass',
        9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3456,'3� Campeonato de ANDALUCIA de Pesca de Bass',
        8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1004,'3� Campeonato de ANDALUCIA de Pesca de Bass',
        7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'3� Campeonato de ANDALUCIA de Pesca de Bass',
        6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2006,'3� Campeonato de ANDALUCIA de Pesca de Bass',
        5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'3� Campeonato de ANDALUCIA de Pesca de Bass',
        4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2006,'3� Concurso de Pesca Ciudad de Granada',18,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1010,'3� Concurso de Pesca Ciudad de Granada',17,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2001,'3� Concurso de Pesca Ciudad de Granada',15,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'3� Concurso de Pesca Ciudad de Granada',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'3� Concurso de Pesca Ciudad de Granada',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'3� Concurso de Pesca Ciudad de Granada',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1004,'3� Encuentro Nacional de Pesca del Barbo',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3456,'3� Encuentro Nacional de Pesca del Barbo',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'3� Encuentro Nacional de Pesca del Barbo',11,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2006,'3� Encuentro Nacional de Pesca del Barbo',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1008,'3� Encuentro Nacional de Pesca del Barbo',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1001,'3� Encuentro Nacional de Pesca del Barbo',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'3� Encuentro Nacional de Pesca del Barbo',3,'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'3� Encuentro Nacional de Pesca del Barbo',1,'Copa y 200000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'3er  Encuentro Internacional.CASPE BASS',20,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1004,'3er  Encuentro Internacional.CASPE BASS',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2009,'3er  Encuentro Internacional.CASPE BASS',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'3er  Encuentro Internacional.CASPE BASS',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'3er Encuentro Lures And Pikes',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1000,'3er Encuentro Lures And Pikes',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'3er Encuentro Lures And Pikes',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'3er Encuentro Lures And Pikes',4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2002,'3er Encuentro Lures And Pikes',2,'Copa y 50000');
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'4�  Encuentro Internacional.CASPE BASS',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'4�  Encuentro Internacional.CASPE BASS',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1010,'4�  Encuentro Internacional.CASPE BASS',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1008,'4� Campeonato de ANDALUCIA de Pesca de Bass',
        14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'4� Campeonato de ANDALUCIA de Pesca de Bass',
        12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1010,'4� Campeonato de ANDALUCIA de Pesca de Bass',
        10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'4� Campeonato de ANDALUCIA de Pesca de Bass',
        9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'4� Campeonato de ANDALUCIA de Pesca de Bass',
        7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'4� Campeonato de ANDALUCIA de Pesca de Bass',
        5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2010,'4� Campeonato de ANDALUCIA de Pesca de Bass',
        4,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'4� Concurso de Pesca Ciudad de Granada',16,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1010,'4� Concurso de Pesca Ciudad de Granada',15,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'4� Concurso de Pesca Ciudad de Granada',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1004,'4� Concurso de Pesca Ciudad de Granada',11,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'4� Concurso de Pesca Ciudad de Granada',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2003,'4� Concurso de Pesca Ciudad de Granada',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'4� Concurso de Pesca Ciudad de Granada',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1001,'4� Encuentro Lures And Pikes',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2000,'4� Encuentro Lures And Pikes',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1002,'4� Encuentro Lures And Pikes',11,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2001,'4� Encuentro Lures And Pikes',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1003,'4� Encuentro Lures And Pikes',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1009,'4� Encuentro Lures And Pikes',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3796,'4� Encuentro Nacional de Pesca del Barbo',14,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1005,'4� Encuentro Nacional de Pesca del Barbo',12,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2006,'4� Encuentro Nacional de Pesca del Barbo',10,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2007,'4� Encuentro Nacional de Pesca del Barbo',9,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1004,'4� Encuentro Nacional de Pesca del Barbo',8,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(2008,'4� Encuentro Nacional de Pesca del Barbo',7,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(3456,'4� Encuentro Nacional de Pesca del Barbo',6,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1006,'4� Encuentro Nacional de Pesca del Barbo',5,NULL);
INSERT
  INTO Participaciones(ficha,evento,posicion,trofeo)
  VALUES(1008,'4� Encuentro Nacional de Pesca del Barbo',
        3,'Copa');

-- Se inserta en la tabla CapturasSolos
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1000,'Barbo',
         TO_DATE('12/03/1995','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         '6',40,'Coto De El Bosque',1001,3456);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1000,'Barbo',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         5.5,37,'Coto De El Bosque',1002,3456);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1000,'Barbo',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         6.5,45,'Coto De El Bosque',1003,3456);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1000,'Black-Bass',
         TO_DATE('12/04/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         4,45,'Coto De San Rafael',1004,3456);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1000,'Cacho',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1,20,'Coto De San Rafael',1005,3456);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1002,'Carpa',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         25,80,'Coto De Embalse De Santa Maria',1006,1005);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1002,'Lucio',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         28,90,'Coto Del Embalse De Colomera',3456,1006);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1002,'Perca-Sol',
         TO_DATE('22/04/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.5,25,'Coto Del Embalse De Cubillas',1008,3456);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,peso,talla,lugar,aval1,aval2)
  VALUES (1002,'Pez Gato',
         TO_DATE('20/03/1997','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         1.5,30,'Coto De Aguas Blancas',1009,1008);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1002,'Salmon',
         TO_DATE('22/04/1997','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         6,30,'Coto De Embalse De Santa Maria',1010,1009);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1002,'Tenca',
         TO_DATE('22/04/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.6,23,'Coto Del Embalse De Colomera',2000,1010);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1003,'Trucha',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         13,45,'Coto Del Embalse De Cubillas',2001,2000);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1003,'Trucha',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         12,43,'Coto De Aguas Blancas',2002,2001);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1003,'Lucio',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         30,100,'Coto De Alhama',2003,2002);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1003,'Perca-Sol',
         TO_DATE('12/04/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2,22,'Coto De Cacin',2004,2003);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1005,'Pez Gato',
         TO_DATE('12/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.75,20,'Coto De Castril',3796,2004);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1005,'Barbo',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         7,60,'Coto De Dilar',2006,3796);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1005,'Black-Bass',
         TO_DATE('20/03/1997','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         8,70,'Coto De Fardes',2007,2006);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1005,'Cacho',
         TO_DATE('22/04/1997','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         1.25,22,'Coto De Velillos',2008,2007);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1006,'Carpa',
         TO_DATE('22/04/1997','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         26,90,'Coto De Genazar',2009,2008);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1006,'Lucio',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         32,105,'Coto De Genil',2010,2009);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1006,'Perca-Sol',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2,23,'Coto De Alhama',1006,1005);	
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1006,'Pez Gato',
         TO_DATE('20/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.5,30,'Coto De Cacin',3456,1006);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1006,'Salmon',
         TO_DATE('12/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         5.6,30,'Coto De Castril',1008,3456);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (3456,'Tenca',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         12,80,'Coto De Dilar',1009,1008);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1009,'Trucha',
         TO_DATE('12/04/1996','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         12.5,80,'Coto De Fardes',1010,1009);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1009,'Trucha',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         11.7,76,'Coto De Velillos',2000,1010);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1009,'Barbo',
         TO_DATE('16/05/2000','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,68,'Coto De Genazar',2001,2000);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1010,'Black-Bass',
         TO_DATE('20/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'Coto De Genil',2002,2001);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1010,'Cacho',
         TO_DATE('09/03/1998','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         1.5,25,'Coto De Pinillos',2003,2002);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2000,'Carpa',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         27,96,'Coto De Riofrio Intensivo',2004,2003);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2000,'Lucio',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         32,102,'Coto De Trevelez',3796,2004);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2000,'Perca-Sol',
         TO_DATE('22/04/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2,15,'Coto De Aguadero Hondo',2006,3796);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2002,'Pez Gato',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         1.5,20,'Coto De Arbuniel',2007,2006);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2002,'Salmon',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         5,25,'Coto De Borosa',2008,2007);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2002,'Tenca',
         TO_DATE('20/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.5,25,'Coto De Pinillos',2009,2008);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2003,'Trucha',
         TO_DATE('16/05/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         13.8,89,'Coto De Riofrio Intensivo',2010,2009);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2006,'Trucha',
         TO_DATE('12/03/1995','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         12.6,75,'Coto De Trevelez',1006,1005);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2006,'Barbo',
         TO_DATE('12/04/1996','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         8,60,'Coto De Arbuniel',3456,1006);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2006,'Black-Bass',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,70,'Coto De Borosa',1008,3456);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2006,'Cacho',
         TO_DATE('09/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.2,20,'Coto De Pinillos',1009,1008);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2007,'Carpa',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         23.7,85,'Coto De Riofrio Intensivo',1010,1009);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2007,'Lucio',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         29,102,'Coto De Trevelez',2000,1010);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2007,'Perca-Sol',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.3,25,'Coto De Castril',2001,2000);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2007,'Pez Gato',
         TO_DATE('20/03/1997','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         1.7,23,'Coto De Dilar',2002,2001);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2009,'Salmon',
         TO_DATE('12/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.5,32,'Coto De Fardes',2003,2002);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2009,'Barbo',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         6.3,62,'Coto De Velillos',2004,2003);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2009,'Black-Bass',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.8,66,'Coto De Genazar',3796,2004);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2009,'Cacho',
         TO_DATE('12/04/1996','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         1.5,25,'Coto De Borosa',2006,3796);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2010,'Carpa',
         TO_DATE('22/04/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         27,96,'Coto De Pinillos',2007,2006);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2010,'Lucio',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         32,102,'Coto De Riofrio Intensivo',2008,2007);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1006,'Perca-Sol',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         2.3,24,'Coto De Trevelez',2009,2008);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1006,'Pez Gato',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         1.7,17,'Coto De Arbuniel',2010,2009);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (3456,'Salmon',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.2,35,'Coto De El Bosque',1006,1005);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1009,'Tenca',
         TO_DATE('20/03/1997','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         1.6,21,'Coto De El Bosque',3456,1006);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1009,'Trucha',
         TO_DATE('11/02/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         12.6,79,'Coto De El Bosque',1008,3456);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1009,'Trucha',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         13.5,83,'Coto De San Rafael',1009,1008);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1010,'Perca-Sol',
         TO_DATE('12/03/1995','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         2.6,22,'Coto De San Rafael',1010,1009);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1010,'Pez Gato',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.8,29,'Coto De Embalse De Santa Maria',2000,1010);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2000,'Salmon',
         TO_DATE('12/04/1996','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         6,31,'Coto Del Embalse De Colomera',2001,2000);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2000,'Barbo',
         TO_DATE('16/05/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.3,67,'Coto De Borosa',2002,2001);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2000,'Black-Bass',
         TO_DATE('11/02/1997','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         8.7,72,'Coto De Pinillos',2003,2002);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2002,'Cacho',
         TO_DATE('05/06/1993','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         1.3,22,'Coto De Riofrio Intensivo',2004,2003);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2002,'Carpa',
         TO_DATE('20/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         22.9,81,'Coto De Trevelez',3796,2004);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2002,'Lucio',
         TO_DATE('22/04/1997','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         31,106,'Coto De Pinillos',2006,3796);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2003,'Perca-Sol',
         TO_DATE('12/04/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.7,27,'Coto De Riofrio Intensivo',2007,2006);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (2006,'Pez Gato',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         1.6,22,'Coto De Trevelez',2008,2007);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1000,'Salmon',
         TO_DATE('12/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.8,37,'Coto De Arbuniel',2009,2008);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1000,'Tenca',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2,30,'Coto De El Bosque',2010,2009);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1002,'Trucha',
         TO_DATE('09/03/1998','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         15,100,'Coto De El Bosque',1006,1005);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1002,'Trucha',
         TO_DATE('20/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         13.7,85,'Coto De El Bosque',3456,1006);
INSERT
  INTO CapturasSolos (ficha,pez,fecha_pesca,hora_pesca,
        peso,talla,lugar, aval1,aval2)
  VALUES (1002,'Perca-Sol',
         TO_DATE('05/06/1994','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         1.6,24,'Coto De San Rafael',1008,3456);

-- Se inserta en la tabla CapturasEventos
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8.7,72,'1er Encuentro Lures And Pikes',870); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Black-Bass',
         TO_DATE('06/04/1995','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8.7,72,'1� Concurso de Pesca Ciudad de Granada',870); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         8,68,'1� Encuentro Provincial',800); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Cacho',
         TO_DATE('02/06/1993','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         1.50,25,'2� Encuentro de Pesca de Cacho',150);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Cacho',
         TO_DATE('15/07/1992','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         1.20,20,'1� Encuentro de Pesca de Cacho',120);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Black-Bass',
         TO_DATE('13/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),8.7,72,
         '2� Campeonato de ANDALUCIA de Pesca de Bass',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Perca-Sol',
         TO_DATE('06/10/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.0,23,'2� Concurso de Pesca de Perca-Sol',200);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,68,'2� Encuentro Nacional de Pesca del Barbo',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,68,'Super Barbo',450);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Trucha',
         TO_DATE('08/05/1999','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         13,45,'La Gran Trucha',500); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Barbo',
         TO_DATE('25/04/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         7,60,'Pesca del Barbo',350);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Carpa',
         TO_DATE('21/03/1999','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         27,97,'Super Carpa',750); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         2.3,25,'1� Concurso de Pesca de Perca-Sol',230); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1000,'Black-Bass',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,75,'3er Encuentro Lures And Pikes',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1001,'Cacho',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),

         1.40,24,'2� Encuentro Lures And Pikes',140);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1001,'Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,60,'2� Encuentro Nacional de Pesca del Barbo',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1001,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,67,'3� Encuentro Nacional de Pesca del Barbo',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1001,'Perca-Sol',
         TO_DATE('06/10/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.0,15,'2� Concurso de Pesca de Perca-Sol',200);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1001,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8,60,'1� Encuentro Provincial',800); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1001,'Black-Bass',
         TO_DATE('16/03/1997','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),7.5,70,
         '1� Campeonato de ANDALUCIA de Pesca de Bass',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1001,'Black-Bass',
         TO_DATE('17/03/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.7,65,'4� Encuentro Lures And Pikes',670);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Black-Bass',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.7,72,'3er Encuentro Lures And Pikes',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.3,67,'Super Barbo',400);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('10:45','HH24:MI'),
         8.3,67,'Super Barbo',400);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('11:45','HH24:MI'),
         8.3,67,'Super Barbo',400);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         8.3,67,'Super Barbo',400);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('12:45','HH24:MI'),
         8.3,67,'Super Barbo',400);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('11:25','HH24:MI'),
         8.3,67,'Super Barbo',400);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Pez Gato',
         TO_DATE('01/02/1997','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         1.5,30,'Super Pez Gato',650); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Black-Bass',
         TO_DATE('17/03/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.7,72,'4� Encuentro Lures And Pikes',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.0,15,'1� Concurso de Pesca de Perca-Sol',200); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Barbo',
         TO_DATE('01/03/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         6.3,62,'1� Encuentro Nacional de Pesca del Barbo',630);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         6,59,'1� Encuentro Provincial',600); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Perca-Sol',
         TO_DATE('06/10/1997','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         2.3,25,'2� Concurso de Pesca de Perca-Sol',230);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Carpa',
         TO_DATE('06/05/1996','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         25,80,'2� Concurso de Pesca Ciudad de Granada',2500);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'1er Encuentro Lures And Pikes',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         7.7,62,'1er Encuentro Lures And Pikes',770);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1002,'Barbo',
         TO_DATE('20/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,60,'2� Encuentro Provincial',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.45,24,'2� Encuentro Nacional de Pesca del Barbo',145);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Barbo',
         TO_DATE('20/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.3,67,'2� Encuentro Provincial',830);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Barbo',
         TO_DATE('20/05/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         6,59,'2� Encuentro Provincial',600);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Carpa',
         TO_DATE('06/05/1996','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         26,90,'2� Concurso de Pesca Ciudad de Granada',2600);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Black-Bass',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8.7,72,'3er Encuentro Lures And Pikes',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Barbo',
         TO_DATE('01/03/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8.1,67,'1� Encuentro Nacional de Pesca del Barbo',810);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Barbo',
         TO_DATE('25/04/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.3,67,'Pesca del Barbo',400);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Barbo',
         TO_DATE('06/10/2000','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7,45,'Super Barbo Dos',320); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Black-Bass',
         TO_DATE('17/03/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.9,81,'4� Encuentro Lures And Pikes',890);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Black-Bass',
         TO_DATE('10/05/1992','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         7.5,65,'1er  Encuentro Internacional.CASPE BASS',750); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Black-Bass',
         TO_DATE('06/04/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.7,65,'1� Concurso de Pesca Ciudad de Granada',670); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Black-Bass',
         TO_DATE('16/03/2000','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'4� Campeonato de ANDALUCIA de Pesca de Bass',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1003,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.3,67,'1� Encuentro Provincial',830); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1004,'Barbo',
         TO_DATE('03/03/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,60,'4� Encuentro Nacional de Pesca del Barbo',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1004,'Pez Gato',
         TO_DATE('01/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.7,17,'Super Pez Gato',800); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1004,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.7,65,'1er Encuentro Lures And Pikes',670);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1004,'Black-Bass',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8.5,70,'4� Concurso de Pesca Ciudad de Granada',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1004,'Barbo',
         TO_DATE('01/03/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,60,'1� Encuentro Nacional de Pesca del Barbo',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1004,'Black-Bass',
         TO_DATE('13/03/1998','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),8.9,81,
         '2� Campeonato de ANDALUCIA de Pesca de Bass',890);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1004,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         8,70,'1er Encuentro Lures And Pikes',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1004,'Black-Bass',
         TO_DATE('16/03/1999','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),7.7,90,
         '3� Campeonato de ANDALUCIA de Pesca de Bass',770);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1004,'Black-Bass',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'3er  Encuentro Internacional.CASPE BASS',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1004,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         5,33,'3� Encuentro Nacional de Pesca del Barbo',533);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Perca-Sol',
         TO_DATE('06/10/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.0,22,'2� Concurso de Pesca de Perca-Sol',200);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Barbo',
         TO_DATE('03/03/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.3,62,'4� Encuentro Nacional de Pesca del Barbo',630);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Trucha',
         TO_DATE('08/05/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         12,43,'La Gran Trucha',460);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7,60,'Super Barbo',350);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.9,80,'1er Encuentro Lures And Pikes',890);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Black-Bass',
         TO_DATE('06/04/1995','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         8.9,81,'1� Concurso de Pesca Ciudad de Granada',890); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Black-Bass',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'4� Concurso de Pesca Ciudad de Granada',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Black-Bass',
         TO_DATE('16/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),8.7,72,
         '1� Campeonato de ANDALUCIA de Pesca de Bass',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Cacho',
         TO_DATE('15/07/1992','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.50,25,'1� Encuentro de Pesca de Cacho',150);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Barbo',
         TO_DATE('01/03/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.5,45,'1� Encuentro Nacional de Pesca del Barbo',650);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1005,'Cacho',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         1.20,20,'2� Encuentro Lures And Pikes',120);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Cacho',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         1.50,25,'2� Encuentro Lures And Pikes',150);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Barbo',
         TO_DATE('01/03/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,67,'1� Encuentro Nacional de Pesca del Barbo',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         1.6,24,'1� Concurso de Pesca de Perca-Sol',160); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Pez Gato',
         TO_DATE('01/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.5,20,'Super Pez Gato',600); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Trucha',
         TO_DATE('08/05/1999','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         12.5,80,'La Gran Trucha',470); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Barbo',
         TO_DATE('25/04/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.3,62,'Pesca del Barbo',320);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Barbo',
         TO_DATE('03/03/1999','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8.2,67,'4� Encuentro Nacional de Pesca del Barbo',820);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Black-Bass',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7.5,65,'3er Encuentro Lures And Pikes',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Black-Bass',
         TO_DATE('13/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),8.5,75,
         '2� Campeonato de ANDALUCIA de Pesca de Bass',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.5,45,'3� Encuentro Nacional de Pesca del Barbo',650);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Barbo',
         TO_DATE('20/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.5,41,'2� Encuentro Provincial',650);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1006,'Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         6.5,45,'2� Encuentro Nacional de Pesca del Barbo',650);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.3,62,'2� Encuentro Nacional de Pesca del Barbo',630);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         8.3,67,'3� Encuentro Nacional de Pesca del Barbo',830);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.0,23,'1� Concurso de Pesca de Perca-Sol',200); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Barbo',
         TO_DATE('03/03/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.4,67,'4� Encuentro Nacional de Pesca del Barbo',840);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         6.5,45,'Super Barbo',320);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Pez Gato',
         TO_DATE('01/02/1997','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         1.8,23,'Super Pez Gato',900); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Black-Bass',
         TO_DATE('16/03/2000','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),7.5,65,
         '4� Campeonato de ANDALUCIA de Pesca de Bass',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,65,'1� Encuentro Provincial',800); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Perca-Sol',
         TO_DATE('06/10/1997','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         2.5,25,'2� Concurso de Pesca de Perca-Sol',250);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Black-Bass',
         TO_DATE('13/05/1994','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         6.8,66,'2�  Encuentro Internacional.CASPE BASS',680);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1008,'Perca-Sol',
         TO_DATE('06/10/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.6,22,'2� Concurso de Pesca de Perca-Sol',260);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Perca-Sol',
         TO_DATE('06/10/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.7,27,'2� Concurso de Pesca de Perca-Sol',270);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Black-Bass',
         TO_DATE('13/03/1998','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),8.7,72,
         '2� Campeonato de ANDALUCIA de Pesca de Bass',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.3,67,'1� Encuentro Provincial',830); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Black-Bass',
         TO_DATE('06/04/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,75,'1� Concurso de Pesca Ciudad de Granada',850); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Barbo',
         TO_DATE('25/04/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,68,'Pesca del Barbo',450);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Carpa',
         TO_DATE('21/03/1999','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         25,80,'Super Carpa',550);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Black-Bass',
         TO_DATE('17/03/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.9,80,'4� Encuentro Lures And Pikes',890);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Barbo',
         TO_DATE('01/03/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.5,45,'1� Encuentro Nacional de Pesca del Barbo',650);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         5,33,'2� Encuentro Nacional de Pesca del Barbo',533);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7,60,'3� Encuentro Nacional de Pesca del Barbo',700);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8.1,67,'3� Encuentro Nacional de Pesca del Barbo',810);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1009,'Barbo',
         TO_DATE('20/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,68,'2� Encuentro Provincial',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1010,'Cacho',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.50,25,'2� Encuentro Lures And Pikes',150);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1010,'Black-Bass',
         TO_DATE('08/05/1997','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8,70,'3� Concurso de Pesca Ciudad de Granada',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1010,'Black-Bass',
         TO_DATE('13/05/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.9,81,'4�  Encuentro Internacional.CASPE BASS',890);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1010,'Black-Bass',
         TO_DATE('16/03/2000','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),7.7,62,
         '4� Campeonato de ANDALUCIA de Pesca de Bass',770);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1010,'Barbo',
         TO_DATE('06/10/2000','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,67,'Super Barbo Dos',430); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1010,'Black-Bass',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7.5,65,'4� Concurso de Pesca Ciudad de Granada',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1010,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.22,67,'1� Encuentro Provincial',822); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1010,'Black-Bass',
         TO_DATE('10/05/1992','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'1er  Encuentro Internacional.CASPE BASS',800); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (1010,'Carpa',
         TO_DATE('06/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         27,96,'2� Concurso de Pesca Ciudad de Granada',2700);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Black-Bass',
         TO_DATE('13/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),7.5,65,
         '2� Campeonato de ANDALUCIA de Pesca de Bass',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Black-Bass',
         TO_DATE('10/05/1992','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8,70,'1er  Encuentro Internacional.CASPE BASS',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.4,67,'1� Encuentro Provincial',840); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Black-Bass',
         TO_DATE('06/04/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.9,80,'1� Concurso de Pesca Ciudad de Granada',790); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Barbo',
         TO_DATE('25/04/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         6,40,'Pesca del Barbo',300);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8.3,67,'Super Barbo',400);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Pez Gato',
         TO_DATE('01/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.7,23,'Super Pez Gato',850); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Black-Bass',
         TO_DATE('06/04/1995','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         7.7,62,'1� Concurso de Pesca Ciudad de Granada',770); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Black-Bass',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.8,66,'4� Concurso de Pesca Ciudad de Granada',680);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Black-Bass',
         TO_DATE('17/03/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         6.8,66,'4� Encuentro Lures And Pikes',680);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Black-Bass',
         TO_DATE('16/03/2000','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),7.5,65,
         '4� Campeonato de ANDALUCIA de Pesca de Bass',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Barbo',
         TO_DATE('01/03/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8,68,'1� Encuentro Nacional de Pesca del Barbo',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Cacho',
         TO_DATE('02/06/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.35,23,'2� Encuentro de Pesca de Cacho',135);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Black-Bass',
         TO_DATE('16/03/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),7.7,62,
         '3� Campeonato de ANDALUCIA de Pesca de Bass',770);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Black-Bass',
         TO_DATE('08/05/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,70,'3� Concurso de Pesca Ciudad de Granada',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2000,'Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         7,60,'2� Encuentro Nacional de Pesca del Barbo',760);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2001,'Black-Bass',
         TO_DATE('08/05/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'3� Concurso de Pesca Ciudad de Granada',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2001,'Barbo',
         TO_DATE('20/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         5.5,37,'2� Encuentro Provincial',550);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2001,'Cacho',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         1.25,22,'2� Encuentro Lures And Pikes',125);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2001,'Carpa',
         TO_DATE('06/05/1996','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         25,90,'2� Concurso de Pesca Ciudad de Granada',2500);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2001,'Black-Bass',
         TO_DATE('10/05/1992','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8.5,70,'1er  Encuentro Internacional.CASPE BASS',850); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2001,'Black-Bass',
         TO_DATE('17/03/1996','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         8.7,72,'4� Encuentro Lures And Pikes',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2001,'Trucha',
         TO_DATE('08/05/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         11.7,76,'La Gran Trucha',430); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2001,'Barbo',
         TO_DATE('06/10/2000','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,69,'Super Barbo Dos',400); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2001,'Carpa',
         TO_DATE('21/03/1999','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         26,90,'Super Carpa',630); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2001,'Cacho',
         TO_DATE('15/07/1992','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.25,22,'1� Encuentro de Pesca de Cacho',125);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2002,'Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         6.5,45,'2� Encuentro Nacional de Pesca del Barbo',650);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2002,'Barbo',
         TO_DATE('06/10/2000','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8,65,'Super Barbo Dos',430); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2002,'Black-Bass',
         TO_DATE('06/04/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7.5,65,'1� Concurso de Pesca Ciudad de Granada',750); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2002,'Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.6,24,'1� Concurso de Pesca de Perca-Sol',160); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2002,'Barbo',
         TO_DATE('01/03/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7,60,'1� Encuentro Nacional de Pesca del Barbo',700);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2002,'Black-Bass',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8.9,80,'3er Encuentro Lures And Pikes',890);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2003,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         6.5,41,'Super Barbo',320);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2003,'Pez Gato',
         TO_DATE('01/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.75,20,'Super Pez Gato',875); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2003,'Black-Bass',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,75,'4� Concurso de Pesca Ciudad de Granada',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2003,'Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         2.3,24,'1� Concurso de Pesca de Perca-Sol',230); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2003,'Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.0,22,'1� Concurso de Pesca de Perca-Sol',200); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2003,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         7,60,'1� Encuentro Provincial',760); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2003,'Cacho',
         TO_DATE('02/06/1993','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         1.00,20,'2� Encuentro de Pesca de Cacho',100);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2004,'Cacho',
         TO_DATE('02/06/1993','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         1.25,22,'2� Encuentro de Pesca de Cacho',125);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2004,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7.5,65,'1er Encuentro Lures And Pikes',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2004,'Black-Bass',
         TO_DATE('13/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),6.7,65,
         '2� Campeonato de ANDALUCIA de Pesca de Bass',670);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2004,'Barbo',
         TO_DATE('20/05/1996','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         7,60,'2� Encuentro Provincial',700);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2004,'Carpa',
         TO_DATE('06/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         23.7,85,'2� Concurso de Pesca Ciudad de Granada',2300);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2004,'Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.7,27,'1� Concurso de Pesca de Perca-Sol',270); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2004,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         5.5,37,'Super Barbo',250);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2004,'Black-Bass',
         TO_DATE('16/03/1997','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),6.8,66,
         '1� Campeonato de ANDALUCIA de Pesca de Bass',680);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2006,'Black-Bass',
         TO_DATE('16/03/1997','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),8.5,70,
         '1� Campeonato de ANDALUCIA de Pesca de Bass',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2006,'Black-Bass',
         TO_DATE('06/04/1995','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         7.5,65,'1� Concurso de Pesca Ciudad de Granada',750); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2006,'Barbo',
         TO_DATE('03/03/1999','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         6.5,45,'4� Encuentro Nacional de Pesca del Barbo',650);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2006,'Cacho',
         TO_DATE('15/07/1992','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         1.45,24,'1� Encuentro de Pesca de Cacho',145);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2006,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         5.5,37,'1� Encuentro Provincial',550); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2006,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,68,'3� Encuentro Nacional de Pesca del Barbo',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2006,'Black-Bass',
         TO_DATE('08/05/1997','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         6.8,66,'3� Concurso de Pesca Ciudad de Granada',680);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2006,'Black-Bass',
         TO_DATE('10/05/1992','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.7,72,'1er  Encuentro Internacional.CASPE BASS',870); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2006,'Black-Bass',
         TO_DATE('16/03/1999','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         8,70,'3� Campeonato de ANDALUCIA de Pesca de Bass',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2006,'Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.3,67,'2� Encuentro Nacional de Pesca del Barbo',830);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Barbo',
         TO_DATE('20/05/1996','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         6.5,45,'2� Encuentro Provincial',650);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Black-Bass',
         TO_DATE('16/03/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'3� Campeonato de ANDALUCIA de Pesca de Bass',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Cacho',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.6,27,'2� Encuentro Lures And Pikes',160);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Cacho',
         TO_DATE('02/06/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.50,25,'2� Encuentro de Pesca de Cacho',150);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Black-Bass',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         6.8,66,'3er  Encuentro Internacional.CASPE BASS',680);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Black-Bass',
         TO_DATE('08/05/1997','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8.7,72,'3� Concurso de Pesca Ciudad de Granada',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Black-Bass',
         TO_DATE('16/03/2000','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'4� Campeonato de ANDALUCIA de Pesca de Bass',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Trucha',
         TO_DATE('25/04/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         13.8,89,'Pesca del Barbo',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Barbo',
         TO_DATE('25/04/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,60,'Pesca del Barbo',425);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Barbo',
         TO_DATE('06/10/2000','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6,59,'Super Barbo Dos',300); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Barbo',
         TO_DATE('03/03/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7,60,'4� Encuentro Nacional de Pesca del Barbo',700);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Cacho',
         TO_DATE('15/07/1992','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.40,24,'1� Encuentro de Pesca de Cacho',140);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Black-Bass',
         TO_DATE('10/05/1992','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.7,72,'1er  Encuentro Internacional.CASPE BASS',870); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Black-Bass',
         TO_DATE('13/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),8.9,80,
         '2� Campeonato de ANDALUCIA de Pesca de Bass',890);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Carpa',
         TO_DATE('06/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         27,96,'2� Concurso de Pesca Ciudad de Granada',2700);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2007,'Black-Bass',
         TO_DATE('13/05/1994','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8.5,70,'2�  Encuentro Internacional.CASPE BASS',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,70,'1er Encuentro Lures And Pikes',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Barbo',
         TO_DATE('03/03/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,68,'4� Encuentro Nacional de Pesca del Barbo',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Barbo',
         TO_DATE('25/04/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         6.5,45,'Pesca del Barbo',320);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Black-Bass',
         TO_DATE('16/03/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),8.2,70,
         '1� Campeonato de ANDALUCIA de Pesca de Bass',820);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.5,25,'1� Concurso de Pesca de Perca-Sol',250); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Black-Bass',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8.7,72,'4� Concurso de Pesca Ciudad de Granada',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Cacho',
         TO_DATE('15/07/1992','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.35,23,'1� Encuentro de Pesca de Cacho',135);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8.2,67,'3� Encuentro Nacional de Pesca del Barbo',820);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:20','HH24:MI'),
         6.5,45,'3� Encuentro Nacional de Pesca del Barbo',650);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,60,'3� Encuentro Nacional de Pesca del Barbo',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Black-Bass',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,70,'3er  Encuentro Internacional.CASPE BASS',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Black-Bass',
         TO_DATE('13/05/1998','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         6.7,65,'4�  Encuentro Internacional.CASPE BASS',670);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Black-Bass',
         TO_DATE('16/03/1999','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),7.5,65,
         '3� Campeonato de ANDALUCIA de Pesca de Bass',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2008,'Cacho',
         TO_DATE('02/06/1993','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         1.40,24,'2� Encuentro de Pesca de Cacho',140);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2009,'Cacho',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.00,20,'2� Encuentro Lures And Pikes',100);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2009,'Cacho',
         TO_DATE('02/06/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.20,20,'2� Encuentro de Pesca de Cacho',120);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2009,'Black-Bass',
         TO_DATE('13/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'3er  Encuentro Internacional.CASPE BASS',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2009,'Barbo',
         TO_DATE('25/03/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,60,'Super Barbo',425);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2009,'Carpa',
         TO_DATE('21/03/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         26.5,96,'Super Carpa',675); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2009,'Carpa',
         TO_DATE('21/03/1999','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         27.5,96,'Super Carpa',800); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2009,'Black-Bass',
         TO_DATE('13/05/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8,70,'2�  Encuentro Internacional.CASPE BASS',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2009,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7.7,62,'1er Encuentro Lures And Pikes',770);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Black-Bass',
         TO_DATE('10/03/1996','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8.9,81,'1er Encuentro Lures And Pikes',890);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8,70,'1er Encuentro Lures And Pikes',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Carpa',
         TO_DATE('06/05/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         27,96,'2� Concurso de Pesca Ciudad de Granada',2700);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Black-Bass',
         TO_DATE('16/03/2000','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),8.5,70,
         '4� Campeonato de ANDALUCIA de Pesca de Bass',850);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Pez Gato',
         TO_DATE('01/02/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.5,30,'Super Pez Gato',650); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Barbo',
         TO_DATE('25/04/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.3,67,'Pesca del Barbo',400);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Carpa',
         TO_DATE('21/03/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         23.7,85,'Super Carpa',500); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Perca-Sol',
         TO_DATE('06/10/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         2.6,22,'1� Concurso de Pesca de Perca-Sol',260); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Cacho',
         TO_DATE('15/07/1992','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         1.50,25,'1� Encuentro de Pesca de Cacho',150);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.5,41,'1� Encuentro Provincial',650); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (2010,'Cacho',
         TO_DATE('02/06/1993','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.45,24,'2� Encuentro de Pesca de Cacho',145);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3456,'Black-Bass',
         TO_DATE('16/03/1999','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),7.5,65,
         '3� Campeonato de ANDALUCIA de Pesca de Bass',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3456,'Barbo',
         TO_DATE('03/03/1999','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8.1,67,'4� Encuentro Nacional de Pesca del Barbo',810);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3456,'Black-Bass',
         TO_DATE('06/04/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.7,72,'1� Concurso de Pesca Ciudad de Granada',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3456,'Barbo',
         TO_DATE('25/04/1996','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         5.5,37,'Pesca del Barbo',250);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3456,'Cacho',
         TO_DATE('15/07/1992','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         1.00,20,'1� Encuentro de Pesca de Cacho',100);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3456,'Barbo',
         TO_DATE('01/03/1996','DD/MM/YYYY'),
         TO_DATE('11:05','HH24:MI'),
         5,33,'1� Encuentro Nacional de Pesca del Barbo',533);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3456,'Barbo',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         6.3,62,'3� Encuentro Nacional de Pesca del Barbo',630);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3456,'Perca-Sol',
         TO_DATE('06/10/1997','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         2.3,24,'2� Concurso de Pesca de Perca-Sol',230);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3456,'Barbo',
         TO_DATE('20/05/1996','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8.3,67,'2� Encuentro Provincial',830);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3456,'Cacho',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.35,23,'2� Encuentro Lures And Pikes',135);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Cacho',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('11:15','HH24:MI'),
         1.45,24,'2� Encuentro Lures And Pikes',145);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Cacho',
         TO_DATE('15/03/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         1.1,21,'2� Encuentro Lures And Pikes',110);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Barbo',
         TO_DATE('06/10/2000','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8.3,67,'Super Barbo Dos',400); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Barbo',
         TO_DATE('03/03/1999','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         5,33,'4� Encuentro Nacional de Pesca del Barbo',500);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Black-Bass',
         TO_DATE('01/03/1998','DD/MM/YYYY'),
         TO_DATE('08:15','HH24:MI'),
         8.7,72,'4� Concurso de Pesca Ciudad de Granada',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Black-Bass',
         TO_DATE('13/05/1998','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.7,72,'4�  Encuentro Internacional.CASPE BASS',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Black-Bass',
         TO_DATE('16/03/2000','DD/MM/YYYY'),
         TO_DATE('17:22','HH24:MI'),
         8,70,'4� Campeonato de ANDALUCIA de Pesca de Bass',800);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Barbo',
         TO_DATE('28/06/1995','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.5,45,'1� Encuentro Provincial',650); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Black-Bass',
         TO_DATE('10/05/1992','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         6.8,66,'1er  Encuentro Internacional.CASPE BASS',680); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Black-Bass',
         TO_DATE('21/03/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         7.5,65,'1er Encuentro Lures And Pikes',750);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Black-Bass',
         TO_DATE('13/05/1994','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.7,72,'2�  Encuentro Internacional.CASPE BASS',870);
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Black-Bass',
         TO_DATE('08/05/1997','DD/MM/YYYY'),
         TO_DATE('10:15','HH24:MI'),
         8.5,70,'3� Concurso de Pesca Ciudad de Granada',850); 
INSERT
  INTO CapturasEventos (ficha, pez,fecha_pesca,hora_pesca,
       peso,talla,evento,puntos)
  VALUES (3796,'Barbo',
         TO_DATE('01/03/1997','DD/MM/YYYY'),
         TO_DATE('16:05','HH24:MI'),
         8.3,67,'2� Encuentro Nacional de Pesca del Barbo',830);

commit;


