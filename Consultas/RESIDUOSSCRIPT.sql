--ALTER session set "_oracle_script"=true;
--CREATE USER RESIDUOS IDENTIFIED BY RESIDUOS;
--GRANT CONNECT, RESOURCE, DBA TO RESIDUOS;

CREATE TABLE EmpresaProductora (
  nif_empresa varchar2(12) NOT NuLL,
  nombre_empresa varchar2(40) NOT NuLL,  
  ciudad_empresa varchar2(20),  
  actividad varchar2(80), 
  od_empresa varchar2(200),
    CONSTRAINT  pk_emp  
      PRIMARY KEY (nif_empresa) ); 


INSERT INTO EmpresaProductora (nif_empresa,nombre_empresa,ciudad_empresa,actividad,od_empresa)  VALuES ('A-11111111-R','Pintatum','Madrid','Pinturas,barnices y lacas','Mediana empresa situada en Madrid');
INSERT INTO EmpresaProductora (nif_empresa,nombre_empresa,ciudad_empresa,actividad,od_empresa) VALuES ('A-17655551-Q','Fermezquita','Cordoba','Fertilizantes y plaguicidas','Empresa ubicada en Cordoba para la fabricacion de Fertilizantes y Plaguicidas');
INSERT INTO EmpresaProductora (nif_empresa,nombre_empresa,ciudad_empresa,actividad,od_empresa) VALuES ('R-12356711-Q','Mueblesur','Lucena','Muebles y accesorios','Empresa ubicada en Lucena y especializada en la construccion de muebles');
INSERT INTO EmpresaProductora (nif_empresa,nombre_empresa,ciudad_empresa,actividad,od_empresa) VALuES ('C-34534522-R','Aceioro','Montoro','Aceites y grasas','Empresa de aceites ubicada en Montoro');
INSERT INTO EmpresaProductora (nif_empresa,nombre_empresa,ciudad_empresa,actividad,od_empresa) VALuES ('A-98988898-Q','Vidriosmer','Malaga','Vidrio y productos de vidrio','Empresa ubicada en Sevilla dedicada a la fabricacion de productos relacionados con el vidrio');
INSERT INTO EmpresaProductora (nif_empresa,nombre_empresa,ciudad_empresa,actividad,od_empresa) VALuES ('A-98989998-Q','Carbonsur','Huelva','Metales no ferrosos','Empresa ubicada en sevilla dedicada a la fabricacion de productos relacionados con  el vidrio');







CREATE TABLE Residuo (
  cod_residuo number NOT NuLL,
  toxicidad number,
  od_residuo varchar2(100),
    CONSTRAINT  pk_res
      PRIMARY KEY (cod_residuo));

INSERT INTO Residuo VALuES (101,10, 'Residuos de la produccion de aceites vegetales');
INSERT INTO Residuo  VALuES (102,10,'Residuos acidos grasos');
INSERT INTO Residuo  VALuES (103,10,'Emulusiones de aceites y grasa');
INSERT INTO Residuo  VALuES (306,12,'Sales de impregnado de la madera');
INSERT INTO Residuo VALuES (501,20,'Residuos de plaguicidas');
INSERT INTO Residuo  VALuES (507,25,'Residuos quimicos de laboratorios');
INSERT INTO Residuo  VALuES (612,15,'Lodos con combustible');
INSERT INTO Residuo  VALuES (708,10,'Pinturas y barnices residuales');
INSERT INTO Residuo  VALuES (709,289,'Lodos de pinturas y barnices');
INSERT INTO Residuo  VALuES (806,30,'Lodos y emulsiones de latex');
INSERT INTO Residuo  VALuES (201,70,'Residuos con sustancias peligrosas provinientes de hornos');
INSERT INTO Residuo  VALuES (202,50,'Escoria de fundicion de metales no ferrosos');
INSERT INTO Residuo  VALuES (203,29,'Escoria de salinas de la produccion de metales no ferrosos');
INSERT INTO Residuo  VALuES (204,10,'Cenizas de metales no ferrosos');




