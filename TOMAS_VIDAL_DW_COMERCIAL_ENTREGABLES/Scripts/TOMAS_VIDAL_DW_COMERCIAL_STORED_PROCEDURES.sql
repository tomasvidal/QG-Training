SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Store Procedures que completan las tablas INT_DIM_ desde las tablas STG_DIM_
-- =============================================


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla INT_DIM_PRODUCTO desde la tabla STG_DIM_PRODUCTO:
-- =============================================
CREATE PROCEDURE SP_CARGA_INT_DIM_PRODUCTO

AS
BEGIN

	SET NOCOUNT ON;

INSERT INTO [dbo].[INT_DIM_PRODUCTO]
           ([COD_PRODUCTO]
           ,[DESC_PRODUCTO])
           (SELECT DISTINCT COD_PRODUCTO, DESC_PRODUCTO FROM STG_DIM_PRODUCTO)
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla INT_DIM_CATEGORIA desde la tabla STG_DIM_CATEGORIA:
-- =============================================
CREATE PROCEDURE SP_CARGA_INT_DIM_CATEGORIA
AS
BEGIN
  INSERT INTO INT_DIM_CATEGORIA (COD_CATEGORIA, DESC_CATEGORIA)
  SELECT DISTINCT COD_CATEGORIA, DESC_CATEGORIA
  FROM STG_DIM_CATEGORIA;
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla INT_DIM_CLIENTE desde la tabla STG_DIM_CLIENTE:
-- =============================================
CREATE PROCEDURE SP_CARGA_INT_DIM_CLIENTE
AS
BEGIN
  INSERT INTO INT_DIM_CLIENTE (COD_CLIENTE, NOMBRE, APELLIDO)
  SELECT DISTINCT
    COD_CLIENTE,
    LEFT(DESC_CLIENTE, CHARINDEX(' ', DESC_CLIENTE) - 1) AS NOMBRE,
    SUBSTRING(DESC_CLIENTE, CHARINDEX(' ', DESC_CLIENTE) + 1, LEN(DESC_CLIENTE)) AS APELLIDO
  FROM STG_DIM_CLIENTE;
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla INT_DIM_PAIS desde la tabla STG_DIM_PAIS:
-- =============================================
CREATE PROCEDURE SP_CARGA_INT_DIM_PAIS
AS
BEGIN
  INSERT INTO INT_DIM_PAIS (COD_PAIS, DESC_PAIS)
  SELECT DISTINCT 
    LEFT(COD_PAIS, 3) AS COD_PAIS_TRUNCATED,
    DESC_PAIS
  FROM STG_DIM_PAIS;
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla INT_DIM_VENDEDOR desde la tabla STG_DIM_VENDEDOR:
-- =============================================
CREATE OR ALTER PROCEDURE SP_CARGA_INT_DIM_VENDEDOR
AS
BEGIN
  INSERT INTO INT_DIM_VENDEDOR (COD_VENDEDOR, NOMBRE, APELLIDO)
  SELECT DISTINCT 
     REPLACE(COD_VENDEDOR, 'V', '')COD_VENDEDOR,
    LEFT(DESC_VENDEDOR, CHARINDEX(' ', DESC_VENDEDOR) - 1) AS NOMBRE,
    SUBSTRING(DESC_VENDEDOR, CHARINDEX(' ', DESC_VENDEDOR) + 1, LEN(DESC_VENDEDOR)) AS APELLIDO
  FROM STG_DIM_VENDEDOR;
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla INT_DIM_SUCURSAL desde la tabla STG_DIM_SUCURSAL:
-- =============================================
CREATE PROCEDURE SP_CARGA_INT_DIM_SUCURSAL
AS
BEGIN
    INSERT INTO INT_DIM_SUCURSAL (COD_SUCURSAL, DESC_SUCURSAL)
    SELECT DISTINCT COD_SUCURSAL, DESC_SUCURSAL
    FROM STG_DIM_SUCURSAL
