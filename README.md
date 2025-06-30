# 📦 Projet MSPR BDD – Nester Manager / Seahawks Monitoring

## 🧾 Présentation

Ce projet a été réalisé dans le cadre de la MSPR BDD du titre **Administrateur Systèmes, Réseaux et Bases de Données (ASRBD)**.

Objectif : concevoir, administrer et sécuriser une base de données relationnelle pour l’application fictive **Nester Manager**, outil de gestion et de supervision d’instances logicielles déployées dans 32 franchises NFL et chez des prestataires tiers.

---

## 👥 Équipe projet

| Nom            | Prénom     | Rôle principal                         |
|----------------|------------|----------------------------------------|
| BELLOIR         | Félix  | Modélisation BDD (MCD/MLD), scripts SQL |
| CARRE         | Adrien  | Supervision, sauvegarde, triggers       |
| BERTRAND T         | Corentin | Sécurité, utilisateurs, vues filtrées   |
| BOURNAUD         | Tom  | Requêtes métiers, documentation         |

---

## 🗂️ Contenu du projet
```
├── seahawks_monitoring_db/
│ ├── README.md
│ ├── backups/
│ ├── docs/
| │ ├── Rapport-doccumentation.pdf
│ │ ├── mcd.png
│ │ ├── mld.png
│ ├── html/
│ │ ├── supervision_output.html
│ ├── scripts/
│ │ ├── backup_postgres.sh
│ │ ├── maintenance_postgres.sh
│ │ ├── supervision_generator.py
│ ├── sql/
│ │ ├── archive_old_incidents.sql
│ │ ├── create_tables.sql
│ │ ├── detect_inactive_instances.sql
│ │ ├── insert_test_data.sql
│ │ ├── optimisation_vues.sql
│ │ ├── requets-trigger.sql
│ │ ├── roles_permissions.sql
```

---

## ⚙️ Stack technique

- **PostgreSQL** : SGBD principal
- **PgAdmin 4** : Interface de gestion
- **Python (psycopg2)** : Génération de supervision HTML
- **Bash (cron)** : Sauvegarde automatique
- **SQL** : Création, interrogation, sécurisation de la base
- **VM locale / Workstation** : Environnement d’hébergement

---

## 🔐 Sécurité & Accès

- 3 utilisateurs créés : admin, lecture seule, prestataire avec vues restreintes
- Authentification renforcée et filtrage réseau
- Supervision active des performances
- Sauvegarde toutes les 2h, nettoyage automatique

---

## 📊 Supervision

Un script Python collecte les indicateurs suivants :
- Requêtes par seconde
- Taux de lectures/écritures
- Taille de la base
- Requêtes lentes
- Index inutilisés

Export HTML automatique consultable en local.

---

## ✅ Réalisations principales

- 🔧 MCD / MLD
- 📦 Déploiement SQL automatisé
- 🛡️ Droits et vues sécurisées
- 🔁 Sauvegarde + restauration testées
- 🧠 Supervision live (HTML)
- 🧮 Requêtes métier + trigger personnalisés
- 📘 Documentation claire et structurée

---

## 📅 Organisation

- Planification initiale en 7 semaines
- Répartition claire des tâches (voir tableau équipe)
- Revue croisée des livrables
- Suivi agile hebdomadaire
