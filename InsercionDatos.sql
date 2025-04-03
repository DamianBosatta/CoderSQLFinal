-- 1. Insertar datos en la tabla Roles
INSERT INTO Roles (nombre, descripcion, permisos) VALUES
('Administrador', 'Acceso completo al sistema', '{"todos": true}'),
('Gerente', 'Gestión de operaciones y personal', '{"ventas": true, "inventario": true, "logistica": true}'),
('Vendedor', 'Atención al cliente y ventas', '{"ventas": true}'),
('Almacenista', 'Gestión de inventario', '{"inventario": true}'),
('Conductor', 'Repartidor y entregas', '{"envios": true}'),
('Compras', 'Gestión de proveedores y compras', '{"compras": true}');

-- 2. Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (nombre, apellido, email, nombre_usuario, password_hash, rol_id, telefono, fecha_creacion, estado) VALUES
('Juan', 'Pérez', 'juan.perez@empresa.com', 'jperez', SHA2('admin123', 256), 1, '5551234567', NOW(), 'activo'),
('María', 'Gómez', 'maria.gomez@empresa.com', 'mgomez', SHA2('gerente456', 256), 2, '5552345678', NOW(), 'activo'),
('Carlos', 'López', 'carlos.lopez@empresa.com', 'clopez', SHA2('vendedor789', 256), 3, '5553456789', NOW(), 'activo'),
('Ana', 'Martínez', 'ana.martinez@empresa.com', 'amartinez', SHA2('almacen123', 256), 4, '5554567890', NOW(), 'activo'),
('Pedro', 'Sánchez', 'pedro.sanchez@empresa.com', 'psanchez', SHA2('conductor456', 256), 5, '5555678901', NOW(), 'activo'),
('Laura', 'Rodríguez', 'laura.rodriguez@empresa.com', 'lrodriguez', SHA2('compras789', 256), 6, '5556789012', NOW(), 'activo');

-- 3. Insertar datos en la tabla Almacenes
INSERT INTO Almacenes (nombre, tipo, direccion, ciudad, estado_provincia, codigo_postal, pais, telefono, capacidad_total, capacidad_utilizada, gerente_id, estado) VALUES
('Almacén Central', 'principal', 'Av. Industrial 123', 'Ciudad de México', 'CDMX', '12345', 'México', '5551234000', 10000.00, 6500.00, 2, 'activo'),
('Almacén Norte', 'secundario', 'Calle Norte 456', 'Monterrey', 'Nuevo León', '54321', 'México', '5554321000', 5000.00, 3200.00, 2, 'activo'),
('Almacén Sur', 'secundario', 'Boulevard Sur 789', 'Guadalajara', 'Jalisco', '67890', 'México', '5555678000', 5000.00, 2800.00, 2, 'activo');

-- Actualizar usuarios con almacenes asignados
UPDATE Usuarios SET almacen_asignado_id = 1 WHERE usuario_id = 4;
UPDATE Usuarios SET almacen_asignado_id = 2 WHERE usuario_id = 5;
UPDATE Usuarios SET almacen_asignado_id = 3 WHERE usuario_id = 6;

-- 4. Insertar datos en la tabla Ubicaciones_Almacen
INSERT INTO Ubicaciones_Almacen (almacen_id, zona, pasillo, estante, nivel, posicion, codigo_ubicacion, capacidad_max, tipo_producto, refrigerada, estado) VALUES
-- Almacén Central
(1, 'A', '1', 'A', '1', '1', 'A-1-A-1-1', 100.00, 'general', FALSE, 'activo'),
(1, 'A', '1', 'A', '2', '1', 'A-1-A-2-1', 100.00, 'general', FALSE, 'activo'),
(1, 'B', '2', 'B', '1', '1', 'B-2-B-1-1', 150.00, 'fragil', FALSE, 'activo'),
(1, 'C', '3', 'C', '1', '1', 'C-3-C-1-1', 80.00, 'perecedero', TRUE, 'activo'),
-- Almacén Norte
(2, 'A', '1', 'A', '1', '1', 'N-A-1-A-1-1', 120.00, 'general', FALSE, 'activo'),
(2, 'B', '2', 'B', '1', '1', 'N-B-2-B-1-1', 90.00, 'fragil', FALSE, 'activo'),
-- Almacén Sur
(3, 'A', '1', 'A', '1', '1', 'S-A-1-A-1-1', 110.00, 'general', FALSE, 'activo'),
(3, 'B', '2', 'B', '1', '1', 'S-B-2-B-1-1', 70.00, 'perecedero', TRUE, 'activo');

-- 5. Insertar datos en la tabla Categorias_Productos
INSERT INTO Categorias_Productos (nombre, descripcion, categoria_padre_id) VALUES
('Electrónicos', 'Productos electrónicos y dispositivos', NULL),
('Computación', 'Equipos de computación y accesorios', 1),
('Telefonía', 'Teléfonos y accesorios móviles', 1),
('Hogar', 'Artículos para el hogar', NULL),
('Electrodomésticos', 'Electrodomésticos mayores y menores', 4),
('Muebles', 'Muebles para el hogar', 4),
('Oficina', 'Artículos de oficina', NULL),
('Papelería', 'Material de papelería', 7),
('Suministros', 'Suministros de oficina', 7);

