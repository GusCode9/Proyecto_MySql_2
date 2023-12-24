-- *** TABLA AUTO TABLA MADRE, a partir de la tabla de echo coches ***
use proyecto;

CREATE TABLE IF NOT EXISTS AUTO
SELECT id_coche, kilometraje, anio, modelo,
cilindros, precio, vin, descripcion, fecha_publicacion,
id_tipo, transmision,TIPO, TRACCION, COLOR_PINTURA,
marca, combustible, estado, region
FROM COCHES;

ALTER TABLE AUTO
MODIFY ID_COCHE bigint (20),
MODIFY KILOMETRAJE INT (100),
MODIFY ANIO INT,
MODIFY MODELO VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci,
MODIFY CILINDROS VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci,
MODIFY PRECIO INT,
MODIFY VIN VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci,
MODIFY DESCRIPCION TEXT,
MODIFY FECHA_PUBLICACION date ,
MODIFY ID_tipo BIGINT(50) not null;


UPDATE AUTO
SET ID_COCHE = TRIM(ID_COCHE);

ALTER TABLE AUTO
MODIFY ID_COCHE BIGINT(20) PRIMARY KEY auto_increment ;

/*
UPDATE AUTO
SET FECHA_PUBLICACION = (
    SELECT COCHES.FECHA_PUBLICACION
    FROM COCHES
    WHERE AUTO.ID_COCHE = COCHES.ID_COCHE
);
*/

-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
-- TABLA COCHE_TIPO 

CREATE TABLE COCHE_TIPO
SELECT ID_coche, TIPO, TRACCION FROM auto;

alter TABLE coche_tipo
ADD CONSTRAINT fk_coche_tipo_id FOREIGN KEY (ID_COCHE) REFERENCES AUTO(ID_COCHE) on update cascade;

-- --------------------------------------------------------------------------------------
-- TABLA TIPO_TRANSMISION
CREATE TABLE TIPO_TRANSMISION
SELECT TRANSMISION, ID_coche
FROM auto;

alter TABLE tipo_transmision
ADD CONSTRAINT fk_tipo_transmision_auto FOREIGN KEY (ID_COCHE) REFERENCES AUTO(ID_COCHE) on update cascade;
-- SET @@foreign_key_checks = 0;
-- SET @@foreign_key_checks = 1;
-- --------------------------------------------------------------------------------------
-- TABLA COLOR
CREATE TABLE IF NOT EXISTS COLOR
SELECT COLOR_PINTURA, ID_COCHE
FROM auto;

ALTER TABLE COLOR 
ADD CONSTRAINT fk_COLOR_AUTO FOREIGN KEY (ID_COCHE)
REFERENCES AUTO(ID_COCHE); 
-- --------------------------------------------------------------------------------------

-- TABLA FECHA_PUBLICACION
CREATE table FECHA_PUBLICACION
SELECT FECHA_PUBLICACION , ID_COCHE 
FROM AUTO;

ALTER TABLE FECHA_PUBLICACION
ADD CONSTRAINT FECHA_AUTO foreign key (ID_COCHE)
REFERENCES AUTO(ID_COCHE) on update cascade;
-- --------------------------------------------------------------------------------------

-- TABLA MARCA
CREATE TABLE if not exists MARCA 
SELECT MARCA, ID_COCHE FROM auto;

ALTER TABLE MARCA
ADD CONSTRAINT FK_MARCA_AUTO FOREIGN KEY 
(ID_COCHE) REFERENCES AUTO(ID_COCHE) on update cascade;
-- --------------------------------------------------------------------------------------

-- TABLA TIPO_COMBUSTIBLE
CREATE TABLE TIPO_COMBUSTIBLE
SELECT COMBUSTIBLE, ID_COCHE FROM auto;

ALTER TABLE TIPO_COMBUSTIBLE
ADD CONSTRAINT FK_COMBUSTIBLE_AUTO FOREIGN KEY
(ID_COCHE) REFERENCES AUTO(ID_COCHE);
-- --------------------------------------------------------------------------------------
-- TABLA UBICACION
CREATE TABLE UBICACION
SELECT ESTADO, REGION, ID_COCHE FROM auto;

ALTER TABLE UBICACION
ADD CONSTRAINT FK_UBICACION_AUTO FOREIGN KEY (ID_COCHE)
REFERENCES AUTO(ID_COCHE) ON update cascade;
-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
-- Dropeo las columnas de la tabla madre que ya normalice y tengo repetidas

alter table auto
drop column estado;

alter table auto
drop column region;

alter table auto
drop column combustible;

alter table auto
drop column marca;

alter table auto
drop column fecha_publicacion;

alter table auto
drop column color_pintura;

alter table auto 
drop column transmision;

alter table auto
drop column tipo;

alter table auto
drop column traccion;
-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
