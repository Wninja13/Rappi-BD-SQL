/*Stored Procedure para insertar un nuevo repartidor en la tabla "Repartidores"*/

DELIMITER //

CREATE PROCEDURE Insertar_Repartidor(
    IN status_param ENUM('Activo', 'Inactivo'),
    IN nombre_apellido_param VARCHAR(50),
    IN mail_param VARCHAR(100),
    IN direccion_param VARCHAR(100),
    IN fecha_nacimiento_param DATE,
    IN fecha_registro_param DATE,
    IN edad_param INT,
    IN genero_param VARCHAR(1)
)
BEGIN
    INSERT INTO Repartidores (Status_repartidor, Nombre_apellido_repartidor, Mail_repartidor, Direccion_repartidor, Fecha_nacimiento_repartidor, Fecha_registro_repartidor, Edad_repartidor, Genero)
    VALUES (status_param, nombre_apellido_param, mail_param, direccion_param, fecha_nacimiento_param, fecha_registro_param, edad_param, genero_param);
    
    SELECT LAST_INSERT_ID() AS id_repartidor;
END //

DELIMITER ;

CALL Insertar_Repartidor('Activo', 'Felix Ruano', 'felix@example.com', 'Calle 1928', '1991-01-01', '2022-01-01', 32, 'M');

/*Stored Procedure que permite indicar el campo de ordenamiento de una tabla y el tipo de orden mediante parametros. Para que funcione debe ponerse
en el parametro 'nombreDetabla' (por ejemplo: Ordenes) 'nombreDecampo' (por ejemplo: Status_orden) y ASC o DESC.*/

DELIMITER //

CREATE PROCEDURE Ordenar_Tabla(
    IN nombre_tabla_param VARCHAR(100),
    IN nombre_campo_param VARCHAR(100),
    IN tipo_orden_param VARCHAR(10)
)
BEGIN
    SET @ordenamiento = CONCAT(nombre_campo_param, ' ', tipo_orden_param);
    SET @query = CONCAT('SELECT * FROM ', nombre_tabla_param, ' ORDER BY ', @ordenamiento);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

CALL Ordenar_Tabla('ordenes', 'Status_orden', 'ASC');

DELIMITER //

CREATE PROCEDURE Actualizar_Estado_Repartidor(
    IN id_repartidor_param INT,
    IN nuevo_estado_param ENUM('Activo', 'Inactivo')
)
BEGIN
    UPDATE Repartidores
    SET Status_repartidor = nuevo_estado_param
    WHERE id_repartidor = id_repartidor_param;
    
    SELECT ROW_COUNT() AS filas_actualizadas;
END //

DELIMITER ;

CALL Actualizar_Estado_Repartidor(1, 'Activo');

DELIMITER //

CREATE PROCEDURE Insertar_Pagos()
BEGIN
    -- Primera fila
    INSERT INTO Pagos (Fecha_pago, Metodo_pago, Monto)
    VALUES ('2023-06-07', 'Tarjeta de crédito', 100);
    
    -- Segunda fila
    INSERT INTO Pagos (Fecha_pago, Metodo_pago, Monto)
    VALUES ('2023-06-08', 'Tarjeta de débito', 150);
    
    -- Tercera fila
    INSERT INTO Pagos (Fecha_pago, Metodo_pago, Monto)
    VALUES ('2023-06-09', 'Efectivo', 200);
END //

DELIMITER ;

CALL Insertar_Pagos();




