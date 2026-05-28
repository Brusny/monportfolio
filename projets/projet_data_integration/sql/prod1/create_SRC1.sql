--------------------------------------------------------------------------
-- TP OWB - script de création de la BD source 1
--------------------------------------------------------------------------
-- Auteur(s) : Olivier Teste, Gilles Hubert
-- Dernière modification : Ronan Tournier
-- Date modif : 01/04/2020
--------------------------------------------------------------------------
-- BD contenant les information de vente de produits
--------------------------------------------------------------------------

DROP TABLE src1_vendre cascade constraint;
DROP TABLE src1_produits cascade constraint;
DROP TABLE src1_magasins cascade constraint;
DROP TABLE src1_categories cascade constraint;
DROP TABLE src1_marques cascade constraint;
DROP TABLE src1_enseignes cascade constraint;
COMMIT;

CREATE TABLE src1_enseignes (
	codeS INTEGER,
	desigS VARCHAR2(30),
	siege VARCHAR2(30),
	ca NUMBER,
	minitel VARCHAR2(30),
	web VARCHAR2(30)
	);

ALTER TABLE src1_enseignes
ADD CONSTRAINT pk_enseignes PRIMARY KEY (codeS);

CREATE TABLE src1_magasins (
	raisonSoc VARCHAR2(30),
	tel VARCHAR2(10),
	adrCP decimal(5),
	adrVILLE VARCHAR2(30),
	codeS INTEGER
	);

ALTER TABLE src1_magasins
ADD CONSTRAINT pk_magasins PRIMARY KEY (raisonSoc);

ALTER TABLE src1_magasins
ADD CONSTRAINT fk_magasins_enseignes FOREIGN KEY (codeS) REFERENCES src1_enseignes (codeS);

CREATE TABLE src1_categories (
	codeC INTEGER,
	desigC VARCHAR2(30),
	codeSupC INTEGER
	);

ALTER TABLE src1_categories
ADD CONSTRAINT pk_categories PRIMARY KEY (codeC);

ALTER TABLE src1_categories
ADD CONSTRAINT fk_categories_categories FOREIGN KEY (codeSupC) REFERENCES src1_categories (codeC);

CREATE TABLE src1_marques (
	codeM INTEGER,
	desigM VARCHAR2(30)
	);

ALTER TABLE src1_marques
ADD CONSTRAINT pk_marques PRIMARY KEY (codeM);

CREATE TABLE src1_produits (
	codeP INTEGER,
	desigP VARCHAR2(50),
	prixU FLOAT,
    cout FLOAT,
	codeC INTEGER,
	codeM INTEGER
	);

ALTER TABLE src1_produits
ADD CONSTRAINT pk_produits PRIMARY KEY (codeP);

ALTER TABLE src1_produits
ADD CONSTRAINT fk_produits_categories FOREIGN KEY (codeC) REFERENCES src1_categories (codeC);

ALTER TABLE src1_produits
ADD CONSTRAINT fk_produits_marques FOREIGN KEY (codeM) REFERENCES src1_marques (codeM);

CREATE TABLE src1_vendre (
	codeP INTEGER,
	raisonSoc VARCHAR2(30),
	qte NUMBER,
    dateV DATE
	);

ALTER TABLE src1_vendre
ADD CONSTRAINT pk_vendre PRIMARY KEY (codeP, raisonSoc, dateV);

ALTER TABLE src1_vendre
ADD CONSTRAINT fk_vendre_produits FOREIGN KEY (codeP) REFERENCES src1_produits (codeP);

ALTER TABLE src1_vendre
ADD CONSTRAINT fk_vendre_magasins FOREIGN KEY (raisonSoc) REFERENCES src1_magasins (raisonSoc);


COMMIT;


---------------------
--!!             !!--
--!!  ATTENTION  !!--
--!!             !!--
---------------------
--Il est nécessaire d'adapter les répertoires ci-dessous

@"D:\Master 1 Toulouse Capitole\Intégration des données\Exercice de synthèse\scripts\prod1\insert_categories.sql"
@"D:\Master 1 Toulouse Capitole\Intégration des données\Exercice de synthèse\scripts\prod1\insert_marques.sql"
@"D:\Master 1 Toulouse Capitole\Intégration des données\Exercice de synthèse\scripts\prod1\insert_produits.sql"
@"D:\Master 1 Toulouse Capitole\Intégration des données\Exercice de synthèse\scripts\prod1\insert_enseignes.sql"
@"D:\Master 1 Toulouse Capitole\Intégration des données\Exercice de synthèse\scripts\prod1\insert_magasins.sql"
@"D:\Master 1 Toulouse Capitole\Intégration des données\Exercice de synthèse\scripts\prod1\insert_vendre_S1_00.sql"
COMMIT;
