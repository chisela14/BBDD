--alter session set "_oracle_script"=true;   
--create user peliculas identified by peliculas;
--GRANT CONNECT, RESOURCE, DBA TO peliculas;

--DROP TABLE Trabajo;
--DROP TABLE Proyeccion;
--DROP TABLE Sala;
--DROP TABLE Cine;
--DROP TABLE Pelicula;
--DROP TABLE Tarea;
--DROP TABLE Personaje;

CREATE TABLE Pelicula  (
  cip VARCHAR2(10) NOT NULL,
  titulo_p VARCHAR2(45) NOT NULL,
  ano_produccion NUMBER(4) NOT NULL,
  titulo_s VARCHAR2(45),
  nacionalidad VARCHAR2(15),
  presupuesto NUMBER(11),
  duracion NUMBER(3),
    CONSTRAINT pk_pelicula
      PRIMARY KEY (cip),
    CONSTRAINT ck_pre
      CHECK (presupuesto > 0),
    CONSTRAINT ck_dur
      CHECK (duracion > 0) );


CREATE TABLE Personaje  (
  nombre_persona VARCHAR2(25) NOT NULL,
  nacionalidad_persona VARCHAR2(15),
  sexo_persona CHAR(1),
    CONSTRAINT pk_persona
      PRIMARY KEY(nombre_persona),
    CONSTRAINT ck_sep
      CHECK (sexo_persona IN ('H','M')) );

CREATE TABLE Tarea  (
  tarea VARCHAR2(30) NOT NULL,
  sexo_tarea CHAR(1),
    CONSTRAINT pk_tarea
      PRIMARY KEY (tarea),
    CONSTRAINT ck_set
      CHECK (sexo_tarea IN ('H','M','N')) );

CREATE TABLE Trabajo  (
  cip VARCHAR2(10) NOT NULL,
  nombre_persona VARCHAR2(25) NOT NULL,
  tarea VARCHAR2(35) NOT NULL,
    CONSTRAINT pk_trabajo
      PRIMARY KEY (cip,nombre_persona, tarea),
    CONSTRAINT fk_Tra_Pel
      FOREIGN KEY (cip)
      REFERENCES Pelicula(cip)
      ON DELETE CASCADE,
    CONSTRAINT fk_tra_per
      FOREIGN KEY (nombre_persona)
      REFERENCES Personaje (nombre_persona)
      ON DELETE CASCADE,
    CONSTRAINT fk_tra_tar
      FOREIGN KEY (tarea)
      REFERENCES Tarea(tarea)
      ON DELETE CASCADE );

CREATE TABLE Cine  (
  cine VARCHAR2(50) NOT NULL,
  ciudad_cine VARCHAR2(25),
  direccion_cine VARCHAR2(65),
    CONSTRAINT pk_cine
      PRIMARY KEY (cine));

CREATE TABLE Sala  (
  cine VARCHAR2(25) NOT NULL,
  sala NUMBER(2) NOT NULL,
  aforo NUMBER(4),
    CONSTRAINT pk_sala
      PRIMARY KEY (cine,sala),
    CONSTRAINT fk_sal_cin
      FOREIGN KEY (cine)
      REFERENCES Cine(cine)
      ON DELETE CASCADE,
    CONSTRAINT ck_afr
      CHECK (aforo > 0) );

CREATE TABLE Proyeccion  (
  cine VARCHAR2(25) NOT NULL,
  sala NUMBER(2) NOT NULL,
  cip VARCHAR2(10) NOT NULL,
  fecha_estreno DATE NOT NULL,
  dias_estreno NUMBER(3),
  espectadores NUMBER(6),
  recaudacion NUMBER(8),
    CONSTRAINT pk_proyeccion
      PRIMARY KEY (cine,sala, cip, fecha_estreno),
    CONSTRAINT fk_pro_sal
      FOREIGN KEY (cine,sala)
      REFERENCES Sala(cine,sala)
      ON DELETE CASCADE,
    CONSTRAINT fk_pro_pel
      FOREIGN KEY (cip)
      REFERENCES Pelicula (cip)
      ON DELETE CASCADE,
    CONSTRAINT ck_dia
      CHECK (dias_estreno>0) );

