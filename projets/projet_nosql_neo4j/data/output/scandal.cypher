// Script
LOAD CSV WITH HEADERS FROM 'file:///scandal.csv' AS row
FIELDTERMINATOR ';'
MERGE (n0:saison {num_saison: row.num_saison, nom_saison: row.nom_saison, date_debut_saison: row.date_debut_saison, date_fin_saison: row.date_fin_saison})
MERGE (n1:episode {num_episode: row.num_episode, resume_episode: row.resume_episode})
MERGE (n2:pays {nom_pays: row.nom_pays})
MERGE (n1)-[:est_contenu]->(n0)
MERGE (n1)-[:avoir {titre_episode: row.nom_episode}]->(n2)
MERGE (n3:personnage {nom_personnage: COALESCE(row.nom_personnage, 'Unknown'), prenom_personnage:COALESCE(row.prenom_personnage, 'Unknown')})

MERGE (n7:personnage:president{nom_personnage:"Grant", prenom_personnage:"Fitzgerald"})
MERGE (n8:personnage:president{nom_personnage:"Grant", prenom_personnage:"Meillie"})

MERGE (n4:acteur {nom_acteur: row.nom_acteur, prenom_acteur:row.prenom_acteur})
MERGE (n4)-[:interprete]->(n3)
MERGE (n5:type_personnage {libelle_personnage: COALESCE(row.libelle_type, 'Unknown')})
MERGE (n3)-[:joue{role: COALESCE(row.description_role, 'Unknown')}]->(n1)
MERGE (n3)-[:etre]->(n5)
MERGE (n6:cabinet{nom_cabinet: COALESCE(row.cabinet, 'Unknown')})
MERGE (n3)-[:travaille]->(n6)
MERGE (n6)-[:aide{type_aide: COALESCE(row.type_aide, 'Unknown'), num_saison: COALESCE(row.num_saison, 'Unknown'), num_episode: COALESCE(row.num_episode, 'Unknown')}]->(n3)
;

// MATCH(c:cabinet{nom_cabinet: 'Unknown'}) DETACH DELETE c;

// MATCH (n:president{prenom_personnage: "Fitzgerald"}), (m:saison{num_saison: "S01"})
// WITH n, m
// CREATE (n)-[:dirige_dans]->(m);

// MATCH (n:president{prenom_personnage: "Fitzgerald"}), (m:saison{num_saison: "S02"})
// WITH n, m
// CREATE (n)-[:dirige_dans]->(m);

// MATCH (n:president{prenom_personnage: "Fitzgerald"}), (m:saison{num_saison: "S03"})
// WITH n, m
// CREATE (n)-[:dirige_dans]->(m);

// MATCH (n:president{prenom_personnage: "Fitzgerald"}), (m:saison{num_saison: "S04"})
// WITH n, m
// CREATE (n)-[:dirige_dans]->(m);

// MATCH (n:president{prenom_personnage: "Fitzgerald"}), (m:saison{num_saison: "S05"})
// WITH n, m
// CREATE (n)-[:dirige_dans]->(m);

// MATCH (n:president{prenom_personnage: "Meillie"}), (m:saison{num_saison: "S06"})
// WITH n, m
// CREATE (n)-[:dirige_dans]->(m);

// MATCH (n:president{prenom_personnage: "Meillie"}), (m:saison{num_saison: "S07"})
// WITH n, m
// CREATE (n)-[:dirige_dans]->(m);
