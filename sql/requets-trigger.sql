-- a. Instances d’un client prestataire
SELECT i.*
FROM instance i
JOIN client_final cf ON i.client_final_id = cf.id
JOIN client_prestataire cp ON cf.client_prestataire_id = cp.id
WHERE cp.nom = 'Nom du Prestataire';

-- b. Incidents pour une instance
SELECT *
FROM incident
WHERE instance_id = (SELECT id FROM instance WHERE numero_serie = 'SN00003');

-- c. Instances jamais redémarrées
SELECT i.*
FROM instance i
LEFT JOIN redemarrage r ON i.id = r.instance_id
WHERE r.id IS NULL;

-- d. Instances à récupérer
SELECT i.*
FROM instance i
WHERE date_desactivation IS NOT NULL AND est_chez_nfl_it = FALSE;

-- e. Historique des installations
SELECT ti.*, t.nom AS technicien_nom, cf.nom AS client_final_nom
FROM technicien_instance ti
JOIN technicien t ON ti.technicien_id = t.id
JOIN instance i ON ti.instance_id = i.id
JOIN client_final cf ON i.client_final_id = cf.id
WHERE i.numero_serie = 'SN00005'
ORDER BY ti.date_intervention;

-- f. Trigger redémarrage
CREATE TABLE IF NOT EXISTS alerte_redemarrages (
    instance_id INTEGER,
    nb_redemarrages INTEGER,
    date_alerte TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION check_redemarrage_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT COUNT(*) FROM redemarrage WHERE instance_id = NEW.instance_id) > 5 THEN
        INSERT INTO alerte_redemarrages (instance_id, nb_redemarrages)
        VALUES (NEW.instance_id, (SELECT COUNT(*) FROM redemarrage WHERE instance_id = NEW.instance_id));
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_check_redemarrages ON redemarrage;

CREATE TRIGGER trg_check_redemarrages
AFTER INSERT ON redemarrage
FOR EACH ROW EXECUTE FUNCTION check_redemarrage_trigger();