-- Se inserta en la tabla Pelicula
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111101-S','El proyecto de la Bruja Blair',
         1999,'The Blair project','EE.UU',500,82);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111103-S','El fin de los dias',
         1999,'El fin de los dias','EE.UU',7000,122);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111102-S','Viaje al centro de la tierra',
         1995,'Viaje al centro de la tierra','EE.UU',6000,139);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111104-S','Bowfinger, El picaro',
         1999,'Bowfinger, El picaro','EE.UU',4500,100);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111105-S','Un marido ideal',
         1999,'Un marido ideal','EE.UU',3000,123);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111106-S','La cara del terror',
         1997,'La cara del terror','EE.UU',4000,90);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111107-S','Jugando con el corazon',
         1995,'Jugando con el corazon','EE.UU',2500,98);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111108-S','El desayuno de campeones',
         1995,'El desayuno de campeones','EE.UU',2000,123);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111109-S','La vida prometida',
         1995,'La vida prometida','EE.UU',2560,124);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111110-S','Nadie en el mundo',
         1998,'Nadie conoce a nadie','EE.UU',800,89);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111111-S','Soledad en las monta�as',
         1999,'Soledad en las monta�as','EE.UU',900,125);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111112-S','Accidente 703',
         1995,'Accidente 703','Espa�ola',250,95);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111113-S','24 horas para la medianoche',
         1996,'24 horas para la medianoche','EE.UU',500,82);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111114-S','Veintisiete horas',
         1998,'Veintisiete horas','Espa�ola',600,79);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111115-S','Velocidad terminal',
         1996,'Velocidad terminal','Escocia',450,97);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111116-S','Verano en Louisiana',
         1996,'Verano en Louisiana','EE.UU',559,95);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111117-S','Verdad oculta',
         1997,'Verdad oculta','EE.UU',665,90);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111118-S','Viaje de novios a la Italia',
         1997,'Viaje de novios a la Italia','EE.UU',700,90);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111119-S','Vicios peque�os',
         1997,'Vicios peque�os','Francia/Italia',340,90);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111120-S','Vidas rebeldes',
         1997,'Vidas rebeldes','EE.UU',700,105);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111121-S','Virus',1998,'Virus',
         'Italia',650,92);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111122-S','Visita por Navidad',
         1998,'Visita por Navidad','EE.UU',770,87);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111123-S','Volver a empezar',
         1996,'Volver a empezar','Espa�ola',650,87);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111124-S','Volveras',1998,'Volveras',
         'EE.UU',550,96);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111125-S','Vuelta al pasado',
         1998,'Vuelta al pasado','EE.UU',800,97);
INSERT
  INTO Pelicula (cip,titulo_p,ano_produccion,titulo_s,
       nacionalidad,presupuesto,duracion)
  VALUES ('11111126-S','Vuelve la justicia',
         1998,'Vuelve la justicia','EE.UU',1200,88);