END
GO


-- =============================================
-- Author:		QG
-- Create date: 20XX-XX-XX
-- Description:	Store Procedure que completa los datos de la tabla DIM_TIEMPO:
-- =============================================
CREATE PROCEDURE [dbo].[Sp_Genera_Dim_Tiempo]
@anio Int
As
SET NOCOUNT ON
SET arithabort off
SET arithignore on

/**************/
/* Variables */
/**************/

SET DATEFIRST 1;
SET DATEFORMAT mdy
DECLARE @dia smallint
DECLARE @mes smallint
DECLARE @f_txt varchar(10)
DECLARE @fecha smalldatetime
DECLARE @key int

DECLARE @vacio smallint
DECLARE @fin smallint
DECLARE @fin_mes int
DECLARE @anioperiodicidad int

SELECT @dia = 1
SELECT @mes = 1
SELECT @f_txt = Convert(char(2), @mes) + '/' + Convert(char(2), @dia) + '/' + Convert(char(4), @anio)
SELECT @fecha = Convert(smalldatetime, @f_txt)
select @anioperiodicidad = @anio

/************************************/
/* Se chequea que el anio a procesar */
/* no exista en la tabla TIME */
/************************************/

IF (SELECT Count(*) FROM dim_tiempo WHERE anio = @anio) > 0
BEGIN
Print 'El año que ingreso ya existe en la tabla'
Print 'Procedimiento CANCELADO.................'
Return 0
END

/*************************/
/* Se inserta dia a dia */
/* hasta terminar el anio */
/*************************/

SELECT @fin = @anio + 1
WHILE (@anio < @fin)
BEGIN
--Armo la fecha
IF Len(Rtrim(Convert(Char(2),Datepart(mm, @fecha))))=1
BEGIN
IF Len(Rtrim(Convert(Char(2),Datepart(dd, @fecha))))=1
SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + '0' +

Rtrim(Convert(Char(2),Datepart(mm, @fecha))) + '0' + Rtrim(Convert(Char(2),Datepart(dd, @fecha)))
ELSE
SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + '0' +

Rtrim(Convert(Char(2),Datepart(mm, @fecha))) + Convert(Char(2),Datepart(dd, @fecha))
END
ELSE
BEGIN
IF Len(Rtrim(Convert(Char(2),Datepart(dd, @fecha))))=1
SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + Convert(Char(2),Datepart(mm,

@fecha)) + '0' + Rtrim(Convert(Char(2),Datepart(dd, @fecha)))
ELSE
SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + Convert(Char(2),Datepart(mm,

@fecha)) + Convert(Char(2),Datepart(dd, @fecha))

END
--Calculo el último día del mes
SET @fin_mes = day(dateadd(d, -1, dateadd(m, 1, dateadd(d, - day(@fecha) + 1, @fecha))))

INSERT Dim_Tiempo (Tiempo_Key, Anio, MES_NRO, Mes_Nombre, Semestre, Trimestre, Semana_Anio

,Semana_Nro_Mes, Dia, Dia_Nombre, Dia_Semana_Nro)

SELECT
tiempo_key = @fecha
, anio = Datepart(yyyy, @fecha)
, mes = Datepart(mm, @fecha)
--, mes_nombre = Datename(mm, @fecha)
, mes_nombre = CASE Datename(mm, @fecha)
when 'January' then 'Enero'
when 'February' then 'Febrero'
when 'March' then 'Marzo'
when 'April' then 'Abril'
when 'May' then 'Mayo'
when 'June' then 'Junio'
when 'July' then 'Julio'
when 'August' then 'Agosto'
when 'September' then 'Septiembre'
when 'October' then 'Octubre'
when 'November' then 'Noviembre'
when 'December' then 'Diciembre'
else Datename(mm, @fecha)
END

, semestre = CASE Datepart(mm, @fecha)
when (SELECT Datepart(mm, @fecha)

WHERE Datepart(mm, @fecha) between 1 and 6) then 1