-- 6. Insertar datos en la tabla Proveedores
INSERT INTO Proveedores (nombre_empresa, contacto_nombre, contacto_cargo, email, telefono, direccion, ciudad, estado_provincia, codigo_postal, pais, categoria, condiciones_pago, tiempo_entrega, calificacion, estado) VALUES
('TecnoSuministros', 'Roberto Jiménez', 'Gerente de Ventas', 'ventas@tecnosuministros.com', '5551112233', 'Av. Tecnológica 456', 'Ciudad de México', 'CDMX', '54321', 'México', 'electrónicos', '30 días', 5, 4.8, 'activo'),
('MueblesPremium', 'Sofía Hernández', 'Coordinadora Comercial', 'comercial@mueblespremium.com', '5552223344', 'Calle Madera 789', 'Guadalajara', 'Jalisco', '67890', 'México', 'muebles', '15 días', 7, 4.5, 'activo'),
('ElectroHogar', 'Miguel Ángel Castro', 'Director Comercial', 'mcastro@electrohogar.com', '5553334455', 'Boulevard Electrodomésticos 101', 'Monterrey', 'Nuevo León', '11223', 'México', 'electrodomésticos', '30 días', 10, 4.2, 'activo'),
('PapeleriaTotal', 'Lucía Mendoza', 'Ejecutiva de Cuentas', 'lmendoza@papeleria.com', '5554445566', 'Calle Papel 202', 'Puebla', 'Puebla', '22334', 'México', 'papelería', '7 días', 3, 4.9, 'activo');

-- 7. Insertar datos en la tabla Productos
INSERT INTO Productos (nombre, descripcion, codigo_sku, codigo_barras, categoria_id, proveedor_id, unidad_medida, precio_compra, precio_venta, peso, largo, ancho, alto, es_perecedero, es_fragil, estado) VALUES
-- Electrónicos
('Laptop EliteBook', 'Laptop de 15 pulgadas, 16GB RAM, 512GB SSD', 'LP-ELT-001', '123456789012', 2, 1, 'unidad', 12000.00, 15999.00, 1.8, 35.0, 24.0, 2.5, FALSE, TRUE, 'activo'),
('Smartphone X10', 'Teléfono inteligente 128GB, cámara triple', 'SP-X10-001', '234567890123', 3, 1, 'unidad', 6000.00, 8999.00, 0.2, 15.0, 7.5, 0.8, FALSE, TRUE, 'activo'),
('Tablet Pro', 'Tablet de 10 pulgadas, 64GB', 'TB-PRO-001', '345678901234', 2, 1, 'unidad', 3500.00, 4999.00, 0.5, 24.0, 16.0, 0.7, FALSE, TRUE, 'activo'),
-- Hogar
('Sofá 3 Plazas', 'Sofá moderno para sala, tela resistente', 'SF-3PL-001', '456789012345', 6, 2, 'unidad', 4500.00, 6999.00, 25.0, 180.0, 90.0, 80.0, FALSE, FALSE, 'activo'),
('Mesa de Centro', 'Mesa de centro de madera maciza', 'MC-MAD-001', '567890123456', 6, 2, 'unidad', 2000.00, 3499.00, 12.0, 100.0, 60.0, 45.0, FALSE, FALSE, 'activo'),
-- Electrodomésticos
('Refrigerador 2 Puertas', 'Refrigerador eficiente 18 pies cúbicos', 'RF-2PT-001', '678901234567', 5, 3, 'unidad', 8000.00, 11999.00, 70.0, 170.0, 75.0, 75.0, FALSE, TRUE, 'activo'),
('Licuadora Profesional', 'Licuadora de 1000W con 6 velocidades', 'LC-PRO-001', '789012345678', 5, 3, 'unidad', 800.00, 1299.00, 3.5, 30.0, 20.0, 40.0, FALSE, TRUE, 'activo'),
-- Oficina
('Paquete de Hojas A4', '500 hojas blancas tamaño carta', 'PH-A4-500', '890123456789', 8, 4, 'paquete', 50.00, 99.00, 2.5, 30.0, 21.0, 5.0, FALSE, FALSE, 'activo'),
('Bolígrafos Negros', 'Paquete con 12 bolígrafos de tinta negra', 'BG-NEG-12', '901234567890', 8, 4, 'paquete', 30.00, 59.00, 0.3, 15.0, 5.0, 5.0, FALSE, FALSE, 'activo');

-- 8. Insertar datos en la tabla Inventario
INSERT INTO Inventario (producto_id, almacen_id, ubicacion_id, cantidad, stock_minimo, stock_maximo, fecha_ultima_actualizacion, lote, fecha_vencimiento, estado) VALUES
-- Almacén Central
(1, 1, 3, 15, 5, 30, NOW(), 'LOTE-2023-001', NULL, 'disponible'),
(2, 1, 3, 25, 10, 50, NOW(), 'LOTE-2023-002', NULL, 'disponible'),
(3, 1, 3, 18, 8, 40, NOW(), 'LOTE-2023-003', NULL, 'disponible'),
(6, 1, 4, 5, 2, 10, NOW(), 'LOTE-2023-004', '2025-12-31', 'disponible'),
(7, 1, 3, 12, 5, 25, NOW(), 'LOTE-2023-005', NULL, 'disponible'),
-- Almacén Norte
(4, 2, 5, 8, 3, 15, NOW(), 'LOTE-2023-006', NULL, 'disponible'),
(5, 2, 5, 10, 4, 20, NOW(), 'LOTE-2023-007', NULL, 'disponible'),
-- Almacén Sur
(8, 3, 7, 30, 10, 100, NOW(), 'LOTE-2023-008', '2024-06-30', 'disponible'),
(9, 3, 7, 45, 15, 120, NOW(), 'LOTE-2023-009', '2024-12-31', 'disponible');

