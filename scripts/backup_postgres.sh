#!/bin/bash

BACKUP_DIR="/var/backups/postgres"
DB_NAME="seahawks_db"
DB_USER="postgres"
DATE=$(date +%Y-%m-%d_%H-%M)
FILENAME="${DB_NAME}_$DATE.sql"

# Créer le répertoire si nécessaire
mkdir -p $BACKUP_DIR

# Sauvegarde locale
pg_dump -U $DB_USER $DB_NAME > $BACKUP_DIR/$FILENAME

# Copie vers une autre machine
scp $BACKUP_DIR/$FILENAME user@192.168.1.100:/home/user/sauvegardes/

# Nettoyage local > 7 jours
find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -exec rm {} \;
