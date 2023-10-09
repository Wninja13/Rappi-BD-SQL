# Desarrollo de base de datos Rappi plataforma de intermediación entre comercios gastronómicos y usuarios.

##Introducción.

####1.- Temática. 
La temática elegida para este proyecto es el modelo de negocios utilizado en las aplicaciones digitales conocidas popularmente como “apps de delivery”. En el caso concreto se tomó a la empresa Rappi. 

####1.- Objetivo.
El presente trabajo tendrá como principal objetivo el desarrollo de una base de datos que pueda ser utilizada en una plataforma digital que se dedica a la intermediación entre usuarios gastronómicos y los diversos establecimientos culinarios. Todo ello, facilitando su materialización permitiendo que una tercera parte (Rappi tendero) lleve de forma eficiente y rápida el pedido hecho por el cliente. 

Los datos que serán almacenados en la base de datos que se construirá como trabajo final tendrá como objetivo almacenar datos cuantitativos y cualitativos. Todo ello, a los efectos de poder determinar estrategias de carácter empresarial. 

####2.- Hipótesis. 

El objetivo del análisis que se llevará a cabo una vez finalizada la creación de la base de datos será analizar la tendencia de los consumidores, ya que el objetivo será poseer datos cualitativos tal como se señaló en el punto anterior. Todo ello, con un enfoque en los consumidores, su edad, género y zona donde estos residen. 
Asimismo, se intentará analizar si existe o no una preferencia respecto a un producto en particular, como así también si es posible determinar un índice de cancelaciones de órdenes respecto a las órdenes que son efectivamente entregadas. En adición a ello, lograr entender cuál es el tiempo promedio en que se recepta la orden y esta es entregada.

##Capítulo 2.

####1.- Objetivo.

El objetivo principal es la creación de una base de datos que pueda ser utilizada por la organización con un esquema de negocio similar a la aplicación Rappi. Asimismo, como objetivo general del proyecto se busca hacer consultas a la base de datos que nos permitan tomar mejores decisiones a la hora de lanzar campañas publicitarias, de descuentos o tomar decisiones estratégicas para robustecer la presencia de la empresa en ciertas zonas específicas donde la demanda de productos sea más elevada. 

2.- Segmento a quien estaría dirigido el producto final del proyecto y objetivos específicos de este. 
Sin perjuicio de que el producto final sería de utilización para la organización mencionada, la BD que se desarrolle se encuentra dirigida a los sectores estratégicos del negocio. Estos tomarán como base los datos vertidos en la BD para luego tomar decisiones estratégicas para el negocio. Tales como pueden ser: 

1.	Reclutar nuevos aliados gastronómicos (Restaurantes) acordes a las principales demandas del público. 

2.	Determinar cuáles son las áreas donde existe una mayor demanda. Buscando generar estímulos para que nuevos repartidores utilicen la plataforma para que funcione como nexo entre los usuarios, el repartidor y el consumidor final. 

3.	Poseer conocimiento de los usuarios a los efectos de determinar cuales son sus preferencias y apuntar adecuadamente los recursos de marketing, fidelización de la empresa. Entre otras campañas o futuros lanzamientos de ofertas. 

## Capítulo 3.

1.- Posibles entidades que encontrarán incluidas en la BD desarrollado. 

Las posibles entidades que formarían parte de la BD serían las siguientes: 
1.	Usuarios. 
2.	Repartidores. 
3.	Tiendas. 
4.	Productos. 
5.	Pagos.
6.	Órdenes. 


## Tabla de Contenidos

