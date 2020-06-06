create procedure sp_compra_producto 
@codigo varchar(10), @nombre varchar(25), @descripcion varchar(100), @presentacion varchar(25), @precio float, @cantidad int
as
  if @codigo is null or @codigo = ''
  begin
    select 'Debe indicar el código del producto'
    return
  end

  if @nombre is null or @nombre = ''
  begin
    select 'Debe indicar el nombre del producto'
    return
  end

  if @presentacion is null or @presentacion = ''
  begin
    select 'Debe indicar una presentación para el producto'
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
  set @cant = @cantidad + isnull((select cantidad from productos where codigo = @codigo), 0)

  if not exists(select *from productos where codigo = @codigo)
  begin
    insert into productos (codigo, nombre, descripcion, presentacion, precio, cantidad)
    values(@codigo, @nombre, @descripcion, @presentacion, @precio, @cant)
  end
  else
    update productos set nombre = @nombre, descripcion = @descripcion, 
    presentacion = @presentacion, precio = @precio, cantidad = @cant
    where codigo = @codigo
  