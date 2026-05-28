--------------------------------------------------------------------------
-- TP OWB - script de création de la BD source 2
--------------------------------------------------------------------------
-- Auteur(s) : Olivier Teste, Gilles Hubert
-- Dernière modification : Ronan Tournier
-- Date modif : 27/11/2016
--------------------------------------------------------------------------
-- BD contenant les information de :
--   -> départements français (et nb habitants)
--	 -> régions françaises
--	 -> pays (limité à la France)
--
-- RMQ : il manque la date de recensement du nombre d'habitants 
--		 par département (a voir si ces chiffres sont toujours à jour)
--------------------------------------------------------------------------

--destruction des tables
DROP TABLE src2_departements CASCADE CONSTRAINT;
DROP TABLE src2_regions CASCADE CONSTRAINT;
DROP TABLE src2_pays CASCADE CONSTRAINTS;
COMMIT;

--table des départements
CREATE TABLE src2_departements (
	idDEPT VARCHAR2(2),
	nomDEPT VARCHAR2(30),
	nbHab NUMBER,
    codeR VARCHAR2(4)
	);
--clé primaire des départements
ALTER TABLE src2_departements
ADD CONSTRAINT pk_departements PRIMARY KEY (idDEPT);

--table des régions françaises
CREATE TABLE src2_regions (
	codeREG VARCHAR2(4),
	nomREG VARCHAR2(30),
	codePays VARCHAR2(2)
	);
--clé primaire des régions
ALTER TABLE src2_regions
ADD CONSTRAINT pk_regions PRIMARY KEY (codeREG);

--clé étrangère département->région
ALTER TABLE src2_departements
ADD CONSTRAINT fk_departements_regions FOREIGN KEY (codeR) REFERENCES src2_regions (codeREG);

--table des pays
CREATE TABLE src2_pays (
	codePA VARCHAR2(2),
	nomPA VARCHAR2(30)
	);
ALTER TABLE src2_pays
ADD CONSTRAINT pk_pays PRIMARY KEY (codePA);

--clé étrangère région-> pays
ALTER TABLE src2_regions
ADD CONSTRAINT fk_regions_pays FOREIGN KEY (codePays) REFERENCES src2_pays (codePA);


COMMIT;

---------------------
--!!             !!--
--!!  ATTENTION  !!--
--!!             !!--
---------------------
--Il est nécessaire d'adapter les répertoires ci-dessous
--chargement des données
@"D:\Master 1 Toulouse Capitole\Intégration des données\Exercice de synthèse\scripts\prod2\insert_pays.sql"
@"D:\Master 1 Toulouse Capitole\Intégration des données\Exercice de synthèse\scripts\prod2\insert_regions.sql"
@"D:\Master 1 Toulouse Capitole\Intégration des données\Exercice de synthèse\scripts\prod2\insert_departements.sql"
COMMIT;


