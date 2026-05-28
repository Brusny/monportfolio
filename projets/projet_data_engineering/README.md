# Projet d'exploration des données DAMIR

> [Open Damir](https://www.assurance-maladie.ameli.fr/etudes-et-donnees/open-damir-depenses-sante-interregimes) : cette base de données mensuelle présente les remboursements de soins effectués par l'ensemble des régimes d'assurance maladie (base complète) en France depuis 2009.

## Ce projet

Un pêle mêle de scripts sql (DuckDB 🦆) & pyton
pour
- télécharger automatiquement les fichiers damir
- parser les données damir en .parquet
- qq explorations sur le pouce


### Notes sur DuckDB 🦆🚀

[DuckDB](https://duckdb.org/) est une BDD OLAP (analytique) super rapide, légère (25Mo) & opensource

En plus de leur super site internet,<br> voici un [📹 webinaire "Quels usages pour DuckDB"](https://www.youtube.com/watch?v=pzTVUm1ifA0) avec Stéphane Heckel & moi-même sur [Datanosco](http://datanosco.com/)

## Revue de litterature

La **page de téléchargement** des données [open damir](https://www.assurance-maladie.ameli.fr/etudes-et-donnees/open-damir-depenses-sante-interregimes) & sa documentation

le [répot github](https://github.com/SGMAP-AGD/DAMIR) du [**hackathon** d'etalab](https://www.etalab.gouv.fr/retour-sur-le-premier-hackathon-donnees-de-sante/) en 2015

## Documentation

> Au total, chaque ligne de prestation est décrite par 55 variables. - **doc Open Damir**

### Axes d'analyse

* **Période de traitement** & rembourserment (année / mois)
* **Prestation** : date de soin, type d'actes ...
* Organisme de prise en charge
* **Bénéficiaire** du soin : sexe, age, région...
* **Exécutant** : région, catégorie
* **Prescripteur** : région, catégorie
* Périmètre CMU-C

### Indicateurs agrégés (volumes & montants)

> ![memoire_2022_principeRbstPrestationSante](./docs/memoire_2022_principeRbstPrestationSante.png)  <br>-> page 43 mémoire Mme Boyer

#### Volumes

| Indicateur  | Définition   | Note |
| :----- | :------ | :------ |
| `ACT_QTE` | Quantité | Nb d'actes réalisés |
| `ACT_COG` | Coefficient Global | `quantité x coefficient tarifé de l'acte` |
| `ACT_NBR` | Dénombrement | Parfois incomplet, privilégier la quantité |

#### Montants

| Indicateur  | Définition   | Note |
| :----- | :------ | :------ |
| `PAI_MNT` | Montant de la Dépense | Frais réels de la prestation de santé |
| `REM_BSE` | Base de Remboursement | Montant défini par la *sécu* |
| `REM_MNT` | Montant Versé/Remboursé par la *sécu* | `REM_BSE * ACT_QTE * taux de remboursement` |
| `DEP_MNT` | Montant du Dépassement | `PAI_MNT - REM_MNT` - les remboursements de la *sécu* uniquement |


### Exploration sur l'utilité des dimensions/colonnes/axes

Vous retrouverez dans le dossier [dim_damir_colonnes](./dim_damir_colonnes/)

* L'[Excel](https://www.assurance-maladie.ameli.fr/content/descriptif-des-variables-de-la-serie-open-damir-base-complete) descriptif des variables Open Damir
* 1 script `.sql` pour extraire les infos de l'Excel en .csv
* 1 script `.python` pour
  * calculer l'usage respectifs des clés dans `A202401.parquet`
  * extraire 1 .csv par dimension<br>*💡 Pratique pour avoir de belles dim dans Power BI ...*
* 1 📊 rapport `.pbix` pour explorer les colonnes
  * Combien de valeurs "inconnues" / "sans objet"
  * les colonnes de la catégorie Bénéficiaire & leurs valeurs

![explo_colonnes_damir.pbix](./dim_damir_colonnes/explo_colonnes_damir.pbix.png)

## 1ères explorations avec DuckDB 🦆🚀

### Intérêt du `.parquet`

**Qq chiffres** sur le mois de janvier 2024

|    |            |
| :-- |:-- |
|lignes| 38 millions |
|`.csv.gz`| 1Go |
|`.csv`| 6.5Go |
|`.parquet`| 1.8Go |

💡 Un `.csv` doit être lu en entier pour analyser un échantillion de colonnes. A contrario, le `.parquet` range & compresse les données par colonnes. Lors d'une analyse, on ira lire uniquement les données des colonnes voulues.

```sql
-- transformer un .csv.gz en .parquet ⏱ ~1m30
copy ( from read_csv('input/A202505.csv.gz') )
  to 'data/A202505.parquet';
```

```sql
-- ⏱ ~1m30 -> stats par colonne min/max/count/...
summarize from 'data/A202401.parquet';
```

![summarize_202401](docs/summarize_202401.png)

### 1ère aggrégation par date de soin

en ⏱ 1 min 16s : aggrégation par mois des soins de 2024 pour afficher le nb d'actes & le montant des remboursements de la sécurité sociale

![explore_damir_2024](./docs/explore_damir_2024.png)
