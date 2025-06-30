-- Liste des instances sans incident ni redémarrage depuis 60 jours
SELECT i.*
FROM instance i
LEFT JOIN incident inc ON inc.instance_id = i.id AND inc.date > now() - INTERVAL '60 days'
LEFT JOIN redemarrage r ON r.instance_id = i.id AND r.date > now() - INTERVAL '60 days'
WHERE inc.id IS NULL AND r.id IS NULL;