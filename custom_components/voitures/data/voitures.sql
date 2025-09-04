-- SQL pour créer les tables du suivi voitures
CREATE TABLE IF NOT EXISTS voitures (
    id SERIAL PRIMARY KEY,
    voiture_id TEXT UNIQUE,
    nom TEXT,
    date_achat DATE,
    prix_achat FLOAT,
    km_achat INTEGER
);

CREATE TABLE IF NOT EXISTS pleins (
    id SERIAL PRIMARY KEY,
    voiture_id TEXT,
    date DATE,
    km INTEGER,
    litres FLOAT,
    prix_litre FLOAT,
    note TEXT
);

CREATE TABLE IF NOT EXISTS entretiens (
    id SERIAL PRIMARY KEY,
    voiture_id TEXT,
    date DATE,
    km INTEGER,
    prix_entretien FLOAT,
    type_entretien TEXT,
    note TEXT,
    interval_km INTEGER,
    interval_temps INTEGER
);
