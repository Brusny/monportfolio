-------------------------------------------------------------------
-- script de TP ETL via Talend OS - Data Integrator
-------------------------------------------------------------------
-- auteur : 	Ronan.Tournier@ut-capitole.fr
-- date : 		08.04.2018
-- der. modif.: 08.04.2018
-------------------------------------------------------------------
-- SCRIPT POUR EFFACER LE CONTENU DE L'ENTREPOT DE DONNEES
-------------------------------------------------------------------

--réinitialisation des tables
DELETE FROM DW_VENTES;
DELETE FROM DW_PRODUITS;
DELETE FROM DW_MARQUES;
DELETE FROM DW_CATEGORIES;
DELETE FROM DW_MAGASINS;
DELETE FROM DW_GEOGRAPHIES;
--validation
COMMIT;

--réinitialisation de la séquence (des fois qu'elle ait été utilisée)
DROP SEQUENCE SEQ_MAGASINS;
CREATE SEQUENCE SEQ_MAGASINS 
	INCREMENT BY 1 START WITH 1 NOMAXVALUE NOMINVALUE NOCYCLE CACHE 20 NOORDER;
