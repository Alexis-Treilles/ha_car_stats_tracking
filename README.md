# Home Assistant – Suivi Automobile

## Description
Cette intégration permet de gérer plusieurs voitures dans Home Assistant avec :
- Historisation complète des pleins et entretiens
- Calcul automatique du coût total (achat + entretien)
- Notifications pour entretiens selon type et échéances km/temps
- Formulaire unique pour la saisie et sélection de la voiture
- Dashboard Lovelace prêt à l’emploi
- Architecture modulaire : ajout/suppression facile de voitures
- Base de données externe ou interne (SQLite, PostgreSQL, MySQL)

---

## Installation
1. Cloner le repo dans le dossier `custom_components` de Home Assistant :
   cd /config/custom_components/
   git clone https://github.com/tonutilisateur/home-assistant-voitures.git

2. Redémarrer Home Assistant.
3. Configurer l’intégration depuis l’UI si `config_flow.py` est présent.
4. Les entités et services sont automatiquement disponibles.

'''

## Structure du repo

home-assistant-voitures/
├── custom_components/
│   └── voitures/
│       ├── __init__.py            # Initialisation du module
│       ├── manifest.json          # Informations sur l’intégration
│       ├── config_flow.py         # Optionnel, configuration via UI
│       ├── sensor.py              # Entités principales (km, coût, pleins, entretiens)
│       ├── services.yaml          # Définition des services Home Assistant
│       ├── dashboards/
│       │   └── ui-lovelace.yaml   # Dashboard Lovelace
│       ├── data/
│       │   └── voitures.sql       # Script SQL pour initialiser la base
│       └── helpers/               # Helpers YAML ou Python
├── README.md
└── LICENSE
---

## Variables backend et entités

### Par voiture
- `voiture_id` : string, identifiant unique (ex: audi_a3, renault_4l)
- `nom_voiture` : string, nom affiché
- `date_achat` : date, date d’achat
- `prix_achat` : float, prix d’achat
- `km_achat` : integer, kilométrage initial

### Pleins
- `date` : date du plein
- `km` : integer, kilométrage actuel
- `litres` : float, litres ajoutés
- `prix_litre` : float, prix par litre
- `note` : string, note facultative

### Entretiens
- `date` : date de l’entretien
- `km` : integer, kilométrage actuel
- `prix_entretien` : float, coût de l’entretien
- `type_entretien` : string, Vidange / Pneus / Contrôle …
- `note` : string, note facultative
- `interval_km` : integer, intervalle kilométrique pour notification
- `interval_temps` : integer, intervalle temporel pour notification

### Statistiques / affichage
- `km_total` : integer, kilométrage total
- `total_entretien` : float, somme des coûts d’entretien
- `total_cout` : float, coût total = prix achat + entretien
- `entretien_todolist` : list, entretiens à venir
- `entretien_notifications` : list, notifications d’entretien proche

---

## Dashboard

- Formulaire unique pour saisir Plein ou Entretien
- Sélecteur de voiture pour afficher les statistiques
- Graphique kilométrage par voiture
- Liste des entretiens à venir
- Notifications pour entretien proche
- Affichage du total coût par voiture (achat + entretien)
- Lovelace YAML prêt à l’emploi : `dashboards/ui-lovelace.yaml`

---

## Base de données

### Tables principales

**voitures**
- id : PK, auto-increment
- voiture_id : string, identifiant unique
- nom : string
- date_achat : date
- prix_achat : float
- km_achat : integer

**pleins**
- id : PK, auto-increment
- voiture_id : FK -> voitures.voiture_id
- date : date
- km : integer
- litres : float
- prix_litre : float
- note : string

**entretiens**
- id : PK, auto-increment
- voiture_id : FK -> voitures.voiture_id
- date : date
- km : integer
- prix_entretien : float
- type_entretien : string
- note : string
- interval_km : integer
- interval_temps : integer

**notifications**
- id : PK, auto-increment
- voiture_id : FK -> voitures.voiture_id
- type_notification : string
- date_echeance : date
- km_echeance : integer
- message : string

---

## Services et scripts

- `enregistrer_evenement` : script pour enregistrer Plein ou Entretien
- Automatisations pour notification selon km ou date
- Historisation des données dans la base SQL ou DB externe

---

## Extensions futures

- Export CSV via base de données
- Graphiques avancés via Grafana
- Notifications push / email pour entretien à venir
- Ajout / suppression de voitures via configuration modulaire
- Suivi consommation et coûts carburant supplémentaires
