CREATE SCHEMA Rappi;
USE RAPPI;

CREATE TABLE Repartidores(
id_repartidor int NOT NULL AUTO_INCREMENT,
Status_repartidor enum ('Activo','Inactivo'),
Nombre_apellido_repartidor varchar (50) UNIQUE, 
Mail_repartidor varchar (100) UNIQUE,
Direccion_repartidor varchar (100),
Fecha_nacimiento_repartidor date,
Fecha_registro_repartidor date,
Edad_repartidor int, 
Genero varchar (1),
PRIMARY KEY (id_repartidor)
);

CREATE TABLE Tiendas(
id_tienda int NOT NULL AUTO_INCREMENT,
Titular_tienda varchar(50),
Denominacion_social_tienda varchar (100) UNIQUE, 
Direccion_tienda varchar (30),
Telefono_tienda int,
Zona_tienda enum ('Recoleta','Caballito','Almagro','Colegiales'),
Mail_tienda varchar (50),  
PRIMARY KEY (id_tienda)
);

CREATE TABLE Productos(
id_producto int NOT NULL AUTO_INCREMENT, 
Nombre_producto varchar (40) UNIQUE,
Precio int, 
Categoria enum ('Alimentos y bebidas','Farmacia y cuidado personal','Hogar'),
PRIMARY KEY (id_producto)
);

CREATE TABLE Pagos(
id_pago int NOT NULL AUTO_INCREMENT, 
Fecha_pago date, 
Metodo_pago enum ('Tarjeta de credito', 'Tarjeta de debito', 'Efectivo'),
Monto int, 
PRIMARY KEY (id_pago)
);

CREATE TABLE Usuarios(
id_usuario int NOT NULL AUTO_INCREMENT, 
Nombre_apellido_usuario varchar (50) UNIQUE,
Mail_usuario varchar(100) UNIQUE, 
Telefono_usuario int, 
Direccion_usuario varchar (50), 
Edad_usuario int, 
Genero varchar (1),
Zona varchar (50),
Fecha_registro_usuario date, 
PRIMARY KEY (id_usuario)
);

CREATE TABLE Cancelaciones(
id_cancel int NOT NULL AUTO_INCREMENT, 
Motivo_cancel enum ('Falta disponibilidad repartidor', 'Cancelacion del usuario', 'Mal tiempo', 'Cancelacion de la tienda'), 
Costo_cancel int, 
Fecha_cancel date, 
Hora_cancel time, 
PRIMARY KEY (id_cancel)
);

CREATE TABLE Ordenes(
id_orden int NOT NULL AUTO_INCREMENT,
id_repartidor int NOT NULL,
id_tienda int NOT NULL, 
id_producto int NOT NULL, 
id_pago int NOT NULL UNIQUE,
id_usuario int NOT NULL,  
id_cancel int NOT NULL, 
Fecha_orden date,
Status_orden enum ('Entregada','Cancelada'),
Hora_entrega_orden time,  
PRIMARY KEY (id_orden),
FOREIGN KEY (id_repartidor) REFERENCES Repartidores (id_repartidor),
FOREIGN KEY (id_tienda) REFERENCES Tiendas (id_tienda),
FOREIGN KEY (id_producto) REFERENCES Productos (id_producto),
FOREIGN KEY (id_pago) REFERENCES Pagos (id_pago),
FOREIGN KEY (id_usuario) REFERENCES Usuarios (id_usuario),
FOREIGN KEY (id_cancel) REFERENCES Cancelaciones (id_cancel)
);