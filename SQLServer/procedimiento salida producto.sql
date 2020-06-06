create procedure sp_salida_producto 
@codigo varchar(10), @precio float, @cantidad int
as
  if @codigo is null or @codigo = ''
  begin
    select 'Debe indicar el código del producto'
    return
  end

  if @precio is null or @precio < 0
  begin
    select 'El precio debe ser mayor o igual a cero'
    return
  end

  if @cantidad is null or @cantidad < 0
  begin
    select 'La cantidad debe ser mayor o igual a cero'
    return
  end
  
  declare @cant float
  set @cant = isnull((select cantidad from productos where codigo = @codigo), 0) - @cantidad

  if @cant < 0
  begin
    select 'No hay esa cantidad en almacén'
    return
  end
  
  update productos set cantidad = @cant where codigo = @codigo

  insert into inventario (codigo, movimiento, fecha, cantidad, precio)
  values(@codigo, 'Salida', GETDATE(), @cantidad, @precio)
  