-- 9. Insertar datos en la tabla Clientes
INSERT INTO Clientes (nombre, apellido, empresa, tipo_cliente, email, telefono, direccion, ciudad, estado_provincia, codigo_postal, pais, fecha_registro, limite_credito, estado, segmento) VALUES
('Alejandro', 'García', 'TechSolutions SA', 'corporativo', 'agarcia@techsolutions.com', '5559876543', 'Av. Tecnológica 789', 'Ciudad de México', 'CDMX', '54321', 'México', '2023-01-15', 50000.00, 'activo', 'grandes_cuentas'),
('Mariana', 'López', NULL, 'individual', 'mariana.lopez@mail.com', '5558765432', 'Calle Flores 123', 'Guadalajara', 'Jalisco', '44100', 'México', '2023-02-20', 10000.00, 'activo', 'consumidor_final'),
('Roberto', 'Martínez', 'OficinaCreativa', 'corporativo', 'rmartinez@oficinacreativa.com', '5557654321', 'Boulevard Diseño 456', 'Monterrey', 'Nuevo León', '64000', 'México', '2023-03-10', 30000.00, 'activo', 'medianas_empresas'),
('Laura', 'Sánchez', NULL, 'individual', 'laura.sanchez@mail.com', '5556543210', 'Calle Jardín 789', 'Puebla', 'Puebla', '72000', 'México', '2023-04-05', 8000.00, 'activo', 'consumidor_final'),
('Carlos', 'Hernández', 'HogarModerno', 'corporativo', 'chernandez@hogarmoderno.com', '5555432109', 'Av. Confort 101', 'Querétaro', 'Querétaro', '76000', 'México', '2023-05-12', 40000.00, 'activo', 'grandes_cuentas');

-- 10. Insertar datos en la tabla Vehiculos
INSERT INTO Vehiculos (tipo, marca, modelo, anio, placa, capacidad_peso, capacidad_volumen, fecha_adquisicion, fecha_ultimo_mantenimiento, kilometraje, estado, notas) VALUES
('Camioneta', 'Ford', 'Transit', 2021, 'ABC1234', 1500.00, 12.00, '2021-03-15', '2023-06-20', 45000, 'disponible', 'Vehiculo principal para repartos'),
('Camión', 'Mercedes', 'Sprinter', 2020, 'DEF5678', 3000.00, 20.00, '2020-05-10', '2023-07-15', 60000, 'disponible', 'Para entregas grandes'),
('Camioneta', 'Nissan', 'NV200', 2022, 'GHI9012', 1000.00, 8.00, '2022-02-20', '2023-05-10', 25000, 'mantenimiento', 'En taller por revisión'),
('Motocicleta', 'Honda', 'CB190', 2023, 'JKL3456', 150.00, 1.50, '2023-01-05', '2023-08-01', 5000, 'disponible', 'Para entregas rápidas en ciudad');

-- 11. Insertar datos en la tabla Rutas
INSERT INTO Rutas (nombre, origen_id, zona_cobertura, distancia_total, tiempo_estimado, frecuencia, horario_salida, costo_estimado, estado) VALUES
('Ruta Centro CDMX', 1, 'Centro de Ciudad de México', 50.00, 120, 'diaria', '08:00:00', 1500.00, 'activo'),
('Ruta Norte Monterrey', 2, 'Área metropolitana de Monterrey', 80.00, 180, 'diaria', '07:30:00', 2000.00, 'activo'),
('Ruta Sur Guadalajara', 3, 'Zona centro de Guadalajara', 60.00, 150, 'diaria', '09:00:00', 1800.00, 'activo'),
('Ruta Interurbana', 1, 'Ciudades cercanas a CDMX', 200.00, 300, 'semanal', '06:00:00', 3500.00, 'activo');

-- 12. Insertar datos en la tabla Puntos_Ruta
INSERT INTO Puntos_Ruta (ruta_id, secuencia, tipo_punto, direccion, ciudad, codigo_postal, latitud, longitud, tiempo_estimado_llegada, tiempo_parada, notas) VALUES
-- Ruta Centro CDMX
(1, 1, 'origen', 'Av. Industrial 123', 'Ciudad de México', '12345', 19.432601, -99.133204, '08:00:00', 0, 'Salida desde almacén'),
(1, 2, 'parada', 'Av. Reforma 500', 'Ciudad de México', '06600', 19.426045, -99.167845, '08:30:00', 15, 'Entrega zona financiera'),
(1, 3, 'parada', 'Calle Madero 25', 'Ciudad de México', '06000', 19.433962, -99.140103, '09:15:00', 10, 'Zona centro histórico'),
(1, 4, 'destino', 'Av. Juárez 100', 'Ciudad de México', '06050', 19.435521, -99.149991, '10:00:00', 0, 'Última entrega'),
-- Ruta Norte Monterrey
(2, 1, 'origen', 'Calle Norte 456', 'Monterrey', '54321', 25.686613, -100.316116, '07:30:00', 0, 'Salida desde almacén'),
(2, 2, 'parada', 'Av. Constitución 2000', 'Monterrey', '64000', 25.675071, -100.318458, '08:15:00', 20, 'Zona comercial'),
(2, 3, 'destino', 'Av. Morones Prieto 3000', 'Monterrey', '64100', 25.668511, -100.385389, '09:00:00', 0, 'Entrega final');