CREATE TABLE Constituyente ( 
  cod_constituyente number(3) NOT NuLL,
  nombre_constituyente varchar2(20) NOT NuLL,  
  od_constituyente varchar2(100),
    CONSTRAINT  pk_con
      PRIMARY KEY (cod_constituyente) );


INSERT INTO Constituyente (cod_constituyente,nombre_constituyente, od_constituyente) VALuES (111,'Bario','');
INSERT INTO Constituyente (cod_constituyente,nombre_constituyente, od_constituyente) VALuES (112,'Lantano','');
INSERT  INTO Constituyente (cod_constituyente,nombre_constituyente, od_constituyente) VALuES (113,'Actinio','');
INSERT INTO Constituyente (cod_constituyente,nombre_constituyente, od_constituyente) VALuES (114,'Beridio','');
INSERT INTO Constituyente (cod_constituyente,nombre_constituyente, od_constituyente) VALuES (115,'Magnesio','');
INSERT INTO Constituyente (cod_constituyente,nombre_constituyente, od_constituyente) VALuES (116,'Polonio','');
INSERT INTO Constituyente (cod_constituyente,nombre_constituyente, od_constituyente) VALuES (117,'Renio','');
INSERT INTO Constituyente (cod_constituyente,nombre_constituyente, od_constituyente) VALuES (118,'Tantalo','');
INSERT INTO Constituyente (cod_constituyente,nombre_constituyente, od_constituyente) VALuES (119,'Wolframio','');



CREATE TABLE Residuo_Constituyente (
  cod_residuo number(3) NOT NuLL,
  cod_constituyente number(3) NOT NuLL,
  cantidad number(3),
    CONSTRAINT  pk_rec
      PRIMARY KEY (cod_residuo, cod_constituyente),
     CONSTRAINT  fk_rec_res
      FOREIGN KEY (cod_residuo)
      REFERENCES Residuo(cod_residuo)
      ON DELETE CASCADE,
    CONSTRAINT  fk_rec_con  
      FOREIGN KEY (cod_constituyente)
      REFERENCES Constituyente(cod_constituyente)
      ON DELETE CASCADE); 


INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (204,111,2);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (101,111,2);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (101,112,3);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (101,113,5);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (102,116,4);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (102,117,6);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (103,118,10);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (103,119,11);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (103,116,4);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (306,112,4);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (306,116,7);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (501,119,2);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (501,111,5);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (501,114,6);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (507,118,8);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (507,119,8);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (507,114,8);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (612,115,4);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (612,116,5);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (708,111,6);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (708,112,7);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (709,113,1);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (709,114,8);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (806,113,5);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (806,114,6);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (201,111,5);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (201,112,5);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (202,113,5);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (202,114,5);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (203,114,5);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (203,116,7);
INSERT  INTO Residuo_Constituyente (cod_residuo, cod_constituyente,cantidad) VALuES (204,113,3);


CREATE TABLE Residuo_Empresa (
  nif_empresa varchar2(12) NOT NuLL,
  cod_residuo number(3) NOT NuLL,
    cantidad number(3),
    fecha date,
    CONSTRAINT  pk_reemp
      PRIMARY KEY (nif_empresa, cod_residuo, fecha),
     CONSTRAINT  fk_ree_emp
      FOREIGN KEY (nif_empresa)
      REFERENCES EmpresaProductora(nif_empresa)
      ON DELETE CASCADE,
     CONSTRAINT  fk_emp_res
      FOREIGN KEY (cod_residuo)
      REFERENCES Residuo(cod_residuo)
      ON DELETE CASCADE); 


INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-98988898-Q',204,2,sysdate-30);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-11111111-R',306,3,sysdate-54);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('C-34534522-R',101,2,sysdate-54);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('C-34534522-R',101,3,sysdate-23);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('C-34534522-R',101,5,sysdate-1);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('C-34534522-R',102,4,sysdate-23);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('C-34534522-R',102,6,sysdate-2);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('C-34534522-R',103,10,sysdate-54);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('C-34534522-R',103,11,sysdate-30);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('C-34534522-R',103,4,sysdate-23);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('R-12356711-Q',306,4,sysdate-23);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('R-12356711-Q',306,7,sysdate-54);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-17655551-Q',501,2,sysdate-23);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-17655551-Q',501,5,sysdate-54);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-17655551-Q',501,6,sysdate-30);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-17655551-Q',507,8,sysdate-23);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-17655551-Q',612,4,sysdate-23);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-17655551-Q',612,5,sysdate-22);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-11111111-R',708,6,sysdate-54);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-11111111-R',708,7,sysdate-52);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-11111111-R',709,1,sysdate-23);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-11111111-R',709,8,sysdate-2);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-11111111-R',806,5,sysdate-23);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-11111111-R',806,6,sysdate-30);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-98989998-Q',201,5,sysdate-23);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-98989998-Q',201,5,sysdate-30);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-98989998-Q',202,5,sysdate-54);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-98989998-Q',202,5,sysdate-4);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-98989998-Q',203,5,sysdate-3);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-98989998-Q',203,7,sysdate-60);
INSERT INTO Residuo_Empresa (nif_empresa,cod_residuo, cantidad,fecha) VALuES ('A-98989998-Q',204,3,sysdate-30);


CREATE TABLE EmpresaTransportista ( 
  nif_emptransporte varchar2(12) NOT NuLL, 
  nombre_emptransporte varchar2(40) NOT NuLL,  
  ciudad_emptransporte varchar2(30),  
  od_emptransporte varchar2(100),
    CONSTRAINT  pk_tra  
      PRIMARY KEY (nif_emptransporte) ); 



INSERT INTO EmpresaTransportista (nif_emptransporte,  nombre_emptransporte,ciudad_emptransporte,od_emptransporte) VALuES ('A-87684567-B','Resur','En andalucia', 'Empresa de transporte de residuos que actua en toda  andalucia');
INSERT  INTO EmpresaTransportista (nif_emptransporte, nombre_emptransporte,ciudad_emptransporte,od_emptransporte) VALuES ('F-98987667-R','AceSur','Cordoba', 'Empresa de transportes de residuos procedentes de  empresas de aceite');
INSERT  INTO EmpresaTransportista (nif_emptransporte, nombre_emptransporte,ciudad_emptransporte,od_emptransporte) VALuES ('A-97654567-S','Perez e Hijos','Madrid', 'Empresa encargada del transporte de todo tipo de  residuos');
INSERT  INTO EmpresaTransportista (nif_emptransporte, nombre_emptransporte,ciudad_emptransporte,od_emptransporte) VALuES ('A-98987067-V','HuelResi','Huelva', 'Empresa encargada del transporte de todo tipo de  residuos en la provincia de Huelva');
INSERT  INTO EmpresaTransportista (nif_emptransporte, nombre_emptransporte,ciudad_emptransporte,od_emptransporte) VALuES ('A-98985367-V','TransMadrid','Madrid', 'Empresa encargada de los transportes en Madrid');



CREATE TABLE Destino ( 
  cod_destino varchar2(12) NOT NuLL,
  nombre_destino varchar2(20) NOT NuLL,  
  ciudad_destino varchar2(15),  
  od_destino varchar2(100),
    CONSTRAINT  pk_des
      PRIMARY KEY (cod_destino) ); 


INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N01','VALSuR','Valencia','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N02','MASuR','Madrid','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N03','BASuR','Barcelona','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N04','SESuR','Malaga','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N05','BILSuR','Bilbao','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N06','VALNOR','Valencia','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N07','MANOR','Madrid','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N08','MADES','Madrid','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N09','BARNOR','Barcelona','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N10','BAREST','Barcelona','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N11','TASuR','Tarragona','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N12','TAES','Tarragona','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N13','COSuR','Cordoba','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N14','CONOR','Cordoba','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N15','COES','Cordoba','');
INSERT INTO Destino (cod_destino,nombre_destino,ciudad_destino, od_destino) VALuES ('DESTIO-N16','BINO','Bilbao','');





