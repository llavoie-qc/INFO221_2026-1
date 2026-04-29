/*
============================================================================== A
Produit : CoFELI.Exemple.Universite_LAB
Variante : 2026.iter01
Artefact : Universite_req2.sql
Responsable : luc.lavoie@usherbrooke.ca
Version : 1.1.0a (2026-04-19)
Statut : travail en cours
Encodage : UTF-8, sans BOM; fin de ligne simple (LF)
Plateformes : PostgreSQL 12 à 18.3
============================================================================== A
*/

/*
============================================================================== B

1. Quels sont les étudiants inscrits à une activité à un semestre donné ?
2. Quelle est la répartition de ces étudiants entre les différents groupes ?
3. Quelle est la moyenne d’un étudiant donné pour trimestre donné ?
4. Produire le relevé de notes d’un étudiant donné.
5. Quelle est la charge d’enseignement d’un enseignant à un trimestre donné ?
6. Quels sont les enseignants ayant déjà enseigné une activité donnée ?
7. Quels sont les enseignants qui n’ont encore jamais enseigné ?
8. Quels sont les enseignants qui portent le même nom qu’un étudiant ?

============================================================================== B
*/

-- 1.	Quels sont les étudiants inscrits à une activité à un semestre donné ?
-- Supposons sigle = 'INF221', trimestre = '20251'

select distinct matriculeE, nom
from Inscription natural join Etudiant
where sigle = 'INF221' and trimestre = '20251' ;

-- 2.	Quelle est la répartition de ces étudiants entre les différents groupes ?
-- Sur la base du #1, il suffit d’ajouter le noGroupe puis de trier
-- Supposons sigle = 'INF111', trimestre = '20243'

select distinct noGroupe, nom, matriculeE
from Inscription natural join Etudiant
where sigle = 'INF111' and trimestre = '20243'
order by noGroupe, nom, matriculeE;

-- Différentes variations de renommage, voir le module SQL_03b, pages 20-21 pour plus de détails
select distinct I.noGroupe, E.nom, E.matriculeE
from Inscription as I natural join Etudiant as E
where I.sigle = 'INF111' and I.trimestre = '20243'
order by I.noGroupe, E.nom, E.matriculeE;

select distinct noGroupe, nom, matriculeE
from Inscription join Etudiant using (matriculeE)
where sigle = 'INF111' and trimestre = '20243'
order by noGroupe, nom, matriculeE;

select distinct noGroupe, nom, I.matriculeE
from Inscription as I join Etudiant as E on (I.matriculeE=E.matriculeE)
where sigle = 'INF111' and trimestre = '20243'
order by noGroupe, nom, I.matriculeE;

-- 3.	Quelle est la moyenne d’un étudiant donné pour trimestre donné ?
-- Supposons matriculeE='99910001', trimestre='20251'
-- Attention à la problématique de l’information manquante

select avg(note) as moyenne_generale
from  Evaluation natural join Etudiant
where matriculeE = '99910001' and trimestre = '20251' ;

-- 4.	Produire le relevé de notes d’un étudiant donné.
-- Supposons matriculeE='99910001'
-- Proposons de produire la liste de (sigle, titre, note) pour chacune des
-- activités auxquelles l’étudiant est inscrit.

  select sigle, titre, credit, note
  from etudiant natural join evaluation natural join activite
  where matriculeE = '99910001' ;

-- Cette variante avec dénomination explicite et jointure conditionnelle est
-- également possible...
-- Noter que la jointure avec inscription est totalement inutile,
-- sauriez-vous dire pourquoi ?
SELECT
  a.sigle,
  a.titre,
  ev.note,
  a.credit
FROM etudiant e
JOIN inscription i ON e.matriculee = i.matriculee -- totalement inutile
JOIN activite a ON i.sigle = a.sigle
JOIN evaluation ev ON (
    i.sigle = ev.sigle
    AND i.trimestre = ev.trimestre
    AND i.matriculee = ev.matriculee)
WHERE e.matriculee = '99910001';

-- Généralisation
create or replace function Releve_notes (m MatriculeE)
returns table (sigle Sigle, titre Titre, note Note, credit Credit)
begin atomic
  select sigle, titre, credit, note
  from etudiant natural join evaluation natural join activite
  where matriculeE = m ;
end ;

select * from Releve_notes ('99910001') ;
select * from Releve_notes ('99910002') ;

-- 5.	Quelle est la charge d’enseignement d’un enseignant à un trimestre donné ?
-- Supposons matricule P= '880004' et trimestre = '20251'
select trimestre, sigle, titre, noGroupe
from Affectation natural join Activite
where matriculeP = '880004' and trimestre = '20251'
order by trimestre, sigle, noGroupe;

-- 6.	Quels sont les enseignants ayant déjà enseigné une activité donnée ?
-- Supposons sigle='INF391'
select distinct matriculeP, nom
from Affectation natural join Enseignant
where sigle = 'INF391' ;

-- 7. Quels sont les enseignants qui n’ont encore jamais enseigné ?
with E as (
  select matriculeP from Enseignant
  except
  select distinct matriculeP from Affectation
  )
select matriculeP, nom
from E natural join Enseignant ;

-- 8. Quels sont les enseignants qui portent le même nom qu’un étudiant ?
select matriculeP, nom, matriculeE
from Enseignant join Etudiant using (nom) ;

/*
============================================================================== Z
Fin, pour plus de détails, voir 000_Universite.adoc.
============================================================================== Z
*/
