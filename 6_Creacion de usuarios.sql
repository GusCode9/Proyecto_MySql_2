-- ------------------------------------------------------------------
-- ------------------------------------------------------------------
use proyecto;

-- ------------------------------------------------------------------
-- CREACION DE USUARIOS

CREATE USER IF NOT EXISTS 'guest_1'@'localhost' IDENTIFIED BY '1234';
CREATE USER IF NOT EXISTS 'guest_2'@'localhost' IDENTIFIED BY '56789';


GRANT SELECT ON proyecto.auto TO 'guest_1'@'localhost';
GRANT SELECT, INSERT, UPDATE ON proyecto.auto TO 'guest_2'@'localhost';

/* 	
CREATE USER 
guest_1 → es el usuario
localhost donde se conecta
identified by →es la contraseña para conectarse
*/

/*
GRANT
select puede seleccionar 
on "nombre del schema . tabla " 
to usuario y direccion de conexion
*/

-- ------------------------------------------------------------------
-- ------------------------------------------------------------------
-- ------------------------------------------------------------------