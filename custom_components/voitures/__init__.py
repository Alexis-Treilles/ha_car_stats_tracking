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
