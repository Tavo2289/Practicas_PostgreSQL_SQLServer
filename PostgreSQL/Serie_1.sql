-- =====================================================================
-- Bases de Datos I - SERIE Nº 1 - Sentencias SQL
-- SENTENCIAS BÁSICAS
-- =====================================================================

-- ---------------------------------------------------------------------
-- Ejercicio Nº 1 - Listar todo el contenido de la tabla persona (220 registros)
-- ---------------------------------------------------------------------
SELECT *
FROM persona;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 2 - Apellido y nombre y fecha de nacimiento (220 registros)
-- ---------------------------------------------------------------------
SELECT apellido_nombre,
       fecha_nacimiento
FROM persona;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 3 - Precedencia de operadores aritméticos (salida: 10 y 12)
-- ---------------------------------------------------------------------
SELECT 4 + 5 * 3 / 2 - 1   AS resultado_1,
       (4 + 5) * 3 / 2 - 1 AS resultado_2;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 4 - Gasto con incremento del 20% en 3 formatos
-- (en PostgreSQL el truncado se hace con TRUNC; ROUND no tiene 3er argumento)
-- ---------------------------------------------------------------------
SELECT importe,
       importe * 1.2             AS "Sin formato",
       ROUND(importe * 1.2, 1)   AS "Redondeado a 1 digito decimal",
       TRUNC(importe * 1.2, 1)   AS "Truncado a 1 digito"
FROM gasto;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 5 - Nombre y población de cada provincia (24 registros)
-- ---------------------------------------------------------------------
SELECT nombre,
       poblacion
FROM provincia;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 6 - Códigos de provincia sin repetir en edificio
-- ---------------------------------------------------------------------
SELECT DISTINCT provincia_id
FROM edificio;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 7 - 4 primeras personas, orden por las 7 primeras letras
-- ---------------------------------------------------------------------
SELECT *
FROM persona
ORDER BY LEFT(apellido_nombre, 7)
FETCH FIRST 4 ROWS ONLY;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 8 - Igual al 7, incluyendo empates (WITH TIES)
-- ---------------------------------------------------------------------
SELECT *
FROM persona
ORDER BY LEFT(apellido_nombre, 7)
FETCH FIRST 4 ROWS WITH TIES;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 9 - 4 primeras personas, orden por apellido_nombre completo,
-- incluyendo empates (WITH TIES). Comparar con el ejercicio 8.
-- ---------------------------------------------------------------------
SELECT *
FROM persona
ORDER BY apellido_nombre
FETCH FIRST 4 ROWS WITH TIES;


-- =====================================================================
-- CLÁUSULAS WHERE Y ORDER BY
-- =====================================================================

-- ---------------------------------------------------------------------
-- Ejercicio Nº 10 - Nombre y dirección de los edificios de Buenos Aires (provincia_id = 2)
-- (ORDER BY por clave primaria: solo para reproducir el orden de la salida esperada)
-- ---------------------------------------------------------------------
SELECT nombre,
       direccion
FROM edificio
WHERE provincia_id = 2
ORDER BY localidad_id, edificio_id;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 11 - Edificios cuyo nombre comienza con EDIFICIO-3
-- (ORDER BY por clave primaria: solo para reproducir el orden de la salida esperada)
-- ---------------------------------------------------------------------
SELECT nombre,
       direccion
FROM edificio
WHERE nombre LIKE 'EDIFICIO-3%'
ORDER BY provincia_id, localidad_id, edificio_id;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 12 - Datos personales en una sola columna, mujeres (88 registros)
-- (ORDER BY por persona_id: solo para reproducir el orden de la salida esperada)
-- ---------------------------------------------------------------------
SELECT apellido_nombre
       || '-' || telefono
       || '-' || TO_CHAR(fecha_nacimiento, 'Mon DD YYYY') AS "Datos personales"
FROM persona
WHERE sexo = 'F'
ORDER BY persona_id;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 13 - Gastos con importe entre 10,00 y 100,00 (172 registros)
-- (ORDER BY por gasto_id: solo para reproducir el orden de la salida esperada)
-- ---------------------------------------------------------------------
SELECT gasto_id, provincia_id, localidad_id, edificio_id,
       periodo, fecha_pago, tipo_gasto_id, importe
FROM gasto
WHERE importe BETWEEN 10.00 AND 100.00
ORDER BY gasto_id;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 14 - Personas nacidas en la década del 60, por fecha descendente (35 registros)
-- (columnas en el orden de la salida esperada del enunciado)
-- ---------------------------------------------------------------------
SELECT persona_id, telefono, apellido_nombre, sexo,
       fecha_nacimiento, estado_civil
FROM persona
WHERE fecha_nacimiento >= DATE '1960-01-01'
  AND fecha_nacimiento <  DATE '1970-01-01'
ORDER BY fecha_nacimiento DESC;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 15 - Localidades de las provincias 1 y 2, alfabéticamente
-- dentro de cada provincia (134 registros)
-- ---------------------------------------------------------------------
SELECT provincia_id,
       localidad_id,
       nombre
FROM localidad
WHERE provincia_id IN (1, 2)
ORDER BY provincia_id, nombre;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 16 - Edificios con la letra 'N' en la posición 5 de la dirección (7 registros)
-- (ORDER BY por clave primaria: solo para reproducir el orden de la salida esperada)
-- ---------------------------------------------------------------------
SELECT provincia_id, localidad_id, edificio_id, nombre,
       direccion, zona_id, conserje_id, administrador_id
FROM edificio
WHERE SUBSTRING(direccion, 5, 1) = 'N'
ORDER BY provincia_id, localidad_id, edificio_id;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 17 - Los 237 gastos menos costosos (237 registros)
-- (columnas en el orden de la salida esperada de este ejercicio)
-- ---------------------------------------------------------------------
SELECT gasto_id, provincia_id, localidad_id, edificio_id,
       fecha_pago, periodo, tipo_gasto_id, importe
FROM gasto
ORDER BY importe
FETCH FIRST 237 ROWS ONLY;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 18 - Igual al 17, incluyendo los importes repetidos (238 registros)
-- ---------------------------------------------------------------------
SELECT gasto_id, provincia_id, localidad_id, edificio_id,
       periodo, fecha_pago, tipo_gasto_id, importe
FROM gasto
ORDER BY importe
FETCH FIRST 237 ROWS WITH TIES;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 19 - Incremento por tramos: 15% (< 10000), 10% (10000 a 20000), 5% (resto)
-- Orden decreciente por importe (8000 registros)
-- ---------------------------------------------------------------------
SELECT periodo,
       fecha_pago,
       importe,
       importe * CASE
                     WHEN importe < 10000                THEN 1.15
                     WHEN importe BETWEEN 10000 AND 20000 THEN 1.10
                     ELSE 1.05
                 END AS "Importe actualizado"
FROM gasto
ORDER BY importe DESC;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 20 - Cantidad de casados y solteros en una sola fila (salida: 126 y 94)
-- ---------------------------------------------------------------------
SELECT COUNT(*) FILTER (WHERE estado_civil = 'C') AS "Casado",
       COUNT(*) FILTER (WHERE estado_civil = 'S') AS "Soltero"
FROM persona;

-- ---------------------------------------------------------------------
-- Ejercicio Nº 21 - Suma, cantidad y promedio de los gastos
-- ---------------------------------------------------------------------
SELECT SUM(importe)         AS sumatoria,
       COUNT(*)             AS cantidad,
       ROUND(AVG(importe), 6) AS promedio
FROM gasto;
