DELIMITER //
CREATE FUNCTION Total_Ordenes_Entregadas(id_repartidor_param INT) RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE total_ordenes INT;
    DECLARE nombre_repartidor VARCHAR(50);
    DECLARE result VARCHAR(100);
    
    SELECT COUNT(*), r.Nombre_apellido_repartidor INTO total_ordenes, nombre_repartidor
    FROM Ordenes o
    JOIN Repartidores r ON o.id_repartidor = r.id_repartidor
    WHERE o.id_repartidor = id_repartidor_param AND o.Status_orden = 'Entregada'
    GROUP BY r.Nombre_apellido_repartidor;
    
    SET result = CONCAT('Total de órdenes entregadas: ', total_ordenes, ', Nombre del repartidor: ', nombre_repartidor);
    RETURN result;
END //
DELIMITER ;

SELECT Total_Ordenes_Entregadas(7) AS resultado; -- Ingresar ID algunos daran como NULL dado que me faltan mas registros--

DELIMITER //
CREATE FUNCTION Promedio_Edad_Usuarios(zona_param VARCHAR(50)) RETURNS DECIMAL(5,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE promedio_edad DECIMAL(5,2);

    SELECT AVG(Edad_usuario) INTO promedio_edad
    FROM Usuarios
    WHERE Zona = zona_param;

    RETURN promedio_edad;
END //
DELIMITER ;

SELECT Promedio_Edad_Usuarios('Recoleta') AS promedio_edad; -- Ingresar barrios de Recoleta, Almagro, Caballito o Agronomia--

DELIMITER //
CREATE FUNCTION Total_Tiendas_Zona(zona_param VARCHAR(50)) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_tiendas INT;

    SELECT COUNT(*) INTO total_tiendas
    FROM Tiendas
    WHERE Zona_tienda = zona_param;

    RETURN total_tiendas;
END //
DELIMITER ;

SELECT Total_Tiendas_Zona('Agronomia') AS total_tiendas; -- Ingresar barrios de Recoleta, Almagro, Caballito, Colegiales o Agronomia--

DELIMITER //
CREATE FUNCTION Detalles_Producto(id_orden_param INT) RETURNS VARCHAR(200)
READS SQL DATA
BEGIN
    DECLARE producto_info VARCHAR(200);
    DECLARE nombre_producto VARCHAR(40);
    DECLARE nombre_tienda VARCHAR(100);
    
    SELECT p.Nombre_producto, t.Denominacion_social_tienda INTO nombre_producto, nombre_tienda
    FROM Ordenes o
    INNER JOIN Productos p ON o.id_producto = p.id_producto
    INNER JOIN Tiendas t ON o.id_tienda = t.id_tienda
    WHERE o.id_orden = id_orden_param;
    
    SET producto_info = CONCAT('Nombre del producto: ', nombre_producto, ', Tienda: ', nombre_tienda);
    RETURN producto_info;
END //
DELIMITER ;


SELECT Detalles_Producto(20) AS 'Detalles orden'; -- Ingresar ID de la orden del 1 al 28--

