/*
============================================================================== A
Produit : CoFELI.Exemple.Universite
Variante : 2026.iter01
Artefact : Universite_jeu0.sql
Responsable : luc.lavoie@usherbrooke.ca
Version : 1.1.0a (2026-04-18)
Statut : travail en cours
Encodage : UTF-8, sans BOM; fin de ligne simple (LF)
Plateformes : PostgreSQL 12 à 18.4
============================================================================== A
*/

insert into Etudiant
  (matriculeE, nom, ddn)
values
  ('00001234', 'Daniel ABC', '2004-01-01'),
  ('88881234', 'Amélie DEF', '2004-02-01'),
  ('99991234', 'Alexia GHI', '2004-03-01');

/*
============================================================================== Z
Fin, pour plus de détails, voir 000_Universite.adoc.
============================================================================== Z
*/
