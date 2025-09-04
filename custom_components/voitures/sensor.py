"""Sensor platform for Suivi Voitures."""
import logging
from homeassistant.helpers.entity import Entity
from .const import DOMAIN

_LOGGER = logging.getLogger(__name__)

async def async_setup_platform(hass, config, async_add_entities, discovery_info=None):
    """Set up the sensor platform."""
    # Implémentation des capteurs pour chaque véhicule
    data = hass.data[DOMAIN]["data"]
    sensors = []
    
    for vehicle_name, vehicle_data in data.items():
        sensors.append(VehicleSensor(vehicle_name, vehicle_data, "consumption"))
        sensors.append(VehicleSensor(vehicle_name, vehicle_data, "total_cost"))
    
    async_add_entities(sensors, True)

class VehicleSensor(Entity):
    """Representation of a Vehicle Sensor."""
    
    def __init__(self, vehicle_name, vehicle_data, sensor_type):
        """Initialize the sensor."""
        self._vehicle_name = vehicle_name
        self._vehicle_data = vehicle_data
        self._sensor_type = sensor_type
        self._state = None
        
    @property
    def name(self):
        """Return the name of the sensor."""
        return f"{self._vehicle_name} {self._sensor_type}"
    
    @property
    def state(self):
        """Return the state of the sensor."""
        return self._state
    
    @property
    def unit_of_measurement(self):
        """Return the unit of measurement."""
        if self._sensor_type == "consumption":
            return "L/100km"
        elif self._sensor_type == "total_cost":
            return "€"
        return None
    
    def update(self):
        """Fetch new state data for the sensor."""
        # Calculer la consommation moyenne ou le coût total
        if self._sensor_type == "consumption":
            self._state = self.calculate_consumption()
        elif self._sensor_type == "total_cost":
            self._state = self.calculate_total_cost()
    
    def calculate_consumption(self):
        """Calculate average fuel consumption."""
        # Implémentation du calcul de consommation
        return 0  # À remplacer par le calcul réel
    
    def calculate_total_cost(self):
        """Calculate total cost of ownership."""
        # Implémentation du calcul du coût total
        return 0  # À remplacer par le calcul réel