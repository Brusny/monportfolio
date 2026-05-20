---
layout: default
title: Projets
---
[Accueil](index.md) | [Projets](projets.md) | [Expérience](experience.md) | [Compétences](competences.md) | [Formation](formation.md) | [Contact](contact.md)

# 📂 Mes projets académiques

Voici une sélection de projets réalisés durant mon **BUT Sciences des Données et mon Master MIAGE**.

---

## Projet Data – Analyse des données Open DAMIR
  
📅 **Date :** Avril 2026  
🏫 **Université :** Université Toulouse Capitole  
📍 **Lieu :** Toulouse, France  

---

### 🎯 Objectif

Mettre en place une **architecture médaillon (Bronze - Silver - Gold)** afin d’optimiser le stockage, la transformation et l’analyse de données de santé à grande échelle.

Le projet porte sur le **traitement et l’analyse des datasets massifs de remboursements de soins de l’Assurance Maladie (Open DAMIR)** couvrant la période **mai 2015 à mai 2025**, représentant environ **200 millions de lignes par mois**.

---

### 🤖 Architecture et pipeline de données

Mise en place d’un **pipeline de données basé sur l’architecture Bronze - Silver - Gold** afin de transformer les données brutes en datasets analytiques optimisés.

![Architecture Bronze Silver Gold](projets/img/architecture_medallion.png)

---

### 🛠️ Technologies utilisées

#### DuckDB
Utilisation de **DuckDB** pour :
- Stocker localement des datasets volumineux
- Interroger efficacement les données analytiques
- Exécuter des transformations SQL sur des fichiers Parquet

#### Modélisation des données
Conception d’un **modèle en étoile (Star Schema)** afin de structurer :

- **Tables de faits**
  - remboursements de soins
  - actes médicaux
  - dépenses

- **Tables de dimensions**
  - patients
  - professionnels de santé
  - actes médicaux
  - temporalité

  ![Modélisation décisionnelle](projets/img/star_modele.jpg)

---

### 📊 Visualisation et analyse

Création de **tableaux de bord Power BI** permettant :

- l’analyse des **dépenses de la CPAM**
  ![Rapport Analyse des dépenses](projets/img/analyse_depense.gif)
  
  ![Rapport Analyse des dépenses](projets/img/analyse_depense2.gif)
- l’étude du **recours aux soins des patients**
  ![Rapport recours aux soins](projets/img/analyse_recours_soins.gif)
- l’exploration temporelle et territoriale des remboursements

---

### Résultats attendus

- Pipeline de données reproductible et scalable
- Amélioration des performances d’analyse sur des datasets massifs
- Visualisation claire des tendances de dépenses de santé
- Support à l’analyse du système de remboursement de l’Assurance Maladie

---

### Volume de données

- **Période analysée :** 2015-05 → 2025-05  
- **Volume mensuel :** ~200 millions de lignes  
- **Formats utilisés :**
  - Source : `.csv.gz`
  - Analytique : `.parquet`
  ![Réduction de la volumétrie des données](projets/img/reduction_volumetrie.png)

➡ Voir le projet : [projets/projet_data_engineering/](https://github.com/Brusny/monportfolio/tree/main/projets/projet_data_engineering)

---

## Projet Data Integration ETL

📅 **Date :** 2026  
🏫 **Université :** Université Toulouse Capitole  
📍 **Lieu :** Toulouse, France  

---

### 🎯 Objectif

Mise en œuvre d’un projet complet de **Data Integration ETL** avec **Talend Open Studio** visant à :

- intégrer plusieurs sources de données hétérogènes,
- construire un **entrepôt de données (Data Warehouse)**,
- créer un **magasin de données (Data Mart)**,
- automatiser les flux ETL,
- permettre l’analyse décisionnelle via un outil OLAP.

Le projet s’appuie sur deux bases de production Oracle :

- **Production 1** : données commerciales et ventes
- **Production 2** : données géographiques françaises

---

### 🏗️ Architecture du projet

  ![Modélisation OLAP](projets/projet_data_integration/img/modelisation_olap.png)
  
---

## Projet Machine Learning – Prédiction d’acceptation de crédit  

📅 **Date :** Mars 2026  
🏫 **Université :** Université Toulouse Capitole  
📍 **Lieu :** Toulouse, France  

### 📌 Description

Développement d’un **pipeline de classification** pour prédire l’acceptation de prêts bancaires à partir de **données clients**.

---

### ⚙️ Prétraitement des données

- Encodage des **variables catégorielles**
- Gestion des **valeurs manquantes**
- **Standardisation** des variables

---

### 🔎 Sélection des variables

- Utilisation de **Feature Selection** pour identifier les variables les plus pertinentes.

---

### 🤖 Modèles de Machine Learning

Entraînement et comparaison de plusieurs modèles :

- **SVM (Support Vector Machine)**
- **KNN (K-Nearest Neighbors)**
- **Régression Logistique**
- **Decision Tree**
- **Random Forest**
- **XGBoost**
- **MLP (Multi-Layer Perceptron)**

---

### 🎯 Optimisation des hyperparamètres

- Recherche des meilleurs paramètres avec **GridSearchCV**.

---

### 📊 Évaluation des performances

Les modèles sont évalués à l’aide des métriques suivantes :

- **Accuracy**
- **Precision**
- **Recall**
- **F1-score**

---

### 🛠️ Technologies utilisées

- **Python**
- **Pandas**
- **NumPy**
- **Scikit-learn**
- **XGBoost**
- **Seaborn**

➡ Voir le projet : /projets/pipeline-data
