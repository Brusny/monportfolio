# 🌍 Crop Circle Explorer — Application Web SIG Interactive

![Page d'accueil](projets/projet_sig_web/img/page_accueil.jpg)

## 📌 Présentation du projet

**Crop Circle Explorer** est une application web SIG (Système d’Information Géographique) permettant la visualisation interactive de crop circles sur une carte dynamique.

Le projet a été développé dans le cadre de la SAE6.01-SIG du BUT3 VCOD et propose :

* Une carte interactive basée sur Leaflet
* La visualisation des crop circles au format GeoJSON
* Des outils de filtrage et de statistiques
* La création d’itinéraires
* La création de zones circulaires d’analyse
* Une interface administrateur de gestion des données

---

# 🚀 Fonctionnalités principales

## 🗺️ Carte interactive

* Affichage des crop circles sur une carte Leaflet
* Contrôle des couches cartographiques
* Navigation dynamique
* Zoom et déplacement

---

## 🔍 Filtrage des données

L’utilisateur peut :

* Filtrer les crop circles par année
* Visualiser les résultats instantanément
* Actualiser dynamiquement les couches cartographiques

---

## 🛣️ Création d’itinéraires

Le système permet :

* De définir un point de départ
* De définir un point d’arrivée
* De sélectionner plusieurs crop circles à visiter
* D’afficher l’itinéraire sur la carte

---

## ⭕ Analyse par zone circulaire

L’utilisateur peut :

* Définir un rayon d’analyse
* Générer une zone circulaire
* Obtenir les statistiques des éléments présents dans cette zone

---

## 📊 Statistiques dynamiques

Les résultats sont affichés via :

* Des tableaux dynamiques DataTables
* Des statistiques interactives
* Des listes filtrées

---

## 🔐 Interface administrateur

Le mode administrateur permet :

* Ajouter des données
* Modifier des données
* Supprimer des données
* Gérer les tables SIG

---

# 🧰 Technologies utilisées

| Technologie | Utilisation                   |
| ----------- | ----------------------------- |
| PHP         | Backend                       |
| PostgreSQL  | Base de données               |
| PostGIS     | Gestion des données spatiales |
| Leaflet.js  | Cartographie interactive      |
| GeoJSON     | Données géographiques         |
| JavaScript  | Interactivité                 |
| AJAX        | Communication asynchrone      |
| jQuery      | Manipulation DOM              |
| DataTables  | Tableaux dynamiques           |
| Bootstrap   | Interface utilisateur         |

---

# 🏗️ Architecture du projet

```text id="archi01"
Utilisateur
     │
     ▼
Interface Web (PHP / JS / Leaflet)
     │
     ▼
Requêtes AJAX
     │
     ▼
Backend PHP
     │
     ▼
PostgreSQL + PostGIS
     │
     ▼
Données GeoJSON
```

---

# 📂 Structure du projet

```bash id="folder01"
project/
│
├── index.php
├── carte.php
│
├── config/
│   ├── database.php
│   ├── auth.php
│   └── logout.php
│
├── includes/
│   ├── header.php
│   └── footer.php
│
├── ajax/
│   ├── filtre_annee.php
│   ├── insert.php
│   └── update.php
│
├── assets/
│   ├── css/
│   ├── js/
│   └── images/
│
└── sql/
```

---

# 🗺️ Fonctionnement de la carte

La carte interactive repose sur :

* Leaflet.js
* Des données GeoJSON
* Des requêtes spatiales PostGIS

## 📍 Localisation

La carte est centrée sur le Royaume-Uni :

```javascript id="mapcenter"
[54.63, -3.43]
```

---

# 📡 Gestion des données spatiales

Les données géographiques sont :

* Stockées dans PostgreSQL/PostGIS
* Converties en GeoJSON
* Affichées dynamiquement dans Leaflet

---

# 🔄 Communication AJAX

Le projet utilise AJAX pour :

* Filtrer les données sans recharger la page
* Insérer des données
* Modifier les informations
* Charger dynamiquement les résultats

---

# 📊 Gestion des statistiques

Les statistiques affichées permettent :

* D’analyser les crop circles par zone
* De consulter les éléments présents dans un rayon donné
* D’afficher les résultats dans des tableaux dynamiques

---

# 🔐 Gestion administrateur

## Fonctionnalités disponibles

| Fonction         | Description                  |
| ---------------- | ---------------------------- |
| Authentification | Connexion sécurisée          |
| CRUD             | Gestion complète des données |
| Sessions         | Gestion utilisateur          |
| Administration   | Gestion des tables           |

---

# ⚙️ Installation du projet

## 1️⃣ Cloner le projet

```bash id="clone01"
git clone https://github.com/username/crop-circle-explorer.git
```

---

## 2️⃣ Configurer la base PostgreSQL/PostGIS

Créer une base de données :

```sql id="sql01"
CREATE DATABASE cropcircle;
```

Activer PostGIS :

```sql id="sql02"
CREATE EXTENSION postgis;
```

---

## 3️⃣ Configurer la connexion

Modifier le fichier :

```bash id="config01"
config/database.php
```

---

## 4️⃣ Lancer le serveur

Avec XAMPP, WAMP ou Apache :

```bash id="serve01"
http://localhost/project
```

---

# 📸 Captures d’écran recommandées

Ajouter dans le dossier `/assets/images/` :

| Image          | Description              |
| -------------- | ------------------------ |
| accueil.png    | Page d’accueil           |
| carte.png      | Carte interactive        |
| filtre.png     | Filtrage des données     |
| itineraire.png | Création d’itinéraire    |
| cercle.png     | Analyse circulaire       |
| admin.png      | Interface administrateur |

---

# 🎯 Objectifs pédagogiques

Ce projet permet de mettre en pratique :

* Le développement SIG Web
* L’utilisation de Leaflet
* Les bases de données spatiales PostGIS
* Les requêtes géographiques
* Les traitements AJAX
* L’administration d’une application web

---

# 📜 Licence

Projet pédagogique / universitaire.
