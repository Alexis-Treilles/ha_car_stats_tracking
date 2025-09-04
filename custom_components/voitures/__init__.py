"""Suivi Voitures integration."""
import logging
from homeassistant.core import HomeAssistant
from homeassistant.helpers import config_validation as cv
from homeassistant.helpers.storage import Store
from .const import *

_LOGGER = logging.getLogger(__name__)

CONFIG_SCHEMA = vol.Schema({
    DOMAIN: vol.Schema({
        vol.Required(CONF_VEHICLES): vol.All(cv.ensure_list, [
            {
                vol.Required(CONF_NAME): cv.string,
                vol.Required(CONF_PURCHASE_DATE): cv.date,
                vol.Required(CONF_PURCHASE_PRICE): vol.Coerce(float),
                vol.Required(CONF_INITIAL_KM): vol.Coerce(int),
            }
        ])
    })
}, extra=vol.ALLOW_EXTRA)

async def async_setup(hass: HomeAssistant, config: dict):
    """Set up the Suivi Voitures component."""
    hass.data[DOMAIN] = {}
    hass.data[DOMAIN][DATA_VEHICLES] = {}
    
    # Configuration des véhicules
    vehicle_configs = config[DOMAIN][CONF_VEHICLES]
    
    # Initialisation du stockage
    store = Store(hass, 1, f"{DOMAIN}_data")
    data = await store.async_load()
    
    if data is None:
        data = {}
    
    hass.data[DOMAIN][DATA_STORAGE] = store
    hass.data[DOMAIN]["data"] = data
    
    # Création des capteurs pour chaque véhicule
    for vehicle_config in vehicle_configs:
        vehicle_name = vehicle_config[CONF_NAME]
        
        # Initialisation des données véhicule si elles n'existent pas
        if vehicle_name not in data:
            data[vehicle_name] = {
                "purchase_date": vehicle_config[CONF_PURCHASE_DATE].isoformat(),
                "purchase_price": vehicle_config[CONF_PURCHASE_PRICE],
                "initial_km": vehicle_config[CONF_INITIAL_KM],
                "events": []
            }
    
    # Sauvegarde des données initiales
    await store.async_save(data)
    
    # Chargement des plateformes (capteurs)
    hass.async_create_task(
        hass.helpers.discovery.async_load_platform(
            "sensor", DOMAIN, {}, config
        )
    )
    
    # Enregistrement des services
    async def add_event_service(call):
        """Service pour ajouter un événement à un véhicule."""
        # Implémentation à compléter
    
    hass.services.async_register(
        DOMAIN, SERVICE_ADD_EVENT, add_event_service
    )
    
    return True