-- Se inserta en la tabla Personaje
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Heather Donahue','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Michael C. Williams','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Joely Richardson','EE.UU','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Gary Oldman','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Daniel Myrick','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Euduardo Sanchez','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Arnold Schwarzenegger','EE.UU','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Peter Hyams','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Steve Martin','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Eddie Murphy','EE.UU','');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Cate Blanchet','G.B','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Julianne Moore','G.B','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Johnny Depp','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Charlize Theron','Francia','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Sean Connery','Scotland','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Gilian Anderson','EE.UU','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Bruce Willis','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('S. Bonnaire','EE.UU','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Catherine Deneuve','Francia','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Pierce Brosnan','EE.UU','');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Sophie Marceau','Belgica','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Kevin Kline','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Michael Pheipher','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Jonh Cusack','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Jay Acovone','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Matt Leblanc','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Zach Galligan','UK','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Michele Laroque','Francia','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Barbara Klopple','EE.UU','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Isaac Hayes','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Richard Lynch','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Barbara Streisand','EE.UU','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Tommy Davidson','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Norman Kaye','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Sandy Core','EE.UU','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Sally Kellerman','EE.UU','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Jodie Foster','EE.UU','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Buba Bayouri','India','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Myra, S. Pierce','EE.UU','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Bernie Pock','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Leo T. Fong','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Martxelo Rubio','Espa�ola','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Maribel Verdu','Espa�ola','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Jon Donosti','Espa�ola','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Montxo Armendariz','Espa�ola','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Charlie Sheen','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Natassja Kinski','Rusa','M');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Christopher Mcdonald','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Luis G. Berlanga','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Sam Waterston','EE.UU','H');
INSERT
  INTO Personaje (nombre_persona,nacionalidad_persona,
       sexo_persona)
  VALUES ('Tess Harper','EE.UU','M');

-- Se inserta en la tabla Tarea
INSERT
  INTO Tarea (tarea,sexo_tarea)
  VALUES ('Productor','N');
INSERT
  INTO Tarea (tarea,sexo_tarea)
  VALUES ('Actor Principal','H');
INSERT
  INTO Tarea (tarea,sexo_tarea)
  VALUES ('Actriz Principal','M');
INSERT
  INTO Tarea (tarea,sexo_tarea)
  VALUES ('Actor Secundario','H');
INSERT
  INTO Tarea (tarea,sexo_tarea)
  VALUES ('Actriz Secundaria','M');
INSERT
  INTO Tarea (tarea,sexo_tarea)
  VALUES ('Director','N');

