-------------------------------------------------------------------
-- script de TP ETL via Talend OS - Data Integrator
-------------------------------------------------------------------
-- auteur : 	Ronan.Tournier@ut-capitole.fr
-- date : 		08.11.2014
-- der. modif.: 08.04.2018
-------------------------------------------------------------------
-- SCRIPT DE CREATION DU MAGASIN DE DONNEES (TP3)
-------------------------------------------------------------------


-------------------------------------------------------------------
-- Destruction des structures du magasin de données
-------------------------------------------------------------------
DROP TABLE F_VENTES;
DROP TABLE D_MAGASINS;
DROP TABLE D_PRODUITS;
DROP TABLE D_TEMPS;


-------------------------------------------------------------------
-- Création des structures du magasin de données
-------------------------------------------------------------------
--création des tables de dimensions
CREATE TABLE D_MAGASINS (
	Code_Mag 		INTEGER,
	Nom_Mag 		VARCHAR2(30),
	Nom_Enseigne 	VARCHAR2(30),
	Ville 			VARCHAR2(30),
	Departement 	VARCHAR2(2),
	Libelle_Depart 	VARCHAR2(30),
	Region 			VARCHAR2(30),
	CONSTRAINT pk_dmagasins PRIMARY KEY (Code_Mag)
	);
CREATE TABLE D_PRODUITS (
	Code_Pro 	INTEGER,
	Libelle_Pro VARCHAR2(50),
	Categorie 	VARCHAR2(30),
	Classe 		VARCHAR2(30),
	Marque 		VARCHAR2(30),
	CONSTRAINT pk_dproduits PRIMARY KEY (Code_Pro)
	);
CREATE TABLE D_TEMPS (
	Mois 		 VARCHAR2(7),
	Libelle_Mois VARCHAR2(9),
	Trimestre 	 VARCHAR2(6),
	Annee 		 VARCHAR2(4),
	CONSTRAINT pk_dtemps PRIMARY KEY (Mois)
	);

--Création de la table de fait
CREATE TABLE F_VENTES (
	Code_Mag INTEGER,
	Code_Pro INTEGER,
	Mois 	 VARCHAR(7),
	Quantite INTEGER,
	Benefice FLOAT,
	CONSTRAINT pk_fventes PRIMARY KEY (Code_Mag,Code_Pro,Mois)	
	);
--Ajout des clefs étrangères de la table du fait
ALTER TABLE F_VENTES ADD (
	CONSTRAINT fk_fventes_dmagasins FOREIGN KEY (Code_Mag) REFERENCES D_MAGASINS (Code_Mag),
	CONSTRAINT fk_fventes_dproduits FOREIGN KEY (Code_Pro) REFERENCES D_PRODUITS (Code_Pro),
	CONSTRAINT fk_fventes_dtemps FOREIGN KEY (Mois) REFERENCES D_TEMPS (Mois)
	);