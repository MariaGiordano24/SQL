# 🗄️ Progetto SQL — ToysGroup Database

Progetto finale del modulo **SQL & Database** — Epicode.  
Progettazione e implementazione di un database relazionale per la gestione delle vendite di un'azienda di distribuzione giocattoli in diverse aree geografiche del mondo.

---

## 📋 Descrizione del progetto

Il progetto prende spunto da uno scenario reale: **ToysGroup** è un'azienda che distribuisce giocattoli in mercati internazionali, classificati per regioni di vendita. A partire da questo scenario, è stato progettato e implementato un database relazionale completo, dalla fase concettuale fino all'implementazione fisica in SQL Server.

---

## 🔍 Fasi del progetto

### 1. Domande teoriche
Risposta a domande fondamentali sui concetti di database: definizione di DBMS, clausole SELECT, logica di GROUP BY, differenza OLTP/OLAP, JOIN vs subquery, operatori logici, DDL e DML.

### 2. Progettazione concettuale — Schema E/R
Modellazione delle entità coinvolte nello scenario con relative relazioni e cardinalità:

- **Product** — con gerarchia categoria → prodotto
- **Region** — con gerarchia regione → stato
- **Sales** — tabella dei fatti che collega prodotti e regioni

### 3. Progettazione logica — Schema delle tabelle
Definizione di tutte le colonne, chiavi primarie (PK), chiavi esterne (FK) e cardinalità delle relazioni, con l'obiettivo di garantire **integrità referenziale** e **minimizzare la ridondanza**.

### 4. Implementazione fisica — DDL
Creazione fisica delle tabelle tramite istruzioni `CREATE TABLE` in MySQL Workbench, con definizione di tipi di dato, vincoli e relazioni tra le tabelle.

### 5. Popolamento delle tabelle — DML
Inserimento di dati di esempio tramite istruzioni `INSERT INTO` per ogni tabella del database.

### 6. Query di analisi
Serie di query SQL per rispondere a domande di business:

| # | Analisi |
|---|---|
| 1 | Verifica univocità delle chiavi primarie (PK) per ogni tabella |
| 2 | Elenco transazioni con dettaglio prodotto, categoria, stato, regione e flag >180 giorni |
| 3 | Prodotti con vendite totali superiori alla media dell'ultimo anno censito |
| 4 | Fatturato totale per prodotto per anno (solo prodotti venduti) |
| 5 | Fatturato totale per stato per anno, ordinato per data e fatturato decrescente |
| 6 | Categoria di prodotti più richiesta dal mercato |
| 7 | Prodotti invenduti — due approcci risolutivi differenti |
| 8 | Vista denormalizzata sui prodotti (codice, nome, categoria) |
| 9 | Vista per le informazioni geografiche |

---

## 🛠️ Tecnologie utilizzate

| Strumento | Utilizzo |
|---|---|
| MySQL Workbench | DBMS per l'implementazione fisica |
| DDL (CREATE TABLE) | Definizione struttura del database |
| DML (INSERT, SELECT) | Popolamento e interrogazione dati |
| Excel | Progettazione logica delle tabelle |

---

## 📁 Note

Nella repository sono presenti anche altri esercizi svolti durante il modulo, utilizzati come pratica per consolidare le competenze SQL.

---

## 👤 Autore

Maria Giordano
