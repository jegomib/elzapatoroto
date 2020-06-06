-- Creación de la base de datos
-- create database ElZapatoRoto
use ElZapatoRoto

-- Tabla productos en donde se guarda un codigo de identificación como llave primaria, 
-- el campo valor será el calculado por el campo precio al haber una entrada de producto, la cual incluirá el precio
--create table productos(codigo varchar(10) primary key not null, nombre varchar(25) not null, descripcion varchar(100), presentacion varchar(25) not null, precio float not null, cantidad int not null)

--create table clientes(id int identity(1, 1) primary key not null, nombre varchar(80) not null, pais varchar(30) not null)

-- Tabla inventario es donde se tendrán todos los movimientos de entrada y salida de productos
--create table inventario(id int identity(1, 1) primary key not null, codigo varchar(10) not null, movimiento varchar(10) not null, fecha datetime not null, cantidad int not null, precio float)

--create table facturacion(noFactura varchar(20) primary key not null, idCliente int, impuestos float, fecha datetime, descuento int)
--create table detallesFacturacion(id int identity (1, 1) primary key not null, noFactura varchar(20) not null, codigoProducto varchar(10) not null, cantidad int not null, precio float)


select *from productos
select *from clientes
select *from inventario
select *from facturacion
select *from detallesFacturacion

--delete from productos
--delete from facturacion
--delete from detallesFacturacion
--dbcc checkident (detallesFacturacion, reseed, 0)
--delete from inventario
--dbcc checkident (inventario, reseed, 0)
--drop procedure sp_inserta_producto