CREATE TABLE Traslado (
  nif_empresa varchar2(12) NOT NuLL,
  cod_residuo number(3) NOT NuLL,
  fecha_envio DATE NOT NuLL, 
  cod_destino varchar2(12) NOT NuLL,  
  nif_emptransporte varchar2(12) NOT NuLL,  
  tipo_transporte varchar2(15),  
  kms number(3),  
  coste number(6),  
  cantidad number(6),
    CONSTRAINT  pk_tet  
      PRIMARY KEY (nif_empresa, cod_residuo, fecha_envio, 
                  cod_destino, nif_emptransporte),  
    CONSTRAINT  fk_tet_trl1 FOREIGN KEY (nif_empresa) REFERENCES EmpresaProductora(nif_empresa)  ON DELETE CASCADE ,
    CONSTRAINT  fk_tet_trl2 FOREIGN KEY (cod_residuo) REFERENCES Residuo(cod_residuo)  ON DELETE CASCADE ,
    CONSTRAINT  fk_tet_trl4 FOREIGN KEY (cod_destino) REFERENCES Destino(cod_destino)  ON DELETE CASCADE,
     CONSTRAINT  fk_tet_tr5 FOREIGN KEY (nif_emptransporte) REFERENCES EmpresaTransportista(nif_emptransporte)  ON DELETE CASCADE  );




INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('C-34534522-R',102,to_date('16/09/1990','dd/mm/YY'), 'DESTIO-N13','A-87684567-B','Carretera',5,10000,300);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('C-34534522-R',102,to_date('15/10/1991','dd/mm/YY'), 'DESTIO-N02','A-87684567-B','Aereo',45,99000,340);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('C-34534522-R',102,to_date('16/08/1992','dd/mm/YY'), 'DESTIO-N03','A-87684567-B','Carretera',90,40000,200);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('C-34534522-R',102,to_date('23/03/1993','dd/mm/YY'), 'DESTIO-N01','A-87684567-B','Carretera',40,50000,3010);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('C-34534522-R',103,to_date('11/05/1994','dd/mm/YY'), 'DESTIO-N02','A-87684567-B','Carretera',30,30000,3000);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('C-34534522-R',103,to_date('16/04/1995','dd/mm/YY'), 'DESTIO-N01','A-87684567-B','Aereo',30,90000,3022);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('C-34534522-R',103,to_date('17/06/1996','dd/mm/YY'), 'DESTIO-N03','A-87684567-B','Ferrocarril',30,50000,250);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('C-34534522-R',103,to_date('25/07/1997','dd/mm/YY'), 'DESTIO-N04','A-87684567-B','Carretera',30,35000,1114);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('R-12356711-Q',306,to_date('23/08/1998','dd/mm/YY'), 'DESTIO-N01','A-97654567-S','Aereo',30,85000,1400);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('R-12356711-Q',306,to_date('24/02/1994','dd/mm/YY'), 'DESTIO-N04','A-97654567-S','Carretera',30,25000,309);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('R-12356711-Q',306,to_date('21/01/1995','dd/mm/YY'), 'DESTIO-N12','A-97654567-S','Carretera',30,35000,3300);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('R-12356711-Q',306,to_date('14/03/1996','dd/mm/YY'), 'DESTIO-N02','A-97654567-S','Carretera',50,40000,3500);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',501,to_date('17/04/1997','dd/mm/YY'), 'DESTIO-N04','A-87684567-B','Carretera',50,50000,7300);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',501,to_date('19/02/1998','dd/mm/YY'), 'DESTIO-N03','A-87684567-B','Carretera',50,35000,3009);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',501,to_date('18/04/1999','dd/mm/YY'), 'DESTIO-N09','A-87684567-B','Carretera',50,60000,30078);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',501,to_date('16/06/1995','dd/mm/YY'), 'DESTIO-N12','A-87684567-B','Carretera',50,35000,8300);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',507,to_date('10/07/1996','dd/mm/YY'), 'DESTIO-N10','A-87684567-B','Carretera',50,50000,3900);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',507,to_date('11/08/1992','dd/mm/YY'), 'DESTIO-N02','A-87684567-B','Aereo',50,90000,3005);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',507,to_date('12/02/1990','dd/mm/YY'), 'DESTIO-N12','A-87684567-B','Carretera',50,35000,99);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',507,to_date('13/01/1993','dd/mm/YY'), 'DESTIO-N10','A-87684567-B','Carretera',50,35000,356);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',612,to_date('18/12/1994','dd/mm/YY'), 'DESTIO-N02','A-98987067-V','Ferrocarril',50,50000,854);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',612,to_date('19/12/1996','dd/mm/YY'), 'DESTIO-N10','A-98987067-V','Carretera',50,30000,654);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-17655551-Q',612,to_date('21/10/1996','dd/mm/YY'), 'DESTIO-N07','A-98987067-V','Carretera',50,35000,875);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-11111111-R',708,to_date('30/07/1994','dd/mm/YY'), 'DESTIO-N11','A-98987067-V','Carretera',50,20000,695);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-11111111-R',708,to_date('27/02/1997','dd/mm/YY'), 'DESTIO-N10','A-98987067-V','Carretera',50,35000,789);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-11111111-R',709,to_date('25/03/1995','dd/mm/YY'), 'DESTIO-N08','A-98987067-V','Carretera',60,40000,456);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-11111111-R',709,to_date('26/04/1996','dd/mm/YY'), 'DESTIO-N07','A-98987067-V','Aereo',60,11000,122);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-11111111-R',709,to_date('28/05/1998','dd/mm/YY'), 'DESTIO-N11','A-98987067-V','Carretera',60,50000,3008);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-11111111-R',709,to_date('10/08/1999','dd/mm/YY'), 'DESTIO-N08','A-98987067-V','Aereo',5,40000,8300);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-11111111-R',806,to_date('22/06/2000','dd/mm/YY'), 'DESTIO-N07','A-98987067-V','Carretera',5,10000,1300);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-11111111-R',806,to_date('11/01/2000','dd/mm/YY'), 'DESTIO-N11','F-98987667-R','Carretera',60,35000,8300);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-11111111-R',806,to_date('14/08/1997','dd/mm/YY'), 'DESTIO-N08','F-98987667-R','Aereo',5,60000,7300);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-11111111-R',806,to_date('16/09/1998','dd/mm/YY'), 'DESTIO-N15','F-98987667-R','Carretera',45,35000,900);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-98989998-Q',202,to_date('13/11/1993','dd/mm/YY'), 'DESTIO-N15','F-98987667-R','Ferrocarril',35,50000,700);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-98989998-Q',202,to_date('17/12/1994','dd/mm/YY'), 'DESTIO-N08','F-98987667-R','Carretera',50,35000,6500);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-98989998-Q',202,to_date('18/10/1996','dd/mm/YY'), 'DESTIO-N06','F-98987667-R','Carretera',60,50000,7800);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-98989998-Q',203,to_date('19/11/1997','dd/mm/YY'), 'DESTIO-N14','F-98987667-R','Carretera',35,35000,5600);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-98989998-Q',203,to_date('21/12/1998','dd/mm/YY'), 'DESTIO-N15','F-98987667-R','Aereo',35,80000,69800);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-98989998-Q',203,to_date('23/12/1992','dd/mm/YY'), 'DESTIO-N06','F-98987667-R','Carretera',60,30000,7800);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-98989998-Q',204,to_date('28/10/1993','dd/mm/YY'), 'DESTIO-N15','F-98987667-R','Carretera',35,35000,96500);
INSERT INTO Traslado (nif_empresa,cod_residuo, fecha_envio,cod_destino,nif_emptransporte, tipo_transporte,kms,coste,cantidad) VALuES ('A-98989998-Q',204,to_date('29/11/1995','dd/mm/YY'), 'DESTIO-N14','F-98987667-R','Carretera',35,50000,56800);

commit;