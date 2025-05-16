-- 1. Crear la base de datos
CREATE DATABASE BaseDeDeudores;
GO

-- 2. Usar la base de datos
USE BaseDeDeudores;
GO

--3. Cargar el o los archivos .csv
   --1. Dar click derecho en la base de datos creada.
   --2. Ir a Task < Import Flat File...
   --3. En Location o File to be imported seleccionar el archivo .csv, le damos un nombre y continuamos.
   --4. Se verá la previsualización, continuar al siguiente paso.
   --5. Seleccionar las primary keys y nulls de ser necesario (para este ejercicio no es necesario).
   --6. Continuar y dar a Finalizar

---------------------------------------------

--Base de datos deudor_13000

-- Ver los primeros 10 registros de la tabla
SELECT TOP 10 * FROM h_deudor_13000;
go

-- Ver información de columnas y tipos 
SELECT 
    TABLE_NAME,
    COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME IN ('h_deudor_13000')
ORDER BY 
    TABLE_NAME,
    ORDINAL_POSITION;
GO
-- Contar total de registros en la tabla
SELECT COUNT(*) AS total_registros FROM h_deudor_13000;
go

-- Obtener los valores únicos de la columna CODMES (meses disponibles), ordenados de forma ascendente
SELECT DISTINCT CODMES
FROM h_deudor_13000
ORDER BY CODMES;
go

--------------------------------------------

--Base de datos demográfico_13000
go

--Ver los primeros 10 registros de la tabla
SELECT TOP 10 * FROM h_demografico_13000;
go

-- Obtener los valores únicos de la columna CODMES (meses disponibles), ordenados de forma ascendente
SELECT DISTINCT CODMES
FROM h_demografico_13000
ORDER BY CODMES;
go

-- Unir la tabla h_deudor_13000 con h_demografico_13000 usando LEFT JOIN
-- La unión se realiza por clienteID y CODMES
SELECT *
FROM h_deudor_13000 d
LEFT JOIN h_demografico_13000 demo
    ON d.clienteID = demo.clienteID
    AND d.CODMES = demo.CODMES;
go

-- Mostrar los primeros 10 registros del resultado combinado
SELECT TOP 10 *
FROM h_deudor_13000 d
LEFT JOIN h_demografico_13000 demo
    ON d.clienteID = demo.clienteID
    AND d.CODMES = demo.CODMES;
GO


-- Obtener los nombres de las columnas de las tablas involucradas en el JOIN
-- Esto equivale a inspeccionar df.columns tras la unión en PySpark

SELECT 
    TABLE_NAME,
    COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME IN ('h_deudor_13000', 'h_demografico_13000')
ORDER BY 
    TABLE_NAME,
    ORDINAL_POSITION;
GO


-- Contar la frecuencia de cada valor único en la columna 'sexo'
-- de la tabla h_demografico_13000

SELECT
  demo.sexo,           -- valor de la columna 'sexo'
  COUNT(*) AS frecuencia  -- número de ocurrencias de ese valor
FROM h_demografico_13000 AS demo
GROUP BY
  demo.sexo            -- agrupar por cada valor de 'sexo'
ORDER BY
  frecuencia DESC;     -- ordenar de mayor a menor frecuencia



-- Contar la frecuencia de cada valor único en la columna 'NUMEDSD'
-- de la tabla h_demografico_13000, ordenar por el valor de NUMEDSD
-- y mostrar sólo los primeros 50 resultados.

SELECT TOP 50
    demo.NUMEDSD,            -- valor de la columna 'NUMEDSD'
    COUNT(*) AS frecuencia   -- número de ocurrencias de ese valor
FROM h_demografico_13000 AS demo
GROUP BY
    demo.NUMEDSD             -- agrupar por cada valor de 'NUMEDSD'
ORDER BY
    demo.NUMEDSD;            -- ordenar de menor a mayor NUMEDSD



-- Contar la frecuencia de cada valor único en la columna 'flag_banco_a'
-- de la tabla h_deudor_13000

SELECT
    d.flag_banco_a,         -- valor de la columna 'flag_banco_a'
    COUNT(*) AS frecuencia  -- número de ocurrencias de ese valor
FROM h_deudor_13000 AS d
GROUP BY
    d.flag_banco_a         -- agrupar por cada valor de 'flag_banco_a'
ORDER BY
    frecuencia DESC;       -- ordenar de mayor a menor frecuencia (opcional)



-- Contar la frecuencia de cada valor único en la columna ‘segmento’
-- de la tabla que corresponde al DataFrame original
SELECT
segmento, -- valor de la columna ‘segmento’
COUNT(*) AS frecuencia -- número de ocurrencias de ese valor
FROM h_demografico_13000 
GROUP BY
segmento -- agrupar por cada valor de ‘segmento’
ORDER BY
frecuencia DESC; -- opcional: ordenar de mayor a menor frecuencia