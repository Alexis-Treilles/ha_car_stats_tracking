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
