#!/bin/bash

# Script minimal pour créer un dépôt HACS Integration

COMPONENT_DIR="custom_components/voitures"

# Créer le dossier
mkdir -p $COMPONENT_DIR

# =====================================
# __init__.py (vide)
# =====================================
cat > $COMPONENT_DIR/__init__.py <<EOL
# Composant Voitures minimal pour HACS
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

echo "Intégration minimale 'voitures' créée avec succès !"
echo "Pour HACS : ajoutez le repo et installez-le comme Integration."
