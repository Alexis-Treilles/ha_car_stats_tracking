# Suivi Voitures pour Home Assistant

Un composant personnalisé pour Home Assistant permettant de suivre les véhicules, les pleins d'essence et les entretiens.

## Fonctionnalités

- Suivi des pleins d'essence avec calcul de consommation
- Suivi des entretiens avec coûts
- Calcul de la consommation moyenne
- Calcul du coût total de possession
- Rappels d'entretien

## Installation

1. Installez via HACS (recommandé) ou copiez manuellement le dossier `custom_components/voitures` dans votre configuration Home Assistant.
2. Redémarrez Home Assistant.
3. Ajoutez l'intégration via l'interface de Home Assistant.

## Configuration

Ajoutez ce qui suit à votre `configuration.yaml`:

```yaml
voitures:
  vehicles:
    - name: "Ma Voiture"
      purchase_date: "2023-01-01"
      purchase_price: 25000
      initial_km: 0
```

## Utilisation

Après l'installation, vous pouvez ajouter des événements via les services ou le dashboard Lovelace.

## Dashboard Lovelace

Un exemple de dashboard est fourni dans `dashboards/voitures.yaml`.
