-- Créer une table d’archivage si elle n’existe pas
CREATE TABLE IF NOT EXISTS incident_archive (
    LIKE incident INCLUDING ALL
);

-- Archiver les incidents de plus de 6 mois
INSERT INTO incident_archive
SELECT * FROM incident
WHERE date < now() - INTERVAL '6 months';

-- Supprimer les incidents archivés
DELETE FROM incident
WHERE date < now() - INTERVAL '6 months';
