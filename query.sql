-- Crear tabla de usuarios
CREATE TABLE usuarios (
    id_usu SERIAL PRIMARY KEY,
    nom_pri VARCHAR(50),
    nom_sec VARCHAR(50),
    ape_pat VARCHAR(50),
    ape_mat VARCHAR(50),
    edad INT,
    ciudad VARCHAR(100),
    pais VARCHAR(100),
    telf VARCHAR(30),
    email VARCHAR(100) UNIQUE,
    fecha_registro DATE
);

-- Crear tabla de wallets
CREATE TABLE wallets (
    id_wallet SERIAL PRIMARY KEY,
    id_usu INT REFERENCES usuarios(id_usu),
    wallet_address VARCHAR(100) UNIQUE,
    crypto_balance NUMERIC(18,2),
    tipo_moneda VARCHAR(10),
    fecha_creacion DATE
);

-- Crear tabla de transacciones
CREATE TABLE transacciones (
    id_trans SERIAL PRIMARY KEY,
    id_wallet INT REFERENCES wallets(id_wallet),
    fecha DATE,
    tipo_operacion VARCHAR(30),
    monto NUMERIC(18,2),
    moneda VARCHAR(10),
    descripcion TEXT
);


-- Insertar usuarios
INSERT INTO usuarios (nom_pri, nom_sec, ape_pat, ape_mat, edad, ciudad, pais, telf, email, fecha_registro) VALUES
('Carlos', 'Miguel', 'Sánchez', 'Pérez', 32, 'Cochabamba', 'Bolivia', '77777777', 'carlos@example.com', '2021-01-10'),
('Ana', 'Lucía', 'Martínez', 'Gómez', 27, 'La Paz', 'Bolivia', '71234567', 'ana@example.com', '2022-03-05');

-- Insertar wallets
INSERT INTO wallets (id_usu, wallet_address, crypto_balance, tipo_moneda, fecha_creacion) VALUES
(1, 'abc123xyz456', 1.23, 'BTC', '2021-01-15'),
(1, 'def789uvw000', 100.00, 'USDT', '2021-06-01'),
(2, 'ghi000rst999', 0.75, 'ETH', '2022-04-01');

-- Insertar transacciones
INSERT INTO transacciones (id_wallet, fecha, tipo_operacion, monto, moneda, descripcion) VALUES
(1, '2023-01-01', 'compra', 0.5, 'BTC', 'Compra en Binance'),
(2, '2023-02-10', 'transferencia', 25.0, 'USDT', 'Transferencia a wallet externa'),
(3, '2023-03-15', 'venta', 0.3, 'ETH', 'Venta parcial en exchange');



-- Ver usuarios
SELECT * FROM usuarios;

-- Ver wallets con datos de usuarios
SELECT w.*, u.nom_pri, u.ape_pat FROM wallets w
JOIN usuarios u ON w.id_usu = u.id_usu;

-- Ver transacciones con datos de wallets
SELECT t.*, w.wallet_address FROM transacciones t
JOIN wallets w ON t.id_wallet = w.id_wallet;
