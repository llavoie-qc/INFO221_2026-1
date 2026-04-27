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

--
-- Activités
--
insert into Activite
  (sigle, titre, credit)
values
  ('INF111', 'Éléments d’analyse et de programmation', 3),
  ('INF141', 'Éléments d’infrastructure informatique matérielle', 3),
  ('MAT111', 'Logique et mathématiques discrètes', 3),
  ('STA111', 'Introduction aux probalilités et aux statistiques', 3),
  ('INF211', 'Structures de données', 3),
  ('INF221', 'Éléments de modélisation et de bases données', 3),
  ('INF231', 'Éléments de télématique', 3),
  ('INF241', 'Interfaces personne-machine', 3),
  ('INF391', 'Projet d’intégration I', 6);

insert into Prealable
  (sigle, prealable)
values
  ('INF211', 'INF111'),
  ('INF211', 'MAT111'),
  ('INF211', 'STA111'),
  ('INF221', 'INF111'),
  ('INF221', 'MAT111'),
  ('INF221', 'STA111'),
  ('INF231', 'INF111'),
  ('INF231', 'INF141'),
  ('INF231', 'MAT111'),
  ('INF231', 'STA111'),
  ('INF241', 'INF111'),
  ('INF241', 'MAT111'),
  ('INF391', 'INF211'),
  ('INF391', 'INF221'),
  ('INF391', 'INF231'),
  ('INF391', 'INF241');

--
-- Offres
--
insert into Offre
  (sigle, trimestre)
values
  ('INF111', '20243'),
  ('INF141', '20243'),
  ('MAT111', '20243'),
  ('STA111', '20243'),
  ('INF211', '20243'),
  ('INF221', '20251'),
  ('INF231', '20251'),
  ('INF241', '20251'),
  ('INF391', '20251'),
  ('INF111', '20253'),
  ('INF141', '20253'),
  ('MAT111', '20253'),
  ('STA111', '20253'),
  ('INF211', '20253'),
  ('INF221', '20261'),
  ('INF231', '20261'),
  ('INF241', '20261'),
  ('INF391', '20261');

insert into Groupe
  (sigle, trimestre, noGroupe)
values
  ('INF111', '20243', '01'),
  ('INF141', '20243', '01'),
  ('MAT111', '20243', '01'),
  ('STA111', '20243', '01'),
  ('INF211', '20243', '01'),
  ('INF111', '20243', '02'),
  ('INF141', '20243', '02'),
  ('MAT111', '20243', '02'),
  ('STA111', '20243', '02'),
  ('INF211', '20243', '02'),
  ('INF221', '20251', '01'),
  ('INF231', '20251', '01'),
  ('INF241', '20251', '01'),
  ('INF391', '20251', '01'),
  ('INF111', '20253', '01'),
  ('INF141', '20253', '01'),
  ('MAT111', '20253', '01'),
  ('STA111', '20253', '01'),
  ('INF211', '20253', '01'),
  ('INF111', '20253', '02'),
  ('INF141', '20253', '02'),
  ('MAT111', '20253', '02'),
  ('STA111', '20253', '02'),
  ('INF211', '20253', '02'),
  ('INF221', '20261', '01'),
  ('INF231', '20261', '01'),
  ('INF241', '20261', '01'),
  ('INF391', '20261', '01');

--
-- Étudiants
--
insert into Etudiant
  (matriculeE, nom, ddn)
values
  ('99910001', 'Arnold AAA', '2004-01-01'),
  ('99910002', 'Amélie BBB', '2004-02-01'),
  ('99910003', 'Alexia CCC', '2004-03-01'),
  ('99910004', 'Arnold DDD', '2004-04-01'),
  ('99910005', 'Amélie EEE', '2004-05-01'),
  ('99910006', 'Alexia FFF', '2004-06-01'),
  ('99910007', 'Arnold GGG', '2004-07-01'),
  ('99910008', 'Amélie HHH', '2004-08-01'),
  ('99910009', 'Alexia III', '2004-09-01'),

  ('99920001', 'Bianca AAA', '2004-01-01'),
  ('99920002', 'Brenda BBB', '2004-02-01'),
  ('99920003', 'Blaise CCC', '2004-03-01'),
  ('99920004', 'Bianca DDD', '2004-04-01'),
  ('99920005', 'Brenda EEE', '2004-05-01'),
  ('99920006', 'Blaise FFF', '2004-06-01'),
  ('99920007', 'Bianca GGG', '2004-07-01'),
  ('99920008', 'Brenda HHH', '2004-08-01'),
  ('99920009', 'Blaise III', '2004-09-01'),

  ('99930001', 'Cédric AAA', '2004-01-01'),
  ('99930002', 'Clovis BBB', '2004-02-01'),
  ('99930003', 'Carole CCC', '2004-03-01'),
  ('99930004', 'Cédric DDD', '2004-04-01'),
  ('99930005', 'Clovis EEE', '2004-05-01'),
  ('99930006', 'Carole FFF', '2004-06-01'),
  ('99930007', 'Cédric GGG', '2004-07-01'),
  ('99930008', 'Clovis HHH', '2004-08-01'),
  ('99930009', 'Marie-Soleil Clair-de-Lune', '2004-09-01'),

  ('99940001', 'Daniel AAA', '2004-01-01'),
  ('99940002', 'Daphné BBB', '2004-02-01'),
  ('99940003', 'Damien CCC', '2004-03-01'),
  ('99940004', 'Daniel DDD', '2004-04-01'),
  ('99940005', 'Daphné EEE', '2004-05-01'),
  ('99940006', 'Damien FFF', '2004-06-01'),
  ('99940007', 'Daniel GGG', '2004-07-01'),
  ('99940008', 'Daphné HHH', '2004-08-01'),
  ('99940009', 'Joseph-Arthur Soleil-Noir', '2004-09-01');

