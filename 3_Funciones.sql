-- -----------------------------------------------------------------------------
use proyecto;
-- -----------------------------------------------------------------------------
-- FUNCIONES 
-- -----------------------------------------------------------------------------

/*Contar num de modelos por marca*/

DELIMITER //
CREATE FUNCTION contar_modelos_por_marca(marca_param VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE cantidad_modelos INT;
    SELECT COUNT(*) INTO cantidad_modelos
    FROM auto
    WHERE marca = marca_param;
    RETURN cantidad_modelos;
END //
DELIMITER ;

select contar_modelos_por_marca ("honda") from auto;

-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

/*Obtener el Modelo Más Caro*/

DELIMITER //
CREATE FUNCTION obtener_modelo_mas_caro()
RETURNS VARCHAR(255)
BEGIN
    DECLARE modelo_mas_caro VARCHAR(255);
    SELECT modelo INTO modelo_mas_caro
    FROM auto
    ORDER BY precio DESC
    LIMIT 1;
    RETURN modelo_mas_caro;
END //
DELIMITER ;

SELECT *, obtener_modelo_mas_caro() AS modelo_mas_caro FROM auto;
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