else 2
END

, trimestre = Datepart(qq, @fecha)
, semana_anio = Datepart(wk, @fecha)
, semana_nro_mes = Datepart(wk, @fecha) - datepart(week,
dateadd(dd,-day(@fecha)+1,@fecha)) +1
, dia = Datepart(dd, @fecha)
, dia_nombre = CASE Datename(dw, @fecha)
when 'Monday' then 'Lunes'
when 'Tuesday' then 'Martes'
when 'Wednesday' then 'Miercoles'
when 'Thursday' then 'Jueves'
when 'Friday' then 'Viernes'
when 'Saturday' then 'Sabado'
when 'Sunday' then 'Domingo'
else Datename(dw, @fecha)
END
--, dia_nombre = Datename(dw, @fecha)
, dia_semana_nro = Datepart(dw, @fecha)

SELECT @fecha = Dateadd(dd, 1, @fecha)
SELECT @dia = Datepart(dd, @fecha)
SELECT @mes = Datepart(mm, @fecha)
SELECT @anio = Datepart(yy, @fecha) CONTINUE

END
GO

-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla INT_FACT_VENTAS desde la tabla STG_FACT_VENTAS:
-- =============================================
CREATE PROCEDURE SP_CARGA_INT_FACT_VENTAS
AS
BEGIN
    -- Insert into INT_FACT_VENTAS tabla con conversion de tipos de dato
    INSERT INTO INT_FACT_VENTAS (COD_PRODUCTO, COD_CATEGORIA, COD_CLIENTE, COD_PAIS, COD_VENDEDOR, COD_SUCURSAL, Fecha, CANTIDAD_VENDIDA, MONTO_VENDIDO, PRECIO, COMISION_COMERCIAL)
    SELECT 
        CAST(COD_PRODUCTO AS varchar(100)),
        CAST(COD_CATEGORIA AS varchar(100)),
        CAST(COD_CLIENTE AS varchar(100)),
        CAST(COD_PAIS AS varchar(100)),
        CAST(REPLACE(COD_VENDEDOR, 'V', '') AS varchar(100)),
        CAST(COD_SUCURSAL AS varchar(100)),
        CONVERT(smalldatetime, FECHA, 101),
        CAST(CANTIDAD_VENDIDA AS decimal(18,2)),
        CAST(MONTO_VENDIDO AS decimal(18,2)),
        CAST(PRECIO AS decimal(18,2)),
        CAST(COMISION_COMERCIAL AS decimal(18,2))
    FROM STG_FACT_VENTAS
END
GO


