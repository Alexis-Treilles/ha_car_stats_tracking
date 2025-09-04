# Vehicle Tracker for Home Assistant

A custom component for Home Assistant to track vehicle refuels, maintenance, and statistics.

## Features

- Track refuel events with consumption calculations
- Track maintenance events with cost tracking
- Calculate average fuel consumption
- Track total cost of ownership
- Maintenance reminders

## Installation

1. Install using HACS (recommended) or manually copy the `custom_components/vehicle_tracker` folder to your Home Assistant configuration.
2. Restart Home Assistant.
3. Add the integration through the Home Assistant UI.

## Configuration

Add the following to your `configuration.yaml`:

```yaml
vehicle_tracker:
  vehicles:
    - name: "My Car"
      purchase_date: "2023-01-01"
      purchase_price: 25000
      initial_km: 0
```

## Usage

After installation, you can add events using services or through the Lovelace dashboard.

## Lovelace Dashboard

A sample dashboard is provided in `dashboards/vehicle_tracker.yaml`.
