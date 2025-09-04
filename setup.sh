#!/bin/bash

# Nom du dossier du composant
COMPONENT_NAME="voitures"
ROOT_DIR="$(pwd)/custom_components"

echo "Création de l'arborescence du composant Home Assistant : $COMPONENT_NAME"

# Créer le dossier custom_components si il n'existe pas
mkdir -p "$ROOT_DIR"

# Créer le dossier du composant
COMP_DIR="$ROOT_DIR/$COMPONENT_NAME"
mkdir -p "$COMP_DIR"
mkdir -p "$COMP_DIR/dashboards"
mkdir -p "$COMP_DIR/data"
mkdir -p "$COMP_DIR/helpers"

# Créer __init__.py
cat > "$COMP_DIR/__init__.py" << EOL
"""Suivi voitures Home Assistant custom component."""
from homeassistant.core import HomeAssistant

async def async_setup(hass: HomeAssistant, config: dict):
    """Setup du module voitures."""
    return True
EOL

# Créer manifest.json
cat > "$COMP_DIR/manifest.json" << EOL
{
  "domain": "voitures",
  "name": "Suivi Voitures",
  "version": "1.0.0",
  "documentation": "https://github.com/tonutilisateur/home-assistant-voitures",
  "requirements": [],
  "dependencies": [],
  "codeowners": ["@tonutilisateur"]
}
EOL

# Créer sensor.py minimal
cat > "$COMP_DIR/sensor.py" << EOL
"""Définition des entités pour le suivi voitures."""
from homeassistant.helpers.entity import Entity

class VoitureSensor(Entity):
    """Exemple de capteur pour une voiture."""
    def __init__(self, name):
        self._name = name
        self._state = None

    @property
    def name(self):
        return self._name

    @property
    def state(self):
        return self._state

    def update(self):
        pass  # ici mettre la logique pour récupérer l'état
EOL

# Créer services.yaml
cat > "$COMP_DIR/services.yaml" << EOL
# Exemple de service Home Assistant pour enregistrer un événement
enregistrer_evenement:
  description: "Enregistre un plein ou un entretien"
  fields:
    type:
      description: "Type d'événement : Plein ou Entretien"
      example: "Plein"
    voiture_id:
      description: "Identifiant de la voiture"
      example: "audi_a3"
EOL

# Créer un dashboard exemple
cat > "$COMP_DIR/dashboards/ui-lovelace.yaml" << EOL
title: Voitures
views:
  - title: Gestion des voitures
    path: voitures
    cards:
      - type: entities
        title: Audi A3 - Saisie
        entities:
          - sensor.audi_a3_km
          - sensor.audi_a3_litres
          - sensor.audi_a3_prix_litre
EOL

# Créer un fichier SQL d'exemple
cat > "$COMP_DIR/data/voitures.sql" << EOL
-- SQL pour créer les tables du suivi voitures
CREATE TABLE IF NOT EXISTS voitures (
    id SERIAL PRIMARY KEY,
    voiture_id TEXT UNIQUE,
    nom TEXT,
    date_achat DATE,
    prix_achat FLOAT,
    km_achat INTEGER
);

CREATE TABLE IF NOT EXISTS pleins (
    id SERIAL PRIMARY KEY,
    voiture_id TEXT,
    date DATE,
    km INTEGER,
    litres FLOAT,
    prix_litre FLOAT,
    note TEXT
);

CREATE TABLE IF NOT EXISTS entretiens (
    id SERIAL PRIMARY KEY,
    voiture_id TEXT,
    date DATE,
    km INTEGER,
    prix_entretien FLOAT,
    type_entretien TEXT,
    note TEXT,
    interval_km INTEGER,
    interval_temps INTEGER
);
EOL

echo "Composant $COMPONENT_NAME créé avec succès dans $COMP_DIR"
echo "Structure :"
tree "$COMP_DIR"