-- 13. Insertar datos en la tabla Ventas
INSERT INTO Ventas (fecha_venta, cliente_id, usuario_id, tipo_venta, subtotal, impuestos, descuento, total, metodo_pago, estado_pago, estado_venta) VALUES
('2023-06-10 10:30:00', 1, 3, 'online', 15999.00, 2559.84, 0.00, 18558.84, 'tarjeta', 'pagado', 'completada'),
('2023-06-12 14:15:00', 2, 3, 'presencial', 4999.00, 799.84, 250.00, 5548.84, 'efectivo', 'pagado', 'completada'),
('2023-06-15 11:00:00', 3, 3, 'online', 3499.00, 559.84, 0.00, 4058.84, 'transferencia', 'pagado', 'completada'),
('2023-06-18 16:45:00', 4, 3, 'presencial', 1299.00, 207.84, 65.00, 1441.84, 'efectivo', 'pagado', 'completada'),
('2023-06-20 09:30:00', 5, 3, 'online', 11999.00, 1919.84, 600.00, 13318.84, 'tarjeta', 'pagado', 'completada'),
('2023-06-22 13:20:00', 1, 3, 'online', 8999.00, 1439.84, 450.00, 9988.84, 'tarjeta', 'pendiente', 'procesando'),
('2023-06-25 15:10:00', 2, 3, 'presencial', 99.00, 15.84, 0.00, 114.84, 'efectivo', 'pagado', 'completada');

-- 14. Insertar datos en la tabla Detalles_Venta
INSERT INTO Detalles_Venta (venta_id, producto_id, cantidad, precio_unitario, descuento, subtotal, impuesto, total) VALUES
(1, 1, 1, 15999.00, 0.00, 15999.00, 2559.84, 18558.84),
(2, 3, 1, 4999.00, 250.00, 4749.00, 799.84, 5548.84),
(3, 5, 1, 3499.00, 0.00, 3499.00, 559.84, 4058.84),
(4, 7, 1, 1299.00, 65.00, 1234.00, 207.84, 1441.84),
(5, 6, 1, 11999.00, 600.00, 11399.00, 1919.84, 13318.84),
(6, 2, 1, 8999.00, 450.00, 8549.00, 1439.84, 9988.84),
(7, 8, 1, 99.00, 0.00, 99.00, 15.84, 114.84);

-- 15. Insertar datos en la tabla Compras
INSERT INTO Compras (fecha_compra, proveedor_id, usuario_id, numero_orden, fecha_entrega_estimada, subtotal, impuestos, descuento, total, estado_compra, estado_pago, almacen_destino_id) VALUES
('2023-05-01 09:00:00', 1, 6, 'OC-2023-001', '2023-05-06', 21500.00, 3440.00, 1000.00, 23940.00, 'completada', 'pagado', 1),
('2023-05-10 10:30:00', 2, 6, 'OC-2023-002', '2023-05-17', 6500.00, 1040.00, 300.00, 7240.00, 'completada', 'pagado', 2),
('2023-05-15 14:00:00', 3, 6, 'OC-2023-003', '2023-05-25', 8800.00, 1408.00, 400.00, 9808.00, 'completada', 'pagado', 1),
('2023-05-20 11:15:00', 4, 6, 'OC-2023-004', '2023-05-23', 80.00, 12.80, 0.00, 92.80, 'completada', 'pagado', 3),
('2023-05-25 16:45:00', 1, 6, 'OC-2023-005', '2023-05-30', 9500.00, 1520.00, 500.00, 10520.00, 'procesando', 'pendiente', 1);

-- 16. Insertar datos en la tabla Detalles_Compra
INSERT INTO Detalles_Compra (compra_id, producto_id, cantidad, precio_unitario, descuento, subtotal, impuesto, total, cantidad_recibida, estado) VALUES
(1, 1, 5, 12000.00, 500.00, 60000.00, 9600.00, 69600.00, 5, 'recibido'),
(1, 2, 10, 6000.00, 500.00, 60000.00, 9600.00, 69600.00, 10, 'recibido'),
(2, 4, 3, 4500.00, 300.00, 13500.00, 2160.00, 15660.00, 3, 'recibido'),
(3, 6, 2, 8000.00, 400.00, 16000.00, 2560.00, 18560.00, 2, 'recibido'),
(4, 8, 2, 50.00, 0.00, 100.00, 16.00, 116.00, 2, 'recibido'),
(5, 3, 5, 3500.00, 500.00, 17500.00, 2800.00, 20300.00, 0, 'pendiente');

-- 17. Insertar datos en la tabla Movimientos_Inventario
INSERT INTO Movimientos_Inventario (producto_id, almacen_id, tipo_movimiento, cantidad, fecha_movimiento, usuario_id, referencia_id, tipo_referencia, notas) VALUES
-- Entradas por compras
(1, 1, 'entrada', 5, '2023-05-06 11:00:00', 4, 1, 'compra', 'Entrada por compra OC-2023-001'),
(2, 1, 'entrada', 10, '2023-05-06 11:00:00', 4, 1, 'compra', 'Entrada por compra OC-2023-001'),
(4, 2, 'entrada', 3, '2023-05-17 10:30:00', 4, 2, 'compra', 'Entrada por compra OC-2023-002'),
(6, 1, 'entrada', 2, '2023-05-25 14:45:00', 4, 3, 'compra', 'Entrada por compra OC-2023-003'),
(8, 3, 'entrada', 2, '2023-05-23 09:15:00', 4, 4, 'compra', 'Entrada por compra OC-2023-004'),
-- Salidas por ventas
(1, 1, 'salida', 1, '2023-06-10 11:30:00', 3, 1, 'venta', 'Salida por venta #1'),
(3, 1, 'salida', 1, '2023-06-12 15:00:00', 3, 2, 'venta', 'Salida por venta #2'),
(5, 2, 'salida', 1, '2023-06-15 12:00:00', 3, 3, 'venta', 'Salida por venta #3'),
(7, 1, 'salida', 1, '2023-06-18 17:30:00', 3, 4, 'venta', 'Salida por venta #4'),
(6, 1, 'salida', 1, '2023-06-20 10:30:00', 3, 5, 'venta', 'Salida por venta #5'),
(2, 1, 'salida', 1, '2023-06-22 14:00:00', 3, 6, 'venta', 'Salida por venta #6'),
(8, 3, 'salida', 1, '2023-06-25 16:00:00', 3, 7, 'venta', 'Salida por venta #7');

