-- -------------------------------------------------------------------------------------- 
use proyecto;

-- 5 - STORAGE PROCEDURES -- PROCEDIMIENTOS ALMACENADOS  
-- --------------------------------------------------------------------------------------
-- 1 - QUE SE ACTUALICE UN 5% LOS PRECIOS DE LOS VEHICULOS Y LA FECHA DE ACTUALIZACION --
-- --------------------------------------------------------------------------------------

CREATE TABLE IF NOT exists  REGISTRO_PRECIOS(
ID_COCHE BIGINT(20),
FECHA_ACTUALIZACION timestamp,
PRECIO_ANTERIOR DECIMAL( 10,2),
PRECIO_NUEVO DECIMAL (10,2)
-- FOREIGN KEY (ID_COCHE) REFERENCES AUTO(ID_COCHE)
);

DELIMITER //
CREATE PROCEDURE ACTUALIZAR_PRECIO(
	IN id_coche bigint, 
	in nuevoPrecio decimal (10,2))
BEGIN
declare precioAnterior decimal(10,2);
-- ingresar el precio del coche
select auto.precio into precioAnterior  FROM auto  where id_coche = auto.id_coche;
-- actualizar precio de vehiculo
update auto set precio = nuevoprecio where  id_coche = auto.id_coche;
-- registrar precio
insert into registro_precios (id_coche , fecha_actualizacion, precio_anterior, precio_nuevo)
values (id_coche, now(), precio_anterior, nuevoprecio);
END //
DELIMITER ;

-- USO EL PROCEDURE 
CALL ACTUALIZAR_precio (7301611362, 33333.33);
-- CHECK
select id_coche, precio
from auto
where id_coche = 7301611362;

-- ------------------------------------------------------------------------------------------
-- 2 - AL INGRESAR DOS LIMITES DE VALORES , ME MUESTRE LOS MODELOS DISPONIBLES A ESE RANGO --
-- ------------------------------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE SP_MODELO_POR_RANGO(
IN PRECIO_MIN INT,
IN PRECIO_MAX INT)
BEGIN
SELECT * FROM AUTO
WHERE PRECIO between PRECIO_MIN AND PRECIO_MAX
ORDER BY modelo;
END//
DELIMITER ;

CALL SP_MODELO_POR_RANGO(2000,5000);

-- ------------------------------------------------------------------
-- 3 - QUE ASE ACTUALICE UN x % LOS PRECIOS DE TODOS LOS VEHICULOS -- 
-- ------------------------------------------------------------------

delimiter //
create procedure sp_update_precios(
	in variacion_p float (2 ,2))
begin
	update auto set precio = ((precio * variacion_p)/100) ;
end //

delimiter ;

call sp_update_precios (12,1);

-- ------------------------------------------------------------------
-- 4 - SELECCIONAR COCHE POR COLOR-- 
-- ------------------------------------------------------------------

delimiter //
create procedure sp_seleccionar_por_color(
	in p_color varchar(30))
begin
	select anio, modelo, kilometraje, precio from coches 
    where coches.color_pintura = p_color;
end //

delimiter ;

call sp_seleccionar_por_color (12,1);

-- ------------------------------------------------------------------
-- 5 - INSERTAR REGISTRO A LA TABLA AUTO                           -- 
-- ------------------------------------------------------------------
USE PROYECTO;
DELIMITER $$

CREATE PROCEDURE sp_InsertarRegistroAuto(
    IN p_id_coche bigint(20),
    IN p_modelo VARCHAR(100),
    IN p_precio INT(11),
    IN p_anio INT(11)
)
BEGIN
    INSERT INTO auto (id_coche, MODELO, PRECIO, ANIO)
    VALUES (p_id_cpche, p_modelo, p_precio,p_anio);
END$$
DELIMITER ;

call sp_InsertarRegistroAuto( 232323234,"fiesta", 50000, 2010);
-- ------------------------------------------------------------------
-- ------------------------------------------------------------------
