/*
============================================================================== A
Produit : CoFELI.Exemple.Universite
Variante : 2026.iter01
Artefact : Universite_cre.sql
Responsable : luc.lavoie@usherbrooke.ca
Version : 1.1.0a (2026-04-18)
Statut : travail en cours
Encodage : UTF-8, sans BOM; fin de ligne simple (LF)
Plateformes : PostgreSQL 12 à 18.4
============================================================================== A
*/

create domain MatriculeE
  Char (8)
  check (value similar to '[0-9]{8}') ;
comment on type MatriculeE is $$
* Un matricule a pour vocation d’identifier uniquement un étudiant.
* Il est composé de huit chiffres arabes.
$$ ; -- end of comment

create domain Nom
  VarChar(120)
  check (value similar to '[[:alpha:]]+([-’ [:alpha:]])*[[:alpha:]]+') ;
comment on type MatriculeE is $$
* Un nom tel consigné par l’État civil.
* Il est composé d’au plus 120 symboles autorisés par l’État civil.
$$ ; -- end of comment

create table Etudiant
(
  matriculeE MatriculeE not null,
  nom Nom not null,
  ddn Date not null,
  --  df matriculeE -> nom
  --  df matriculeE -> ddn
  constraint Etudiant_cc0 primary key (matriculeE)
) ;
comment on table Etudiant is $$
* L’étudiant est identifié par un matricule et caractérisé par son nom «nom» et
  sa date de naissance «ddn» tel que consigné par l’État civil.
* Dès lors que l’étudiant est défini, il est réputé admis et peut s’inscrire
  à des activités, y participer et se présenter aux évaluations de ces activités.
$$ ; -- end of comment

--
-- Gestion des activités
--

--
-- Gestion de l’offre
--

--
-- Gestion des inscriptions
--

--
-- Gestion des évaluations
--

--
-- Gestion des affections d’enseignants
--

/*
============================================================================== Z
Fin, pour plus de détails, voir 000_Universite.adoc.
============================================================================== Z
*/
