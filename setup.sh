#!/bin/bash

# Création de l'arborescence du projet
mkdir -p custom_components/vehicle_tracker
mkdir -p dashboards
mkdir -p automations
mkdir -p data

# Création des fichiers principaux de l'intégration
touch custom_components/vehicle_tracker/__init__.py
touch custom_components/vehicle_tracker/manifest.json
touch custom_components/vehicle_tracker/services.yaml
touch custom_components/vehicle_tracker/const.py
touch custom_components/vehicle_tracker/sensor.py
touch custom_components/vehicle_tracker/storage.py

# Création des fichiers de configuration
touch dashboards/vehicle_tracker.yaml
touch automations/vehicle_tracker.yaml

# Création du fichier README
touch README.md

# Ajout du contenu minimal aux fichiers

# Manifest.json
cat > custom_components/vehicle_tracker/manifest.json << EOF
{
  "domain": "vehicle_tracker",
  "name": "Vehicle Tracker",
  "version": "1.0.0",
  "documentation": "https://github.com/your-username/vehicle-tracker",
  "requirements": [],
  "dependencies": [],
  "codeowners": ["@alexis-treilles"],
  "config_flow": true,
  "iot_class": "local_polling"
}
EOF

# Fichier const.py
cat > custom_components/vehicle_tracker/const.py << EOF
DOMAIN = "vehicle_tracker"
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
cat > custom_components/vehicle_tracker/__init__.py << EOF
import logging
from homeassistant.core import HomeAssistant

_LOGGER = logging.getLogger(__name__)

async def async_setup(hass: HomeAssistant, config: dict):
    """Set up the Vehicle Tracker component."""
    return True
EOF

# Fichier services.yaml
cat > custom_components/vehicle_tracker/services.yaml << EOF
add_event:
  name: Add event
  description: Add a refuel or maintenance event to a vehicle
  fields:
    vehicle:
      name: Vehicle
      description: Name of the vehicle
      required: true
      selector:
        text:
    event_type:
      name: Event type
      description: Type of event (refuel or maintenance)
      required: true
      selector:
        select:
          options:
            - "refuel"
            - "maintenance"
    date:
      name: Date
      description: Date of the event
      required: true
      selector:
        date:
    kilometers:
      name: Kilometers
      description: Current kilometers
      required: true
      selector:
        number:
          min: 0
          step: 1
    notes:
      name: Notes
      description: Optional notes
      required: false
      selector:
        text:
    liters:
      name: Liters
      description: Liters of fuel (for refuel events)
      required: false
      selector:
        number:
          min: 0
          step: 0.1
    price_per_liter:
      name: Price per liter
      description: Price per liter (for refuel events)
      required: false
      selector:
        number:
          min: 0
          step: 0.01
    maintenance_type:
      name: Maintenance type
      description: Type of maintenance (for maintenance events)
      required: false
      selector:
        text:
    cost:
      name: Cost
      description: Cost of maintenance (for maintenance events)
      required: false
      selector:
        number:
          min: 0
          step: 0.01
EOF

# Fichier README.md
cat > README.md << EOF
# Vehicle Tracker for Home Assistant

A custom component for Home Assistant to track vehicle refuels, maintenance, and statistics.

## Features

- Track refuel events with consumption calculations
- Track maintenance events with cost tracking
- Calculate average fuel consumption
- Track total cost of ownership
- Maintenance reminders

## Installation

