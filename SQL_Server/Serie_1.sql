USE base_consorcio_2025;


-----EJER 1-----
SELECT * FROM persona;
----------------------
-----EJER 2-----
SELECT apellido_nombre, fecha_nacimiento FROM persona;
----------------------
-----EJER 3-----
SELECT 4+5*3/2-1;
SELECT (4+5)*3/2-1;
----------------------
-----EJER 4-----
SELECT importe,
(importe+(importe*0.2)) AS Sin_Formato,
ROUND((importe+(importe*0.2)),1) AS Redondeado_a_1_digito_decimal,
ROUND((importe+(importe*0.2)),1,1) AS Truncado_a_1_digito
FROM gasto;
----------------------
-----EJER 5-----
SELECT nombre, poblacion FROM provincia;
----------------------
-----EJER 6-----
SELECT DISTINCT provincia_id FROM edificio;
----------------------
-----EJER 7-----
SELECT TOP(4)apellido_nombre 
FROM persona
ORDER BY LEFT(apellido_nombre,7);
;
----------------------
-----EJER 8-----
SELECT TOP(4) WITH TIES apellido_nombre 
FROM persona
ORDER BY LEFT(apellido_nombre,7);
----------------------
-----EJER 9-----
SELECT TOP(4) WITH TIES apellido_nombre
FROM persona
ORDER BY apellido_nombre ASC;
----------------------
-----EJER 10-----
SELECT nombre, direccion 
FROM edificio
WHERE provincia_id = 2;
----------------------
-----EJER 11-----
SELECT nombre, direccion
FROM edificio
WHERE nombre LIKE 'EDIFICIO-3%';
----------------------
-----EJER 12-----
SELECT CONCAT(apellido_nombre,' - ',telefono,' - ',fecha_nacimiento) AS 'Datos Personales'
FROM persona
WHERE sexo = 'F';
----------------------
-----EJER 13-----
SELECT *
FROM gasto
WHERE importe>=10.00 AND importe<=100.00;
----------------------
-----EJER 14-----
SELECT * 
FROM persona
WHERE fecha_nacimiento>='1960-01-01' AND fecha_nacimiento<='1969-12-31';
----------------------
-----EJER 15-----
SELECT  provincia_id, localidad_id, nombre
FROM  localidad
WHERE provincia_id IN (1,2);
----------------------
-----EJER 16-----
SELECT *
FROM edificio
WHERE direccion LIKE '____N%';
-----------------------
-----EJER 17-----
SELECT TOP(237) *
FROM gasto
ORDER BY importe ASC;
-----------------------
-----EJER 18-----
SELECT TOP(237) *
FROM gasto
ORDER BY importe ASC;


