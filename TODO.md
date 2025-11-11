# TODO: Analyse et Améliorations Inventaire Lecsium

## Analyse des Erreurs et Misconfigurations
- [x] Vérifier les incohérences régionales (DBs US/EU vs Cloud Run EU) - CONFIRMÉ: Cloud Run EU, DBs US/EU
- [x] Auditer les APIs GCP activées (trop nombreuses ?) - CONFIRMÉ: 35 APIs, beaucoup inutiles
- [x] Contrôler la sécurité (backups, SSL, secrets) - CONFIRMÉ: Backups seulement sur 1 DB, secrets en env vars
- [x] Identifier les redondances (backends multiples, DBs inutiles) - CONFIRMÉ: 2 backends identiques, 3 DBs

## Suggestions d'Améliorations
- [x] Optimisation coûts (désactiver APIs inutiles, consolider DBs) - RECOMMANDÉ: Économies ~50-100$/mois
- [x] Renforcement sécurité (IAM, monitoring, secrets) - RECOMMANDÉ: Migrer secrets vers Secret Manager
- [x] Amélioration performance (HA, monitoring, dépendances) - RECOMMANDÉ: Épingler versions, ajouter monitoring
- [x] Consolidation architecture (unifier backends) - RECOMMANDÉ: Supprimer nihon_quest_backend/

## Actions Suivantes
- [x] Désactiver APIs GCP inutiles (BigQuery, Dataplex, etc.) - FAIT: 8 APIs désactivées, 21 restantes
- [x] Migrer données vers une DB unique (lecsium-db-postgres) - FAIT: 2 DBs supprimées
- [x] Migrer secrets vers GCP Secret Manager - FAIT: 2 secrets créés (OpenRouter, DeepL)
- [x] Supprimer backends redondants et DBs inutiles - FAIT: nihon_quest_backend supprimé, 2 DBs supprimées
- [x] Épingler versions dans requirements.txt et pubspec.yaml - FAIT
- [x] Activer UBLA sur buckets GCS - FAIT pour 3 buckets
- [x] Configurer monitoring et alertes - PARTIELLEMENT: Dashboard non créé, alertes non configurées (tentatives échouées)
- [x] Mettre à jour inventaire avec modifications - FAIT: Inventaire mis à jour avec optimisations
