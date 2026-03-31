CREATE DATABASE ToysGroup;
USE ToysGroup;


CREATE TABLE Region ( 
			ID_Region INT AUTO_INCREMENT PRIMARY KEY,
			Area_Geografica VARCHAR(50) NOT NULL,
            Stato VARCHAR(50) NOT NULL,
			Nome_Regione VARCHAR(50) NOT NULL
 );
 
 CREATE TABLE Product (
			ID_Product INT AUTO_INCREMENT PRIMARY KEY, 
            Nome_prodotto VARCHAR(50) NOT NULL,
            Categoria_Prodotto VARCHAR(50) NOT NULL,
			Prezzo DECIMAL (7,2) 
 );
 
 CREATE TABLE Sales (
			ID_Sales INT AUTO_INCREMENT PRIMARY KEY,
            Quantita INT NOT NULL, 
			Data_Vendita DATE NOT NULL,
            ID_Product INT, 
            ID_Region INT, 
 CONSTRAINT FK_Sales_Product FOREIGN KEY (ID_Product) REFERENCES Product(ID_Product), 
 CONSTRAINT FK_Sales_Region FOREIGN KEY (ID_Region) REFERENCES Region(ID_Region)
 );
 
INSERT INTO Region (Area_Geografica, Stato, Nome_Regione) VALUES
('Europa', 'Francia', 'Est Europa'),
('Europa', 'Italia', 'Sud Europa'),
('Asia', 'Giappone', 'Est Asia'),
('America', 'USA', 'Nord America'),
('Europa', 'Germania', 'Est Europa'),
('Europa', 'Spagna', 'Sud Europa'),
('Asia', 'Cina', 'Est Asia'),
('America', 'Canada', 'Nord America');

SELECT * FROM Region;

INSERT INTO Product (Nome_prodotto, Categoria_Prodotto, Prezzo) VALUES
('Costruzioni Lego', 'Costruzioni', 75.00),
('Treno Elettrico', 'Veicoli', 100.00),
('Macchina Telecomandata', 'Veicoli', 125.00),
('Carte', 'Giochi da tavolo', 8.00),
('Puzzle 500 Pezzi', 'Puzzle', 12.00),
('Bambola', 'Bambole', 30.00),
('Costruzioni Lego Base', 'Costruzioni', 50.00),
('Puzzle 1000 Pezzi', 'Puzzle', 18.00),
('Bambola Gigante', 'Bambole', 40.00);

SELECT * FROM Product;

INSERT INTO Sales (Quantita, Data_Vendita, ID_Product, ID_Region) VALUES
(1, '2025-06-10', 1, 1),
(3, '2025-01-05', 2, 5),
(1, '2025-03-15', 3, 3),
(4, '2025-08-24', 4, 4),
(2, '2025-09-08', 8, 2),
(5, '2025-10-16', 6, 8),
(3, '2025-07-05', 5, 7),
(4, '2025-05-20', 7, 6);

SELECT * FROM Sales;

#Task4. 
#4.1)Verificare che i campi definiti come PK siano univoci per tutte e tre le tabelle.

#Per ciascuna tabella conto quante volte compare ogni valore della PK, se il conteggio è maggiore di 1 significa che ci sono duplicati.
SELECT ID_Region, 
COUNT(*) AS Conteggio
FROM Region
GROUP BY ID_Region
HAVING COUNT(*) > 1;

SELECT ID_Product, 
COUNT(*) AS Conteggio
FROM Product
GROUP BY ID_Product
HAVING COUNT(*) > 1;

SELECT ID_Sales, 
COUNT(*) AS Conteggio
FROM Sales
GROUP BY ID_Sales
HAVING COUNT(*) > 1;

# 4.2)Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data, il nome del prodotto, 
#la categoria del prodotto, il nome dello stato, il nome della regione di vendita e un campo booleano valorizzato in base alla condizione
# che siano passati più di 180 giorni dalla data vendita o meno (>180 -> True, <= 180 -> False).

#Seleziono il codice documento, la data, il nome del prodotto, la categoria, lo stato e la regione di vendita
#aggiungo un campo calcolato che indica TRUE se sono passati più di 180 giorni dalla vendita,altrimenti FALSE.
#utilizzo JOIN tra Sales, Product e Region per collegare i dati corretti.

SELECT 
    s.ID_Sales AS Codice_Documento,
    s.Data_Vendita,
    p.Nome_Prodotto,
    p.Categoria_Prodotto,
    r.Stato AS Nome_Stato,
    r.Nome_Regione AS Nome_Regione_Vendita,
IF(DATEDIFF(CURDATE(), s.Data_Vendita) > 180, 'TRUE', 'FALSE') AS Oltre_180_Giorni
FROM Sales s
JOIN Region r ON s.ID_Region = r.ID_Region
JOIN Product p ON s.ID_Product = p.ID_Product;

#4.3)Esporre l’elenco dei prodotti che hanno venduto, in totale, una quantità maggiore della media delle vendite realizzate
# nell’ultimo anno censito. (ogni valore della condizione deve risultare da una query e non deve essere inserito a mano).
# Nel result set devono comparire solo il codice prodotto e il totale venduto.

#Nella seguente query ho estratto l'anno dalla data di vendita.
SELECT 
      Data_Vendita,
YEAR(Data_Vendita) AS Anno_Vendita
FROM Sales;

#La seguente query è una subquery che calcola la media delle quantità vendute nell'anno estratto (2025).
SELECT 
      AVG(Quantita) AS Media_Quantita