-- Se inserta en la tabla Trabajo
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111101-S','Heather Donahue','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111101-S','Michael C. Williams','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111101-S','Daniel Myrick','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111101-S','Euduardo Sanchez','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111101-S','Joely Richardson','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111101-S','Gary Oldman','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111101-S','Gary Oldman','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111102-S','Kevin Kline','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111102-S','Matt Leblanc','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111102-S','Michael C. Williams','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111102-S','Michael Pheipher','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111102-S','Michele Laroque','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111103-S','Arnold Schwarzenegger','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111103-S','Barbara Klopple','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111103-S','Cate Blanchet','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111103-S','Daniel Myrick','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111103-S','Gary Oldman','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111103-S','Zach Galligan','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111104-S','Barbara Streisand','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111104-S','Bruce Willis','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111104-S','Buba Bayouri','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111104-S','Catherine Deneuve','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111104-S','Zach Galligan','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111105-S','Charlize Theron','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111105-S','Eddie Murphy','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111105-S','Euduardo Sanchez','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111105-S','Gilian Anderson','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111105-S','Heather Donahue','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111105-S','Isaac Hayes','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111106-S','Gilian Anderson','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111106-S','Jay Acovone','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111106-S','Jodie Foster','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111106-S','Joely Richardson','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111107-S','Johnny Depp','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111107-S','Jonh Cusack','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111107-S','Julianne Moore','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111107-S','Jay Acovone','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111107-S','Isaac Hayes','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111108-S','Norman Kaye','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111108-S','Peter Hyams','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111108-S','Pierce Brosnan','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111108-S','Richard Lynch','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111108-S','S. Bonnaire','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111109-S','Sandy Core','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111109-S','Sean Connery','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111109-S','Gary Oldman','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111109-S','Zach Galligan','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111110-S','Sally Kellerman','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111110-S','Sophie Marceau','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111110-S','Matt Leblanc','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111110-S','Joely Richardson','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111111-S','Steve Martin','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111111-S','Tommy Davidson','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111111-S','Heather Donahue','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111111-S','Jay Acovone','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111111-S','Richard Lynch','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111111-S','Isaac Hayes','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111111-S','S. Bonnaire','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Arnold Schwarzenegger','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Kevin Kline','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Barbara Klopple','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Michael Pheipher','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Gary Oldman','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Jay Acovone','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Buba Bayouri','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Norman Kaye','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Cate Blanchet','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Julianne Moore','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Zach Galligan','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Isaac Hayes','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111112-S','Daniel Myrick','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111113-S','Myra, S. Pierce','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111113-S','Bernie Pock','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111113-S','Charlie Sheen','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111113-S','Gary Oldman','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111113-S','Zach Galligan','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111113-S','Isaac Hayes','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111114-S','Martxelo Rubio','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111114-S','Maribel Verdu','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111114-S','Jon Donosti','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111114-S','Montxo Armendariz','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111114-S','Zach Galligan','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111115-S','Leo T. Fong','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111115-S','Natassja Kinski','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111115-S','Luis G. Berlanga','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111115-S','S. Bonnaire','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111115-S','Zach Galligan','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111116-S','Christopher Mcdonald','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111116-S','Sam Waterston','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111116-S','Tess Harper','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111116-S','Jay Acovone','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111116-S','Joely Richardson','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111117-S','Arnold Schwarzenegger','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111117-S','Peter Hyams','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111117-S','Eddie Murphy','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111117-S','Julianne Moore','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111117-S','Jay Acovone','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111117-S','Gary Oldman','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111117-S','Richard Lynch','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111117-S','S. Bonnaire','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111117-S','Zach Galligan','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111118-S','Tess Harper','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111118-S','Sam Waterston','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111118-S','Luis G. Berlanga','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111118-S','Christopher Mcdonald',
         'Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111118-S','Natassja Kinski','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111118-S','Matt Leblanc','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111118-S','Matt Leblanc','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111118-S','Michael C. Williams','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111119-S','Maribel Verdu','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111119-S','Martxelo Rubio','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111119-S','Leo T. Fong','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111119-S','Bernie Pock','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111119-S','Myra, S. Pierce','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111119-S','Richard Lynch','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111119-S','Zach Galligan','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111120-S','Sam Waterston','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111120-S','Luis G. Berlanga','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111120-S','Christopher Mcdonald','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111120-S','Montxo Armendariz','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111120-S','Zach Galligan','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111121-S','Charlie Sheen','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111121-S','Jon Donosti','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111121-S','Maribel Verdu','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111121-S','Jay Acovone','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111121-S','Joely Richardson','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111122-S','Peter Hyams','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111122-S','Arnold Schwarzenegger','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111122-S','Johnny Depp','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111122-S','Jonh Cusack','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111122-S','Michael Pheipher','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111122-S','Isaac Hayes','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111122-S','Jay Acovone','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111123-S','Barbara Streisand','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111123-S','Barbara Klopple','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111123-S','Michele Laroque','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111123-S','Julianne Moore','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111124-S','Sean Connery','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111124-S','Tess Harper','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111124-S','Sam Waterston','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111124-S','Luis G. Berlanga','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111124-S','Christopher Mcdonald','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111125-S','Bruce Willis','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111125-S','Gilian Anderson','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111125-S','Sean Connery','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111125-S','Buba Bayouri','Actor Secundario');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111125-S','Jodie Foster','Actriz Secundaria');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111125-S','Sally Kellerman','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111125-S','Heather Donahue','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111125-S','Isaac Hayes','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111126-S','Pierce Brosnan','Actor Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111126-S','Catherine Deneuve','Actriz Principal');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111126-S','Luis G. Berlanga','Director');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111126-S','Isaac Hayes','Productor');
INSERT
  INTO Trabajo (cip,nombre_persona,tarea)
  VALUES ('11111126-S','Zach Galligan','Productor');

-- Se inserta en la tabla Cine
INSERT
  INTO Cine (cine,ciudad_cine,direccion_cine)
  VALUES('El Arcangel','Cordoba','Centro Comercial El Arcangel');
INSERT
  INTO Cine (cine,ciudad_cine,direccion_cine)
  VALUES('La Catolica','Cordoba','La paz,25');