-- =============================================
-- Description:	Store Procedures que completan las tablas DIM_ desde las tablas INT_DIM_
-- =============================================


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla DIM_PRODUCTO desde la tabla INT_DIM_PRODUCTO:
-- =============================================
CREATE PROCEDURE SP_CARGA_DIM_PRODUCTO
AS
BEGIN
    SET NOCOUNT ON;
    -- Actualizo los registros existentes en DIM_PRODUCTO con los valores más recientes de INT_DIM_PRODUCTO
    UPDATE DIM_PRODUCTO
    SET
        DESC_PRODUCTO = INT_DIM_PRODUCTO.DESC_PRODUCTO,
        FECHA_UPDATE = GETDATE(),
        USUARIO_UPDATE = SYSTEM_USER
    FROM DIM_PRODUCTO
    INNER JOIN INT_DIM_PRODUCTO ON DIM_PRODUCTO.COD_PRODUCTO = INT_DIM_PRODUCTO.COD_PRODUCTO

    -- Insertar nuevos registros en DIM_PRODUCTO desde INT_DIM_PRODUCTO
    INSERT INTO DIM_PRODUCTO
    (
        COD_PRODUCTO,
        DESC_PRODUCTO,
        FECHA_ALTA,
        USUARIO_ALTA,
        FECHA_UPDATE,
        USUARIO_UPDATE
    )
    SELECT
        COD_PRODUCTO,
        DESC_PRODUCTO,
        GETDATE(),
        SYSTEM_USER,
        GETDATE(),
        SYSTEM_USER
    FROM INT_DIM_PRODUCTO
    WHERE NOT EXISTS (
        SELECT *
        FROM DIM_PRODUCTO
        WHERE DIM_PRODUCTO.COD_PRODUCTO = INT_DIM_PRODUCTO.COD_PRODUCTO
    )
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla DIM_CATEGORIA desde la tabla INT_DIM_CATEGORIA:
-- =============================================
CREATE PROCEDURE SP_CARGA_DIM_CATEGORIA
AS
BEGIN
    SET NOCOUNT ON;
    -- Actualizo los registros existentes en DIM_CATEGORIA con los valores más recientes de INT_DIM_CATEGORIA
    UPDATE DIM_CATEGORIA
    SET
        DESC_CATEGORIA = INT_DIM_CATEGORIA.DESC_CATEGORIA,
        FECHA_UPDATE = GETDATE(),
        USUARIO_UPDATE = SYSTEM_USER
    FROM DIM_CATEGORIA
    INNER JOIN INT_DIM_CATEGORIA ON INT_DIM_CATEGORIA.COD_CATEGORIA = DIM_CATEGORIA.COD_CATEGORIA

    -- Insertar nuevos registros en DIM_CATEGORIA desde INT_DIM_CATEGORIA
    INSERT INTO DIM_CATEGORIA
    (
        COD_CATEGORIA,
        DESC_CATEGORIA,
        FECHA_ALTA,
        USUARIO_ALTA,
        FECHA_UPDATE,
        USUARIO_UPDATE
    )
    SELECT
        COD_CATEGORIA,
        DESC_CATEGORIA,
        GETDATE(),
        SYSTEM_USER,
        GETDATE(),
        SYSTEM_USER
    FROM INT_DIM_CATEGORIA
    WHERE NOT EXISTS (
        SELECT *
        FROM DIM_CATEGORIA
        WHERE DIM_CATEGORIA.COD_CATEGORIA = INT_DIM_CATEGORIA.COD_CATEGORIA
    )
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla DIM_CLIENTE desde la tabla INT_DIM_CLIENTE:
-- =============================================
CREATE PROCEDURE SP_CARGA_DIM_CLIENTE
AS
BEGIN
    SET NOCOUNT ON;
    -- Actualizo los registros existentes en DIM_CLIENTE con los valores más recientes de INT_DIM_CLIENTE
    UPDATE DIM_CLIENTE
    SET
        NOMBRE = INT_DIM_CLIENTE.NOMBRE,
		APELLIDO = INT_DIM_CLIENTE.APELLIDO,
        FECHA_UPDATE = GETDATE(),
        USUARIO_UPDATE = SYSTEM_USER
    FROM DIM_CLIENTE
    INNER JOIN INT_DIM_CLIENTE ON INT_DIM_CLIENTE.COD_CLIENTE = DIM_CLIENTE.COD_CLIENTE

    -- Insertar nuevos registros en DIM_CLIENTE desde INT_DIM_CLIENTE
    INSERT INTO DIM_CLIENTE
    (
        COD_CLIENTE,
        NOMBRE,
		APELLIDO,
        FECHA_ALTA,
        USUARIO_ALTA,
        FECHA_UPDATE,
        USUARIO_UPDATE
    )
    SELECT
        COD_CLIENTE,
        NOMBRE,
		APELLIDO,
        GETDATE(),
        SYSTEM_USER,
        GETDATE(),
        SYSTEM_USER
    FROM INT_DIM_CLIENTE
    WHERE NOT EXISTS (
        SELECT *
        FROM DIM_CLIENTE
        WHERE DIM_CLIENTE.COD_CLIENTE = INT_DIM_CLIENTE.COD_CLIENTE
    )
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla DIM_PAIS desde la tabla INT_DIM_PAIS:
-- =============================================
CREATE PROCEDURE SP_CARGA_DIM_PAIS
AS
BEGIN
    SET NOCOUNT ON;
    -- Actualizo los registros existentes en DIM_PAIS con los valores más recientes de INT_DIM_PAIS
    UPDATE DIM_PAIS
    SET
        DESC_PAIS = INT_DIM_PAIS.DESC_PAIS,
        FECHA_UPDATE = GETDATE(),
        USUARIO_UPDATE = SYSTEM_USER
    FROM DIM_PAIS
    INNER JOIN INT_DIM_PAIS ON INT_DIM_PAIS.COD_PAIS = DIM_PAIS.COD_PAIS

    -- Insertar nuevos registros en DIM_PAIS desde INT_DIM_PAIS
    INSERT INTO DIM_PAIS
    (
        COD_PAIS,
        DESC_PAIS,
        FECHA_ALTA,
        USUARIO_ALTA,
        FECHA_UPDATE,
        USUARIO_UPDATE
    )
    SELECT
        COD_PAIS,
        DESC_PAIS,
        GETDATE(),
        SYSTEM_USER,
        GETDATE(),
        SYSTEM_USER
    FROM INT_DIM_PAIS
    WHERE NOT EXISTS (
        SELECT *
        FROM DIM_PAIS
        WHERE DIM_PAIS.COD_PAIS = INT_DIM_PAIS.COD_PAIS
    )
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla DIM_VENDEDOR desde la tabla INT_DIM_VENDEDOR:
-- =============================================
CREATE PROCEDURE SP_CARGA_DIM_VENDEDOR
AS
BEGIN
    SET NOCOUNT ON;
    -- Actualizo los registros existentes en DIM_VENDEDOR con los valores más recientes de INT_DIM_VENDEDOR
    UPDATE DIM_VENDEDOR
    SET
        NOMBRE = INT_DIM_VENDEDOR.NOMBRE,
		APELLIDO = INT_DIM_VENDEDOR.APELLIDO,
        FECHA_UPDATE = GETDATE(),
        USUARIO_UPDATE = SYSTEM_USER
    FROM DIM_VENDEDOR
    INNER JOIN INT_DIM_VENDEDOR ON INT_DIM_VENDEDOR.COD_VENDEDOR = DIM_VENDEDOR.COD_VENDEDOR

    -- Insertar nuevos registros en DIM_VENDEDOR desde INT_DIM_VENDEDOR
    INSERT INTO DIM_VENDEDOR
    (
        COD_VENDEDOR,
        NOMBRE,
		APELLIDO,
        FECHA_ALTA,
        USUARIO_ALTA,
        FECHA_UPDATE,
        USUARIO_UPDATE
    )
    SELECT
        COD_VENDEDOR,
        NOMBRE,
		APELLIDO,
        GETDATE(),
        SYSTEM_USER,
        GETDATE(),
        SYSTEM_USER
    FROM INT_DIM_VENDEDOR
    WHERE NOT EXISTS (
        SELECT *
        FROM DIM_VENDEDOR
        WHERE DIM_VENDEDOR.COD_VENDEDOR = INT_DIM_VENDEDOR.COD_VENDEDOR
    )
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla DIM_SUCURSAL desde la tabla INT_DIM_SUCURSAL:
-- =============================================
CREATE PROCEDURE SP_CARGA_DIM_SUCURSAL
AS
BEGIN
    SET NOCOUNT ON;
    -- Actualizo los registros existentes en DIM_SUCURSAL con los valores más recientes de INT_DIM_SUCURSAL
    UPDATE DIM_SUCURSAL
    SET
        DESC_SUCURSAL = INT_DIM_SUCURSAL.DESC_SUCURSAL,
        FECHA_UPDATE = GETDATE(),
        USUARIO_UPDATE = SYSTEM_USER
    FROM DIM_SUCURSAL
    INNER JOIN INT_DIM_SUCURSAL ON INT_DIM_SUCURSAL.COD_SUCURSAL = DIM_SUCURSAL.COD_SUCURSAL

    -- Insertar nuevos registros en DIM_SUCURSAL desde INT_DIM_SUCURSAL
    INSERT INTO DIM_SUCURSAL
    (
        COD_SUCURSAL,
        DESC_SUCURSAL,
        FECHA_ALTA,
        USUARIO_ALTA,
        FECHA_UPDATE,
        USUARIO_UPDATE
    )
    SELECT
        COD_SUCURSAL,
        DESC_SUCURSAL,
        GETDATE(),
        SYSTEM_USER,
        GETDATE(),
        SYSTEM_USER
    FROM INT_DIM_SUCURSAL
    WHERE NOT EXISTS (
        SELECT *
        FROM DIM_SUCURSAL
        WHERE DIM_SUCURSAL.COD_SUCURSAL = INT_DIM_SUCURSAL.COD_SUCURSAL
    )
