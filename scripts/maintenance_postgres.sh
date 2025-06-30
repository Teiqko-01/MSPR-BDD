#!/bin/bash

# Configuration
DB_NAME="seahawks_db"
DB_USER="postgres"
DB_PASSWORD="EPSI@2024"
LOG_DIR="/var/log/pg_maintenance"
SQL_DIR="/mnt/seahawks_monitoring_db/sql"
DATE=$(date +%Y-%m-%d_%H-%M)
LOG_FILE="$LOG_DIR/maintenance_$DATE.log"

# Export du mot de passe PostgreSQL pour la session
export PGPASSWORD=$DB_PASSWORD

# Création du dossier de logs
mkdir -p $LOG_DIR

echo "Début de la maintenance PostgreSQL - $DATE" > $LOG_FILE

# Archivage incidents
echo "--- Archivage des incidents anciens ---" >> $LOG_FILE
psql -U $DB_USER -d $DB_NAME -f "$SQL_DIR/archive_old_incidents.sql" >> $LOG_FILE 2>&1

# Détection d'inactivité
echo "--- Instances inactives depuis 60 jours ---" >> $LOG_FILE
psql -U $DB_USER -d $DB_NAME -f "$SQL_DIR/detect_inactive_instances.sql" >> $LOG_FILE 2>&1

echo "Fin de la maintenance - $DATE" >> $LOG_FILE

# Nettoyage variable
unset PGPASSWORD