INSERT
  INTO Cine (cine,ciudad_cine,direccion_cine)
  VALUES('Zayra','Cordoba','Centro Comercial La Sierra');
INSERT
  INTO Cine (cine,ciudad_cine,direccion_cine)
  VALUES('Los Arcos','Madrid','Centro Comercial Los Arcos');
INSERT
  INTO Cine (cine,ciudad_cine,direccion_cine)
  VALUES('Los Arcos2','Madrid','Centro Cormercila Los Arcos 2');
INSERT
  INTO Cine (cine,ciudad_cine,direccion_cine)
  VALUES('Multicines Ciudad Jardin','Malaga','Ciudad Jardin s/n');

-- Se inserta en la tabla Sala
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('El Arcangel',1,50);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('El Arcangel',2,60);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('El Arcangel',3,70);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('El Arcangel',4,250);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('El Arcangel',5,250);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('La Catolica',1,120);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('La Catolica',2,120);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('La Catolica',3,120);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('La Catolica',4,120);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('La Catolica',5,120);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Zayra',1,90);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Zayra',2,80);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Zayra',3,120);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Zayra',4,130);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Zayra',5,140);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Los Arcos',1,100);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Los Arcos',2,100);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Los Arcos',3,120);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Los Arcos',4,120);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Los Arcos',5,300);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Los Arcos2',1,100);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Los Arcos2',2,120);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Los Arcos2',3,120);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Los Arcos2',4,125);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Los Arcos2',5,125);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Multicines Ciudad Jardin',1,150);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Multicines Ciudad Jardin',2,150);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Multicines Ciudad Jardin',3,150);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Multicines Ciudad Jardin',4,150);
INSERT
  INTO Sala (cine,sala,aforo)
  VALUES ('Multicines Ciudad Jardin',5,150);

