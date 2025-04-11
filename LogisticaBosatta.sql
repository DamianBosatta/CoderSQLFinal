-- Creación de la base de datos
CREATE DATABASE SistemaLogistico;
USE SistemaLogistico;

-- Tabla: Clientes
CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    empresa VARCHAR(150),
    tipo_cliente VARCHAR(50) NOT NULL,
    email VARCHAR(150),
    telefono VARCHAR(20),
    direccion VARCHAR(200),
    ciudad VARCHAR(100),
    estado_provincia VARCHAR(100),
    codigo_postal VARCHAR(20),
    pais VARCHAR(100),
    fecha_registro DATE NOT NULL,
    limite_credito DECIMAL(12,2),
    estado VARCHAR(20) NOT NULL,
    segmento VARCHAR(50)
);

-- Tabla: Proveedores
CREATE TABLE Proveedores (
    proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_empresa VARCHAR(150) NOT NULL,
    contacto_nombre VARCHAR(100),
    contacto_cargo VARCHAR(100),
    email VARCHAR(150),
    telefono VARCHAR(20),
    direccion VARCHAR(200),
    ciudad VARCHAR(100),
    estado_provincia VARCHAR(100),
    codigo_postal VARCHAR(20),
    pais VARCHAR(100),
    categoria VARCHAR(50),
    condiciones_pago VARCHAR(100),
    tiempo_entrega INT,
    calificacion DECIMAL(2,1),
    estado VARCHAR(20) NOT NULL
);

-- Tabla: Categorias_Productos
CREATE TABLE Categorias_Productos (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    categoria_padre_id INT,
    FOREIGN KEY (categoria_padre_id) REFERENCES Categorias_Productos(categoria_id)
);

-- Tabla: Productos
CREATE TABLE Productos (
    producto_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    codigo_sku VARCHAR(50) UNIQUE,
    codigo_barras VARCHAR(50),
    categoria_id INT,
    proveedor_id INT,
    unidad_medida VARCHAR(30),
    precio_compra DECIMAL(12,2),
    precio_venta DECIMAL(12,2) NOT NULL,
    peso DECIMAL(8,2),
    largo DECIMAL(8,2),
    ancho DECIMAL(8,2),
    alto DECIMAL(8,2),
    es_perecedero BOOLEAN DEFAULT FALSE,
    es_fragil BOOLEAN DEFAULT FALSE,
    estado VARCHAR(30) NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES Categorias_Productos(categoria_id),
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id)
);

-- Tabla: Roles
CREATE TABLE Roles (
    rol_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    permisos TEXT
);

-- Tabla: Usuarios
CREATE TABLE Usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    nombre_usuario VARCHAR(50) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol_id INT,
    telefono VARCHAR(20),
    fecha_creacion DATETIME NOT NULL,
    ultimo_acceso DATETIME,
    estado VARCHAR(30) NOT NULL,
    almacen_asignado_id INT,
    FOREIGN KEY (rol_id) REFERENCES Roles(rol_id)
);

-- Tabla: Almacenes
CREATE TABLE Almacenes (
    almacen_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    direccion VARCHAR(200),
    ciudad VARCHAR(100),
    estado_provincia VARCHAR(100),
    codigo_postal VARCHAR(20),
    pais VARCHAR(100),
    telefono VARCHAR(20),
    capacidad_total DECIMAL(10,2),
    capacidad_utilizada DECIMAL(10,2),
    gerente_id INT,
    estado VARCHAR(30) NOT NULL,
    FOREIGN KEY (gerente_id) REFERENCES Usuarios(usuario_id)
);

-- Actualizar la tabla Usuarios para agregar la FK a Almacenes
ALTER TABLE Usuarios
ADD FOREIGN KEY (almacen_asignado_id) REFERENCES Almacenes(almacen_id);

-- Tabla: Ubicaciones_Almacen
CREATE TABLE Ubicaciones_Almacen (
    ubicacion_id INT PRIMARY KEY AUTO_INCREMENT,
    almacen_id INT NOT NULL,
    zona VARCHAR(50),
    pasillo VARCHAR(10),
    estante VARCHAR(10),
    nivel VARCHAR(10),
    posicion VARCHAR(10),
    codigo_ubicacion VARCHAR(30) UNIQUE,
    capacidad_max DECIMAL(8,2),
    tipo_producto VARCHAR(50),
    refrigerada BOOLEAN DEFAULT FALSE,
    estado VARCHAR(30) NOT NULL,
    FOREIGN KEY (almacen_id) REFERENCES Almacenes(almacen_id)
);

-- Tabla: Inventario
CREATE TABLE Inventario (
    inventario_id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT NOT NULL,
    almacen_id INT NOT NULL,
    ubicacion_id INT,
    cantidad INT NOT NULL,
    stock_minimo INT,
    stock_maximo INT,
    fecha_ultima_actualizacion DATETIME NOT NULL,
    lote VARCHAR(50),
    fecha_vencimiento DATE,
    estado VARCHAR(30) NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id),
    FOREIGN KEY (almacen_id) REFERENCES Almacenes(almacen_id),
    FOREIGN KEY (ubicacion_id) REFERENCES Ubicaciones_Almacen(ubicacion_id)
);

