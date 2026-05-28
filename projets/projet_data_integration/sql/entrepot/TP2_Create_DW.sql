-------------------------------------------------------------------
-- script de TP ETL via Talend OS - Data Integrator 5.5.1
-------------------------------------------------------------------
-- auteur : Ronan Tournier
-- date créat : 29.10.2014
-- date modif : 24.03.2026
-------------------------------------------------------------------
-- SCRIPT DE PREPARATION DES STRUCTURES DE L'ENTREPOT DE DONNEES
-------------------------------------------------------------------



-------------------------------------------------------------------
-- Création des tables de l'entrepôt de données
-------------------------------------------------------------------
--destruction des composants de l'entrepôtpôt
DROP SEQUENCE SEQ_MAGASINS;
--destruction des tables de l'entrepôt
DROP TABLE DW_VENTES CASCADE CONSTRAINTS;
DROP TABLE DW_PRODUITS CASCADE CONSTRAINTS;
DROP TABLE DW_MARQUES CASCADE CONSTRAINTS;
DROP TABLE DW_CATEGORIES CASCADE CONSTRAINTS;
DROP TABLE DW_MAGASINS CASCADE CONSTRAINTS;
DROP TABLE DW_GEOGRAPHIES CASCADE CONSTRAINTS;

--possibilité d'utiliser un TRIGGER pour tester la pk_magasins
--décommenter l'instruction DROP ainsi que le CREATE TRIGGER en 
--fin de script
--DROP TRIGGER TRIG_INSERT_MAGASIN;


--création des tables
CREATE TABLE DW_MARQUES (
	Code_Mar  INTEGER,
	Desig_Mar VARCHAR2(30),
	CONSTRAINT pk_dwmarques PRIMARY KEY (Code_Mar)
	);

CREATE TABLE DW_CATEGORIES (
	Code_Cat     INTEGER,
	Desig_Cat 	 VARCHAR2(30),
	Desig_Cat_Sup VARCHAR2(30),
	CONSTRAINT pk_dwcategories PRIMARY KEY (Code_Cat)
	);
--ALTERNATIVE de DW_CATEGORIES (avec code au lieu du nom de la catégorie sup)
--	Commenter le précédent CREATE TABLE, décommenter cette instruction, ainsi que, 
--	plus bas la clé étrangère associée (ALTER TABLE de DW_CATEGORIE)
--CREATE TABLE DW_CATEGORIES (
--	Code_Cat     INTEGER,
--	Desig_Cat 	 VARCHAR2(30),
--	Code_Cat_Sup INTEGER,
--	CONSTRAINT pk_dwcategories PRIMARY KEY (Code_Cat)
--	);
	
CREATE TABLE DW_PRODUITS (
	Code_Pro INTEGER,
	Desig_Pro VARCHAR2(50),
	Prix_Unit FLOAT,
	Cout      FLOAT,
	Code_Cat  INTEGER,
	Code_Mar  INTEGER,
	CONSTRAINT pk_dwproduits PRIMARY KEY (Code_Pro)
	);
	
CREATE TABLE DW_MAGASINS (
	--le contenu sera issus d 'une séquence Oracle
	Code_Mag  INTEGER,
	Desig_Mag VARCHAR2(30),
	Ville     VARCHAR2(30),
	Desig_Ens VARCHAR2(30),
	Code_Dep  VARCHAR2(2),
	CONSTRAINT pk_dwmagasins PRIMARY KEY (Code_Mag)
	);
	
CREATE TABLE DW_VENTES (
	Code_Pro INTEGER,
	Code_Mag INTEGER,
	Date_VT  DATE,
	Qte_VT   INTEGER,
	CONSTRAINT pk_dwventes PRIMARY KEY (Code_Pro, Code_Mag, Date_VT)
	);
	
CREATE TABLE DW_GEOGRAPHIES (
	Code_Dep  VARCHAR2(2),
	Desig_Dep VARCHAR2(30),
	Desig_Reg VARCHAR2(30),
	CONSTRAINT pk_dwgeographies PRIMARY KEY (Code_Dep)
	);
	
--spécification des clef étrangères
--ALTERNATIVE de DW_CATEGORIES (avec code au lieu du nom de la catégorie sup)
--ALTER TABLE DW_CATEGORIES 
--	ADD CONSTRAINT fk_dwcategories_categ FOREIGN KEY (Code_Cat_Sup) REFERENCES DW_CATEGORIES (Code_Cat);
ALTER TABLE DW_PRODUITS ADD (
	CONSTRAINT fk_dwproduits_categories FOREIGN KEY (Code_Cat) REFERENCES DW_CATEGORIES (Code_Cat),
	CONSTRAINT fk_dwproduits_marques FOREIGN KEY (Code_Mar) REFERENCES DW_MARQUES (Code_Mar)
	);
ALTER TABLE DW_MAGASINS
	ADD CONSTRAINT fk_dwmagasins_geographies FOREIGN KEY (Code_Dep) REFERENCES DW_GEOGRAPHIES (Code_Dep);
ALTER TABLE DW_VENTES ADD (
	CONSTRAINT fk_dwventes_produits FOREIGN KEY (Code_Pro) REFERENCES DW_PRODUITS (Code_Pro),
	CONSTRAINT fk_dwventes_magasins FOREIGN KEY (Code_Mag) REFERENCES DW_MAGASINS (Code_Mag)
	);

--création de la séquence
CREATE SEQUENCE SEQ_MAGASINS 
	INCREMENT BY 1 START WITH 1 NOMAXVALUE NOMINVALUE NOCYCLE CACHE 20 NOORDER;


--possibilité d'employer un déclencheur pour gérer la séquence
--NE PAS OUBLIER de décommenter le DROP TRIGGER plus haut

--CREATE OR REPLACE TRIGGER TRIG_INSERT_MAGASIN
--	BEFORE INSERT ON DW_MAGASINS
--	REFERENCES NEW AS NOUV_LIGNE
--	FOR EACH ROW
--	BEGIN
--		SELECT SEQ_MAGASINS.NEXTVAL INTO :NOUV_LIGNE.Code_Mag FROM DUAL;
--	END;
--	/