-- 18. Insertar datos en la tabla Envios
INSERT INTO Envios (venta_id, fecha_creacion, fecha_envio, fecha_entrega_estimada, fecha_entrega_real, estado_envio, vehiculo_id, ruta_id, conductor_id, numero_seguimiento, costo_envio) VALUES
(1, '2023-06-10 11:00:00', '2023-06-10 14:00:00', '2023-06-12', '2023-06-12 10:30:00', 'entregado', 1, 1, 5, 'ENV-001-001', 250.00),
(2, '2023-06-12 15:00:00', '2023-06-13 09:00:00', '2023-06-14', '2023-06-14 15:00:00', 'entregado', 4, 1, 5, 'ENV-001-002', 150.00),
(3, '2023-06-15 12:00:00', '2023-06-16 10:00:00', '2023-06-19', '2023-06-19 11:30:00', 'entregado', 2, 3, 5, 'ENV-003-001', 300.00),
(4, '2023-06-18 17:30:00', '2023-06-19 16:00:00', '2023-06-20', '2023-06-20 09:00:00', 'entregado', 4, 1, 5, 'ENV-001-003', 120.00),
(5, '2023-06-20 10:30:00', '2023-06-21 08:00:00', '2023-06-23', '2023-06-23 14:00:00', 'entregado', 2, 4, 5, 'ENV-004-001', 500.00),
(6, '2023-06-22 14:00:00', '2023-06-23 10:00:00', '2023-06-26', NULL, 'en_transito', 1, 1, 5, 'ENV-001-004', 200.00),
(7, '2023-06-25 16:00:00', '2023-06-26 11:00:00', '2023-06-27', NULL, 'preparacion', 4, 1, 5, 'ENV-001-005', 100.00);

-- 19. Insertar datos en la tabla Incidencias
INSERT INTO Incidencias (tipo_incidencia, fecha_reportada, fecha_resolucion, estado, prioridad, descripcion, usuario_reporta_id, usuario_resuelve_id, referencia_id, tipo_referencia, solucion, impacto) VALUES
('retraso', '2023-06-13 10:00:00', '2023-06-14 16:00:00', 'resuelta', 'media', 'Retraso en entrega por tráfico', 5, 2, 2, 'envio', 'Se reprogramó la entrega para el mismo día por la tarde', 'medio'),
('producto_danado', '2023-06-20 11:30:00', '2023-06-22 09:00:00', 'resuelta', 'alta', 'Refrigerador llegó con golpe en la puerta', 1, 6, 5, 'venta', 'Se envió repuesto de puerta sin costo', 'alto'),
('stock', '2023-06-15 08:00:00', NULL, 'abierta', 'alta', 'Stock crítico de laptops EliteBook', 4, NULL, 1, 'producto', NULL, 'alto');

-- 20. Insertar datos en la tabla Facturas
INSERT INTO Facturas (numero_factura, venta_id, fecha_emision, fecha_vencimiento, subtotal, impuestos, descuento, total, estado_pago, metodo_pago, fecha_pago) VALUES
('FAC-2023-001', 1, '2023-06-10 12:00:00', '2023-07-10', 15999.00, 2559.84, 0.00, 18558.84, 'pagado', 'tarjeta', '2023-06-10'),
('FAC-2023-002', 2, '2023-06-12 15:30:00', '2023-07-12', 4749.00, 799.84, 250.00, 5548.84, 'pagado', 'efectivo', '2023-06-12'),
('FAC-2023-003', 3, '2023-06-15 12:30:00', '2023-07-15', 3499.00, 559.84, 0.00, 4058.84, 'pagado', 'transferencia', '2023-06-16'),
('FAC-2023-004', 4, '2023-06-18 18:00:00', '2023-07-18', 1234.00, 207.84, 65.00, 1441.84, 'pagado', 'efectivo', '2023-06-18'),
('FAC-2023-005', 5, '2023-06-20 11:00:00', '2023-07-20', 11399.00, 1919.84, 600.00, 13318.84, 'pagado', 'tarjeta', '2023-06-21'),
('FAC-2023-006', 6, '2023-06-22 14:30:00', '2023-07-22', 8549.00, 1439.84, 450.00, 9988.84, 'pendiente', NULL, NULL),
('FAC-2023-007', 7, '2023-06-25 16:30:00', '2023-07-25', 99.00, 15.84, 0.00, 114.84, 'pagado', 'efectivo', '2023-06-25');

-- 21. Insertar datos en la tabla Rendimiento_Logistico
INSERT INTO Rendimiento_Logistico (fecha, almacen_id, ruta_id, vehiculo_id, usuario_id, cantidad_envios, entregas_tiempo, entregas_retrasadas, tiempo_promedio_entrega, distancia_recorrida, consumo_combustible, costo_total, eficiencia_carga, retornos_cliente, incidencias_reportadas) VALUES
('2023-06-12', 1, 1, 1, 5, 1, 1, 0, 120.5, 52.0, 15.2, 250.00, 85.2, 0, 0),
('2023-06-14', 1, 1, 4, 5, 1, 1, 0, 135.0, 50.0, 5.5, 150.00, 65.0, 0, 1),
('2023-06-19', 3, 3, 2, 5, 1, 1, 0, 180.0, 62.0, 20.0, 300.00, 78.5, 0, 0),
('2023-06-20', 1, 1, 4, 5, 1, 1, 0, 125.0, 50.0, 5.0, 120.00, 60.0, 0, 0),
('2023-06-23', 1, 4, 2, 5, 1, 1, 0, 310.0, 205.0, 65.0, 500.00, 82.0, 0, 1),
('2023-06-26', 1, 1, 1, 5, 1, 0, 1, NULL, 50.0, 15.0, 200.00, 75.0, 0, 0);

