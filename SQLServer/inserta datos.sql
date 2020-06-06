-- los parametros para comprar un producto (entrada) son:
-- codigo del producto(varchar(10)), nombre del producto (varchar(25)), descripcion (varchar(100)),
-- presentacion (varchar(25)), precio float, cantidad int
-- al precio se le aumentará el 40% de utilidad para tomarlo como precio de venta, pero en la 
-- tabla inventario se quedará el precio de entrada (precio de compra)
sp_compra_producto '123456', 'Botin', '', 'Caja', 1000, 5
sp_compra_producto '123489', 'Zapatilla', '', 'Caja', 1500, 3
sp_compra_producto '234567', 'Zapato escolar', 'Zapato escolar para niño', 'Caja', 700, 8
sp_compra_producto '234568', 'Zapato escolar', 'Zapato escolar para niña', 'Caja', 750, 8

-- Parametros: nombre del cliente varchar(80), pais varchar(30)
insert into clientes values('Jesus', 'México')
insert into clientes values('Carol', 'México')

declare @noFactura varchar(20)
declare @codigoProducto varchar(10)
set @noFactura = (select dbo.fn_genera_no_factura())
select @noFactura
insert into facturacion (noFactura, idCliente, impuestos, fecha, descuento)
values(@noFactura, 1, 16, getdate(), 5)
set @codigoProducto = '123489'

--sp_inserta_producto_a_factura @noFactura, @codigoProducto, 1

-- los parametros para insertar producto a factura son:
-- noFactura, codigo del producto, cantidad
sp_inserta_producto_a_factura 'ED0002-20', '234568', 1
set @codigoProducto = '123456'

--sp_inserta_producto_a_factura @noFactura, @codigoProducto, 1

sp_inserta_producto_a_factura 'ED0002-20', '123489', 2



exec sp_listado_clientes_que_han_comprado
exec sp_facturacion_rango_fechas '2020-06-01', '2020-06-06'
exec sp_facturacion_rango_fechas_detalles '2020-06-01', '2020-06-06'
exec sp_facturacion_por_producto 'Zapatilla'
exec sp_facturacion_por_codigo_producto '123489'
exec sp_facturacion_por_cliente 'Carol'