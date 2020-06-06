-- Este trigger lo que hace es que actualiza la cantidad del producto restándole la cantidad
-- que se vendió en la factura
create trigger tr_inventario_insertar_Salida
on inventario
after insert
as
begin
  if (select movimiento from inserted) = 'Salida'
  begin
	if (select cantidad from inserted) > (select cantidad from productos where codigo = (select codigo from inserted))
	begin
      raiserror ('La cantidad es mayor a lo que hay en almacén', 16, 1)
      rollback transaction
	end

	update productos set cantidad = cantidad - (select cantidad from inserted) where codigo = (select codigo from inserted)
  end
  
end