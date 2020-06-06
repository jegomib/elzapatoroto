-- Trigger que se dispara cuando se inserta un registro en la tabla detallesFacturacion, 
-- la cual es donde se guardan los productos que se vendieron y corresponden a una factura
create trigger tr_detallesFacturacion_insertar
on detallesFacturacion
after insert
as
begin
  if (select cantidad from inserted) <= 0
  begin
    raiserror ('La cantidad debe ser mayor a cero', 16, 1)
    rollback transaction
  end
  
  if (select cantidad from inserted) > (select cantidad from productos where codigo = (select codigoProducto from inserted))
  begin
    raiserror ('La cantidad es mayor a lo que hay en almacen', 16, 1)
    rollback transaction
  end
  
  if (select precio from inserted) <= 0
  begin
    raiserror ('El precio debe ser mayor a cero', 16, 1)
    rollback transaction
  end
  
  update productos set cantidad = cantidad - (select cantidad from inserted)
  where codigo = (select codigoProducto from inserted)
  
  insert into inventario (codigo, movimiento, fecha, cantidad, precio)
  select codigoProducto, 'Salida', getDate(), cantidad, precio from inserted
end