- [Desarrollo de base de datos Rappi plataforma de intermediación entre comercios gastronómicos y usuarios.](#desarrollo-de-base-de-datos-rappi-plataforma-de-intermediación-entre-comercios-gastronómicos-y-usuarios)
  - [Capítulo 3.](#capítulo-3)
  - [Tabla de Contenidos](#tabla-de-contenidos)
  - [Estructura de la Base de Datos](#estructura-de-la-base-de-datos)
    - [Usuarios.](#usuarios)
    - [Repartidores.](#repartidores)
    - [Tiendas.](#tiendas)
    - [Productos.](#productos)
    - [Pagos.](#pagos)
    - [Modelo a utilizar en la base de datos. (DB)](#modelo-a-utilizar-en-la-base-de-datos-db)
    - [Tablas](#tablas)
    - [Vistas](#vistas)
  - [Inserción de Registros](#inserción-de-registros)
  - [Triggers](#triggers)
  - [Stored Procedures](#stored-procedures)
  - [Funciones](#funciones)
  - [Cómo utilizar](#cómo-utilizar)
  - [Contacto](#contacto)

## Estructura de la Base de Datos
###Explicación DER. 
En este apartado se procederá a desgranar cada una de las entidades aquí presentadas y se explicará cada uno de sus atributos. 
###Órdenes. 
Esta entidad se describe cada una de las órdenes que se hacen mediante la aplicación. El código de identificación denominado como “Orden_ID” es el correspondiente a una venta efectuada en una fecha específica. 

#####Estructura de la tabla.

PK	Orden_ID	Int	Cada orden tiene un número asignado.
FK	Usuario_ID	Int. 	Cada usuario posee un número de identificación. Permite la relación con la entidad “Usuarios”. 
-	Monto_total	Int.	Monto total de la orden efectuada. 
FK	Tienda_ID	Int. 	Cada tienda posee un número de identificación. Permite la relación con la entidad “Tienda”. 
-	Fecha	Date	Fecha en que se hizo la orden. 
-	Status_orden	Varchar	Estado de la orden.

### Usuarios. 
La entidad usuarios posee datos de los usuarios que utilizan la aplicación y efectúan pedidos mediante la aplicación. 

#####Estructura de la tabla.

PK	Usuario_ID	Int.	Cada usuario posee un número asignado.
FK	Orden_ID	Int.	Numero que identifica la orden y funciona para relacionarla con la entidad“Ordenes”.
FK	Repartidor_ID	Int.	Número que identifica al repartidor asignado y la relaciona con la entidad “Repartidores”.
-	Nombre	Varchar	Nombre y apellido del usuario.
-	Mail	Varchar	Correo electrónico del usuario
-	Teléfono	Int.	Número de contacto.
-	Dirección	Varchar	Dirección con altura del domicilio.

### Repartidores. 
Esta entidad contiene información sobre los repartidores que será asociado a un usuario y órdenes. Cada uno de ellos tiene asignado ID, mediante por el cual, se identifica a cada uno de ellos. 

#####Estructura de la tabla.

PK	Repartidor_ID	Int.	Código numérico para identificar a cada repartidor.
FK	Orden_ID	Int.	Número que identifica la orden y funciona para relacionarla con la entidad “Ordenes”.
FK	Usuario_ID	Int.	Cada usuario posee un número de identificación. Permite la relación con la entidad “Usuarios”.
-	Fecha	Date	Fecha en que el repartidor toma la orden.
-	Status_repartidor	Varchar	Activo o inactivo dependiendo cantidad de órdenes tomadas en el mes.

### Tiendas. 
La entidad contiene información de cada una de las tiendas o “aliados” que reciben las órdenes de los usuarios y luego son entregados por los repartidores en los domicilios indicados. 

#####Estructura de la tabla.

PK	Tienda_ID	Int. 	Número que identifica de forma única a cada una de las tiendas. 
FK	Orden_ID	Int.	Número que identifica cada una de las órdenes. Permite la relación con la entidad “Ordenes”. 
-	Nombre	Varchar	Nombre de cada una de las tiendas.
-	Dirección	Varchar	Dirección de la tienda con su altura.
-	Teléfono	Int. 	Número de contacto de la tienda. 
-	Zona	Varchar	Zona donde se encuentra la tienda. 

### Productos. 
Esta entidad contiene cada uno de los productos que se encuentran catalogados en la aplicación y que son susceptibles de ser comprados por los usuarios. Dichos productos deben ser ofrecidos por las tiendas que se encuentran en la aplicación. 


#####Estructura de la tabla.

PK	Producto_ID	Int.	Número que individualiza a cada producto.
FK	Orden_ID	Int.	Numero que individualiza cada orden. Funciona para relacionar la entidad “Productos” con la entidad “Ordenes”.
FK	Tienda_ID	Int.	Número identificatorio de la tienda. Relaciona la entidad con la entidad “Tiendas”.
-	Nombre_producto	Varchar	Nombre del producto.
-	Cantidad	Int.	Cantidad de producto por orden.
-	Precio	Int.	Valor de cada unidad.

### Pagos. 
En esta entidad se guardan los datos referenciados a los pagos efectuados por los usuarios en las compras efectuadas en los establecimientos gastronómicos.

#####Estructura de la tabla.

PK	Pago_ID	Int.	Es la identificación numérica de cada uno de los pagos efectuados.
FK	Usuario_ID	Int.	Identificación de cada uno de los usuarios y relaciona con la entidad “Usuarios”.
FK	Orden_ID	Int.	Identificación numérica de cada una de las órdenes y permite relacionarse con la entidad “Ordenes”.
-	Fecha	Date	Fecha en la que se efectuó el pago.
-	Método_pago	Varchar	Forma en la que se efectuó el pago de la orden.
-	Monto	Int.	Valor final de la compra efectuada.

### Modelo a utilizar en la base de datos. (DB)

Ante las interrogantes planteadas en capítulos anteriores y habiendo analizado y descripto el negocio debemos elegir un modelo adecuado para hacer las consultas que consideremos para el proceso que estamos analizando. Además de ello, debemos destacar que existen medidas cuantificables asociadas a estos.  

Atento, a ello, como esquema de desarrollo de la base de datos en primer lugar hemos decidido desarrollar en SQL una tabla de hecho. En este caso, es la tabla “órdenes” dado que se identifica como un proceso nuclear del negocio de Rappi. Siendo a siempre vista que las órdenes son una operación vital y cotidiana para la organización, hemos considerado. Por ello, se ha decidido tomar como tabla de hecho este elemento de la base de datos al momento de desarrollarla. 

Teniendo en cuenta esto. Se ha considerado necesario crear tablas de dimensión que jugaran como vistas del proceso de ventas de la aplicación. Asimismo, la base de datos poseerá indicadores de un proceso del negocio, los cuales, son cuantificables y nos permitirán medir nuestro proceso de negocios, tales como podrían ser los importes, las fechas etc. 

Habiendo analizado todas estas cuestiones. Se ha considerado que para como esquema para estructurar los datos el más óptimo es el esquema en estrella. 
En el centro de este, tendremos una tabla de hechos que será la tabla de “ordenes”. Alrededor de esta tendremos las tablas de dimensión “pagos”, “repartidores”, “productos”, “usuarios”, “tiendas” y “cancelaciones”. 

### Tablas

- **NombreTabla1**: Breve descripción de la tabla y su función principal.
  - `Campo1`: Descripción del campo (Tipo de dato).
  - `Campo2`: Descripción del campo (Tipo de dato).
  - ...
  
- **NombreTabla2**: Descripción...
  - ...

(Repite este esquema para cada tabla)

### Vistas

- **NombreVista1**: Breve descripción de la vista y su función principal.
- **NombreVista2**: Descripción...

(Repite para cada vista)

## Inserción de Registros

Descripción de los scripts utilizados para la inserción de registros en las tablas, tal vez un ejemplo de uso o una mención a las tablas principales que afectan.

## Triggers

- **NombreTrigger1**: Descripción del trigger, qué acción provoca su activación y qué cambios o acciones realiza.
- **NombreTrigger2**: ...

(Repite para cada trigger)

## Stored Procedures

- **NombreSP1**: Descripción del procedimiento almacenado, su función y posiblemente los parámetros que acepta.
- **NombreSP2**: ...

(Repite para cada stored procedure)

## Funciones

- **NombreFuncion1**: Descripción de la función, su propósito y posiblemente los parámetros que acepta y el tipo de retorno.
- **NombreFuncion2**: ...

(Repite para cada función)

## Cómo utilizar

1. Paso 1: Descripción de cómo instalar o configurar la base de datos.
2. Paso 2: ...
3. ...

## Contacto

Información de contacto, en caso de que alguien quiera obtener más detalles o informar sobre algún problema.
