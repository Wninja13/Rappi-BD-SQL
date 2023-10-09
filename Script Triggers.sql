CREATE TABLE Log_Repartidores (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50),
    fecha DATE,
    hora TIME,
    accion VARCHAR(100)
);

CREATE TABLE Log_Ordenes (
    id_registro INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50),
    fecha DATE,
    hora TIME,
    accion VARCHAR(100)
);

/*Trigger 1 en Repartidores (BEFORE):

Controlará la acción de actualización en la tabla Repartidores.
Registrará en el Log_Repartidores el usuario que realiza la actualización, la fecha, la hora y la acción ("Actualización").
Antes de que se realice una actualización en la tabla Repartidores, se ejecutará este trigger y se insertará un registro en el Log_Repartidores.*/

DELIMITER //

CREATE TRIGGER Trigger_BeforeUpdate_Repartidores
BEFORE UPDATE ON Repartidores
FOR EACH ROW
BEGIN
    INSERT INTO Log_Repartidores (usuario, fecha, hora, accion)
    VALUES (USER(), CURDATE(), CURTIME(), 'Actualización');
END //

DELIMITER ;

/*Trigger 2 en Ordenes (AFTER):

Controlará la acción de inserción en la tabla Ordenes.
Registrará en el Log_Ordenes el usuario que realiza la inserción, la fecha, la hora y la acción ("Inserción").
Después de que se realice una inserción en la tabla Ordenes, se ejecutará este trigger y se insertará un registro en el Log_Ordenes.*/

DELIMITER //

CREATE TRIGGER Trigger_AfterInsert_Ordenes
AFTER INSERT ON Ordenes
FOR EACH ROW
BEGIN
    INSERT INTO Log_Ordenes (usuario, fecha, hora, accion)
    VALUES (USER(), CURDATE(), CURTIME(), 'Inserción');
END //

DELIMITER ;

UPDATE Repartidores
SET Status_repartidor = 'Inactivo'
WHERE id_repartidor = 1;

-- Registros en Log_Repartidores
SELECT * FROM Log_Repartidores;

-- Registros en Log_Ordenes
SELECT * FROM Log_Ordenes;
