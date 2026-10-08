# Migration de données PostgreSQL vers Neo4j

> Projet de migration et de transformation de données d'une base relationnelle PostgreSQL vers une base de données orientée graphe Neo4j.

## 📌 Présentation

Ce projet a pour objectif de mettre en place une solution permettant de **migrer des données entre une base de données relationnelle PostgreSQL et une base de données NoSQL orientée graphe Neo4j**.

L'approche consiste à extraire les données relationnelles, les transformer au format CSV à l'aide de **Python / PySpark**, puis à les intégrer dans Neo4j afin de construire un modèle de données basé sur des **nœuds, relations et propriétés**.

Cette architecture permet notamment de représenter plus naturellement les connexions entre les différentes entités du jeu de données.

## 🎯 Objectifs

* Modéliser les données sous forme de graphe dans Neo4j.
* Extraire les données provenant de sources relationnelles.
* Transformer et préparer les données pour leur migration.
* Utiliser des fichiers CSV comme format intermédiaire.
* Exploiter PySpark pour manipuler les données et exécuter des requêtes SQL.
* Créer les nœuds et relations dans Neo4j.
* Visualiser les données sous forme de graphe.
* Mettre en place une chaîne de migration reproductible.

## 🏗️ Architecture du projet

```text
             PostgreSQL
                  │
                  │ Extraction
                  ▼
          Données relationnelles
                  │
                  │ Transformation
                  ▼
             PySpark / SQL
                  │
                  │ Export
                  ▼
              Fichiers CSV
                  │
                  │ Import
                  ▼
               Neo4j
                  │
                  │ Requêtes Cypher
                  ▼
        Visualisation du graphe
```

## 🧩 Modélisation des données

Contrairement au modèle relationnel basé sur des tables et des clés étrangères, Neo4j représente les informations sous forme de :

* **Nœuds** : représentent les entités du système.
* **Relations** : représentent les connexions entre les entités.
* **Propriétés** : contiennent les informations associées aux nœuds et aux relations.

Cette approche est particulièrement adaptée lorsque les relations entre les différentes entités constituent une partie importante des données.

## 🔄 Pipeline de migration

### 1. Lecture des données

Les données sont récupérées à partir de fichiers CSV.

Les données chargées sont ensuite stockées dans des DataFrames afin de pouvoir être manipulées avec PySpark.

### 2. Création des tables temporaires

Des vues temporaires sont créées à partir des DataFrames.

Elles permettent ensuite d'utiliser des requêtes SQL directement sur les données chargées.

### 3. Transformation avec SQL

Plusieurs opérations de jointure permettent de réunir les données provenant des différentes tables.

Des `LEFT JOIN` sont notamment utilisés lorsque certaines entités peuvent être absentes de certaines tables.

Le résultat des jointures est stocké dans des DataFrames puis utilisé pour construire les vues nécessaires à la suite du traitement.

### 4. Génération du CSV

Les données transformées sont regroupées dans un fichier CSV unique servant de support à l'importation dans Neo4j.

### 5. Import dans Neo4j

Le fichier CSV est ensuite utilisé pour créer la base de données Neo4j.

Des scripts permettent notamment de créer les différents nœuds et relations du graphe. Le projet prévoit également la création de nœuds `Président`, qui n'existaient pas dans le modèle conceptuel initial de la base relationnelle.

### 6. Visualisation

Une fois les données importées, Neo4j permet de visualiser les relations entre les différentes entités sous forme de graphe.

## 🛠️ Technologies utilisées

| Technologie    | Utilisation                                             |
| -------------- | ------------------------------------------------------- |
| **PostgreSQL** | Base de données relationnelle                           |
| **Python**     | Manipulation et traitement des données                  |
| **PySpark**    | Transformation des données et exécution de requêtes SQL |
| **CSV**        | Format intermédiaire pour la migration                  |
| **Neo4j**      | Base de données NoSQL orientée graphe                   |
| **Cypher**     | Requêtes et manipulation des données dans Neo4j         |

## 📂 Organisation possible

```text
.
├── data/
│   ├── input/
│   └── output/
│
├── pyspark/
│   ├── read_csv.py
│   ├── transformations.py
│   └── export_csv.py
│
├── neo4j/
│   ├── import.cypher
│   └── queries.cypher
│
├── README.md
└── documentation/
```

## 🚀 Installation

### Prérequis

* Python 3.x
* Apache Spark / PySpark
* PostgreSQL
* Neo4j
* Java compatible avec la version de Spark utilisée

### Installation des dépendances Python

```bash
pip install pyspark
```

## ▶️ Utilisation

### 1. Préparer les données

Placer les fichiers CSV sources dans le répertoire prévu à cet effet.

```text
data/input/
```

### 2. Lancer les traitements PySpark

Les scripts PySpark permettent de :

1. charger les fichiers CSV ;
2. créer les DataFrames ;
3. créer les vues temporaires ;
4. exécuter les requêtes SQL ;
5. effectuer les jointures ;
6. générer le fichier CSV final.

### 3. Importer les données dans Neo4j

Lancer Neo4j puis exécuter les scripts d'importation présents dans le dossier :

```text
neo4j/
```

### 4. Explorer le graphe

Une fois l'import terminé, les données peuvent être explorées et visualisées directement dans Neo4j.

## 🔍 Exemple de requête Cypher

```cypher
MATCH (n)
RETURN n
LIMIT 50;
```

Cette requête permet d'explorer les premiers éléments présents dans le graphe.

## 📊 Résultat

Le résultat final est une base Neo4j représentant les données sous forme de graphe et permettant d'explorer les relations entre les différentes entités.

Le projet met ainsi en œuvre une chaîne complète :

```text
Extraction
    ↓
Transformation
    ↓
Jointures SQL
    ↓
DataFrames PySpark
    ↓
CSV
    ↓
Import Neo4j
    ↓
Graphe
    ↓
Visualisation
```

## 💡 Compétences développées

* Modélisation de données
* Bases de données relationnelles
* Bases de données NoSQL
* Bases de données orientées graphe
* ETL / migration de données
* Manipulation de données avec PySpark
* SQL
* Cypher
* Transformation de données
* Jointures et agrégation de données
* Visualisation de graphes

## 👥 Projet

**SAÉ 5 – 02 : Migration de données vers ou depuis un environnement NoSQL**

Projet réalisé dans le cadre du **BUT3 – VCOD**, semestre 5, année académique 2024–2025.

---

⭐ **Projet réalisé dans le cadre de ma formation en informatique — spécialisation données / systèmes d'information.**

