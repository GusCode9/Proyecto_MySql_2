-- ------------------------------------------------------------------
-- ------------------------------------------------------------------
-- ------------------------------------------------------------------
/* SENTENCIAS DML CONTROLADAS POR TCL*/
use proyecto;

select @@autocommit;
set @@autocommit=0;
set @@autocommit=1;

select * from auto
limit 5;

SET @@foreign_key_checks = 0;
-- SET @@foreign_key_checks = 1;

start transaction;

INSERT INTO auto (kilometraje, anio, cilindros, precio, fecha_publicacion, marca, modelo) 
VALUES (10500, 2010, 8, 30000, '2023-11-06', 'lexus','coupe rs');

INSERT INTO auto (kilometraje, anio, cilindros, precio, fecha_publicacion, marca, modelo) 
VALUES (10500, 2010, 10, 25000, '2023-11-07', 'honda','coupe rsx');

-- verifico datos ingresados
select * from auto where fecha_publicacion='2023-11-07';
select * from auto where fecha_publicacion='2023-11-06';
-- ok
savepoint sp_1;

update auto set anio=2022 where ID_COCHE=730164099;
delete from auto where ID_COCHE=7301654236;
-- verifico 
select * from auto where ID_COCHE=730164099;
select * from auto where ID_COCHE=7301654236;
rollback to sp_1;
savepoint sp_2;
-- ok

INSERT INTO auto (kilometraje, anio, cilindros, precio, fecha_publicacion, marca, modelo) 
VALUES (123456, 1999, 24, 5000000, '2023-11-00', 'cohete','rayovac');
select * from auto where modelo="rayovac";

-- verifico
select * from auto where modelo="rayovac";

rollback to sp_1;

INSERT INTO auto (kilometraje, anio, cilindros, precio, fecha_publicacion, marca, modelo) 
VALUES (200, 2008, 12, 1000000, NOW(), 'amg','clk-gtr');

savepoint sp_3;

INSERT INTO auto (kilometraje, anio, cilindros, precio, fecha_publicacion, marca, modelo) 
VALUES (200, 2008, 8, 50000, NOW(), 'ferrari','355F1');

commit;

SET @@foreign_key_checks = 1;

-- ------------------------------------------------------------------
-- ------------------------------------------------------------------
-- ------------------------------------------------------------------