END
GO


-- =============================================
-- Author:		Tomas Vidal
-- Create date: 2023-04-04
-- Description:	Store Procedure que completa los datos de la tabla FACT_VENTAS desde la tabla INT_FACT_VENTAS:
-- =============================================
CREATE PROCEDURE SP_CARGA_FACT_VENTAS
AS
BEGIN
    -- Insert into INT_FACT_VENTAS tabla con conversion de tipos de dato
	SET IDENTITY_INSERT FACT_VENTAS ON
    INSERT INTO FACT_VENTAS (CATEGORIA_KEY, CLIENTE_KEY, PAIS_KEY, PRODUCTO_KEY, SUCURSAL_KEY, VENDEDOR_KEY, TIEMPO_KEY, CANTIDAD_VENDIDA, MONTO_VENDIDO, PRECIO, COMISION_COMERCIAL, FECHA_ALTA, USUARIO_ALTA)
    SELECT DIM_CATEGORIA.CATEGORIA_KEY,
	   DIM_CLIENTE.CLIENTE_KEY,
	   DIM_PAIS.PAIS_KEY,
	   DIM_PRODUCTO.PRODUCTO_KEY,
	   DIM_SUCURSAL.SUCURSAL_KEY,
	   DIM_VENDEDOR.VENDEDOR_KEY,
	   DIM_TIEMPO.TIEMPO_KEY,
	   INT_FACT_VENTAS.CANTIDAD_VENDIDA,
	   INT_FACT_VENTAS.MONTO_VENDIDO,
	   INT_FACT_VENTAS.PRECIO,
	   INT_FACT_VENTAS.COMISION_COMERCIAL,
	   GETDATE() AS FECHA_ALTA,
       SYSTEM_USER AS USUARIO_ALTA 
	FROM INT_FACT_VENTAS 
	INNER JOIN DIM_CATEGORIA on INT_FACT_VENTAS.COD_CATEGORIA = DIM_CATEGORIA.COD_CATEGORIA
	INNER JOIN DIM_CLIENTE on INT_FACT_VENTAS.COD_CLIENTE = DIM_CLIENTE.COD_CLIENTE
	INNER JOIN DIM_PAIS on INT_FACT_VENTAS.COD_PAIS = DIM_PAIS.COD_PAIS
	INNER JOIN DIM_PRODUCTO on INT_FACT_VENTAS.COD_PRODUCTO = DIM_PRODUCTO.COD_PRODUCTO
	INNER JOIN DIM_SUCURSAL on INT_FACT_VENTAS.COD_SUCURSAL = DIM_SUCURSAL.COD_SUCURSAL
	INNER JOIN DIM_VENDEDOR on INT_FACT_VENTAS.COD_VENDEDOR = DIM_VENDEDOR.COD_VENDEDOR
	INNER JOIN DIM_TIEMPO on INT_FACT_VENTAS.Fecha = DIM_TIEMPO.TIEMPO_KEY

	SET IDENTITY_INSERT FACT_VENTAS OFF
END
GO