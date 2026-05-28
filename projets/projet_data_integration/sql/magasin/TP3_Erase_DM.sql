-------------------------------------------------------------------
-- script de TP ETL via Talend OS - Data Integrator
-------------------------------------------------------------------
-- auteur : 	Ronan.Tournier@ut-capitole.fr
-- date : 		08.04.2018
-- der. modif.: 08.04.2018
-------------------------------------------------------------------
-- SCRIPT POUR EFFACER LE CONTENU DU MAGASIN DE DONNEES
-------------------------------------------------------------------

DELETE FROM F_VENTES;
DELETE FROM D_MAGASINS;
DELETE FROM D_PRODUITS;
DELETE FROM D_TEMPS;
--validation
COMMIT;