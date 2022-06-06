--alter session set "_oracle_script"=true;   
--create user CICLISMO identified by CICLISMO;
--GRANT CONNECT, RESOURCE, DBA TO CICLISMO;


create table equipos
(
	codequipo number(4) constraint pk_equipos primary key,
	nombre 	  varchar2(30) constraint nomequipo_no_nulo not null,
	nacionalidad varchar2(20),
	nombredirector varchar2(20) constraint nomdire_valido check (nombredirector= upper (nombredirector))
);

create table ciclistas
(
	dorsal number(3) constraint pk_ciclistas primary key,
	nombre varchar2(30) constraint nom_cicl_no_nulo not null,
	nacionalidad varchar2(20),
	codequipo number(4) constraint fk_equipos references equipos,
	fechanacimiento date,
	constraint dorsalvalido check(dorsal<=99 and dorsal>=1)
);

create table etapas
(
	numetapa number(2) constraint pk_etapas primary key,
	numkms number(3),
	tipo varchar2(30),
	fecha date 
); 

create table clasificacionetapas
(
	numetapa 	   number(2) constraint fk_etapas references etapas,
	dorsal 		   number(3) constraint fk_ciclistas references ciclistas,
	posicion	   varchar2(8), 
	distanciaalganador varchar2(8),
	constraint pk_clasetapas primary key (numetapa, dorsal),
	constraint posvalida check ((posicion>='1' and posicion <='99') or posicion ='Abandono')
);



insert into equipos (codequipo, nombre, nacionalidad, nombredirector)
values(1, 'Reynolds', 'Española', 'JESUS MORENO');
insert into equipos (codequipo, nombre, nacionalidad, nombredirector)
values(2, 'KAS', 'Española', 'ALBERTO MOLINA');
insert into equipos (codequipo, nombre, nacionalidad, nombredirector)
values(3, 'Faema', 'Española', 'JUAN TAGUA');
insert into equipos (codequipo, nombre, nacionalidad, nombredirector)
values(4, 'US Postal', 'Estadounidense', 'JOSEPH SUNDAY');
insert into equipos (codequipo, nombre, nacionalidad, nombredirector)
values(5, 'FDJ', 'Francesa', 'MARIE GRAGERA');
insert into equipos (codequipo, nombre, nacionalidad, nombredirector)
values(6, 'Cafe de Colombia', 'Colombiana', 'MAURI CARDONA');



insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (1, 'Lopez', 'Española', 1, to_date('21/02/1981','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (2, 'Gomez', 'Española', 1, to_date('11/04/1985','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (3, 'Garcia', 'Española', 1, to_date('23/06/1991','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (4, 'Jankauskas', 'Lituana', 2, to_date('21/02/1985','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (5, 'Indurain', 'Española', 2, to_date('02/02/1974','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (6, 'Olano', 'Española', 2, to_date('27/04/1977','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (7, 'Laguia', 'Española', 3, to_date('26/05/1967','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (8, 'Arroyo', 'Española', 3, to_date('29/04/1966','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (9, 'Pino', 'Española', 3, to_date('11/02/1969','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (10, 'Caritoux', 'Francesa', 4, to_date('14/12/1972','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (11, 'Fignon', 'Francesa', 4, to_date('13/04/1971','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (12, 'Brochard', 'Francesa', 4, to_date('11/08/1979','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (13, 'Lemond', 'Estadounidense', 5, to_date('23/07/1980','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (14, 'Armstrong', 'Estadounidense', 5, to_date('27/05/1971','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (15, 'Landis', 'Estadounidense', 5, to_date('23/04/1987','dd/mm/yyyy'));
insert into ciclistas (dorsal, nombre, nacionalidad,codequipo,fechanacimiento)
values (16, 'Leipheimer', 'Estadounidense', 5, to_date('21/11/1981','dd/mm/yyyy'));



insert into etapas (numetapa, numkms, tipo, fecha)
values (1, 9, 'Contrarreloj',to_date('27/07/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (2, 185, 'Llana',to_date('28/07/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (3, 198, 'Llana',to_date('29/07/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (4, 139, 'Alta Montaña',to_date('30/07/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (5, 229, 'Alta Montaña',to_date('31/07/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (6, 49, 'Contrarreloj',to_date('02/08/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (7, 203, 'Media Montaña',to_date('03/08/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (8, 144, 'Llana',to_date('04/08/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (9, 175, 'Alta Montaña',to_date('05/08/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (10, 239, 'Llana',to_date('06/08/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (11, 189, 'Llana',to_date('07/08/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (12, 34, 'Contrarreloj',to_date('08/08/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (13, 174, 'Llana',to_date('09/08/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (14, 148, 'Llana',to_date('10/08/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (15, 119, 'Alta Montaña',to_date('11/08/2010','dd/mm/yyyy'));
insert into etapas (numetapa, numkms, tipo, fecha)
values (16, 200, 'Llana',to_date('12/08/2010','dd/mm/yyyy'));



insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(1, 1, '1', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion)
values(1, 2, 'Abandono');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(1, 4, '2', '00:00:04');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(1, 5, '3', '00:00:05');
insert into clasificacionetapas(numetapa, dorsal, posicion)
values(1, 7, 'Abandono');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(1, 8, '4', '00:00:10');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(1, 10, '5', '00:00:22');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(1, 11, '6', '00:00:24');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(1, 12, '7', '00:00:27');
insert into clasificacionetapas(numetapa, dorsal, posicion)
values(1, 13, 'Abandono');
insert into clasificacionetapas(numetapa, dorsal, posicion)
values(1, 14, 'Abandono');

insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(2, 1, '1', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(2, 4, '2', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(2, 5, '3', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(2, 8, '4', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion)
values(2, 10, 'Abandono');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(2, 11, '5', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(2, 12, '6', '00:00:00');

insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(3, 1, '6', '00:01:10');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(3, 4, '5', '00:00:57');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(3, 5, '4', '00:00:45');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(3, 8, '3', '00:00:23');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(3, 11, '2', '00:00:12');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(3, 12, '1', '00:00:00');

insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(4, 1, '2', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(4, 4, '1', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(4, 5, '4', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(4, 8, '3', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(4, 11, '5', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion)
values(4, 12, 'Abandono');

insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(5, 1, '4', '00:35:20');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(5, 4, '3', '00:16:30');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(5, 5, '2', '00:02:20');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(5, 8, '1', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion)
values(5, 11, 'Abandono');

insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(6, 1, '1', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(6, 4, '2', '00:12:12');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(6, 5, '3', '00:20:10');
insert into clasificacionetapas(numetapa, dorsal, posicion)
values(6, 8, 'Abandono');

insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(7, 1, '1', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(7, 4, '3', '00:14:30');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(7, 5, '2', '00:04:34');

insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(8, 1, '1', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(8, 4, '3', '01:01:20');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(8, 5, '2', '00:20:00');

insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(9, 1, '1', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(9, 4, '2', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion)
values(9, 5, 'Abandono');

insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(10, 1, '2', '00:00:00');
insert into clasificacionetapas(numetapa, dorsal, posicion, distanciaalganador)
values(10, 4, '1', '00:00:00');








