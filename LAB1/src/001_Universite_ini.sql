/*
============================================================================== A
Produit : CoFELI.Exemple.Universite_LAB
Variante : 2026.iter01
Artefact : Universite_ini.sql
Responsable : luc.lavoie@usherbrooke.ca
Version : 1.1.0a (2026-04-18)
Statut : travail en cours
Encodage : UTF-8, sans BOM; fin de ligne simple (LF)
Plateformes : PostgreSQL 11 à 18.3
============================================================================== A
*/

/*
============================================================================== B
Ce composant est un exemple conçu à des fins didactiques dans le cadre de CoFELI.
Création des schémas correspondant au modèle de consignation des résultats
d’évaluation des activités pédagogiques de l’Université de Samarcande (UdeS).
============================================================================== B
*/

drop schema if exists "Universite" cascade ;
create schema "Universite";
COMMENT ON SCHEMA "Universite" is $$
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
Développer un système informatisé permettant de :

  * constiuer un répertoire des activités proposées ;
  * consigner les inscriptions aux activités ;
  * consigner les résultats des évaluations (notes) par étudiant, par activité
    et par type d’évaluation ;
  * consigner l’offre d’activités par trimestre ;
  * consigner l’affectation des enseignants aux activités offertes.
$$ ; -- end of comment

set schema 'Universite';

/*
============================================================================== Z
Fin, pour plus de détails voir 000_Universite.adoc.
============================================================================== Z
*/
