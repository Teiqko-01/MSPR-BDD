-- Création d'index pour optimiser les requêtes courantes

-- Recherches par état de l'instance
CREATE INDEX idx_instance_etat ON instance(etat);

-- Filtrage par client final
CREATE INDEX idx_instance_client_final_id ON instance(client_final_id);

-- Requêtes fréquentes sur incidents
CREATE INDEX idx_incident_instance_id ON incident(instance_id);

-- Recherche technicien
CREATE INDEX idx_technicien_nom ON technicien(nom);

-- Vue sécurisée pour isoler les données d’un prestataire

CREATE OR REPLACE VIEW vue_instances_par_prestataire AS
SELECT i.*
FROM instance i
JOIN client_final cf ON i.client_final_id = cf.id
JOIN client_prestataire cp ON cf.client_prestataire_id = cp.id
WHERE cp.id = current_setting('app.prestataire_id')::int;

-- Utilisateur restreint qui ne peut voir que ses instances
CREATE ROLE prestataire_vu WITH LOGIN PASSWORD 'prestataire123';

GRANT USAGE ON SCHEMA public TO prestataire_vu;
GRANT SELECT ON vue_instances_par_prestataire TO prestataire_vu;

-- Astuce : définir la variable de session au moment de la connexion
-- SET app.prestataire_id = 2;
-- SELECT * FROM vue_instances_par_prestataire;

-- Ce rôle ne pourra pas voir les autres tables directement
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM prestataire_vu;