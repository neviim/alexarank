BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS sites(
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   nome VARCHAR(30),
   rank INTEGER DEFAULT NULL
);
INSERT INTO sites (nome, rank) VALUES('vaticano.va', 0);
INSERT INTO sites (nome, rank) VALUES('cancaonova.com', 0);
INSERT INTO sites (nome, rank) VALUES('ewtn.com', 0);
INSERT INTO sites (nome, rank) VALUES('zenit.org', 0);
INSERT INTO sites (nome, rank) VALUES('cnbb.org.br', 0);
INSERT INTO sites (nome, rank) VALUES('tvseculo21.org.br', 0);
INSERT INTO sites (nome, rank) VALUES('santuarionacional.com', 0);
INSERT INTO sites (nome, rank) VALUES('asj.org.br', 0);
INSERT INTO sites (nome, rank) VALUES('a12.com', 0);
COMMIT;

