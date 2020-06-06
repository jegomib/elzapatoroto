-- Trigger que se dispara cuando se inserta un producto
create trigger tr_productos_insertar
on productos
after insert
as
begin
  if (select cantidad from inserted) < 0
  begin
    raiserror ('La cantidad debe ser igual o mayor a cero', 16, 1)
    rollback transaction
  end
  
  if (select precio from inserted) < 0
  begin
    raiserror ('El precio debe ser igual o mayor a cero', 16, 1)
    rollback transaction
  end
  
  insert into inventario(codigo, movimiento, fecha, cantidad, precio)
  select codigo, 'Entrada', getdate(), cantidad, precio from inserted
  
end