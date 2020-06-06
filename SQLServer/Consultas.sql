-- Consulta de facturaci�n de un cliente en espec�fico
create procedure sp_facturacion_por_cliente
@cliente varchar(80)
as
select f.noFactura as Factura, c.nombre as Cliente, c.pais as Pais, 
cast(f.fecha as date) as Fecha, p.codigo as 'C�digo producto', 
p.nombre as Producto, p.precio as Precio, df.cantidad as Cantidad,
(p.precio * df.cantidad) as 'Total', (((p.precio * df.cantidad) * f.impuestos) / 100) as 'Impuestos',
(p.precio * df.cantidad) + (((p.precio * df.cantidad) * f.impuestos) / 100) as 'Total con impuestos'
from facturacion f, detallesFacturacion df, productos p, clientes c
where f.noFactura = df.noFactura and df.codigoProducto = p.codigo and f.idCliente = c.id
and c.nombre = @cliente


-- Consulta de facturaci�n de un producto en espec�fico
create procedure sp_facturacion_por_producto
@producto varchar(25)
as
select df.noFactura as Factura, c.nombre as Cliente, c.pais as Pais, 
cast(f.fecha as date) as Fecha, p.codigo as 'C�digo producto', 
p.nombre as Producto, p.precio as Precio, df.cantidad as Cantidad,
(p.precio * df.cantidad) as 'Total', (((p.precio * df.cantidad) * f.impuestos) / 100) as 'Impuestos',
(p.precio * df.cantidad) + (((p.precio * df.cantidad) * f.impuestos) / 100) as 'Total con impuestos'
from facturacion f, detallesFacturacion df, productos p, clientes c
where f.noFactura = df.noFactura and df.codigoProducto = p.codigo and f.idCliente = c.id
and p.nombre = @producto


-- Consulta de facturaci�n de un producto en espec�fico por c�digo
create procedure sp_facturacion_por_codigo_producto
@codigo varchar(10)
as
select df.noFactura as Factura, c.nombre as Cliente, c.pais as Pais, 
cast(f.fecha as date) as Fecha, p.codigo as 'C�digo producto', 
p.nombre as Producto, p.precio as Precio, df.cantidad as Cantidad,
(p.precio * df.cantidad) as 'Total', (((p.precio * df.cantidad) * f.impuestos) / 100) as 'Impuestos',
(p.precio * df.cantidad) + (((p.precio * df.cantidad) * f.impuestos) / 100) as 'Total con impuestos'
from facturacion f, detallesFacturacion df, productos p, clientes c
where f.noFactura = df.noFactura and df.codigoProducto = p.codigo and f.idCliente = c.id
and p.codigo = @codigo


-- Consulta de facturaci�n por rango de fechas (s�lo facturas)
-- la fecha se env�a como un varchar
create procedure sp_facturacion_rango_fechas
@fecha1 varchar(10), @fecha2 varchar(10)
as
select f.noFactura as Factura, c.nombre as Cliente, c.pais as Pais, 
cast(f.fecha as date) as Fecha
from facturacion f, clientes c
where f.idCliente = c.id
and cast(f.fecha as DATE) between @fecha1 and @fecha2


-- Consulta de facturaci�n por rango de fechas (detalles facturas)
-- la fecha se env�a como un varchar
create procedure sp_facturacion_rango_fechas_detalles
@fecha1 varchar(10), @fecha2 varchar(10)
as
select f.noFactura as Factura, c.nombre as Cliente, c.pais as Pais, 
cast(f.fecha as date) as Fecha, p.codigo as 'C�digo producto', 
p.nombre as Producto, p.precio as Precio, df.cantidad as Cantidad,
(p.precio * df.cantidad) as 'Total', (((p.precio * df.cantidad) * f.impuestos) / 100) as 'Impuestos',
(p.precio * df.cantidad) + (((p.precio * df.cantidad) * f.impuestos) / 100) as 'Total con impuestos'
from facturacion f, detallesFacturacion df, productos p, clientes c
where f.noFactura = df.noFactura and df.codigoProducto = p.codigo and f.idCliente = c.id
and cast(f.fecha as DATE) between @fecha1 and @fecha2



-- Listado de clientes que han comprado al menos una vez
create procedure sp_listado_clientes_que_han_comprado
as
select c.nombre as Cliente, c.pais as Pais, COUNT(*) as 'Veces que han comprado' from facturacion f, clientes c
where f.idCliente = c.id
group by c.nombre, c.pais
