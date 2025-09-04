import json
import os

DATA_FILE = os.path.join(os.path.dirname(__file__), "../data/voitures.json")

def load_data():
    with open(DATA_FILE, "r") as f:
        return json.load(f)

def save_data(data):
    with open(DATA_FILE, "w") as f:
        json.dump(data, f, indent=2)

def add_event(voiture_id, event_type, event):
    data = load_data()
    if event_type == "plein":
        data["voitures"][voiture_id]["pleins"].append(event)
    elif event_type == "entretien":
        data["voitures"][voiture_id]["entretiens"].append(event)
    save_data(data)
