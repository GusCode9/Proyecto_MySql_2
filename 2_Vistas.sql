--  -------------------------------------------------------------
use proyecto;
--  -------------------------------------------------------------
--  -------------------------------------------------------------

--  VISTAS
--  -------------------------------------------------------------
--  -------------------------------------------------------------

-- LOS MAS BARATOS ( PRECIO INF A  5000 )
CREATE VIEW VW_VISTA_MAS_BARATOS AS
	SELECT MODELO, PRECIO, DESCRIPCION, ANIO, KILOMETRAJE 
	FROM AUTO
	WHERE PRECIO < 5000
	ORDER BY ANIO ASC;  

SELECT * FROM VW_VISTA_MAS_BARATOS;

--  -------------------------------------------------------------

-- VER COLORES DISPONIBLES
CREATE VIEW VW_VISTA_COLORES_DISPONIBLES AS
SELECT DISTINCT COLOR_PINTURA
FROM COLOR 
ORDER BY COLOR_PINTURA ASC;

SELECT * FROM VW_VISTA_COLORES_DISPONIBLES;

-- -----------------------------------------------------------------

-- CUANTOS VEHICULOS DISPONIBLES POR ANIO
CREATE VIEW VW_VEHIC_POR_ANIO AS
SELECT ANIO, COUNT(*) AS MODELO_DISPONIBLES
FROM AUTO
GROUP BY ANIO
ORDER BY ANIO ASC;

SELECT*FROM VW_VEHIC_POR_ANIO;
-- -----------------------------------------------------------------

-- AUTOS POR ANIO Y PRECIO PROMEDIO
CREATE VIEW Vista_AutoPorAnio AS
SELECT ANIO, COUNT(*) AS CantidadAutos, AVG(PRECIO) AS PrecioPromedio
FROM AUTO
GROUP BY ANIO;

select * from Vista_AutoPorAnio;

-- -----------------------------------------------------

-- AUTOS POR MODELO Y KILOMETRAJE PROMEDIO
CREATE VIEW Vista_AutoPorModelo AS
SELECT MODELO, COUNT(*) AS CantidadAutos, AVG(KILOMETRAJE) AS KilometrajePromedio
FROM AUTO
GROUP BY MODELO;

SELECT* FROM Vista_AutoPorModelo;
-- --------------------------------------------------------
 