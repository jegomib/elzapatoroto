-- Este trigger lo que hace es que actualiza el precio del producto aumentándole un 40%
-- para que sea el precio de venta, y en el inventario se queda el precio original de entrada
create trigger tr_inventario_insertar_Entrada
on inventario
after insert
as
begin
  if (select movimiento from inserted) = 'Entrada'
  begin
	update productos set precio = (select precio * 1.4 from inserted) where codigo = (select codigo from inserted)
  end
  
end