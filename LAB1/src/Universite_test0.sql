/*
============================================================================== A
Produit : CoFELI.Exemple.Universite_LAB
Variante : 2026.iter01
Artefact : Universite_test0.sql
Responsable : luc.lavoie@usherbrooke.ca
Version : 1.1.0a (2026-04-18)
Statut : travail en cours
Encodage : UTF-8, sans BOM; fin de ligne simple (LF)
Plateformes : PostgreSQL 12 à 18.4
============================================================================== A
*/

insert into Etudiant
  (matriculeE, nom, ddn)
values -- matricule trop court
  ('5551234', 'Alexia GHI', '2004-03-01');

insert into Etudiant
  (matriculeE, nom, ddn)
values -- matricule trop long
  ('555551234', 'Alexia GHI', '2004-03-01');

insert into Etudiant
  (matriculeE, nom, ddn)
values -- matricule comportant un caractère interdit
  ('5551234', 'Alexia GHI', '2004-03-01');



/*
============================================================================== Z
Fin, pour plus de détails, voir 000_Universite.adoc.
============================================================================== Z
*/
