/*
============================================================================== A
Produit : CoFELI.Exemple.Evaluation
Composant : Evaluation_cre.sql
Responsable : luc.lavoie@usherbrooke.ca
Version : 1.1.0 (2026-04-18)
Statut : applicable
Encodage : UTF-8, sans BOM; fin de ligne simple (LF)
Plateformes : ISO/IEC 7095 (éditions 2011-2023), PostgreSQL (versions 9.4-18)
============================================================================== A
*/

/*
============================================================================== B
Ce composant est un exemple conçu à des fins didactiques dans le cadre de CoFELI.
Création des schémas correspondant au modèle de consignation des résultats
d’évaluation des activités pédagogiques de l’Université de Samarcande (UdeS).
============================================================================== B
*/

DROP SCHEMA IF EXISTS "Evaluation" CASCADE;
CREATE SCHEMA "Evaluation";
COMMENT ON SCHEMA "Evaluation" IS '
.Sommaire
Ce module est un exemple conçu à des fins didactiques dans le cadre de CoFELI.
Il est plus particulièrement utilisées dans les modules TRM et SQL.

.Contexte
L’Université de Samarcande (UdeS), fondée en 1927, propose différentes activités
pédagogiques dans plusieurs domaines. Depuis deux ans, le nombre de personnes
étudiantes ne cesse d’augmenter. Afin de mieux répondre à leurs besoins, il est
nécessaire de pouvoir ajuster l’offre de formation aux parcours effectifs de
formation.

.Problème
Développer un système (informatisé) permettant de :

  * constiuer un répertoire des activités proposées ;
  * consigner les admissions à l’UdeS ;
  * consigner les inscriptions aux activités ;
  * consigner les résultats des évaluations (notes) par étudiant, par activité
    et par type d’évaluation.
' ; -- END OF COMMENT
SET SCHEMA 'Evaluation';

/*
Usage futur

DROP SCHEMA IF EXISTS "Eva_EMIR" CASCADE;
CREATE SCHEMA "Eva_EMIR";

DROP SCHEMA IF EXISTS "Eva_ALIM" CASCADE;
CREATE SCHEMA "Eva_ALIM";
*/

/*
============================================================================== Z
...
============================================================================== Z
*/