-- Se inserta en la tabla Proyeccion
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',1,'11111102-S',
         TO_DATE('21/09/1995','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',2,'11111102-S',
         TO_DATE('01/10/1995','DD/MM/YYYY'),10,9000,4500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',1,'11111102-S',
         TO_DATE('21/09/1995','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',1,'11111102-S',
         TO_DATE('21/09/1995','DD/MM/YYYY'),5,2000,1000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',2,'11111102-S',
         TO_DATE('26/09/1995','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',1,'11111102-S',
         TO_DATE('21/09/1995','DD/MM/YYYY'),8,2000,1000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',2,'11111102-S',
         TO_DATE('29/09/1995','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',1,'11111102-S',
         TO_DATE('21/09/1995','DD/MM/YYYY'),6,3000,2000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',2,'11111102-S',
         TO_DATE('27/09/1995','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',1,'11111102-S',
         TO_DATE('21/09/1995','DD/MM/YYYY'),8,2000,1000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',2,'11111102-S',
         TO_DATE('29/09/1995','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',1,'11111113-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),4,1000,500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',2,'11111113-S',
         TO_DATE('26/09/1996','DD/MM/YYYY'),15,2000,1000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',2,'11111114-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),7,4000,2000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',3,'11111114-S',
         TO_DATE('29/09/1996','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',4,'11111115-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),8,2000,1000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',5,'11111116-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),9,6000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',5,'11111123-S',
         TO_DATE('01/10/1996','DD/MM/YYYY'),15,9000,6000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',1,'11111113-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',2,'11111114-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',3,'11111115-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',4,'11111116-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',5,'11111123-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',1,'11111113-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),23,4400,7000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',2,'11111114-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',3,'11111115-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',4,'11111116-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',5,'11111123-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),30,5000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',1,'11111113-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',1,'11111114-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',2,'11111114-S',
         TO_DATE('04/10/1996','DD/MM/YYYY'),16,3000,2000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',2,'11111115-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),15,2000,1000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',3,'11111115-S',
         TO_DATE('08/10/1996','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',3,'11111116-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),14,1000,500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',4,'11111116-S',
         TO_DATE('10/10/1996','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',4,'11111123-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',5,'11111123-S',
         TO_DATE('12/10/1996','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',1,'11111114-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',2,'11111113-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',3,'11111115-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',4,'11111116-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',5,'11111123-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',1,'11111113-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',2,'11111115-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',3,'11111114-S',
         TO_DATE('21/09/1996','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',4,'11111116-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',5,'11111123-S',
         TO_DATE('22/09/1996','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',1,'11111106-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',2,'11111117-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',3,'11111118-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',4,'11111119-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),14,1000,500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',5,'11111120-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',1,'11111117-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',2,'11111106-S',
         TO_DATE('21/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',3,'11111118-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),
         19,6000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',4,'11111119-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),10,9000,4500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',5,'11111120-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),21,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',1,'11111118-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),10,9000,4500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',2,'11111106-S',
         TO_DATE('21/09/1997','DD/MM/YYYY'),21,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',3,'11111117-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',4,'11111119-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',5,'11111120-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',1,'11111106-S',
         TO_DATE('21/09/1997','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',2,'11111117-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',4,'11111119-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),14,1000,500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',5,'11111120-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',1,'11111120-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',2,'11111119-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',3,'11111118-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),21,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',4,'11111117-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',5,'11111106-S',
         TO_DATE('21/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',1,'11111106-S',
         TO_DATE('21/09/1997','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',2,'11111117-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',3,'11111118-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',4,'11111119-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',5,'11111120-S',
         TO_DATE('22/09/1997','DD/MM/YYYY'),14,1000,500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',1,'11111110-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',2,'11111121-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',3,'11111122-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',4,'11111124-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',5,'11111125-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',5,'11111126-S',
         TO_DATE('07/10/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',1,'11111121-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',2,'11111110-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',2,'11111126-S',
         TO_DATE('05/10/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',3,'11111122-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',4,'11111125-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',5,'11111126-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',1,'11111110-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',2,'11111121-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',4,'11111122-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),22,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',5,'11111125-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',5,'11111126-S',
         TO_DATE('05/10/1998','DD/MM/YYYY'),13,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',1,'11111125-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',1,'11111126-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',2,'11111124-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',3,'11111122-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),14,1000,500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',4,'11111121-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',5,'11111110-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',1,'11111110-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',2,'11111121-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',3,'11111122-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',4,'11111124-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',5,'11111125-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',5,'11111126-S',
         TO_DATE('02/10/1998','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',1,'11111110-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',2,'11111121-S',
         TO_DATE('21/09/1998','DD/MM/YYYY'),22,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',3,'11111122-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),21,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',4,'11111124-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),22,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',5,'11111125-S',
         TO_DATE('22/09/1998','DD/MM/YYYY'),23,4400,7000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',5,'11111126-S',
         TO_DATE('20/10/1998','DD/MM/YYYY'),12,3500,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',1,'11111101-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',2,'11111103-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',3,'11111104-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',4,'11111105-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('El Arcangel',5,'11111111-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',1,'11111101-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',2,'11111103-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',3,'11111104-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),13,6000,4000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',4,'11111105-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('La Catolica',5,'11111111-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',1,'11111103-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',2,'11111101-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',3,'11111104-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',4,'11111105-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos',5,'11111111-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),10,5000,2500000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',1,'11111101-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',2,'11111103-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',3,'11111104-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',4,'11111105-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Los Arcos2',5,'11111111-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',1,'11111111-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',2,'11111105-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',3,'11111101-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',4,'11111103-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Multicines Ciudad Jardin',5,'11111104-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',1,'11111101-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',2,'11111103-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',3,'11111104-S',
         TO_DATE('21/09/1999','DD/MM/YYYY'),12,7000,5000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',4,'11111105-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),11,4000,3000000);
INSERT
  INTO Proyeccion (cine,sala,cip,fecha_estreno,
       dias_estreno,espectadores,recaudacion)
  VALUES ('Zayra',5,'11111111-S',
         TO_DATE('22/09/1999','DD/MM/YYYY'),12,7000,5000000);