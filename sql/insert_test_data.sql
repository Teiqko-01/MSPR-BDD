-- Clients prestataires
INSERT INTO client_prestataire (nom, siret, adresse_siege, contact_principal)
VALUES
('TechCorp', '12345678901234', '1 rue de Paris, 75000 Paris', 'Jean Dupont'),
('NetManage', '23456789012345', '22 avenue Lyon, 69000 Lyon', 'Claire Moreau');

-- Clients finaux
INSERT INTO client_final (nom, adresse, client_prestataire_id)
VALUES
('Stadium One', '3 boulevard Sport, 75015 Paris', 1),
('TeamBase', '55 route Match, 13000 Marseille', 1),
('Football Analytics', '11 rue des Stats, 31000 Toulouse', 2),
('USGrid Network', '18 chemin Tech, 44000 Nantes', 2);

-- Techniciens
INSERT INTO technicien (nom, role)
VALUES
('Alice Lemaitre', 'support'),
('Eric Blanc', 'intégrateur');

-- OS Config
INSERT INTO os_config (cpu, ram, type_disque, taille_disque)
VALUES
('Intel i7', '16GB', 'SSD', 512),
('AMD Ryzen 5', '8GB', 'HDD', 1024);

-- Instances
INSERT INTO instance (nom, numero_serie, ip_locale, ip_vpn, etat, date_activation, version_os, version_app, est_chez_nfl_it, client_final_id, os_config_id)
VALUES
('MonitorX', 'SN00001', '192.168.1.10', '10.0.0.1', 'connectée', '2024-05-01', 'Ubuntu 22.04', '1.0', TRUE, 1, 1),
('MonitorY', 'SN00002', '192.168.1.11', '10.0.0.2', 'déconnectée', '2024-04-20', 'Debian 11', '1.2', FALSE, 2, 2);