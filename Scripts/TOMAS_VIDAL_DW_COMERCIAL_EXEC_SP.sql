EXEC [dbo].[SP_CARGA_INT_DIM_CATEGORIA]
EXEC [dbo].[SP_CARGA_INT_DIM_CLIENTE]
EXEC [dbo].[SP_CARGA_INT_DIM_PAIS]
EXEC [dbo].[SP_CARGA_INT_DIM_PRODUCTO]
EXEC [dbo].[SP_CARGA_INT_DIM_SUCURSAL]
EXEC [dbo].[SP_CARGA_INT_DIM_VENDEDOR]
EXEC [dbo].[SP_CARGA_INT_FACT_VENTAS]

EXEC [dbo].[SP_CARGA_DIM_CATEGORIA]
EXEC [dbo].[SP_CARGA_DIM_CLIENTE]
EXEC [dbo].[SP_CARGA_DIM_PAIS]
EXEC [dbo].[SP_CARGA_DIM_PRODUCTO]
EXEC [dbo].[SP_CARGA_DIM_SUCURSAL]
EXEC [dbo].[SP_CARGA_DIM_VENDEDOR]



-- Populo la tabla DIM_TIEMPO con los anios pertenencientes a INT_FACT_VENTAS utilizando el sp_Genera_Dim_Tiempo.
DECLARE @Anio INT;
DECLARE MyCursor CURSOR FOR
    SELECT DISTINCT YEAR(Fecha) FROM dbo.INT_FACT_VENTAS;
OPEN MyCursor;
FETCH NEXT FROM MyCursor INTO @Anio;
WHILE @@FETCH_STATUS = 0
BEGIN
EXEC [dbo].[Sp_Genera_Dim_Tiempo] @Anio
    FETCH NEXT FROM MyCursor INTO @Anio;
END;
CLOSE MyCursor;
DEALLOCATE MyCursor;



EXEC [dbo].[SP_CARGA_FACT_VENTAS]
