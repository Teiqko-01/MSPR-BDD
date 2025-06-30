-- Création de la base de données
CREATE DATABASE seahawks_db
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'fr_FR.UTF-8'
    LC_CTYPE = 'fr_FR.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- Connexion à la base créée
\c seahawks_db

-- Création des tables principales

-- Table des prestataires clients
CREATE TABLE client_prestataire (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    siret VARCHAR(14) NOT NULL,
    adresse_siege TEXT NOT NULL,
    contact_principal VARCHAR(100) NOT NULL
);

-- Table des clients finaux (liés aux prestataires)
CREATE TABLE client_final (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    adresse TEXT NOT NULL,
    client_prestataire_id INTEGER REFERENCES client_prestataire(id)
);

-- Table des techniciens qui interviennent sur les instances
CREATE TABLE technicien (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL
);

-- Table de configuration matérielle du système d’exploitation
CREATE TABLE os_config (
    id SERIAL PRIMARY KEY,
    cpu VARCHAR(50),
    ram VARCHAR(50),
    type_disque VARCHAR(50),
    taille_disque INTEGER
);

-- Table principale des instances supervisées
CREATE TABLE instance (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    numero_serie VARCHAR(100) UNIQUE NOT NULL,
    ip_locale INET,
    ip_vpn INET,
    etat VARCHAR(20) CHECK (etat IN ('connectée', 'déconnectée', 'indéfini')),
    date_activation DATE,
    date_desactivation DATE,
    version_os VARCHAR(50),
    version_app VARCHAR(50),
    est_chez_nfl_it BOOLEAN DEFAULT TRUE,
    client_final_id INTEGER REFERENCES client_final(id),
    os_config_id INTEGER REFERENCES os_config(id)
);

-- Table du matériel déployé pour chaque instance
CREATE TABLE materiel (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50),
    est_recupere BOOLEAN,
    instance_id INTEGER REFERENCES instance(id)
);

-- Table des licences associées aux instances
CREATE TABLE licence (
    id SERIAL PRIMARY KEY,
    numero CHAR(8) UNIQUE NOT NULL,
    instance_id INTEGER UNIQUE REFERENCES instance(id)
);

-- Table des scripts installés sur les instances
CREATE TABLE script (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    version VARCHAR(20)
);

-- Table de liaison (N:N) entre instances et scripts installés
CREATE TABLE instance_script (
    instance_id INTEGER REFERENCES instance(id),
    script_id INTEGER REFERENCES script(id),
    PRIMARY KEY (instance_id, script_id)
);

-- Table des interventions des techniciens sur les instances
CREATE TABLE technicien_instance (
    technicien_id INTEGER REFERENCES technicien(id),
    instance_id INTEGER REFERENCES instance(id),
    role VARCHAR(50),
    date_intervention TIMESTAMP,
    PRIMARY KEY (technicien_id, instance_id, date_intervention)
);


-- Table des incidents détectés sur les instances
CREATE TABLE incident (
    id SERIAL PRIMARY KEY,
    date TIMESTAMP NOT NULL,
    motif TEXT,
    instance_id INTEGER REFERENCES instance(id),
    technicien_id INTEGER REFERENCES technicien(id)
);

-- Table des redémarrages manuels enregistrés
CREATE TABLE redemarrage (
    id SERIAL PRIMARY KEY,
    date TIMESTAMP NOT NULL,
    motif TEXT,
    instance_id INTEGER REFERENCES instance(id)
);
