# 🧠 Projet ML – Apprentissage Supervisé sur le Dataset Credit

## 📌 Description

Ce projet a été réalisé dans le cadre du module **Machine Learning / Intelligence Artificielle** du Master **MIAGE**.

L’objectif principal est de construire un pipeline complet de **classification supervisée** permettant de prédire l’acceptation ou le refus d’un prêt bancaire à partir du dataset **Credit Loan Prediction**.

Le projet couvre l’ensemble des étapes classiques d’un workflow Machine Learning :

- Prétraitement des données
- Gestion des valeurs manquantes
- Encodage des variables catégorielles
- Standardisation des données
- Sélection de variables (Feature Selection)
- Optimisation des hyperparamètres
- Comparaison de plusieurs algorithmes
- Explicabilité des modèles (SHAP / ICE Plots)
- Ajout de modèles avancés (XGBoost & Réseaux de neurones)

---

# 📂 Structure du projet

```bash
.
├── TP2_credit_correction_fixed.ipynb   # Notebook principal
├── credit.csv                          # Dataset
├── README.md                           # Documentation du projet
└── requirements.txt                    # Dépendances Python
```

---

# 📊 Dataset utilisé

Le dataset utilisé est un dataset de prédiction d’acceptation de prêt bancaire.

## 🎯 Variable cible

- `Loan_Status`
  - Y → prêt accepté
  - N → prêt refusé

## 📌 Exemples de variables explicatives

- `ApplicantIncome`
- `CoapplicantIncome`
- `LoanAmount`
- `Loan_Amount_Term`
- `Credit_History`
- `Education`
- `Property_Area`
- `Married`
- `Dependents`

---

# ⚙️ Pipeline Machine Learning

## 1️⃣ Analyse exploratoire des données

Le notebook commence par :

- Chargement du dataset
- Visualisation des données
- Analyse statistique
- Étude de la distribution des variables
- Identification des valeurs manquantes

### Visualisations utilisées

- Histogrammes
- Heatmap de corrélation
- Analyse de distribution

---

## 2️⃣ Prétraitement des données

### ✔️ Encodage des variables catégorielles

Transformation des variables catégorielles en variables numériques à l’aide de :

```python
OrdinalEncoder
```

### ✔️ Gestion des valeurs manquantes

Méthodes utilisées :

- `SimpleImputer`
- `KNNImputer`

### ✔️ Standardisation des données

Les variables numériques sont standardisées avec :

```python
StandardScaler
```

### ✔️ Split Train / Test

Le dataset est séparé en :

- Ensemble d’entraînement
- Ensemble de test

---

# 🔍 Feature Selection

## 📌 Matrice de corrélation

Une heatmap de corrélation est utilisée afin d’identifier :

- Les variables fortement corrélées
- Les redondances potentielles
- Les variables peu pertinentes

---

## 🌲 Sélection automatique avec Boruta

Le projet utilise l’algorithme **Boruta** avec un `RandomForestClassifier` afin de sélectionner automatiquement les variables les plus importantes.

### Objectifs

- Réduire le bruit
- Améliorer les performances
- Réduire l’overfitting
- Améliorer l’interprétabilité

---

# 🤖 Modèles de Machine Learning testés

## 📌 Régression Logistique

- Modèle baseline
- Optimisation des hyperparamètres

---

## 📌 K-Nearest Neighbors (KNN)

Optimisation des paramètres :

- Nombre de voisins
- Distance
- Pondération

Utilisation de :

```python
GridSearchCV
RandomizedSearchCV
```

---

## 📌 Support Vector Machine (SVM)

Optimisation de :

- Kernel
- C
- Gamma

---

## 🌳 Decision Tree

Optimisation :

- Profondeur maximale
- Critères de split
- Nombre minimal d’échantillons

---

## 🌲 Random Forest

Optimisation :

- Nombre d’arbres
- Profondeur
- Features utilisées

---

## 🚀 XGBoost

Ajout du modèle avancé **XGBoost**.

### Hyperparamètres étudiés

- `max_depth`
- `min_child_weight`
- `gamma`
- `learning_rate`
- `n_estimators`

### Objectif

Comparer les performances de boosting avec les autres modèles.

---

## 🧠 Réseaux de neurones – MLP

Deux architectures principales ont été testées :

### Architecture 1

```text
64 neurones → 32 neurones
Activation : ReLU
```

### Architecture 2

```text
128 neurones → 64 neurones → 32 neurones
Activation : ReLU
```

---

# 📈 Évaluation des modèles

Les modèles sont comparés avec différentes métriques :

- Accuracy
- Precision
- Recall
- F1-Score
- Classification Report

Le projet compare également :

- Les performances sur le train
- Les performances sur le test
- L’écart train/test pour détecter l’overfitting

---

# 🔎 Explicabilité des modèles

## 📌 SHAP Values

Le projet utilise les **SHAP Values** afin de comprendre :

- L’impact des variables sur les prédictions
- Les décisions prises par le modèle
- Les features les plus influentes

### Variables importantes identifiées

- `Credit_History`
- `LoanAmount`
- `ApplicantIncome`

---

## 📌 ICE Plots

Les ICE Plots permettent d’analyser :

- L’effet individuel des variables
- Les variations de prédiction
- Le comportement du modèle selon chaque feature

---

# 🏆 Résultats

Le projet met en évidence :

- L’importance du prétraitement des données
- L’impact de la feature selection
- Les gains liés à l’optimisation des hyperparamètres
- Les différences de comportement entre les modèles
- L’intérêt de l’explicabilité dans les systèmes de décision

Les modèles de type :

- Random Forest
- XGBoost

obtiennent généralement les meilleures performances sur ce dataset.

---

# 🛠️ Technologies utilisées

## 📌 Langage

- Python 3

## 📌 Librairies principales

```python
pandas
numpy
matplotlib
seaborn
scikit-learn
xgboost
shap
boruta
```

---

# ▶️ Installation

## 1️⃣ Cloner le projet

```bash
git clone <repo_url>
cd projet-ml-credit
```

## 2️⃣ Installer les dépendances

```bash
pip install -r requirements.txt
```

---

# ▶️ Exécution

Lancer le notebook Jupyter :

```bash
jupyter notebook
```

Puis ouvrir :

```text
TP2_credit_correction_fixed.ipynb
```

---

# 📚 Concepts Machine Learning abordés

- Classification supervisée
- Prétraitement des données
- Feature Engineering
- Feature Selection
- Hyperparameter Tuning
- Cross Validation
- Ensemble Learning
- Explainable AI (XAI)
- SHAP Values
- Réseaux de neurones

---

# 🎓 Contexte académique

Projet réalisé dans le cadre du cours :

> **TD 2 – Apprentissage supervisé**
> Master 1 MIAGE

Objectifs pédagogiques :

- Réduction du nombre de features
- Compréhension des décisions des modèles
- Implémentation de nouveaux algorithmes
- Analyse de l’explicabilité des modèles

---

# 👨‍💻 Auteur

Projet réalisé dans le cadre d’un TP universitaire de Machine Learning.

---

# 📜 Licence

Projet académique à but pédagogique.


