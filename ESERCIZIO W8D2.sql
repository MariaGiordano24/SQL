CREATE DATABASE Azienda;
USE Azienda;

CREATE TABLE Region (
    id_region INT AUTO_INCREMENT PRIMARY KEY,
    nome_citta VARCHAR(50),
    nome_regione VARCHAR(50),
    area_geografica VARCHAR(50),
    nazione VARCHAR(50)
);

CREATE TABLE Store (
    id_store INT AUTO_INCREMENT PRIMARY KEY,
    nome_store VARCHAR(40),
    data_apertura DATE NOT NULL,
    indirizzo VARCHAR(50),
    cap VARCHAR(10),
    telefono VARCHAR(30),
    email VARCHAR(50),
    id_region INT,
    FOREIGN KEY (id_region) REFERENCES Region(id_region)
);

INSERT INTO Region (nome_citta, nome_regione, area_geografica, nazione) VALUES
('Napoli', 'Campania', 'Sud Italia', 'Italia'),
('Firenze', 'Toscana', 'Centro Italia', 'Italia'),
('Roma', 'Lazio', 'Centro Italia', 'Italia'),
('Milano', 'Lombardia', 'Nord Italia', 'Italia'),
('Palermo', 'Sicilia', 'Sud Italia', 'Italia');

SELECT * FROM Region;

INSERT INTO Store (nome_store, data_apertura, indirizzo, cap, telefono, email, id_region) VALUES
('Sorbillo Napoli', '2018-03-15', 'Via Toledo 10', '80100', '081223344', 'napoli@sorbillo.it', 1),
('Fashion Firenze', '2019-06-20', 'Via Roma 15', '50100', '055334455', 'firenze@fashion.it', 2),
('Food Roma', '2020-10-10', 'Via del Corso 45', '00100', '066554433', 'roma@food.it', 3),
('TechWorld Milano', '2017-01-05', 'Corso Buenos Aires 20', '20100', '029998877', 'milano@techworld.it', 4),
('Food Palermo', '2021-09-12', 'Via Maqueda 12', '90100', '091112233', 'palermo@food.it', 5);

SELECT * FROM Store;

START TRANSACTION;
UPDATE Store
SET indirizzo = 'Via Toledo 14'
WHERE id_store = 1;

DELETE FROM Store
WHERE id_store = 5;
ROLLBACK;







