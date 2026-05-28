INSERT INTO src2_regions (codeREG,nomREG) VALUES ('RA', 'Rhône-Alpes');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('Pi', 'Picardie');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('Au', 'Auvergne');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('PACA', 'Provence-Alpes-Côte-d''Azur');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('CA', 'Champagne-Ardenne');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('MP', 'Midi-Pyrénées');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('LR', 'Languedoc-Roussillon');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('BN', 'Basse-Normandie');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('PC', 'Poitou-Charentes');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('Ce', 'Centre');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('Li', 'Limousin');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('Co', 'Corse');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('Bo', 'Bourgogne');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('Br', 'Bretagne');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('Aq', 'Aquitaine');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('FC', 'Franche-Comté');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('HN', 'Haute-Normandie');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('PL', 'Pays de la Loire');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('Lo', 'Lorraine');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('NPC', 'Nord-Pas-de-Calais');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('Al', 'Alsace');
INSERT INTO src2_regions (codeREG,nomREG) VALUES ('IdF', 'Ile-de-France');

COMMIT;

UPDATE src2_regions SET codePays = 'FR';

COMMIT;
