CREATE DATABASE airport_operations;
USE airport_operations;

-- CREACION DE LAS TABLAS 
CREATE TABLE aerolineas(
id_aerolinea INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (100) NOT NULL,
codigo_iata VARCHAR(5) NOT NULL,
pais_origen VARCHAR(50)
);
CREATE TABLE puertas_embarque(
id_puerta INT PRIMARY KEY AUTO_INCREMENT,
terminal VARCHAR(10) NOT NULL,
numero_puerta VARCHAR(10) NOT NULL,
estado VARCHAR(20) DEFAULT 'DISPONIBLE'
);
CREATE TABLE vuelos (
    id_vuelo INT AUTO_INCREMENT PRIMARY KEY,
    numero_vuelo VARCHAR(10) NOT NULL,
    id_aerolinea INT,
    origen VARCHAR(50),
    destino VARCHAR(50),
    fecha DATE,
    hora_programada TIME,
    hora_real TIME,
    id_puerta INT,
    estado VARCHAR(50),
    FOREIGN KEY (id_aerolinea) REFERENCES aerolineas(id_aerolinea),
    FOREIGN KEY (id_puerta) REFERENCES puertas_embarque(id_puerta)
);

CREATE TABLE operaciones_pista (
    id_operacion INT AUTO_INCREMENT PRIMARY KEY,
    id_vuelo INT,
    tipo_operacion VARCHAR(20), -- Aterrizaje / Despegue
    pista VARCHAR(10),
    hora_operacion TIME,
    FOREIGN KEY (id_vuelo) REFERENCES vuelos(id_vuelo)
);
CREATE TABLE retrasos (
    id_retraso INT AUTO_INCREMENT PRIMARY KEY,
    id_vuelo INT,
    causa VARCHAR(100),
    minutos INT,
    FOREIGN KEY (id_vuelo) REFERENCES vuelos(id_vuelo)
);
INSERT INTO aerolineas (nombre, codigo_iata, pais_origen) VALUES
('Iberia', 'IB', 'España'),
('Vueling', 'VY', 'España'),
('Air Europa', 'UX', 'España'),
('Ryanair', 'FR', 'Irlanda'),
('Lufthansa', 'LH', 'Alemania');

INSERT INTO puertas_embarque (terminal, numero_puerta, estado) VALUES
('A', 'A12', 'Disponible'),
('A', 'A14', 'Ocupada'),
('B', 'B03', 'Disponible'),
('B', 'B07', 'Mantenimiento'),
('C', 'C01', 'Disponible');

INSERT INTO vuelos (numero_vuelo, id_aerolinea, origen, destino, fecha, hora_programada, hora_real, id_puerta, estado) VALUES
('IB1234', 1, 'Madrid', 'Palma', '2026-01-03', '10:00', '10:15', 1, 'Retrasado'),
('VY5678', 2, 'Barcelona', 'Palma', '2026-01-03', '11:30', '11:30', 2, 'En horario'),
('UX9012', 3, 'Palma', 'Madrid', '2026-01-03', '12:00', '12:45', 3, 'Retrasado'),
('FR3456', 4, 'Palma', 'Berlin', '2026-01-03', '13:15', '13:20', 4, 'En horario'),
('LH7890', 5, 'Frankfurt', 'Palma', '2026-01-03', '14:00', '14:50', 5, 'Retrasado');

INSERT INTO operaciones_pista (id_vuelo, tipo_operacion, pista, hora_operacion) VALUES
(1, 'Aterrizaje', '06L', '10:20'),
(2, 'Aterrizaje', '06R', '11:35'),
(3, 'Despegue', '24L', '12:55'),
(4, 'Despegue', '24R', '13:25'),
(5, 'Aterrizaje', '06L', '14:55');

INSERT INTO retrasos (id_vuelo, causa, minutos) VALUES
(1, 'Clima', 15),
(3, 'Problema técnico', 45),
(5, 'Alta congestión', 50);

-- CONSULTAS DEL PROYECTO 'PUNTUALIDAD POR AEROLINEA' 
SELECT a.nombre AS aerolinea,
COUNT(v.id_vuelo) AS total_vuelos,
SUM(CASE WHEN v.estado = 'En horario' THEN 1 ELSE 0 END) AS vuelos_en_horario,
SUM(CASE WHEN v.estado = 'Retrasado' THEN 1 ELSE 0 END) AS vuelos_retrasados
FROM vuelos v
JOIN aerolineas a ON v.id_aerolinea = v.id_aerolinea
GROUP BY a.nombre;

-- SEGUNDA CONSULTA 'RETRASOS POR CAUSA' 
SELECT r.causa,
COUNT(*) AS cantidad,
SUM(r.minutos) AS minutos_totales,
AVG(r.minutos) AS promedio_minutos
FROM retrasos r
GROUP BY r.causa;

-- TERCERA CONSULTA 'MOVIMIENTO POR PISTA'
SELECT pista, tipo_operacion, COUNT(*) AS cantidad
FROM operaciones_pista
GROUP BY pista,tipo_operacion;