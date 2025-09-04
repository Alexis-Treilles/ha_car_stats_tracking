#!/bin/bash

# Script de création du custom component "voitures" pour Home Assistant

COMPONENT_DIR="custom_components/voitures"
DATA_DIR="$COMPONENT_DIR/data"
HELPERS_DIR="$COMPONENT_DIR/helpers"
DASHBOARD_DIR="$COMPONENT_DIR/dashboards"

# Créer les répertoires
mkdir -p $COMPONENT_DIR $DATA_DIR $HELPERS_DIR $DASHBOARD_DIR

# =====================================
# __init__.py
# =====================================
cat > $COMPONENT_DIR/__init__.py <<EOL
import os
from homeassistant.core import ServiceCall
from .helpers.utils import add_event

DOMAIN = "voitures"

def setup(hass, config):
    def handle_enregistrer_evenement(call: ServiceCall):
        event_type = call.data.get("type")
        voiture_id = call.data.get("voiture_id")
        km = call.data.get("km")
        litres = call.data.get("litres")
        prix_litre = call.data.get("prix_litre")
        prix_entretien = call.data.get("prix_entretien")
        note = call.data.get("note")
        event = {
            "km": km,
            "litres": litres,
            "prix_litre": prix_litre,
            "prix_entretien": prix_entretien,
            "note": note
        }
        add_event(voiture_id, event_type.lower(), event)

    hass.services.register(DOMAIN, "enregistrer_evenement", handle_enregistrer_evenement)
    return True
EOL

# =====================================
# manifest.json
# =====================================
cat > $COMPONENT_DIR/manifest.json <<EOL
{
  "domain": "voitures",
  "name": "Suivi Voitures",
  "version": "1.0.0",
  "documentation": "https://github.com/Alexis-Treilles/ha_car_stats_tracking",
  "requirements": [],
  "dependencies": [],
  "codeowners": ["@Alexis-Treilles"]
}
EOL

# =====================================
# sensor.py (vide pour l'instant)
# =====================================
touch $COMPONENT_DIR/sensor.py

# =====================================
# services.yaml
# =====================================
cat > $COMPONENT_DIR/services.yaml <<EOL
enregistrer_evenement:
  description: "Enregistre un plein ou un entretien pour une voiture"
  fields:
    type:
      description: "Type d'événement : Plein ou Entretien"
      example: "Plein"
    voiture_id:
      description: "Identifiant de la voiture"
      example: "audi_a3"
    km:
      description: "Kilométrage"
      example: 55000
    litres:
      description: "Litres pour un plein"
      example: 40
    prix_litre:
      description: "Prix par litre"
      example: 1.60
    prix_entretien:
      description: "Prix entretien"
      example: 120
    note:
      description: "Notes éventuelles"
      example: "Vidange huile"
EOL

# =====================================
# helpers/utils.py
# =====================================
cat > $HELPERS_DIR/utils.py <<EOL
import json
import os

DATA_FILE = os.path.join(os.path.dirname(__file__), "../data/voitures.json")

def load_data():
    with open(DATA_FILE, "r") as f:
        return json.load(f)

def save_data(data):
    with open(DATA_FILE, "w") as f:
        json.dump(data, f, indent=2)

def add_event(voiture_id, event_type, event):
    data = load_data()
    if event_type == "plein":
        data["voitures"][voiture_id]["pleins"].append(event)
    elif event_type == "entretien":
        data["voitures"][voiture_id]["entretiens"].append(event)
    save_data(data)
EOL

# =====================================
# data/voitures.json
# =====================================
cat > $DATA_DIR/voitures.json <<EOL
{
  "voitures": {
    "audi_a3": {
      "date_achat": "2022-01-01",
      "prix_achat": 15000,
      "km_achat": 50000,
      "pleins": [],
      "entretiens": []
    },
    "renault_4l": {
      "date_achat": "2021-06-15",
      "prix_achat": 8000,
      "km_achat": 70000,
      "pleins": [],
      "entretiens": []
    },
    "peugeot_205": {
      "date_achat": "2019-03-10",
      "prix_achat": 4000,
      "km_achat": 90000,
      "pleins": [],
      "entretiens": []
    }
  }
}
EOL

# =====================================
# dashboards/ui-lovelace.yaml
# =====================================
cat > $DASHBOARD_DIR/ui-lovelace.yaml <<EOL
title: Voitures
views:
  - title: Gestion voitures
    path: voitures
    cards:
      - type: entities
        title: Saisie Plein/Entretien
        entities:
          - input_select.voiture
          - input_select.type_evenement
          - input_number.km
          - input_number.litres
          - input_number.prix_litre
          - input_number.prix_entretien
          - input_text.note
          - input_button.enregistrer
EOL

echo "Custom component 'voitures' créé avec succès !"
