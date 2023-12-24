
-- ******************************************************************************
-- TRIGERS ( DISPARADORES )
-- ******************************************************************************
use proyecto;
-- -------------------------------------------------------------------------------
-- TABLAS DE AUDITORIA  log_auditoria_1 **
drop table if  exists log_auditoria_1;
CREATE TABLE IF NOT EXISTS log_auditoria_1
(
	id_log INT AUTO_INCREMENT ,
	nombre_accion VARCHAR(10),
	nombre_tabla VARCHAR(30),
	user_ VARCHAR(100), 
	fecha_accion DATE,
	PRIMARY KEY (id_log)
);
-- --------------------------------------------------------------------------------
-- TRIGGER 1 AFTER
DELIMITER //
CREATE TRIGGER trg_insert_new 
AFTER INSERT ON proyecto.auto
FOR EACH ROW 
BEGIN
	INSERT INTO log_auditoria_1 (nombre_accion , nombre_tabla , user_ ,fecha_accion) 
    VALUES ( 'INSERT' , 'auto' ,CURRENT_USER() , NOW());
END//
DELIMITER ;
-- --------------------------------------------------------------------------------
-- PRUEBA --
-- ---------
insert into proyecto.auto ( kilometraje, anio, modelo, cilindros, precio, descripcion)
values ( 40000, 2020, "Prius", 4, 4500, "Toyota hibrido 5 puertas");

select * from log_auditoria_1; -- ok

select * from auto where descripcion = "Toyota hibrido 5 puertas"; -- ok
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- TABLAS DE AUDITORIA   **

DROP TABLE IF EXISTS log_reg_eliminados;

CREATE TABLE IF NOT EXISTS log_reg_eliminados (
    id_reg_elim INT AUTO_INCREMENT,
    marca VARCHAR(50),
    modelo VARCHAR(100),
    precio INT(11),
    descripcion TEXT,
    fecha_aliminacion DATETIME, -- Corregido el tipo de dato a DATETIME
    PRIMARY KEY (id_reg_elim)
);

-- Trigger BEFORE DELETE
DROP TRIGGER IF EXISTS log_reg_eliminados;

DELIMITER //
CREATE TRIGGER log_reg_eliminados
BEFORE DELETE ON proyecto.coches
FOR EACH ROW
BEGIN
    INSERT INTO log_reg_eliminados (marca, modelo, precio, descripcion, fecha_aliminacion)
    VALUES (OLD.marca, OLD.modelo, OLD.precio, OLD.descripcion, NOW());
END;
//
DELIMITER ;

DELETE FROM proyecto.coches
WHERE marca = "gmc" AND color_pintura = "black" AND anio = 2012;

-- revision
select * from log_reg_eliminados; -- ok
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- TABLAS DE AUDITORIA 3 **

DROP TABLE IF EXISTS log_reg_eliminados_color;

CREATE TABLE IF NOT EXISTS log_reg_eliminados_color (
    id_color_elim INT AUTO_INCREMENT,
    color_pintura VARCHAR(50),
    fecha_aliminacion DATETIME,
    PRIMARY KEY (id_color_elim)
);

-- Trigger BEFORE DELETE
DROP TRIGGER IF EXISTS log_color_eliminado;

DELIMITER //
CREATE TRIGGER log_color_eliminado
BEFORE DELETE ON proyecto.color
FOR EACH ROW
BEGIN
    INSERT INTO log_reg_eliminados_color (color_pintura, fecha_aliminacion)
    VALUES (OLD.color_pintura, NOW());
END;
//
DELIMITER ;

DELETE FROM proyecto.color
WHERE color_pintura="red" and id_coche=7316257769;

select * from proyecto.color
limit 5;

select * from log_reg_eliminados_color;
-- --------------------------------------------------------------------------------