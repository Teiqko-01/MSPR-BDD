#psycopg2
import psycopg2
from datetime import datetime

# Connexion à PostgreSQL
conn = psycopg2.connect(
    dbname='seahawks_db',
    user='postgres',
    password='EPSI@2024',
    host='localhost'
)
cur = conn.cursor()

# Requêtes SQL de supervision
queries = {
    "requetes_par_seconde": "SELECT sum(calls) FROM pg_stat_statements;",
    "lectures_ecritures": "SELECT tup_returned, tup_inserted FROM pg_stat_database WHERE datname = 'seahawks_db';",
    "taille_bdd": "SELECT pg_size_pretty(pg_database_size('seahawks_db'));",
    "requetes_longues": "SELECT query, total_time, calls FROM pg_stat_statements ORDER BY total_time DESC LIMIT 5;",
    "index_non_utilises": '''
        SELECT relname, indexrelname, idx_scan
        FROM pg_stat_user_indexes
        JOIN pg_index ON pg_index.indexrelid = pg_stat_user_indexes.indexrelid
        WHERE idx_scan = 0;
    '''
}

results = {}

# Exécution des requêtes
for key, sql in queries.items():
    cur.execute(sql)
    results[key] = cur.fetchall()

# Création du fichier HTML
with open("supervision_output.html", "w", encoding="utf-8") as f:
    f.write(f"""<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Supervision PostgreSQL - Seahawks DB</title>
    <style>
        body {{ font-family: Arial, sans-serif; padding: 20px; background-color: #f4f4f4; }}
        h1 {{ color: #2c3e50; }}
        table {{ width: 100%; border-collapse: collapse; margin-bottom: 20px; background: white; }}
        th, td {{ border: 1px solid #ccc; padding: 8px; text-align: left; }}
        th {{ background-color: #2c3e50; color: white; }}
    </style>
</head>
<body>
    <h1>Supervision PostgreSQL - Seahawks DB</h1>
    <p>Date de génération : {datetime.now()}</p>

    <h2>1. Requêtes par seconde</h2>
    <table><tr><th>Total</th></tr>
    <tr><td>{results["requetes_par_seconde"][0][0]}</td></tr></table>

    <h2>2. Taux de lectures/écritures</h2>
    <table><tr><th>Lectures</th><th>Écritures</th></tr>
    <tr><td>{results["lectures_ecritures"][0][0]}</td><td>{results["lectures_ecritures"][0][1]}</td></tr></table>

    <h2>3. Taille de la base</h2>
    <table><tr><th>Taille</th></tr>
    <tr><td>{results["taille_bdd"][0][0]}</td></tr></table>

    <h2>4. Requêtes les plus longues</h2>
    <table><tr><th>Requête</th><th>Temps total (ms)</th><th>Appels</th></tr>
    {"".join([f"<tr><td>{r[0]}</td><td>{r[1]:.2f}</td><td>{r[2]}</td></tr>" for r in results["requetes_longues"]])}
    </table>

    <h2>5. Index non utilisés</h2>
    <table><tr><th>Table</th><th>Index</th><th>Scan</th></tr>
    {"".join([f"<tr><td>{r[0]}</td><td>{r[1]}</td><td>{r[2]}</td></tr>" for r in results["index_non_utilises"]])}
    </table>
</body></html>""")
    
cur.close()
conn.close()