FROM Sales
WHERE YEAR(Data_Vendita) = 2025;

#Questa query restituisce l'elenco dei prodotti che hanno venduto più della media delle vendite nell'anno 2025,
#raggruppa i record per ID_Prodotto, calcola il totale venduto per ogni prodotto con SUM(Quantita) e con HAVING
#confronta il totale venduto di ciascun prodotto con la media delle vendite dell'anno.
SELECT 
      s.ID_Product AS ID_Prodotto,
SUM(s.Quantita) AS Totale_Venduto
FROM Sales s
WHERE YEAR(s.Data_Vendita) = 2025
GROUP BY s.ID_Product
HAVING SUM(s.Quantita) > (
                          SELECT AVG(Quantita)
FROM Sales
WHERE YEAR(Data_Vendita) = 2025
);

#4.4)Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno. 

#In questa query calcolo il fatturato totale moltiplicando la quantità per il prezzo,
#faccio la JOIN tra Product e Sales per avere tutte le informazioni,
#raggruppo i dati per anno di vendita e prodotto e infine ordino i risultati per fatturato decrescente.
SELECT 
      s.ID_Product AS ID_Prodotto,
      p.Nome_Prodotto,
YEAR(s.Data_Vendita) AS Anno_Vendita,
SUM(s.Quantita * p.Prezzo) AS Fatturato_Totale
FROM Sales s
JOIN Product p ON s.ID_Product = p.ID_Product
GROUP BY s.ID_Product, p.Nome_Prodotto,
YEAR(s.Data_Vendita)
ORDER BY Anno_Vendita, Fatturato_Totale DESC;

#4.5)Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente.

#In questa query ricalcolo il fatturato totale esponendolo per stato e per anno,
#raggruppando per entrambi e ordinando i risultati in modo decrescente in base al fatturato.
SELECT 
      r.Stato,
YEAR(s.Data_Vendita) AS Anno_Vendita,
SUM(s.Quantita * p.Prezzo) AS Fatturato_Totale
FROM Sales s 
JOIN Product p ON s.ID_Product = p.ID_Product
JOIN Region r ON s.ID_Region = r.ID_Region
GROUP BY r.Stato, YEAR(s.Data_Vendita)
ORDER BY Anno_Vendita, Fatturato_Totale DESC;

#4.6)Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?

#In questa query individuo la categoria di articoli più richiesta dal mercato,sommando le quantità vendute per ciascuna categoria.
SELECT 
    p.Categoria_Prodotto,
    SUM(s.Quantita) AS Totale_Quantita_Venduta
FROM Product p
JOIN Sales s ON p.ID_Product = s.ID_Product
GROUP BY p.Categoria_Prodotto
ORDER BY Totale_Quantita_Venduta DESC;

#4.7)Rispondere alla seguente domanda: quali sono i prodotti invenduti? Proponi due approcci risolutivi differenti.

#Estraggo l'elenco dei prodotti invenduti, utilizzo LEFT JOIN tra Product e Sales per includere tutti i prodotti
#filtro con WHERE per selezionare solo quelli senza vendite.
SELECT 
    p.ID_Product,
    p.Nome_Prodotto
FROM Product p
LEFT JOIN Sales s ON p.ID_Product = s.ID_Product
WHERE s.ID_Product IS NULL;

#4.8)Creare una vista sui prodotti in modo tale da esporre una “versione denormalizzata” delle informazioni utili 
#(codice prodotto, nome prodotto, nome categoria).

#Creo la vista 'Product_View' che contiene le principali informazioni sui prodotti.
#Successivamente, eseguo un SELECT * dalla vista per visualizzare la tabella virtuale con i dati.
CREATE VIEW Product_View AS
SELECT 
       ID_Product AS Codice_Prodotto,
	   Nome_Prodotto,
       Categoria_Prodotto
FROM Product;

SELECT * FROM Product_View;

#4.9)Creare una vista per le informazioni geografiche.

#Creo la vista 'Region_View' che contiene le principali informazioni geografiche.
#Successivamente, eseguo un SELECT * dalla vista per visualizzare la tabella virtuale con i dati.
CREATE VIEW Region_View AS
SELECT 
	  ID_Region AS Codice_Regione,
      Nome_Regione,
      Area_Geografica,
      Stato
FROM Region;

SELECT * FROM Region_View;


#Creo una VIEW con l'unione delle tre tabelle per avere un result set chiaro con le informazioni principali.
CREATE VIEW Product_Sales_Region_View AS
SELECT 
    p.ID_Product AS Codice_Prodotto,
    p.Nome_Prodotto,
    p.Categoria_Prodotto,
    r.Nome_Regione,
    r.Area_Geografica,
    r.Stato,
    SUM(s.Quantita * p.Prezzo) AS Importo_Totale
FROM Sales s
JOIN Product p ON s.ID_Product = p.ID_Product
JOIN Region r ON s.ID_Region = r.ID_Region
GROUP BY 
    p.ID_Product,
    p.Nome_Prodotto,
    p.Categoria_Prodotto,
    r.Nome_Regione,
    r.Area_Geografica,
    r.Stato;
    
#Eseguo un SELECT * dalla vista per visualizzare la tabella virtuale con i dati.
SELECT * FROM Product_Sales_Region_View;

#Eseguo un SELECT * dalla vista e ordino i risultati per Importo_Totale in ordine decrescente,
# in questo modo vedo prima i prodotti/regione con le vendite più alte.
SELECT *
FROM Product_Sales_Region_View
ORDER BY Importo_Totale DESC;