-- Actualizar el estado del inventario después de las ventas
UPDATE Inventario SET cantidad = cantidad - 1 WHERE producto_id = 1 AND almacen_id = 1;
UPDATE Inventario SET cantidad = cantidad - 1 WHERE producto_id = 3 AND almacen_id = 1;
UPDATE Inventario SET cantidad = cantidad - 1 WHERE producto_id = 5 AND almacen_id = 2;
UPDATE Inventario SET cantidad = cantidad - 1 WHERE producto_id = 7 AND almacen_id = 1;
UPDATE Inventario SET cantidad = cantidad - 1 WHERE producto_id = 6 AND almacen_id = 1;
UPDATE Inventario SET cantidad = cantidad - 1 WHERE producto_id = 2 AND almacen_id = 1;
UPDATE Inventario SET cantidad = cantidad - 1 WHERE producto_id = 8 AND almacen_id = 3;

-- Generar algunos movimientos de inventario adicionales
INSERT INTO Movimientos_Inventario (producto_id, almacen_id, tipo_movimiento, cantidad, fecha_movimiento, usuario_id, referencia_id, tipo_referencia, notas) VALUES
-- Ajustes de inventario
(1, 1, 'ajuste', 2, '2023-06-15 10:00:00', 4, NULL, 'inventario', 'Ajuste por conteo físico'),
(3, 1, 'ajuste', -1, '2023-06-18 11:30:00', 4, NULL, 'inventario', 'Ajuste por producto dañado'),
(8, 3, 'ajuste', 5, '2023-06-20 09:45:00', 4, NULL, 'inventario', 'Ajuste por recepción adicional');

-- Actualizar fechas de último mantenimiento para algunos vehículos
UPDATE Vehiculos SET fecha_ultimo_mantenimiento = '2023-08-01', kilometraje = 5500 WHERE vehiculo_id = 4;
UPDATE Vehiculos SET estado = 'disponible', fecha_ultimo_mantenimiento = '2023-08-15' WHERE vehiculo_id = 3;

-- Crear algunas devoluciones
INSERT INTO Movimientos_Inventario (producto_id, almacen_id, tipo_movimiento, cantidad, fecha_movimiento, usuario_id, referencia_id, tipo_referencia, notas) VALUES
(2, 1, 'entrada', 1, '2023-06-25 14:00:00', 3, 6, 'devolucion', 'Devolución por cambio de producto');

-- Actualizar detalles de compra con devoluciones
UPDATE Detalles_Compra SET cantidad_recibida = 9, estado = 'devuelto' WHERE detalle_compra_id = 2 AND compra_id = 1;

-- Actualizar algunos estados de envíos
UPDATE Envios SET estado_envio = 'entregado', fecha_entrega_real = '2023-06-26 16:30:00' WHERE envio_id = 6;
UPDATE Envios SET estado_envio = 'en_transito', fecha_envio = '2023-06-26 11:30:00' WHERE envio_id = 7;

-- Registrar más incidencias
INSERT INTO Incidencias (tipo_incidencia, fecha_reportada, estado, prioridad, descripcion, usuario_reporta_id, referencia_id, tipo_referencia, impacto) VALUES
('retraso', '2023-06-26 12:00:00', 'abierta', 'media', 'Vehículo con problemas mecánicos', 5, 6, 'envio', 'medio'),
('falta_producto', '2023-06-15 09:00:00', 'resuelta', 'alta', 'Faltante de 2 tablets en inventario', 4, NULL, 'inventario', 'alto');

-- Actualizar rendimiento logístico con datos más recientes
INSERT INTO Rendimiento_Logistico (fecha, almacen_id, ruta_id, vehiculo_id, usuario_id, cantidad_envios, entregas_tiempo, entregas_retrasadas, tiempo_promedio_entrega, distancia_recorrida, consumo_combustible, costo_total, eficiencia_carga, retornos_cliente, incidencias_reportadas) VALUES
('2023-06-27', 1, 1, 4, 5, 1, 1, 0, 118.0, 50.0, 5.2, 100.00, 70.0, 0, 0);

-- Actualizar algunas facturas
UPDATE Facturas SET estado_pago = 'pagado', metodo_pago = 'tarjeta', fecha_pago = '2023-06-26' WHERE factura_id = 6;

-- Generar datos para reportes de análisis
-- Ventas por mes
SELECT 
    MONTH(fecha_venta) AS mes,
    COUNT(*) AS total_ventas,
    SUM(total) AS monto_total,
    AVG(total) AS promedio_venta,
    MAX(total) AS venta_maxima,
    MIN(total) AS venta_minima
FROM Ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Productos más vendidos
SELECT 
    p.nombre AS producto,
    cp.nombre AS categoria,
    SUM(dv.cantidad) AS cantidad_vendida,
    SUM(dv.total) AS ingresos_totales
FROM Productos p
JOIN Detalles_Venta dv ON p.producto_id = dv.producto_id
JOIN Categorias_Productos cp ON p.categoria_id = cp.categoria_id
GROUP BY p.nombre, cp.nombre
ORDER BY cantidad_vendida DESC;