-- Tabla: Movimientos_Inventario
CREATE TABLE Movimientos_Inventario (
    movimiento_id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT NOT NULL,
    almacen_id INT NOT NULL,
    ubicacion_id INT,
    tipo_movimiento VARCHAR(30) NOT NULL,
    cantidad INT NOT NULL,
    fecha_movimiento DATETIME NOT NULL,
    usuario_id INT NOT NULL,
    referencia_id INT,
    tipo_referencia VARCHAR(30),
    notas TEXT,
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id),
    FOREIGN KEY (almacen_id) REFERENCES Almacenes(almacen_id),
    FOREIGN KEY (ubicacion_id) REFERENCES Ubicaciones_Almacen(ubicacion_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla: Ventas
CREATE TABLE Ventas (
    venta_id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_venta DATETIME NOT NULL,
    cliente_id INT NOT NULL,
    usuario_id INT NOT NULL,
    tipo_venta VARCHAR(30) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    impuestos DECIMAL(12,2) NOT NULL,
    descuento DECIMAL(12,2) DEFAULT 0,
    total DECIMAL(12,2) NOT NULL,
    metodo_pago VARCHAR(50),
    estado_pago VARCHAR(30) NOT NULL,
    notas TEXT,
    direccion_envio_id INT,
    estado_venta VARCHAR(30) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla: Detalles_Venta
CREATE TABLE Detalles_Venta (
    detalle_venta_id INT PRIMARY KEY AUTO_INCREMENT,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL,
    descuento DECIMAL(12,2) DEFAULT 0,
    subtotal DECIMAL(12,2) NOT NULL,
    impuesto DECIMAL(12,2) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    almacen_destino_id INT,  -- NUEVA COLUMNA
    FOREIGN KEY (venta_id) REFERENCES Ventas(venta_id),
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id),
    FOREIGN KEY (almacen_destino_id) REFERENCES Almacenes(almacen_id) -- RELACIÓN CON ALMACENES
);


-- Tabla: Compras
CREATE TABLE Compras (
    compra_id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_compra DATETIME NOT NULL,
    proveedor_id INT NOT NULL,
    usuario_id INT NOT NULL,
    numero_orden VARCHAR(50),
    fecha_entrega_estimada DATE,
    subtotal DECIMAL(12,2) NOT NULL,
    impuestos DECIMAL(12,2) NOT NULL,
    descuento DECIMAL(12,2) DEFAULT 0,
    total DECIMAL(12,2) NOT NULL,
    estado_compra VARCHAR(30) NOT NULL,
    estado_pago VARCHAR(30) NOT NULL,
    almacen_destino_id INT NOT NULL,
    notas TEXT,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (almacen_destino_id) REFERENCES Almacenes(almacen_id)
);

-- Tabla: Detalles_Compra
CREATE TABLE Detalles_Compra (
    detalle_compra_id INT PRIMARY KEY AUTO_INCREMENT,
    compra_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL,
    descuento DECIMAL(12,2) DEFAULT 0,
    subtotal DECIMAL(12,2) NOT NULL,
    impuesto DECIMAL(12,2) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    cantidad_recibida INT,
    estado VARCHAR(30),
    FOREIGN KEY (compra_id) REFERENCES Compras(compra_id),
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
);

-- Tabla: Vehiculos
CREATE TABLE Vehiculos (
    vehiculo_id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INT,
    placa VARCHAR(20) UNIQUE,
    capacidad_peso DECIMAL(10,2) NOT NULL,
    capacidad_volumen DECIMAL(10,2) NOT NULL,
    fecha_adquisicion DATE,
    fecha_ultimo_mantenimiento DATE,
    kilometraje INT,
    estado VARCHAR(30) NOT NULL,
    notas TEXT
);

-- Tabla: Rutas
CREATE TABLE Rutas (
    ruta_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    origen_id INT NOT NULL,
    zona_cobertura VARCHAR(100),
    distancia_total DECIMAL(10,2),
    tiempo_estimado INT,
    frecuencia VARCHAR(50),
    horario_salida TIME,
    costo_estimado DECIMAL(12,2),
    estado VARCHAR(30) NOT NULL,
    FOREIGN KEY (origen_id) REFERENCES Almacenes(almacen_id)
);

-- Tabla: Puntos_Ruta
CREATE TABLE Puntos_Ruta (
    punto_id INT PRIMARY KEY AUTO_INCREMENT,
    ruta_id INT NOT NULL,
    secuencia INT NOT NULL,
    tipo_punto VARCHAR(30) NOT NULL,
    direccion VARCHAR(200),
    ciudad VARCHAR(100),
    codigo_postal VARCHAR(20),
    latitud DECIMAL(10,7),
    longitud DECIMAL(10,7),
    tiempo_estimado_llegada TIME,
    tiempo_parada INT,
    notas TEXT,
    FOREIGN KEY (ruta_id) REFERENCES Rutas(ruta_id)
);

-- Tabla: Envios
CREATE TABLE Envios (
    envio_id INT PRIMARY KEY AUTO_INCREMENT,
    venta_id INT NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    fecha_envio DATETIME,
    fecha_entrega_estimada DATE,
    fecha_entrega_real DATETIME,
    estado_envio VARCHAR(30) NOT NULL,
    vehiculo_id INT,
    ruta_id INT,
    conductor_id INT,
    numero_seguimiento VARCHAR(50),
    costo_envio DECIMAL(12,2),
    notas TEXT,
    firma_recepcion TEXT,
    FOREIGN KEY (venta_id) REFERENCES Ventas(venta_id),
    FOREIGN KEY (vehiculo_id) REFERENCES Vehiculos(vehiculo_id),
    FOREIGN KEY (ruta_id) REFERENCES Rutas(ruta_id),
    FOREIGN KEY (conductor_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla: Incidencias
CREATE TABLE Incidencias (
    incidencia_id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_incidencia VARCHAR(50) NOT NULL,
    fecha_reportada DATETIME NOT NULL,
    fecha_resolucion DATETIME,
    estado VARCHAR(30) NOT NULL,
    prioridad VARCHAR(20) NOT NULL,
    descripcion TEXT NOT NULL,
    usuario_reporta_id INT NOT NULL,
    usuario_resuelve_id INT,
    referencia_id INT,
    tipo_referencia VARCHAR(30),
    solucion TEXT,
    impacto VARCHAR(30),
    FOREIGN KEY (usuario_reporta_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (usuario_resuelve_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla: Facturas
CREATE TABLE Facturas (
    factura_id INT PRIMARY KEY AUTO_INCREMENT,
    numero_factura VARCHAR(50) UNIQUE,
    venta_id INT NOT NULL,
    fecha_emision DATETIME NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    impuestos DECIMAL(12,2) NOT NULL,
    descuento DECIMAL(12,2) DEFAULT 0,
    total DECIMAL(12,2) NOT NULL,
    estado_pago VARCHAR(30) NOT NULL,
    metodo_pago VARCHAR(50),
    fecha_pago DATE,
    notas TEXT,
    FOREIGN KEY (venta_id) REFERENCES Ventas(venta_id)
);

-- Tabla: Rendimiento_Logistico
CREATE TABLE Rendimiento_Logistico (
    rendimiento_id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    almacen_id INT,
    ruta_id INT,
    vehiculo_id INT,
    usuario_id INT,
    cantidad_envios INT NOT NULL,
    entregas_tiempo INT NOT NULL,
    entregas_retrasadas INT NOT NULL,
    tiempo_promedio_entrega DECIMAL(8,2),
    distancia_recorrida DECIMAL(10,2),
    consumo_combustible DECIMAL(8,2),
    costo_total DECIMAL(12,2),
    eficiencia_carga DECIMAL(5,2),
    retornos_cliente INT,
    incidencias_reportadas INT,
    FOREIGN KEY (almacen_id) REFERENCES Almacenes(almacen_id),
    FOREIGN KEY (ruta_id) REFERENCES Rutas(ruta_id),
    FOREIGN KEY (vehiculo_id) REFERENCES Vehiculos(vehiculo_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- 1. Vista de productos más vendidos
CREATE VIEW Vista_Productos_Mas_Vendidos AS
SELECT 
    p.producto_id,
    p.nombre AS producto,
    p.codigo_sku,
    cp.nombre AS categoria,
    SUM(dv.cantidad) AS total_vendido,
    SUM(dv.total) AS ingresos_totales,
    COUNT(DISTINCT v.venta_id) AS veces_vendido
FROM 
    Productos p
JOIN 
    Detalles_Venta dv ON p.producto_id = dv.producto_id
JOIN 
    Ventas v ON dv.venta_id = v.venta_id
JOIN 
    Categorias_Productos cp ON p.categoria_id = cp.categoria_id
GROUP BY 
    p.producto_id, p.nombre, p.codigo_sku, cp.nombre
ORDER BY 
    total_vendido DESC;

-- 2. Vista de clientes con mayor volumen de compra
CREATE VIEW Vista_Clientes_Mayor_Volumen AS
SELECT 
    c.cliente_id,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    c.empresa,
    c.tipo_cliente,
    c.segmento,
    COUNT(v.venta_id) AS total_compras,
    SUM(v.total) AS volumen_compra,
    MAX(v.fecha_venta) AS ultima_compra
FROM 
    Clientes c
JOIN 
    Ventas v ON c.cliente_id = v.cliente_id
GROUP BY 
    c.cliente_id, c.nombre, c.apellido, c.empresa, c.tipo_cliente, c.segmento
ORDER BY 
    volumen_compra DESC;

-- 3. Vista de rendimiento de rutas
CREATE VIEW Vista_Rendimiento_Rutas AS
SELECT 
    r.ruta_id,
    r.nombre AS ruta,
    a.nombre AS almacen_origen,
    r.zona_cobertura,
    r.distancia_total,
    COUNT(e.envio_id) AS total_envios,
    SUM(CASE WHEN e.estado_envio = 'Entregado' AND e.fecha_entrega_real <= e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_a_tiempo,
    SUM(CASE WHEN e.estado_envio = 'Entregado' AND e.fecha_entrega_real > e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_retrasadas,
    AVG(TIMESTAMPDIFF(MINUTE, e.fecha_envio, e.fecha_entrega_real)) AS tiempo_promedio_min,
    r.costo_estimado,
    AVG(rl.eficiencia_carga) AS eficiencia_carga_promedio
FROM 
    Rutas r
JOIN 
    Almacenes a ON r.origen_id = a.almacen_id
LEFT JOIN 
    Envios e ON r.ruta_id = e.ruta_id
LEFT JOIN 
    Rendimiento_Logistico rl ON r.ruta_id = rl.ruta_id
GROUP BY 
    r.ruta_id, r.nombre, a.nombre, r.zona_cobertura, r.distancia_total, r.costo_estimado;

-- 4. Vista de stock actual con alertas
CREATE VIEW Vista_Stock_Alertas AS
SELECT 
    i.inventario_id,
    p.producto_id,
    p.nombre AS producto,
    p.codigo_sku,
    a.nombre AS almacen,
    u.codigo_ubicacion,
    i.cantidad,
    i.stock_minimo,
    i.stock_maximo,
    CASE 
        WHEN i.cantidad <= i.stock_minimo THEN 'CRÍTICO'
        WHEN i.cantidad <= (i.stock_minimo * 1.5) THEN 'BAJO'
        WHEN i.cantidad >= i.stock_maximo THEN 'EXCESO'
        ELSE 'NORMAL'
    END AS estado_stock,
    i.fecha_ultima_actualizacion,
    CASE 
        WHEN p.es_perecedero = TRUE AND i.fecha_vencimiento < DATE_ADD(CURDATE(), INTERVAL 7 DAY) THEN 'PRÓXIMO A VENCER'
        WHEN p.es_perecedero = TRUE AND i.fecha_vencimiento < CURDATE() THEN 'VENCIDO'
        ELSE 'OK'
    END AS estado_vencimiento
FROM 
    Inventario i
JOIN 
    Productos p ON i.producto_id = p.producto_id
JOIN 
    Almacenes a ON i.almacen_id = a.almacen_id
LEFT JOIN 
    Ubicaciones_Almacen u ON i.ubicacion_id = u.ubicacion_id
ORDER BY 
    estado_stock, estado_vencimiento DESC;

-- 5. Vista de facturas pendientes
CREATE VIEW Vista_Facturas_Pendientes AS
SELECT 
    f.factura_id,
    f.numero_factura,
    v.venta_id,
    c.cliente_id,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    c.empresa,
    f.fecha_emision,
    f.fecha_vencimiento,
    DATEDIFF(f.fecha_vencimiento, CURDATE()) AS dias_para_vencer,
    f.total,
    f.estado_pago,
    v.metodo_pago,
    v.tipo_venta
FROM 
    Facturas f
JOIN 
    Ventas v ON f.venta_id = v.venta_id
JOIN 
    Clientes c ON v.cliente_id = c.cliente_id
WHERE 
    f.estado_pago != 'Pagado'
ORDER BY 
    f.fecha_vencimiento;

-- 6. Vista de eficiencia de proveedores
CREATE VIEW Vista_Eficiencia_Proveedores AS
SELECT 
    pr.proveedor_id,
    pr.nombre_empresa,
    pr.contacto_nombre,
    pr.calificacion AS calificacion_actual,
    COUNT(c.compra_id) AS total_compras,
    SUM(c.total) AS volumen_total,
    AVG(DATEDIFF(c.fecha_entrega_estimada, c.fecha_compra)) AS tiempo_entrega_promedio,
    SUM(CASE WHEN c.estado_compra = 'Completada' THEN 1 ELSE 0 END) / COUNT(c.compra_id) * 100 AS porcentaje_completadas,
    AVG(dc.cantidad_recibida / dc.cantidad) * 100 AS porcentaje_cantidad_recibida,
    SUM(CASE WHEN dc.estado = 'Devuelto' THEN 1 ELSE 0 END) AS productos_devueltos
FROM 
    Proveedores pr
LEFT JOIN 
    Compras c ON pr.proveedor_id = c.proveedor_id
LEFT JOIN 
    Detalles_Compra dc ON c.compra_id = dc.compra_id
GROUP BY 
    pr.proveedor_id, pr.nombre_empresa, pr.contacto_nombre, pr.calificacion
ORDER BY 
    porcentaje_completadas DESC, porcentaje_cantidad_recibida DESC;

-- 7. Vista de rendimiento de empleados en entregas
CREATE VIEW Vista_Rendimiento_Empleados AS
SELECT 
    u.usuario_id,
    CONCAT(u.nombre, ' ', u.apellido) AS empleado,
    r.nombre AS rol,
    a.nombre AS almacen_asignado,
    COUNT(e.envio_id) AS total_envios,
    SUM(CASE WHEN e.estado_envio = 'Entregado' AND e.fecha_entrega_real <= e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_a_tiempo,
    SUM(CASE WHEN e.estado_envio = 'Entregado' AND e.fecha_entrega_real > e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_retrasadas,
    SUM(CASE WHEN e.estado_envio = 'Cancelado' THEN 1 ELSE 0 END) AS entregas_canceladas,
    AVG(TIMESTAMPDIFF(MINUTE, e.fecha_envio, e.fecha_entrega_real)) AS tiempo_promedio_min,
    COUNT(i.incidencia_id) AS incidencias_reportadas
FROM 
    Usuarios u
JOIN 
    Roles r ON u.rol_id = r.rol_id
LEFT JOIN 
    Almacenes a ON u.almacen_asignado_id = a.almacen_id
LEFT JOIN 
    Envios e ON u.usuario_id = e.conductor_id
LEFT JOIN 
    Incidencias i ON u.usuario_id = i.usuario_reporta_id
GROUP BY 
    u.usuario_id, u.nombre, u.apellido, r.nombre, a.nombre;

-- 1. Procedimiento para actualizar el stock tras una venta
DELIMITER //
CREATE PROCEDURE ActualizarStockPorVenta(IN p_venta_id INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_producto_id INT;
    DECLARE v_cantidad INT;
    DECLARE v_almacen_id INT;
    
    -- Cursor para recorrer los detalles de la venta
    DECLARE cur CURSOR FOR 
        SELECT dv.producto_id, dv.cantidad, v.almacen_destino_id
        FROM Detalles_Venta dv
        JOIN Ventas v ON dv.venta_id = v.venta_id
        WHERE dv.venta_id = p_venta_id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO v_producto_id, v_cantidad, v_almacen_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Actualizar el inventario
        UPDATE Inventario i
        SET i.cantidad = i.cantidad - v_cantidad,
            i.fecha_ultima_actualizacion = NOW()
        WHERE i.producto_id = v_producto_id 
        AND i.almacen_id = v_almacen_id;
        
        -- Registrar el movimiento de inventario
        INSERT INTO Movimientos_Inventario (
            producto_id, almacen_id, tipo_movimiento, cantidad, 
            fecha_movimiento, usuario_id, referencia_id, tipo_referencia, notas
        ) VALUES (
            v_producto_id, v_almacen_id, 'salida', v_cantidad, 
            NOW(), (SELECT usuario_id FROM Ventas WHERE venta_id = p_venta_id), 
            p_venta_id, 'venta', 'Salida por venta'
        );
    END LOOP;
    
    CLOSE cur;
END //
DELIMITER ;

-- 2. Procedimiento para calcular rutas óptimas
DELIMITER //
CREATE PROCEDURE CalcularRutaOptima(
    IN p_almacen_id INT,
    IN p_fecha_envio DATE,
    OUT p_ruta_id INT
)
BEGIN
    -- Variables para cálculo de eficiencia
    DECLARE v_mejor_ruta_id INT;
    DECLARE v_max_eficiencia DECIMAL(5,2) DEFAULT 0;
    DECLARE v_eficiencia_actual DECIMAL(5,2);
    
    -- Cursor para recorrer rutas disponibles
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur_ruta_id INT;
    DECLARE cur_nombre VARCHAR(100);
    DECLARE cur_eficiencia DECIMAL(5,2);
    
    DECLARE cur CURSOR FOR 
        SELECT r.ruta_id, r.nombre, COALESCE(AVG(rl.eficiencia_carga), 0) AS eficiencia
        FROM Rutas r
        LEFT JOIN Rendimiento_Logistico rl ON r.ruta_id = rl.ruta_id
        WHERE r.origen_id = p_almacen_id
        AND r.estado = 'Activo'
        GROUP BY r.ruta_id, r.nombre;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO cur_ruta_id, cur_nombre, cur_eficiencia;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Calcular eficiencia considerando factores adicionales
        SET v_eficiencia_actual = cur_eficiencia * 0.7 + 
            (SELECT COUNT(*) FROM Envios e 
             WHERE e.ruta_id = cur_ruta_id 
             AND DATE(e.fecha_envio) = p_fecha_envio) * 0.3;
        
        -- Determinar la mejor ruta
        IF v_eficiencia_actual > v_max_eficiencia THEN
            SET v_max_eficiencia = v_eficiencia_actual;
            SET v_mejor_ruta_id = cur_ruta_id;
        END IF;
    END LOOP;
    
    CLOSE cur;
    
    -- Asignar la mejor ruta encontrada
    SET p_ruta_id = v_mejor_ruta_id;
END //
DELIMITER ;

-- 3. Procedimiento para generar informes periódicos
DELIMITER //
CREATE PROCEDURE GenerarInformePeriodico(
    IN p_tipo_informe VARCHAR(50),
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    IF p_tipo_informe = 'ventas' THEN
        -- Informe de ventas
        SELECT 
            DATE(v.fecha_venta) AS fecha,
            c.tipo_cliente,
            cp.nombre AS categoria_producto,
            SUM(dv.cantidad) AS cantidad_vendida,
            SUM(dv.total) AS total_ventas,
            COUNT(DISTINCT v.venta_id) AS transacciones
        FROM 
            Ventas v
        JOIN 
            Clientes c ON v.cliente_id = c.cliente_id
        JOIN 
            Detalles_Venta dv ON v.venta_id = dv.venta_id
        JOIN 
            Productos p ON dv.producto_id = p.producto_id
        JOIN 
            Categorias_Productos cp ON p.categoria_id = cp.categoria_id
        WHERE 
            DATE(v.fecha_venta) BETWEEN p_fecha_inicio AND p_fecha_fin
        GROUP BY 
            DATE(v.fecha_venta), c.tipo_cliente, cp.nombre
        ORDER BY 
            fecha, total_ventas DESC;
            
    ELSEIF p_tipo_informe = 'logistica' THEN
        -- Informe de logística
        SELECT 
            r.nombre AS ruta,
            a.nombre AS almacen_origen,
            COUNT(e.envio_id) AS total_envios,
            SUM(CASE WHEN e.estado_envio = 'Entregado' AND e.fecha_entrega_real <= e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_a_tiempo,
            SUM(CASE WHEN e.estado_envio = 'Entregado' AND e.fecha_entrega_real > e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_retrasadas,
            AVG(TIMESTAMPDIFF(MINUTE, e.fecha_envio, e.fecha_entrega_real)) AS tiempo_promedio_min,
            SUM(e.costo_envio) AS costo_total_envios
        FROM 
            Rutas r
        JOIN 
            Almacenes a ON r.origen_id = a.almacen_id
        LEFT JOIN 
            Envios e ON r.ruta_id = e.ruta_id AND DATE(e.fecha_envio) BETWEEN p_fecha_inicio AND p_fecha_fin
        GROUP BY 
            r.nombre, a.nombre;
            
    ELSEIF p_tipo_informe = 'inventario' THEN
        -- Informe de inventario
        SELECT 
            p.nombre AS producto,
            cp.nombre AS categoria,
            SUM(i.cantidad) AS stock_total,
            SUM(CASE WHEN i.cantidad <= i.stock_minimo THEN 1 ELSE 0 END) AS ubicaciones_bajo_stock,
            SUM(CASE WHEN i.fecha_vencimiento < CURDATE() THEN i.cantidad ELSE 0 END) AS cantidad_vencida
        FROM 
            Productos p
        JOIN 
            Categorias_Productos cp ON p.categoria_id = cp.categoria_id
        JOIN 
            Inventario i ON p.producto_id = i.producto_id
        WHERE 
            i.fecha_ultima_actualizacion BETWEEN p_fecha_inicio AND p_fecha_fin
        GROUP BY 
            p.nombre, cp.nombre
        HAVING 
            stock_total > 0 OR ubicaciones_bajo_stock > 0 OR cantidad_vencida > 0
        ORDER BY 
            ubicaciones_bajo_stock DESC, cantidad_vencida DESC;
    END IF;
END //
DELIMITER ;

-- 4. Procedimiento para asignar vehículos a rutas
DELIMITER //
CREATE PROCEDURE AsignarVehiculoARuta(
    IN p_ruta_id INT,
    IN p_fecha_envio DATE,
    OUT p_vehiculo_id INT
)
BEGIN
    DECLARE v_distancia_ruta DECIMAL(10,2);
    DECLARE v_capacidad_necesaria DECIMAL(10,2);
    DECLARE v_vehiculo_asignado INT;
    
    -- Obtener información de la ruta
    SELECT distancia_total INTO v_distancia_ruta
    FROM Rutas
    WHERE ruta_id = p_ruta_id;
    
    -- Estimar capacidad necesaria basada en envíos programados
    SELECT SUM(p.peso * dv.cantidad) INTO v_capacidad_necesaria
    FROM Envios e
    JOIN Ventas v ON e.venta_id = v.venta_id
    JOIN Detalles_Venta dv ON v.venta_id = dv.venta_id
    JOIN Productos p ON dv.producto_id = p.producto_id
    WHERE e.ruta_id = p_ruta_id
    AND DATE(e.fecha_envio) = p_fecha_envio
    AND e.vehiculo_id IS NULL;
    
    -- Buscar vehículo disponible con mejor rendimiento
    SELECT v.vehiculo_id INTO v_vehiculo_asignado
    FROM Vehiculos v
    WHERE v.estado = 'Disponible'
    AND v.capacidad_peso >= v_capacidad_necesaria
    AND v.fecha_ultimo_mantenimiento >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    ORDER BY 
        (SELECT AVG(rl.eficiencia_carga) 
         FROM Rendimiento_Logistico rl 
         WHERE rl.vehiculo_id = v.vehiculo_id) DESC,
        v.kilometraje ASC
    LIMIT 1;
    
    -- Asignar el vehículo encontrado
    SET p_vehiculo_id = v_vehiculo_asignado;
    
    -- Actualizar estado del vehículo si se asignó
    IF v_vehiculo_asignado IS NOT NULL THEN
        UPDATE Vehiculos
        SET estado = 'Asignado'
        WHERE vehiculo_id = v_vehiculo_asignado;
    END IF;
END //
DELIMITER ;

-- 1. Trigger que actualice el inventario después de una venta
DELIMITER //
CREATE TRIGGER ActualizarInventarioVenta
AFTER INSERT ON Detalles_Venta
FOR EACH ROW
BEGIN
    DECLARE v_almacen_id INT;
    
    -- Obtener el almacén de destino de la venta
    SELECT almacen_destino_id INTO v_almacen_id
    FROM Ventas
    WHERE venta_id = NEW.venta_id;
    
    -- Actualizar el inventario
    UPDATE Inventario
    SET cantidad = cantidad - NEW.cantidad,
        fecha_ultima_actualizacion = NOW()
    WHERE producto_id = NEW.producto_id
    AND almacen_id = v_almacen_id;
    
    -- Registrar movimiento de inventario
    INSERT INTO Movimientos_Inventario (
        producto_id, almacen_id, tipo_movimiento, cantidad, 
        fecha_movimiento, usuario_id, referencia_id, tipo_referencia, notas
    ) VALUES (
        NEW.producto_id, v_almacen_id, 'salida', NEW.cantidad, 
        NOW(), (SELECT usuario_id FROM Ventas WHERE venta_id = NEW.venta_id), 
        NEW.venta_id, 'venta', 'Salida por venta'
    );
END //
DELIMITER ;

-- 2. Trigger que registre cambios en precios de productos
DELIMITER //
CREATE TRIGGER RegistrarCambioPrecio
BEFORE UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF OLD.precio_venta != NEW.precio_venta THEN
        INSERT INTO Movimientos_Inventario (
            producto_id, tipo_movimiento, cantidad, 
            fecha_movimiento, tipo_referencia, notas
        ) VALUES (
            NEW.producto_id, 'ajuste', 0, 
            NOW(), 'precio', 
            CONCAT('Cambio de precio: ', OLD.precio_venta, ' -> ', NEW.precio_venta)
        );
    END IF;
END //
DELIMITER ;

-- 3. Trigger que alerte sobre stock mínimo
DELIMITER //
CREATE TRIGGER AlertaStockMinimo
AFTER UPDATE ON Inventario
FOR EACH ROW
BEGIN
    DECLARE v_producto_nombre VARCHAR(150);
    DECLARE v_almacen_nombre VARCHAR(100);
    
    IF NEW.cantidad <= NEW.stock_minimo AND OLD.cantidad > NEW.stock_minimo THEN
        -- Obtener nombres para el registro
        SELECT nombre INTO v_producto_nombre FROM Productos WHERE producto_id = NEW.producto_id;
        SELECT nombre INTO v_almacen_nombre FROM Almacenes WHERE almacen_id = NEW.almacen_id;
        
        -- Registrar incidencia
        INSERT INTO Incidencias (
            tipo_incidencia, fecha_reportada, estado, prioridad,
            descripcion, tipo_referencia, referencia_id, impacto
        ) VALUES (
            'stock', NOW(), 'Abierta', 'Alta',
            CONCAT('Stock mínimo alcanzado para ', v_producto_nombre, ' en ', v_almacen_nombre, 
                  '. Stock actual: ', NEW.cantidad, ', Mínimo: ', NEW.stock_minimo),
            'inventario', NEW.inventario_id, 'Alto'
        );
    END IF;
END //
DELIMITER ;

-- 4. Trigger que actualice el estado de los envíos
DELIMITER //
CREATE TRIGGER ActualizarEstadoEnvio
BEFORE UPDATE ON Envios
FOR EACH ROW
BEGIN
    -- Si se está actualizando la fecha de entrega real, marcar como entregado
    IF NEW.fecha_entrega_real IS NOT NULL AND OLD.fecha_entrega_real IS NULL THEN
        SET NEW.estado_envio = 'Entregado';
        
        -- Registrar en rendimiento logístico
        INSERT INTO Rendimiento_Logistico (
            fecha, almacen_id, ruta_id, vehiculo_id, usuario_id,
            cantidad_envios, entregas_tiempo, entregas_retrasadas,
            tiempo_promedio_entrega, distancia_recorrida, costo_total
        ) VALUES (
            CURDATE(), 
            (SELECT origen_id FROM Rutas WHERE ruta_id = NEW.ruta_id),
            NEW.ruta_id,
            NEW.vehiculo_id,
            NEW.conductor_id,
            1,
            CASE WHEN NEW.fecha_entrega_real <= NEW.fecha_entrega_estimada THEN 1 ELSE 0 END,
            CASE WHEN NEW.fecha_entrega_real > NEW.fecha_entrega_estimada THEN 1 ELSE 0 END,
            TIMESTAMPDIFF(MINUTE, NEW.fecha_envio, NEW.fecha_entrega_real),
            (SELECT distancia_total FROM Rutas WHERE ruta_id = NEW.ruta_id),
            NEW.costo_envio
        );
    END IF;
END //
-- ========================================
-- FUNCIONES DE LOGÍSTICA Y ENVÍO
-- ========================================

-- 1. Función: Calcular Tiempo de Entrega
DELIMITER //
CREATE FUNCTION CalcularTiempoEntrega(
    p_ruta_id INT,
    p_numero_paradas INT
) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_tiempo_base INT;
    DECLARE v_tiempo_por_parada INT DEFAULT 15;
    DECLARE v_tiempo_total INT;
    
    -- Obtener tiempo base de la ruta
    SELECT tiempo_estimado INTO v_tiempo_base
    FROM Rutas
    WHERE ruta_id = p_ruta_id;
    
    -- Calcular tiempo total
    SET v_tiempo_total = v_tiempo_base + (p_numero_paradas * v_tiempo_por_parada);
    
    RETURN v_tiempo_total;
END //
DELIMITER ;

-- 2. Función: Calcular Costo de Envío
DELIMITER //
CREATE FUNCTION CalcularCostoEnvio(
    p_distancia DECIMAL(10,2),
    p_peso DECIMAL(10,2),
    p_volumen DECIMAL(10,2),
    p_urgente BOOLEAN
) RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_costo_base DECIMAL(10,2) DEFAULT 5.00;
    DECLARE v_costo_distancia DECIMAL(10,2);
    DECLARE v_costo_peso DECIMAL(10,2);
    DECLARE v_costo_volumen DECIMAL(10,2);
    DECLARE v_costo_total DECIMAL(12,2);
    
    -- Costo por distancia
    SET v_costo_distancia = p_distancia * 0.15;
    
    -- Costo por peso
    IF p_peso > 5 THEN
        SET v_costo_peso = (p_peso - 5) * 0.10;
    ELSE
        SET v_costo_peso = 0;
    END IF;
    
    -- Costo por volumen
    IF p_volumen > 0.5 THEN
        SET v_costo_volumen = (p_volumen - 0.5) * 0.05;
    ELSE
        SET v_costo_volumen = 0;
    END IF;
    
    -- Sumar todos los costos
    SET v_costo_total = v_costo_base + v_costo_distancia + v_costo_peso + v_costo_volumen;
    
    -- Recargo por urgente
    IF p_urgente THEN
        SET v_costo_total = v_costo_total * 1.5;
    END IF;
    
    RETURN ROUND(v_costo_total, 2);
END //
DELIMITER ;

-- 3. Función: Determinar Ruta Más Eficiente
DELIMITER //
CREATE FUNCTION DeterminarRutaMasEficiente(
    p_almacen_id INT,
    p_destino_ciudad VARCHAR(100),
    p_destino_codigo_postal VARCHAR(20)
) RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_ruta_id INT;
    DECLARE v_coincidencia_exacta INT;
    
    -- Buscar coincidencia exacta por código postal
    SELECT r.ruta_id INTO v_coincidencia_exacta
    FROM Rutas r
    JOIN Puntos_Ruta pr ON r.ruta_id = pr.ruta_id
    WHERE r.origen_id = p_almacen_id
      AND pr.codigo_postal = p_destino_codigo_postal
      AND pr.tipo_punto = 'destino'
    LIMIT 1;
    
    IF v_coincidencia_exacta IS NOT NULL THEN
        RETURN v_coincidencia_exacta;
    END IF;
    
    -- Buscar por ciudad si no hay coincidencia exacta
    SELECT r.ruta_id INTO v_ruta_id
    FROM Rutas r
    JOIN Puntos_Ruta pr ON r.ruta_id = pr.ruta_id
    WHERE r.origen_id = p_almacen_id
      AND pr.ciudad = p_destino_ciudad
      AND pr.tipo_punto = 'destino'
    ORDER BY (
        SELECT AVG(rl.eficiencia_carga)
        FROM Rendimiento_Logistico rl
        WHERE rl.ruta_id = r.ruta_id
    ) DESC
    LIMIT 1;
    
    RETURN v_ruta_id;
END //
DELIMITER ;

-- 4. Función: Calcular Descuento por Volumen
DELIMITER //
CREATE FUNCTION CalcularDescuentoVolumen(
    p_cliente_id INT,
    p_total_compra DECIMAL(12,2),
    p_cantidad_items INT
) RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_descuento DECIMAL(5,2) DEFAULT 0;
    DECLARE v_tipo_cliente VARCHAR(50);
    DECLARE v_compras_previas INT;
    
    -- Obtener tipo de cliente
    SELECT tipo_cliente INTO v_tipo_cliente
    FROM Clientes
    WHERE cliente_id = p_cliente_id;
    
    -- Compras previas en los últimos 6 meses
    SELECT COUNT(*) INTO v_compras_previas
    FROM Ventas
    WHERE cliente_id = p_cliente_id
      AND fecha_venta >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
    
    -- Reglas de descuento
    IF v_tipo_cliente = 'corporativo' THEN
        SET v_descuento = LEAST(20, v_descuento + 5);
    END IF;
    
    IF p_total_compra > 1000 THEN
        SET v_descuento = LEAST(20, v_descuento + 5);
    END IF;
    
    IF p_cantidad_items > 10 THEN
        SET v_descuento = LEAST(20, v_descuento + 3);
    END IF;
    
    IF v_compras_previas > 5 THEN
        SET v_descuento = LEAST(20, v_descuento + 2);
    END IF;
    
    RETURN ROUND(p_total_compra * v_descuento / 100, 2);
END //
DELIMITER ;


-- 1. Eficiencia logística
SELECT 
    r.nombre AS ruta,
    a.nombre AS almacen_origen,
    COUNT(e.envio_id) AS total_envios,
    SUM(CASE WHEN e.estado_envio = 'Entregado' AND e.fecha_entrega_real <= e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_a_tiempo,
    SUM(CASE WHEN e.estado_envio = 'Entregado' AND e.fecha_entrega_real > e.fecha_entrega_estimada THEN 1 ELSE 0 END) AS entregas_retrasadas,
    AVG(TIMESTAMPDIFF(MINUTE, e.fecha_envio, e.fecha_entrega_real)) AS tiempo_promedio_min,
    SUM(e.costo_envio) AS costo_total_envios,
    SUM(e.costo_envio) / COUNT(e.envio_id) AS costo_promedio_por_envio,
    (SUM(CASE WHEN e.estado_envio = 'Entregado' AND e.fecha_entrega_real <= e.fecha_entrega_estimada THEN 1 ELSE 0 END) / COUNT(e.envio_id)) * 100 AS porcentaje_entregas_a_tiempo
FROM 
    Rutas r
JOIN 
    Almacenes a ON r.origen_id = a.almacen_id
LEFT JOIN 
    Envios e ON r.ruta_id = e.ruta_id
WHERE 
    DATE(e.fecha_envio) BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    r.nombre, a.nombre
ORDER BY 
    porcentaje_entregas_a_tiempo DESC;

-- 2. Análisis de ventas
SELECT 
    MONTH(v.fecha_venta) AS mes,
    cp.nombre AS categoria,
    SUM(dv.cantidad) AS cantidad_vendida,
    SUM(dv.total) AS ingresos_totales,
    SUM(dv.total) / SUM(SUM(dv.total)) OVER (PARTITION BY MONTH(v.fecha_venta)) * 100 AS porcentaje_mensual,
    c.ciudad,
    c.estado_provincia AS region
FROM 
    Ventas v
JOIN 
    Detalles_Venta dv ON v.venta_id = dv.venta_id
JOIN 
    Productos p ON dv.producto_id = p.producto_id
JOIN 
    Categorias_Productos cp ON p.categoria_id = cp.categoria_id
JOIN 
    Clientes c ON v.cliente_id = c.cliente_id
WHERE 
    YEAR(v.fecha_venta) = 2023
GROUP BY 
    MONTH(v.fecha_venta), cp.nombre, c.ciudad, c.estado_provincia
ORDER BY 
    mes, ingresos_totales DESC;

-- 3. Gestión de inventario
SELECT 
    p.nombre AS producto,
    cp.nombre AS categoria,
    SUM(i.cantidad) AS stock_total,
    AVG(i.stock_minimo) AS stock_minimo_promedio,
    AVG(i.stock_maximo) AS stock_maximo_promedio,
    SUM(CASE WHEN i.cantidad <= i.stock_minimo THEN i.cantidad ELSE 0 END) AS cantidad_bajo_stock,
    SUM(CASE WHEN i.fecha_vencimiento < CURDATE() THEN i.cantidad ELSE 0 END) AS cantidad_vencida,
    SUM(CASE WHEN i.fecha_vencimiento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY) THEN i.cantidad ELSE 0 END) AS cantidad_por_vencer,
    COUNT(DISTINCT CASE WHEN i.cantidad > 0 THEN i.almacen_id ELSE NULL END) AS almacenes_con_stock,
    (SELECT COUNT(*) FROM Detalles_Venta dv WHERE dv.producto_id = p.producto_id AND YEAR(DATE((SELECT fecha_venta FROM Ventas WHERE venta_id = dv.venta_id))) = YEAR(CURDATE())) AS ventas_este_anio,
    SUM(i.cantidad) / NULLIF((SELECT COUNT(*) FROM Detalles_Venta dv WHERE dv.producto_id = p.producto_id AND YEAR(DATE((SELECT fecha_venta FROM Ventas WHERE venta_id = dv.venta_id))) = YEAR(CURDATE())), 1) AS meses_inventario
FROM 
    Productos p
JOIN 
    Categorias_Productos cp ON p.categoria_id = cp.categoria_id
JOIN 
    Inventario i ON p.producto_id = i.producto_id
GROUP BY 
    p.nombre, cp.nombre
HAVING 
    stock_total > 0 OR cantidad_bajo_stock > 0 OR cantidad_vencida > 0
ORDER BY 
    cantidad_bajo_stock DESC, cantidad_vencida DESC;

-- 4. Rendimiento de proveedores
SELECT 
    pr.nombre_empresa AS proveedor,
    pr.calificacion AS calificacion_actual,
    COUNT(c.compra_id) AS total_compras,
    SUM(c.total) AS volumen_total,
    AVG(DATEDIFF(c.fecha_entrega_estimada, c.fecha_compra)) AS tiempo_entrega_promedio,
    SUM(CASE WHEN c.estado_compra = 'Completada' THEN 1 ELSE 0 END) / COUNT(c.compra_id) * 100 AS porcentaje_completadas,
    AVG(dc.cantidad_recibida / dc.cantidad) * 100 AS porcentaje_cantidad_recibida,
    SUM(CASE WHEN dc.estado = 'Devuelto' THEN 1 ELSE 0 END) AS productos_devueltos,
    AVG(DATEDIFF((SELECT MAX(fecha_movimiento) FROM Movimientos_Inventario mi 
                 WHERE mi.referencia_id = c.compra_id AND mi.tipo_referencia = 'compra'), 
                 c.fecha_compra)) AS tiempo_procesamiento_promedio
FROM 
    Proveedores pr
LEFT JOIN 
    Compras c ON pr.proveedor_id = c.proveedor_id
LEFT JOIN 
    Detalles_Compra dc ON c.compra_id = dc.compra_id
WHERE 
    YEAR(c.fecha_compra) = YEAR(CURDATE())
GROUP BY 
    pr.nombre_empresa, pr.calificacion
ORDER BY 
    porcentaje_completadas DESC, porcentaje_cantidad_recibida DESC;