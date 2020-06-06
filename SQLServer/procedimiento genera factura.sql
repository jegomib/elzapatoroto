-- Función para generar el numero de factura
create function fn_genera_no_factura()
  returns varchar(20)
as
begin
  declare @noFactura varchar(20)
  declare @consecutivo int
  declare @sConsecutivo varchar(4)
  set @noFactura = isnull((select top 1 noFactura from facturacion order by fecha desc), 'ED0000-' + cast((year(getdate()) % 2000) as varchar))
  set @consecutivo = cast(SUBSTRING(@noFactura, 3, 4) as int) + 1
  if cast(substring(@noFactura, 8, 2) as int) < (YEAR(getdate()) % 2000)
    set @consecutivo = 1
  set @sConsecutivo = CAST(@consecutivo as varchar)
  set @sConsecutivo = REPLACE(SPACE(4 - len(@sConsecutivo)) + @sConsecutivo, ' ', '0')
  set @noFactura = SUBSTRING(@noFactura, 1, 2) + @sConsecutivo + '-' + cast((year(getdate()) % 2000) as varchar)

  return @noFactura
end