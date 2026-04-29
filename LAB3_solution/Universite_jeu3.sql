/*
============================================================================== A
Produit : CoFELI.Exemple.Universite
Variante : 2026.iter01
Artefact : Universite_jeu3.sql
Responsable : luc.lavoie@usherbrooke.ca
Version : 1.1.0a (2026-04-18)
Statut : travail en cours
Encodage : UTF-8, sans BOM; fin de ligne simple (LF)
Plateformes : PostgreSQL 12 à 18.4
============================================================================== A
*/

/*
On suppose que le jeu0 a été inclus au préalable

DONE
1. Ajouter un étudiant avec 5 activités, mais comportant un échec.
2. Ajouter un étudiant avec 4 activités, mais sans échec.
3. Ajouter une activité dont le niveau est incorrect (n=1)
4. Ajouter une activité dont le niveau est incorrect (n>1)

TODO
...
*/
insert into Etudiant
  (matriculeE, nom, ddn)
values
  ('99910021', 'Arnold Cinq-activités-avec-un-échec', '2004-01-01'),
  ('99910022', 'Amélie Quatre-activités-sans-echec', '2004-02-01');

Insert into Inscription
  (sigle, trimestre, noGroupe, matriculeE)
values
  ('INF111', '20243', '01', '99910021'),
  ('INF141', '20243', '01', '99910021'),
  ('MAT111', '20243', '01', '99910021'),
  ('STA111', '20243', '01', '99910021'),
  ('INF211', '20243', '01', '99910021'),
  ('INF111', '20243', '01', '99910022'),
  ('INF141', '20243', '01', '99910022'),
  ('MAT111', '20243', '01', '99910022'),
  ('STA111', '20243', '01', '99910022');
Insert into Evaluation
  (sigle, trimestre, matriculeE, note)
values
  ('INF111', '20243', '99910021', 80),
  ('INF141', '20243', '99910021', 80),
  ('MAT111', '20243', '99910021', 80),
  ('STA111', '20243', '99910021', 80),
  ('INF211', '20243', '99910021', 40),
  ('INF111', '20243', '99910022', 80),
  ('INF141', '20243', '99910022', 80),
  ('MAT111', '20243', '99910022', 80),
  ('STA111', '20243', '99910022', 80);

insert into Activite
  (sigle, titre, credit)
values
  ('ZZZ111', 'ZZZ111', 3),
  ('ZZZ311', 'ZZZ311', 6),
  ('ZZZ411', 'ZZZ411', 9);

insert into Prealable
  (sigle, prealable)
values
  ('ZZZ111', 'INF111'),
  -- ZZZ311, pas de préalable
  ('ZZZ411', 'INF111'),
  ('ZZZ411', 'INF211');

/*
============================================================================== Z
Fin, pour plus de détails, voir 000_Universite.adoc.
============================================================================== Z
*/
