-- Para que esto funcione hay que guardar los csv dentro de la carpeta 'C:\FinalProjectSQL\csv\'
-- Los nombres de los archivos deberan tener la siguiente estructura: 'QG - Ejercicio Integrador - Data Source - XXXXX.csv'

BULK INSERT [dbo].[STG_DIM_CATEGORIA]
FROM 'C:\FinalProjectSQL\csv\QG - Ejercicio Integrador - Data Source - Categoria.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2,
  CODEPAGE = '65001' -- UTF-8 encoding
);

BULK INSERT [dbo].[STG_DIM_CLIENTE]
FROM 'C:\FinalProjectSQL\csv\QG - Ejercicio Integrador - Data Source - Cliente.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2,
  CODEPAGE = '65001' -- UTF-8 encoding
);

BULK INSERT [dbo].[STG_DIM_PAIS]
FROM 'C:\FinalProjectSQL\csv\QG - Ejercicio Integrador - Data Source - PAIS.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2,
  CODEPAGE = '65001' -- UTF-8 encoding
);

BULK INSERT [dbo].[STG_DIM_PRODUCTO]
FROM 'C:\FinalProjectSQL\csv\QG - Ejercicio Integrador - Data Source - Producto.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2,
  CODEPAGE = '65001' -- UTF-8 encoding
);

BULK INSERT [dbo].[STG_DIM_SUCURSAL]
FROM 'C:\FinalProjectSQL\csv\QG - Ejercicio Integrador - Data Source - Sucursal.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2,
  CODEPAGE = '65001' -- UTF-8 encoding
);

BULK INSERT [dbo].[STG_DIM_VENDEDOR]
FROM 'C:\FinalProjectSQL\csv\QG - Ejercicio Integrador - Data Source - Vendedor.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2,
  CODEPAGE = '65001' -- UTF-8 encoding
);

BULK INSERT [dbo].[STG_FACT_VENTAS]
FROM 'C:\FinalProjectSQL\csv\QG - Ejercicio Integrador - Data Source - Ventas.csv'
WITH (
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '\n',
  FIRSTROW = 2,
  CODEPAGE = '65001' -- UTF-8 encoding
);

