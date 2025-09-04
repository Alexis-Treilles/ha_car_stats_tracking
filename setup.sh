#!/bin/bash

# Création de l'arborescence du projet
mkdir -p custom_components/voitures
mkdir -p dashboards
mkdir -p automations
mkdir -p data

# Création des fichiers principaux de l'intégration
touch custom_components/voitures/__init__.py
touch custom_components/voitures/manifest.json
touch custom_components/voitures/services.yaml
touch custom_components/voitures/const.py
touch custom_components/voitures/sensor.py
touch custom_components/voitures/storage.py

# Création des fichiers de configuration
touch dashboards/voitures.yaml
touch automations/voitures.yaml

# Création du fichier README
touch README.md

# Ajout du contenu minimal aux fichiers

# Manifest.json
cat > custom_components/voitures/manifest.json << EOF
{
  "domain": "voitures",
  "name": "Suivi Voitures",
  "version": "1.0.0",
  "documentation": "https://github.com/votre-utilisateur/suivi-voitures",
  "requirements": [],
  "dependencies": [],
  "codeowners": ["@votre-utilisateur"],
  "config_flow": false,
  "iot_class": "local_polling"
}
EOF

# Fichier const.py
cat > custom_components/voitures/const.py << EOF
DOMAIN = "voitures"
DATA_VEHICLES = "vehicles"
DATA_STORAGE = "storage"

CONF_VEHICLES = "vehicles"
CONF_NAME = "name"
CONF_PURCHASE_DATE = "purchase_date"
CONF_PURCHASE_PRICE = "purchase_price"
CONF_INITIAL_KM = "initial_km"

EVENT_TYPE_REFUEL = "refuel"
EVENT_TYPE_MAINTENANCE = "maintenance"

ATTR_DATE = "date"
ATTR_KM = "kilometers"
ATTR_LITERS = "liters"
ATTR_PRICE_PER_LITER = "price_per_liter"
ATTR_NOTES = "notes"
ATTR_MAINTENANCE_TYPE = "maintenance_type"
ATTR_COST = "cost"

SERVICE_ADD_EVENT = "add_event"
EOF

# Fichier __init__.py minimal
cat > custom_components/voitures/__init__.py << EOF
import logging
from homeassistant.core import HomeAssistant

_LOGGER = logging.getLogger(__name__)

async def async_setup(hass: HomeAssistant, config: dict):
    """Set up the Suivi Voitures component."""
    return True
EOF

# Fichier services.yaml
cat > custom_components/voitures/services.yaml << EOF
add_event:
  name: Ajouter un événement
  description: Ajouter un événement (plein ou entretien) à un véhicule
  fields:
    vehicle:
      name: Véhicule
      description: Nom du véhicule
      required: true
      selector:
        text:
    event_type:
      name: Type d'événement
      description: Type d'événement (plein ou entretien)
      required: true
      selector:
        select:
          options:
            - "refuel"
            - "maintenance"
    date:
      name: Date
      description: Date de l'événement
      required: true
      selector:
        date:
    kilometers:
      name: Kilométrage
      description: Kilométrage actuel
      required: true
      selector:
        number:
          min: 0
          step: 1
    notes:
      name: Notes
      description: Notes optionnelles
      required: false
      selector:
        text:
    liters:
      name: Litres
      description: Litres de carburant (pour les pleins)
      required: false
      selector:
        number:
          min: 0
          step: 0.1
    price_per_liter:
      name: Prix au litre
      description: Prix au litre (pour les pleins)
      required: false
      selector:
        number:
          min: 0
          step: 0.01
    maintenance_type:
      name: Type d'entretien
      description: Type d'entretien (pour les entretiens)
      required: false
      selector:
        text:
    cost:
      name: Coût
      description: Coût de l'entretien (pour les entretiens)
      required: false
      selector:
        number:
          min: 0
          step: 0.01
EOF

# Fichier README.md
cat > README.md << EOF
# Suivi Voitures pour Home Assistant

Un composant personnalisé pour Home Assistant permettant de suivre les véhicules, les pleins d'essence et les entretiens.

## Fonctionnalités

- Suivi des pleins d'essence avec calcul de consommation
- Suivi des entretiens avec coûts
- Calcul de la consommation moyenne
- Calcul du coût total de possession
- Rappels d'entretien

## Installation

1. Installez via HACS (recommandé) ou copiez manuellement le dossier \`custom_components/voitures\` dans votre configuration Home Assistant.
2. Redémarrez Home Assistant.
3. Ajoutez l'intégration via l'interface de Home Assistant.

## Configuration

Ajoutez ce qui suit à votre \`configuration.yaml\`:

\`\`\`yaml
voitures:
  vehicles:
    - name: "Ma Voiture"
      purchase_date: "2023-01-01"
      purchase_price: 25000
      initial_km: 0
\`\`\`

## Utilisation

Après l'installation, vous pouvez ajouter des événements via les services ou le dashboard Lovelace.

## Dashboard Lovelace

Un exemple de dashboard est fourni dans \`dashboards/voitures.yaml\`.
EOF

echo "Structure créée avec succès!"
echo "N'oubliez pas de:"
echo "1. Modifier le manifest.json avec vos informations"
echo "2. Compléter le code des fichiers Python"
echo "3. Ajouter votre dashboard Lovelace"
echo "4. Ajouter vos automatisations"