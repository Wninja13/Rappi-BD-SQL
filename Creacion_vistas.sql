/*Vista para estadistica de repartidores. El objetivo de esta vista es saber la cantidad de repartidores 'activos' e 'inactivos' que se encuentran en la nomina de
la organizacion.*/
CREATE VIEW estadisticas_repartidores AS
SELECT
    (SELECT COUNT(*) FROM Repartidores WHERE Status_repartidor = 'Activo') AS RepartidoresActivos,
    (SELECT COUNT(*) FROM Repartidores WHERE Status_repartidor = 'Inactivo') AS RepartidoresInactivos
FROM
    dual;

/*Vista para conocer tiendas rentables. El objetivo d e esta vista es conocer las tiendas mas rentables en la que podemos visualizar su nombre e ingreso total.*/
CREATE VIEW tiendas_rentables AS
SELECT
    Tiendas.Denominacion_social_tienda,
    SUM(Productos.Precio) AS IngresosTotales
FROM
    Tiendas
JOIN Ordenes ON Tiendas.id_tienda = Ordenes.id_tienda
JOIN Productos ON Ordenes.id_producto = Productos.id_producto
GROUP BY Tiendas.Denominacion_social_tienda
ORDER BY IngresosTotales DESC;

/*Vista para estadistica de repartidores con mayor cantidad de entregas. El objetivo de esta vista es saber cual de todos los repartidores ha hecho mas entregas.*/
CREATE VIEW repartidores_con_mas_entregas AS
SELECT r.Nombre_apellido_repartidor, COUNT(*) AS Cantidad_Entregas
FROM Ordenes o
JOIN Repartidores r ON o.id_repartidor = r.id_repartidor
WHERE o.Status_orden = 'Entregada'
GROUP BY r.Nombre_apellido_repartidor
ORDER BY Cantidad_Entregas DESC;

/*Vista para estadistica de productos mas vendidos. El criterio utilizado fue la cantidad de productos que se vendieron.*/
CREATE VIEW productos_mas_vendidos AS
SELECT p.Nombre_producto, COUNT(*) AS Cantidad_Vendida
FROM Ordenes o
JOIN Productos p ON o.id_producto = p.id_producto
WHERE o.Status_orden = 'Entregada'
GROUP BY p.Nombre_producto
ORDER BY Cantidad_Vendida DESC;

/*Vista para estadistica de los productos mas rentables. En este caso el criterio utilizado fue el dinero que ingreso por cada prodcuto.*/
CREATE VIEW productos_mas_rentables AS
SELECT p.Nombre_producto, SUM(p.Precio) AS Ingreso_Total
FROM Ordenes o
JOIN Productos p ON o.id_producto = p.id_producto
GROUP BY p.Nombre_producto
ORDER BY Ingreso_Total DESC;

/*Vista para estadistica de cancelaciones. Para el futuro me gustaria hacerlo por años o periodos de tiempo.*/
CREATE VIEW cantidad_ordenes_canceladas AS
SELECT COUNT(*) AS CantidadCanceladas
FROM Ordenes
WHERE Status_orden = 'Cancelada';

/*Vista para estadistica de motivos de cancelaciones. La misma observacion que en el punto anterior.*/
CREATE VIEW cancelaciones_causas AS
SELECT COUNT(*) AS CantidadCanceladas, Motivo_cancel
FROM Ordenes
JOIN Cancelaciones ON Ordenes.id_cancel = Cancelaciones.id_cancel
WHERE Ordenes.Status_orden = 'Cancelada'
GROUP BY Motivo_cancel
ORDER BY CantidadCanceladas DESC
LIMIT 1;

/*Vista para estadistica de ganancias por tienda. */
CREATE VIEW ganancias_por_tienda AS
SELECT Tiendas.Denominacion_social_tienda, SUM (Pagos.Monto) AS Ganancias
FROM Ordenes
JOIN Pagos ON Ordenes.id_pago = Pagos.id_pago
JOIN Tiendas ON Ordenes.id_tienda = Tiendas.id_tienda
GROUP BY Tiendas.Denominacion_social_tienda;

/*Vista para estadistica de consumidores por genero y edad. Se busca conocer la edad promedio del consumidor de Rappi*/
CREATE VIEW promedio_edad_por_genero AS
SELECT Genero, AVG(Edad_usuario) AS PromedioEdad
FROM Usuarios
GROUP BY Genero;

/*Vista para estadistica de consumo. Encontraremos información de genero, gasto promedio y producto mas comprado.*/
CREATE VIEW estadisticas_consumo AS
SELECT
    Usuarios.Genero,
    AVG(Pagos.Monto) AS GastoPromedio,
    SUBSTRING_INDEX(GROUP_CONCAT(DISTINCT Productos.Nombre_producto ORDER BY Cantidad DESC SEPARATOR ', '), ',', 1) AS 'Producto mas consumido'
FROM
    Usuarios
JOIN Ordenes ON Usuarios.id_usuario = Ordenes.id_usuario
JOIN Pagos ON Ordenes.id_pago = Pagos.id_pago
JOIN (
    SELECT
        Ordenes.id_usuario,
        Ordenes.id_producto,
        COUNT(*) AS Cantidad
    FROM
        Ordenes
    GROUP BY Ordenes.id_usuario, Ordenes.id_producto
) AS Subconsulta ON Usuarios.id_usuario = Subconsulta.id_usuario
JOIN Productos ON Subconsulta.id_producto = Productos.id_producto
GROUP BY Usuarios.Genero;

/*Vista para estadistica de productos mas rentables. Encontraremos la categoria con su producto mas vendido y las ventas totales.*/
CREATE VIEW productos_rentables AS
SELECT
    Productos.Categoria,
    Productos.Nombre_producto,
    SUM(Productos.Precio) AS IngresosTotales
FROM
    Productos
JOIN Ordenes ON Productos.id_producto = Ordenes.id_producto
GROUP BY Productos.Categoria, Productos.Nombre_producto
HAVING IngresosTotales = (
    SELECT
        MAX(IngresosTotales)
    FROM
        (
            SELECT
                Productos.Categoria,
                Productos.Nombre_producto,
                SUM(Productos.Precio) AS IngresosTotales
            FROM
                Productos
            JOIN Ordenes ON Productos.id_producto = Ordenes.id_producto
            GROUP BY Productos.Categoria, Productos.Nombre_producto
        ) AS TotalesPorCategoria
    WHERE TotalesPorCategoria.Categoria = Productos.Categoria
)
ORDER BY Productos.Categoria;