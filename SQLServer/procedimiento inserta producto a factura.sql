-- Procedimiento almacenado que inserta un producto a una factura
create procedure sp_inserta_producto_a_factura
@noFactura varchar(20), @codigoProducto varchar(10), @cantidad int
as
  if not exists(select *from productos where codigo = @codigoProducto)
  begin
    select 'El código de producto no existe en la base de datos'
    return
  end

  if not exists(select *from facturacion where noFactura = @noFactura)
  begin
    select 'Ese número de factura no existe en la base de datos'
    return
  end
  
  declare @precio float
  declare @descuento int
  
  set @descuento = (select descuento from facturacion where noFactura = @noFactura)
  set @precio = (select precio from productos where codigo = @codigoProducto)
  set @precio = @precio - ((@precio * @descuento) / 100)
  
  insert into detallesFacturacion (noFactura, codigoProducto, cantidad, precio)
  values(@noFactura, @codigoProducto, @cantidad, @precio)
