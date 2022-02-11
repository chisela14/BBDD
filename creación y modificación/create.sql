create database db_exampleName;
create user 'dummy'@'%' identified by 'dummy';
grant all on db_exampleName.* to 'dummy'@'%';