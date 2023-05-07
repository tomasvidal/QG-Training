-- Metricas

SELECT 
  SUM(MONTO_VENDIDO) AS VentasTotales,
  SUM(CANTIDAD_VENDIDA) AS CantidadVentasTotales,
  AVG(MONTO_VENDIDO) AS PromedioVentasTotales,
  SUM(MONTO_VENDIDO * COMISION_COMERCIAL) AS ComisionComercialTotal,
  COUNT(DISTINCT CLIENTE_KEY) AS CantidadClientes
FROM 
  dbo.FACT_VENTAS;