--
-- Inscriptions
--
create or replace procedure Inscription_ins0 (c Char, t trimestre, n NoGroupe)
begin atomic
with
  T as (
    select *
    from Groupe
    where trimestre = t and noGroupe = n
  ),
  C as (
    select matriculeE
    from Etudiant
    where substring(matriculeE, 4, 1) = c
    )
insert into Inscription
  select sigle, trimestre, noGroupe, matriculeE
  from T cross join C ;
end ;

call Inscription_ins0 ('1', '20243', '01');
call Inscription_ins0 ('2', '20243', '02');
call Inscription_ins0 ('1', '20251', '01');
call Inscription_ins0 ('2', '20251', '01');
call Inscription_ins0 ('3', '20253', '01');
call Inscription_ins0 ('4', '20253', '02');
call Inscription_ins0 ('3', '20261', '01');
call Inscription_ins0 ('4', '20261', '01');

--
-- Evaluations
--
create or replace function note_alea () returns Note
return cast (floor (50 + random()*51) as Note) ;

insert into Evaluation (sigle, trimestre, matriculeE, note)
  select sigle, trimestre, matriculeE, note_alea() as note
  from Inscription ;

select avg (note) as moyenne
from Evaluation ;

--
-- Enseignants
--
insert into  Enseignant
  (matriculeP, nom)
values
  ('880001', 'Tryphon Tournesol'),
  ('880002', 'Gaston Lagaffe'),
  ('880003', 'Marie-Soleil Clair-de-Lune'),
  ('880004', 'Maria Skłodowska'),
  ('880005', 'Ada Lovelace'),
  ('880006', 'Joseph-Arthur Soleil-Noir');

/*
insert into  Enseignant_Bureau_PRE
  (matriculeP, bureau)
values
  ('880001', 'D4-2001'),
  ('880003', 'D4-2003'),
  ('880004', 'D4-2004'),
  ('880005', 'D4-2005');

insert into  Enseignant_Bureau_ABS
  (matriculeP, cause)
values
  ('880002', 'en congé sabbatique');
*/

/*
-- Comptetence (sigle, MatriculeP)
-- Disponibilité (trimestre, MatriculeP)
*/

--
-- Affectations
--

with C as (select * from Groupe where sigle = 'INF111')
insert into Affectation
select sigle, trimestre, noGroupe, '880001' as matriculeP from C ;

with C as (select * from Groupe where sigle = 'INF211')
insert into Affectation
select sigle, trimestre, noGroupe, '880001' as matriculeP from C ;

with C as (select * from Groupe where sigle = 'INF141')
insert into Affectation
select sigle, trimestre, noGroupe, '880002' as matriculeP from C ;

with C as (select * from Groupe where sigle = 'INF231')
insert into Affectation
select sigle, trimestre, noGroupe, '880002' as matriculeP from C ;

with C as (select * from Groupe where sigle = 'MAT111')
insert into Affectation
select sigle, trimestre, noGroupe, '880003' as matriculeP from C ;

with C as (select * from Groupe where sigle = 'INF221')
insert into Affectation
select sigle, trimestre, noGroupe, '880003' as matriculeP from C ;

with C as (select * from Groupe where sigle = 'STA111')
insert into Affectation
select sigle, trimestre, noGroupe, '880004' as matriculeP from C ;

with C as (select * from Groupe where sigle = 'INF241')
insert into Affectation
select sigle, trimestre, noGroupe, '880004' as matriculeP from C ;

with C as (select * from Groupe where sigle = 'INF391')
insert into Affectation
select sigle, trimestre, noGroupe, '880005' as matriculeP from C ;

insert into Groupe (sigle, trimestre, noGroupe)
values ('INF391', '20261', '02') ;
insert into Affectation (sigle, trimestre, noGroupe, matriculeP)
values ('INF391', '20261', '02', '880006') ;

/*
============================================================================== Z
Fin, pour plus de détails, voir 000_Universite.adoc.
============================================================================== Z
*/
