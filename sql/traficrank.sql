BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS traficrank(
   idcodigo INTEGER PRIMARY KEY,
   rankwod  INTEGER DEFAULT NULL,
   rankbra  INTEGER DEFAULT NULL,
   lnksite  INTEGER DEFAULT NULL,
   rankyest INTEGER DEFAULT NULL,
   chanyest INTEGER DEFAULT NULL,
   statyest INTEGER DEFAULT NULL,
   rankdia7 INTEGER DEFAULT NULL,
   chandia7 INTEGER DEFAULT NULL,
   statdia7 INTEGER DEFAULT NULL,
   rankmes1 INTEGER DEFAULT NULL,
   chanmes1 INTEGER DEFAULT NULL, 
   statmes1 INTEGER DEFAULT NULL,
   rankmes3 INTEGER DEFAULT NULL,
   chanmes3 INTEGER DEFAULT NULL,
   statmes3 INTEGER DEFAULT NULL,
   timestap DATE
);
INSERT INTO traficrank (idcodigo,rankwd,rankbr,linksite,med7dia,med1mes,med3mes,cha7dia,cha1mes,cha3mes,timestp) VALUES(2,17714,393,837,15022,17146,17714,1616,520,2216,DATETIME('NOW'));
COMMIT;
