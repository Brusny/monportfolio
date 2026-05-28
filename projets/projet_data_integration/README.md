# 🚀 Projet d’Intégration de Données — Talend & Oracle

## 📌 Présentation du projet

Ce projet a pour objectif de mettre en œuvre une chaîne complète d’intégration de données à l’aide de **Talend Open Studio** et de bases de données **Oracle**.

L’architecture repose sur :

* Deux bases de données de production (`PROD1` et `PROD2`)
* Un **Entrepôt de Données (Data Warehouse)** (`DW`)
* Un **Magasin de Données (Data Mart)** (`MD`)
* Un outil OLAP pour l’analyse décisionnelle

Le projet couvre :

✅ L’extraction des données
✅ Les transformations ETL
✅ Le chargement dans un Data Warehouse
✅ La création d’un Data Mart multidimensionnel
✅ L’automatisation des traitements Talend
✅ La documentation des mappings et dictionnaires de données

---

# 🏗️ Architecture globale

![Architecture Data Integration](https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80\&w=1400\&auto=format\&fit=crop)

```text
             ┌─────────────────┐
             │   PROD1 Oracle  │
             │ Données ventes  │
             └────────┬────────┘
                      │
                      │
             ┌────────▼────────┐
             │     Talend      │
             │ ETL / Mapping   │
             └────────┬────────┘
                      │
             ┌────────▼────────┐
             │ Data Warehouse  │
             │       DW        │
             └────────┬────────┘
                      │
             ┌────────▼────────┐
             │   Data Mart     │
             │       MD        │
             └────────┬────────┘
                      │
             ┌────────▼────────┐
             │   Power BI /    │
             │ Tableau / OLAP  │
             └─────────────────┘

             ┌─────────────────┐
             │   PROD2 Oracle  │
             │ Données géo     │
             └─────────────────┘
```

---

# 🧰 Technologies utilisées

| Technologie        | Rôle                           |
| ------------------ | ------------------------------ |
| Talend Open Studio | Développement ETL              |
| Oracle Database    | Stockage des données           |
| SQL                | Manipulation et transformation |
| Power BI / Tableau | Analyse OLAP                   |
| Git / GitHub       | Versioning                     |

---

# 📂 Structure du projet

```bash
project/
│
├── jobs/
│   ├── create_dw/
│   ├── load_dw/
│   ├── create_md/
│   └── load_md/
│
├── metadata/
│   ├── prod1/
│   ├── prod2/
│   ├── dw/
│   └── md/
│
├── sql/
│   ├── prod1/
│   ├── prod2/
│   ├── warehouse/
│   └── datamart/
│
├── docs/
│   ├── dictionnaires/
│   ├── mappings/
│   └── screenshots/
│
└── README.md
```

---

# 🗄️ Sources de données

## 📦 Production 1 — Données commerciales

Contient :

* Enseignes
* Magasins
* Produits
* Marques
* Catégories
* Ventes

### Exemple de tables

| Table          | Description                |
| -------------- | -------------------------- |
| SRC1_ENSEIGNES | Informations des enseignes |
| SRC1_MAGASINS  | Informations magasins      |
| SRC1_PRODUITS  | Catalogue produits         |
| SRC1_VENDRE    | Historique des ventes      |

---

## 🌍 Production 2 — Données géographiques

Contient :

* Régions françaises
* Départements
* Population

### Exemple de tables

| Table             | Description        |
| ----------------- | ------------------ |
| SRC2_REGIONS      | Régions françaises |
| SRC2_DEPARTEMENTS | Départements       |

---

# 🏢 Data Warehouse (DW)

![Data Warehouse](https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80\&w=1400\&auto=format\&fit=crop)

Le Data Warehouse centralise les données des deux productions.

## Tables principales

| Table          | Description           |
| -------------- | --------------------- |
| DW_MARQUES     | Marques produits      |
| DW_CATEGORIES  | Catégories            |
| DW_PRODUITS    | Produits              |
| DW_MAGASINS    | Magasins              |
| DW_GEOGRAPHIES | Données géographiques |
| DW_VENTES      | Historique des ventes |

---

# 🔄 Processus ETL

## Étapes d’intégration

### 1️⃣ Extraction

Lecture des données depuis :

* PROD1
* PROD2

via connecteurs Oracle Talend.

---

### 2️⃣ Transformation

Transformations réalisées :

* Jointures
* Nettoyage des données
* Uniformisation des types
* Génération de clés techniques
* Mapping des dimensions

---

### 3️⃣ Chargement

Insertion des données dans :

* Data Warehouse
* Data Mart

via jobs Talend automatisés.

---

# ⭐ Data Mart multidimensionnel

![OLAP](https://images.unsplash.com/photo-1558494949-ef010cbdcc31?q=80\&w=1400\&auto=format\&fit=crop)

Le magasin de données est construit selon un modèle en étoile.

## Dimensions

| Dimension  | Description |
| ---------- | ----------- |
| D_PRODUITS | Produits    |
| D_MAGASINS | Magasins    |
| D_TEMPS    | Temps       |

## Table de faits

| Table    | Description            |
| -------- | ---------------------- |
| F_VENTES | Quantités et bénéfices |

---

# 📊 Exemple de KPIs

* Quantité vendue par mois
* Bénéfice par produit
* Analyse régionale des ventes
* Performance des enseignes
* Répartition géographique

---

# ⚙️ Exécution des jobs Talend

## Ordre d’exécution

```text
1. Création DW
2. Chargement DW
3. Création MD
4. Chargement MD
```

## Vérifications attendues

| Table          | Nombre de lignes |
| -------------- | ---------------- |
| DW_MARQUES     | 21               |
| DW_CATEGORIES  | 25               |
| DW_GEOGRAPHIES | 95               |
| DW_MAGASINS    | 224              |
| DW_PRODUITS    | 93               |
| DW_VENTES      | 54600            |

---

# 📖 Documentation

Le projet contient :

* Dictionnaires de données
* Mapping source → destination
* Captures d’exécution Talend
* Scripts SQL
* Documentation ETL

---

# 🖼️ Illustrations recommandées

Ajouter dans `/docs/images/` :

| Image                 | Utilisation          |
| --------------------- | -------------------- |
| architecture.png      | Architecture globale |
| talend_jobs.png       | Jobs Talend          |
| dw_schema.png         | Schéma DW            |
| star_schema.png       | Modèle en étoile     |
| powerbi_dashboard.png | Dashboard OLAP       |

---

# 🚧 Difficultés rencontrées

* Gestion des clés étrangères
* Ordonnancement des chargements
* Génération des clés techniques
* Agrégation des données temporelles
* Synchronisation des jobs Talend

---

# ✅ Résultat final

Le projet permet :

✔️ Une intégration complète des données
✔️ Une centralisation dans un entrepôt Oracle
✔️ Une modélisation multidimensionnelle
✔️ Une analyse décisionnelle performante
✔️ Une automatisation ETL robuste

---

# 👨‍💻 Auteur

Projet réalisé dans le cadre d’un exercice de synthèse en intégration de données avec Talend et Oracle.

---

# 📜 Licence

Projet académique / pédagogique.