1. Install using HACS (recommended) or manually copy the \`custom_components/vehicle_tracker\` folder to your Home Assistant configuration.
2. Restart Home Assistant.
3. Add the integration through the Home Assistant UI.

## Configuration

Add the following to your \`configuration.yaml\`:

\`\`\`yaml
vehicle_tracker:
  vehicles:
    - name: "My Car"
      purchase_date: "2023-01-01"
      purchase_price: 25000
      initial_km: 0
\`\`\`

## Usage

After installation, you can add events using services or through the Lovelace dashboard.

## Lovelace Dashboard

A sample dashboard is provided in \`dashboards/vehicle_tracker.yaml\`.
EOF

echo "Structure créée avec succès!"
echo "N'oubliez pas de:"
echo "1. Modifier le manifest.json avec vos informations"
echo "2. Compléter le code des fichiers Python"
echo "3. Ajouter votre dashboard Lovelace"
echo "4. Ajouter vos automatisations"#!/bin/bash

# Création de l'arborescence du projet
mkdir -p custom_components/vehicle_tracker
mkdir -p dashboards
mkdir -p automations
mkdir -p data

# Création des fichiers principaux de l'intégration
touch custom_components/vehicle_tracker/__init__.py
touch custom_components/vehicle_tracker/manifest.json
touch custom_components/vehicle_tracker/services.yaml
touch custom_components/vehicle_tracker/const.py
touch custom_components/vehicle_tracker/sensor.py
touch custom_components/vehicle_tracker/storage.py

# Création des fichiers de configuration
touch dashboards/vehicle_tracker.yaml
touch automations/vehicle_tracker.yaml

# Création du fichier README
touch README.md

# Ajout du contenu minimal aux fichiers

# Manifest.json
cat > custom_components/vehicle_tracker/manifest.json << EOF
{
  "domain": "vehicle_tracker",
  "name": "Vehicle Tracker",
  "version": "1.0.0",
  "documentation": "https://github.com/your-username/vehicle-tracker",
  "requirements": [],
  "dependencies": [],
  "codeowners": ["@your-username"],
  "config_flow": true,
  "iot_class": "local_polling"
}
EOF

# Fichier const.py
cat > custom_components/vehicle_tracker/const.py << EOF
DOMAIN = "vehicle_tracker"
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
cat > custom_components/vehicle_tracker/__init__.py << EOF
import logging
from homeassistant.core import HomeAssistant

_LOGGER = logging.getLogger(__name__)

async def async_setup(hass: HomeAssistant, config: dict):
    """Set up the Vehicle Tracker component."""
    return True
EOF

# Fichier services.yaml
cat > custom_components/vehicle_tracker/services.yaml << EOF
add_event:
  name: Add event
  description: Add a refuel or maintenance event to a vehicle
  fields:
    vehicle:
      name: Vehicle
      description: Name of the vehicle
      required: true
      selector:
        text:
    event_type:
      name: Event type
      description: Type of event (refuel or maintenance)
      required: true
      selector:
        select:
          options:
            - "refuel"
            - "maintenance"
    date:
      name: Date
      description: Date of the event
      required: true
      selector:
        date:
    kilometers:
      name: Kilometers
      description: Current kilometers
      required: true
      selector:
        number:
          min: 0
          step: 1
    notes:
      name: Notes
      description: Optional notes
      required: false
      selector:
        text:
    liters:
      name: Liters
      description: Liters of fuel (for refuel events)
      required: false
      selector:
        number:
          min: 0
          step: 0.1
    price_per_liter:
      name: Price per liter
      description: Price per liter (for refuel events)
      required: false
      selector:
        number:
          min: 0
          step: 0.01
    maintenance_type:
      name: Maintenance type
      description: Type of maintenance (for maintenance events)
      required: false
      selector:
        text:
    cost:
      name: Cost
      description: Cost of maintenance (for maintenance events)
      required: false
      selector:
        number:
          min: 0
          step: 0.01
EOF

# Fichier README.md
cat > README.md << EOF
# Vehicle Tracker for Home Assistant

A custom component for Home Assistant to track vehicle refuels, maintenance, and statistics.

## Features

- Track refuel events with consumption calculations
- Track maintenance events with cost tracking
- Calculate average fuel consumption
- Track total cost of ownership
- Maintenance reminders

## Installation

1. Install using HACS (recommended) or manually copy the \`custom_components/vehicle_tracker\` folder to your Home Assistant configuration.
2. Restart Home Assistant.
3. Add the integration through the Home Assistant UI.

## Configuration

Add the following to your \`configuration.yaml\`:

\`\`\`yaml
vehicle_tracker:
  vehicles:
    - name: "My Car"
      purchase_date: "2023-01-01"
      purchase_price: 25000
      initial_km: 0
\`\`\`

## Usage

After installation, you can add events using services or through the Lovelace dashboard.

## Lovelace Dashboard

A sample dashboard is provided in \`dashboards/vehicle_tracker.yaml\`.
EOF

echo "Structure créée avec succès!"
echo "N'oubliez pas de:"
echo "1. Modifier le manifest.json avec vos informations"
echo "2. Compléter le code des fichiers Python"
echo "3. Ajouter votre dashboard Lovelace"
echo "4. Ajouter vos automatisations"