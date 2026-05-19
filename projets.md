---
layout: default
title: Projets
---
[Accueil](index.md) | [Projets](projets.md) | [Expérience](experience.md) | [Compétences](competences.md) | [Formation](formation.md) | [Contact](contact.md)

# Mes projets

Voici une sélection de projets réalisés durant mon **BUT Sciences des Données et mon Master MIAGE**.

---

# Projet Data – Analyse des données Open DAMIR

**Date :** Avril 2026  
**Université :** Université Toulouse Capitole  
**Lieu :** Toulouse, France  

---

## Objectif

Mettre en place une **architecture médaillon (Bronze - Silver - Gold)** afin d’optimiser le stockage, la transformation et l’analyse de données de santé à grande échelle.

Le projet porte sur le **traitement et l’analyse des datasets massifs de remboursements de soins de l’Assurance Maladie (Open DAMIR)** couvrant la période **mai 2015 à mai 2025**, représentant environ **200 millions de lignes par mois**.

---

## Architecture et pipeline de données

Mise en place d’un **pipeline de données basé sur l’architecture Bronze - Silver - Gold** afin de transformer les données brutes en datasets analytiques optimisés.

### Bronze Layer
- Ingestion des données brutes **Open DAMIR**
- Format source : `.csv.gz`
- Stockage des données brutes sans transformation

### Silver Layer
- Nettoyage et transformation des données
- Standardisation des formats
- Filtrage et enrichissement des données

### Gold Layer
- Création de **datasets analytiques optimisés**
- Format cible : **`.parquet`**
- Structuration pour l’analyse décisionnelle

---

## Technologies utilisées

### DuckDB
Utilisation de **DuckDB** pour :
- Stocker localement des datasets volumineux
- Interroger efficacement les données analytiques
- Exécuter des transformations SQL sur des fichiers Parquet

### Modélisation des données
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

---

## Visualisation et analyse

Création de **tableaux de bord Power BI** permettant :

- l’analyse des **dépenses de la CPAM**
- l’étude du **recours aux soins des patients**
- l’exploration temporelle et territoriale des remboursements

---

## Résultats attendus

- Pipeline de données reproductible et scalable
- Amélioration des performances d’analyse sur des datasets massifs
- Visualisation claire des tendances de dépenses de santé
- Support à l’analyse du système de remboursement de l’Assurance Maladie

---

## Volume de données

- **Période analysée :** 2015-05 → 2025-05  
- **Volume mensuel :** ~200 millions de lignes  
- **Formats utilisés :**
  - Source : `.csv.gz`
  - Analytique : `.parquet`

➡ Voir le projet : /projets/pipeline-data
