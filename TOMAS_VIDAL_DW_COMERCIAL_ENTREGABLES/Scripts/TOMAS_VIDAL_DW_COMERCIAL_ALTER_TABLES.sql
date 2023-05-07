ALTER TABLE [dbo].[FACT_VENTAS]  WITH CHECK ADD FOREIGN KEY([CATEGORIA_KEY])
REFERENCES [dbo].[DIM_CATEGORIA] ([CATEGORIA_KEY])
GO
ALTER TABLE [dbo].[FACT_VENTAS]  WITH CHECK ADD FOREIGN KEY([CLIENTE_KEY])
REFERENCES [dbo].[DIM_CLIENTE] ([CLIENTE_KEY])
GO
ALTER TABLE [dbo].[FACT_VENTAS]  WITH CHECK ADD FOREIGN KEY([PAIS_KEY])
REFERENCES [dbo].[DIM_PAIS] ([PAIS_KEY])
GO
ALTER TABLE [dbo].[FACT_VENTAS]  WITH CHECK ADD FOREIGN KEY([PRODUCTO_KEY])
REFERENCES [dbo].[DIM_PRODUCTO] ([PRODUCTO_KEY])
GO
ALTER TABLE [dbo].[FACT_VENTAS]  WITH CHECK ADD FOREIGN KEY([SUCURSAL_KEY])
REFERENCES [dbo].[DIM_SUCURSAL] ([SUCURSAL_KEY])
GO
ALTER TABLE [dbo].[FACT_VENTAS]  WITH CHECK ADD FOREIGN KEY([TIEMPO_KEY])
REFERENCES [dbo].[DIM_TIEMPO] ([TIEMPO_KEY])
GO
ALTER TABLE [dbo].[FACT_VENTAS]  WITH CHECK ADD FOREIGN KEY([VENDEDOR_KEY])
REFERENCES [dbo].[DIM_VENDEDOR] ([VENDEDOR_KEY])
GO