-- Eficiencia de rutas
SELECT 
    r.nombre AS ruta,
    COUNT(e.envio_id) AS total_envios,
    SUM(CASE WHEN e.estado_envio = 'entregado' AND e.fecha_entrega_real <= e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_a_tiempo,
    SUM(CASE WHEN e.estado_envio = 'entregado' AND e.fecha_entrega_real > e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_retrasadas,
    AVG(TIMESTAMPDIFF(MINUTE, e.fecha_envio, e.fecha_entrega_real)) AS tiempo_promedio_min
FROM Rutas r
LEFT JOIN Envios e ON r.ruta_id = e.ruta_id
GROUP BY r.nombre
ORDER BY entregas_a_tiempo DESC;

-- Niveles de inventario
SELECT 
    p.nombre AS producto,
    a.nombre AS almacen,
    i.cantidad,
    i.stock_minimo,
    i.stock_maximo,
    CASE 
        WHEN i.cantidad <= i.stock_minimo THEN 'CRÍTICO' 
        WHEN i.cantidad <= (i.stock_minimo * 1.5) THEN 'BAJO'
        ELSE 'NORMAL' 
    END AS estado_stock
FROM Inventario i
JOIN Productos p ON i.producto_id = p.producto_id
JOIN Almacenes a ON i.almacen_id = a.almacen_id
ORDER BY estado_stock, i.cantidad ASC;

-- Insertar más clientes para pruebas
INSERT INTO Clientes (nombre, apellido, empresa, tipo_cliente, email, telefono, direccion, ciudad, estado_provincia, codigo_postal, pais, fecha_registro, limite_credito, estado, segmento) VALUES
('Fernando', 'Díaz', 'TechCorp', 'corporativo', 'fdiaz@techcorp.com', '5553334444', 'Av. Digital 202', 'Querétaro', 'Querétaro', '76000', 'México', '2023-07-01', 35000.00, 'activo', 'medianas_empresas'),
('Gabriela', 'Ruiz', NULL, 'individual', 'gabriela.ruiz@mail.com', '5554445555', 'Calle Primavera 303', 'Puebla', 'Puebla', '72000', 'México', '2023-07-05', 7500.00, 'activo', 'consumidor_final'),
('Ricardo', 'Vargas', 'OficinaPlus', 'corporativo', 'rvargas@oficinaplus.com', '5555556666', 'Boulevard Papel 404', 'Guadalajara', 'Jalisco', '44100', 'México', '2023-07-10', 25000.00, 'activo', 'medianas_empresas');

-- Insertar más productos
INSERT INTO Productos (nombre, descripcion, codigo_sku, codigo_barras, categoria_id, proveedor_id, unidad_medida, precio_compra, precio_venta, peso, largo, ancho, alto, es_perecedero, es_fragil, estado) VALUES
('Monitor 24"', 'Monitor Full HD 24 pulgadas', 'MN-24FHD-001', '112233445566', 2, 1, 'unidad', 2500.00, 3499.00, 4.5, 55.0, 35.0, 10.0, FALSE, TRUE, 'activo'),
('Teclado Inalámbrico', 'Teclado ergonómico inalámbrico', 'TC-INL-001', '223344556677', 2, 1, 'unidad', 300.00, 499.00, 0.8, 45.0, 15.0, 3.0, FALSE, FALSE, 'activo'),
('Silla Ejecutiva', 'Silla ergonómica para oficina', 'SC-EJE-001', '334455667788', 6, 2, 'unidad', 1800.00, 2599.00, 12.5, 60.0, 60.0, 100.0, FALSE, FALSE, 'activo');

-- Actualizar inventario con nuevos productos
INSERT INTO Inventario (producto_id, almacen_id, ubicacion_id, cantidad, stock_minimo, stock_maximo, fecha_ultima_actualizacion, estado) VALUES
(10, 1, 3, 8, 3, 15, NOW(), 'disponible'),
(11, 1, 3, 20, 10, 40, NOW(), 'disponible'),
(12, 2, 5, 6, 2, 10, NOW(), 'disponible');

-- Crear más ventas recientes
INSERT INTO Ventas (fecha_venta, cliente_id, usuario_id, tipo_venta, subtotal, impuestos, descuento, total, metodo_pago, estado_pago, estado_venta) VALUES
('2023-07-05 11:20:00', 8, 3, 'online', 3499.00, 559.84, 175.00, 3883.84, 'tarjeta', 'pagado', 'completada'),
('2023-07-08 14:45:00', 9, 3, 'presencial', 499.00, 79.84, 0.00, 578.84, 'efectivo', 'pagado', 'completada'),
('2023-07-12 10:15:00', 10, 3, 'online', 2599.00, 415.84, 130.00, 2884.84, 'transferencia', 'pendiente', 'procesando');

INSERT INTO Detalles_Venta (venta_id, producto_id, cantidad, precio_unitario, descuento, subtotal, impuesto, total) VALUES
(8, 10, 1, 3499.00, 175.00, 3324.00, 559.84, 3883.84),
(9, 11, 1, 499.00, 0.00, 499.00, 79.84, 578.84),
(10, 12, 1, 2599.00, 130.00, 2469.00, 415.84, 2884.84);

-- Crear envíos para las nuevas ventas
INSERT INTO Envios (venta_id, fecha_creacion, fecha_envio, fecha_entrega_estimada, estado_envio, vehiculo_id, ruta_id, conductor_id, numero_seguimiento, costo_envio) VALUES
(8, '2023-07-05 12:00:00', '2023-07-06 09:00:00', '2023-07-08', 'entregado', 1, 1, 5, 'ENV-001-006', 200.00),
(9, '2023-07-08 15:30:00', '2023-07-08 16:00:00', '2023-07-10', 'entregado', 4, 1, 5, 'ENV-001-007', 120.00),
(10, '2023-07-12 11:00:00', '2023-07-13 10:00:00', '2023-07-15', 'en_transito', 2, 3, 5, 'ENV-003-002', 280.00);

-- Actualizar el inventario después de las nuevas ventas
UPDATE Inventario SET cantidad = cantidad - 1 WHERE producto_id = 10 AND almacen_id = 1;
UPDATE Inventario SET cantidad = cantidad - 1 WHERE producto_id = 11 AND almacen_id = 1;
UPDATE Inventario SET cantidad = cantidad - 1 WHERE producto_id = 12 AND almacen_id = 2;

-- Registrar movimientos de inventario para las nuevas ventas
INSERT INTO Movimientos_Inventario (producto_id, almacen_id, tipo_movimiento, cantidad, fecha_movimiento, usuario_id, referencia_id, tipo_referencia, notas) VALUES
(10, 1, 'salida', 1, '2023-07-06 10:00:00', 3, 8, 'venta', 'Salida por venta #8'),
(11, 1, 'salida', 1, '2023-07-08 16:30:00', 3, 9, 'venta', 'Salida por venta #9'),
(12, 2, 'salida', 1, '2023-07-13 11:00:00', 3, 10, 'venta', 'Salida por venta #10');

-- Crear facturas para las nuevas ventas
INSERT INTO Facturas (numero_factura, venta_id, fecha_emision, fecha_vencimiento, subtotal, impuestos, descuento, total, estado_pago, metodo_pago, fecha_pago) VALUES
('FAC-2023-008', 8, '2023-07-05 12:30:00', '2023-08-05', 3324.00, 559.84, 175.00, 3883.84, 'pagado', 'tarjeta', '2023-07-05'),
('FAC-2023-009', 9, '2023-07-08 16:00:00', '2023-08-08', 499.00, 79.84, 0.00, 578.84, 'pagado', 'efectivo', '2023-07-08'),
('FAC-2023-010', 10, '2023-07-12 11:30:00', '2023-08-12', 2469.00, 415.84, 130.00, 2884.84, 'pendiente', NULL, NULL);

-- Actualizar rendimiento logístico con datos más recientes
INSERT INTO Rendimiento_Logistico (fecha, almacen_id, ruta_id, vehiculo_id, usuario_id, cantidad_envios, entregas_tiempo, entregas_retrasadas, tiempo_promedio_entrega, distancia_recorrida, consumo_combustible, costo_total, eficiencia_carga, retornos_cliente, incidencias_reportadas) VALUES
('2023-07-08', 1, 1, 1, 5, 1, 1, 0, 125.0, 50.0, 15.0, 200.00, 80.0, 0, 0),
('2023-07-10', 1, 1, 4, 5, 1, 1, 0, 130.0, 50.0, 5.0, 120.00, 65.0, 0, 0),
('2023-07-15', 3, 3, 2, 5, 1, 0, 1, NULL, 60.0, 18.0, 280.00, 75.0, 0, 0);

-- 1. Verificar niveles de stock
SELECT p.nombre, i.cantidad, i.stock_minimo, i.stock_maximo, 
       CASE WHEN i.cantidad <= i.stock_minimo THEN 'ALERTA' ELSE 'OK' END AS estado
FROM Inventario i
JOIN Productos p ON i.producto_id = p.producto_id
ORDER BY estado, i.cantidad;

-- 2. Ventas por cliente
SELECT c.nombre, c.tipo_cliente, COUNT(v.venta_id) AS total_compras, SUM(v.total) AS monto_total
FROM Clientes c
JOIN Ventas v ON c.cliente_id = v.cliente_id
GROUP BY c.nombre, c.tipo_cliente
ORDER BY monto_total DESC;

-- 3. Eficiencia de proveedores
SELECT pr.nombre_empresa, AVG(dc.cantidad_recibida/dc.cantidad)*100 AS porcentaje_entrega,
       AVG(DATEDIFF(c.fecha_entrega_estimada, c.fecha_compra)) AS tiempo_entrega_promedio
FROM Proveedores pr
JOIN Compras c ON pr.proveedor_id = c.proveedor_id
JOIN Detalles_Compra dc ON c.compra_id = dc.compra_id
GROUP BY pr.nombre_empresa
ORDER BY porcentaje_entrega DESC;

-- 4. Rendimiento de rutas
SELECT r.nombre, 
       COUNT(e.envio_id) AS total_envios,
       SUM(CASE WHEN e.estado_envio = 'entregado' AND e.fecha_entrega_real <= e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_a_tiempo,
       AVG(rl.tiempo_promedio_entrega) AS tiempo_promedio
FROM Rutas r
LEFT JOIN Envios e ON r.ruta_id = e.ruta_id
LEFT JOIN Rendimiento_Logistico rl ON r.ruta_id = rl.ruta_id
GROUP BY r.nombre
ORDER BY entregas_a_tiempo DESC;

-- 5. Productos más rentables
SELECT p.nombre, 
       SUM(dv.cantidad) AS unidades_vendidas,
       SUM(dv.total) AS ingresos_totales,
       SUM(dv.total) - SUM(dv.cantidad * pr.precio_compra) AS ganancia_total
FROM Productos p
JOIN Detalles_Venta dv ON p.producto_id = dv.producto_id
JOIN Ventas v ON dv.venta_id = v.venta_id
JOIN (
    SELECT producto_id, precio_compra 
    FROM Productos 
    GROUP BY producto_id
) pr ON p.producto_id = pr.producto_id
GROUP BY p.nombre
ORDER BY ganancia_total DESC;