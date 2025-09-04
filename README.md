Projet Home Assistant – Suivi Automobile

1️⃣ Objectif du projet
Créer un système modulaire pour suivre les pleins, entretiens et coûts de plusieurs voitures dans Home Assistant avec :
- Historisation complète des données
- Calcul automatique du coût total (achat + entretien)
- Notifications pour entretiens selon type et échéances km/temps
- Dashboard clair avec formulaire unique et sélection de la voiture
- Architecture modulaire pour ajouter ou supprimer facilement des voitures
- Possibilité d’exporter les données via la base de données

---

2️⃣ Architecture générale
```
Home Assistant
├── configuration.yaml
│   ├── input_number: !include voiture_input_number.yaml
│   ├── input_text: !include voiture_input_text.yaml
│   ├── input_datetime: !include voiture_input_datetime.yaml
│   ├── input_select: !include voiture_input_select.yaml
│   ├── input_button: !include voiture_input_button.yaml
│   ├── script: !include voiture_scripts.yaml
│   └── automation: !include voiture_automations.yaml
├── dashboards/
│   └── ui-lovelace.yaml
└── base_de_donnees/
    └── voitures.sql (ou DB externe: PostgreSQL / MySQL / InfluxDB)

---

3️⃣ Variables backend

3.1 Variables par voiture
- voiture_id : string, identifiant unique (ex: audi_a3, renault_4l, peugeot_205)
- nom_voiture : string, nom affiché
- date_achat : date, date d’achat de la voiture
- prix_achat : float, prix d’achat
- km_achat : integer, kilométrage à l’achat

3.2 Pleins
- date : date du plein
- km : integer, kilométrage actuel
- litres : float, litres ajoutés
- prix_litre : float, prix par litre
- note : string, note facultative

3.3 Entretiens
- date : date de l’entretien
- km : integer, kilométrage actuel
- prix_entretien : float, coût de l’entretien
- type_entretien : string, type d’entretien (vidange, pneus…)
- note : string, note facultative
- interval_km : integer, intervalle kilométrique pour notification
- interval_temps : integer, intervalle temporel pour notification (en jours)

3.4 Statistiques / affichage
- km_total : integer, kilométrage total
- total_entretien : float, somme des coûts d’entretien
- total_cout : float, coût total = prix achat + entretien
- entretien_todolist : list, liste des entretiens à venir avec échéance
- entretien_notifications : list, notifications d’entretien proche

---

4️⃣ Sélecteurs et inputs Home Assistant
- input_select.voiture_selection : choix de la voiture pour la saisie
- input_select.action_selection : “Plein” ou “Entretien”
- input_select.voiture_stats : choix de la voiture pour afficher les stats
- input_number.km : kilométrage actuel
- input_number.litres : litres ajoutés (Plein)
- input_number.prix_litre : prix litre (Plein)
- input_number.prix_entretien : prix entretien (Entretien)
- input_datetime.date_action : date de l’action
- input_text.note_action : note facultative
- input_button.enregistrer : bouton pour lancer le script d’enregistrement

---

5️⃣ Dashboard (aperçu)
- Formulaire unique pour saisir Plein ou Entretien
- Sélecteur de voiture pour afficher les statistiques
- Graphique kilométrage par voiture
- Liste des entretiens à venir
- Notifications pour entretien proche
- Affichage du total coût par voiture (achat + entretien)

---

6️⃣ Scripts et automatisations
- Script enregistrer_evenement pour gérer toutes les voitures et types d’action
- Automatisations pour notifications selon km ou date
- Historisation des données dans la base SQL ou DB externe

---

7️⃣ Structure de la base de données (SQL)

Table: voitures
- id : PK, int, auto-increment
- voiture_id : string, identifiant unique
- nom : string
- date_achat : date
- prix_achat : float
- km_achat : integer

Table: pleins
- id : PK, int, auto-increment
- voiture_id : FK -> voitures.voiture_id
- date : date
- km : integer
- litres : float
- prix_litre : float
- note : string

Table: entretiens
- id : PK, int, auto-increment
- voiture_id : FK -> voitures.voiture_id
- date : date
- km : integer
- prix_entretien : float
- type_entretien : string
- note : string
- interval_km : integer
- interval_temps : integer

Table: notifications
- id : PK, int, auto-increment
- voiture_id : FK -> voitures.voiture_id
- type_notification : string
- date_echeance : date
- km_echeance : integer
- message : string

---

8️⃣ Extensions et améliorations futures
- Export CSV via la base de données
- Graphiques avancés via Grafana
- Notifications push ou email pour entretien à venir
- Ajout ou suppression de voitures via la configuration modulaire
- Intégration de métriques supplémentaires (coût carburant, consommation, maintenance préventive)
