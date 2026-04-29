/*
============================================================================== A
Produit : CoFELI.Exemple.Universite_LAB
Variante : 2026.iter01
Artefact : Universite_req3.sql
Responsable : luc.lavoie@usherbrooke.ca
Version : 1.1.0a (2026-04-19)
Statut : travail préparatoire en cours
Encodage : UTF-8, sans BOM; fin de ligne simple (LF)
Plateformes : PostgreSQL 12 à 18.3
============================================================================== A
*/

/*
============================================================================== B

X01::
Calculer le nombre d’étudiants par groupe.

X02::
Quel est le trimestre comportant le plus d’inscriptions ?

X03::
Quels sont les enseignants n’ayant pas enseigné d’activités de niveau 1 ? +
Le niveau d’une activité est donné par le premier chiffre du sigle.

X04::
Quels sont les étudiants inscrits à au moins 5 activités et les ayant toutes
réussies ?

X05::
Quels sont les étudiants ayant réussi au moins 5 activités et une moyenne
cumulative inférieure à 65 ?

X06::
Quels sont les étudiants ayant réussi au moins 5 activités avec une moyenne cumulative
supérieure à un écart-type au-dessus de la moyenne de leur cohorte ? +
La cohorte d’un étudiant est donnée par le quatrième chiffre de son matricule.

X07::
Quels sont les sigles d’activités dont le niveau est incorrect ? +
Le niveau d’une activité sans préalable est 1. +
Le niveau d’une activité avec préalable est déterminé comme un de plus que
le niveau maximal de ses préalables.

X08::
Exprimer toutes les requêtes précédentes sous la forme de fonctions paramétrées
adéquatement.

============================================================================== B
*/

/*
NOTE
* Toutes les fonctions sans paramètres pourraient être exprimées comme des vues.
* Les requêtes uni-lignes précédées du marqueur /*T*/ sont des tests minimaux
  composés sur la base des données des fichiers Universite_jeu0.sql et
  Universite_jeu3.sql. Elles peuvent être inhibées en substituant --T-- au
  marqueur /*T*/ (et vice-versa).
* Le présent commentaire illustre le fait que les commentaires multi-lignes de
  SQL sont emboitables. :-)

TODO
1. Une règle de pratique souvent appliquée recommande de privilégier les
   jointures sélectives (using) aux jointures naturelles afin de pallier le
   risque d’une modification indirecte de la nature de la jointure en cas
   de changements aux listes d’attributs des tables impliquées.
   Ceci augmente l’évolutivité du script.
   À FAIRE : Appliquer cette règle au présent script.
2. La requête X05 n’a pas pris en compte la possibilité qu’un étudiant puisse être inscrit
   à une même activité plusieurs fois. Dans ce cas, la règle stipule qu’il faut
   utiliser la seule note la plus récente dans le cal de la moyenne.
   À FAIRE : Appliquer la règle.
   Ce cas inclut la reprise d’un cours déjà réussi.
   Problème : dans le calcul de la réussite, de la moyenne, etc.,
   quelle(s) valeurs(s) prendre en considération ?
   - la plus élevée,
   - la plus récente,
   - toutes ?
3. Le calcul des moyennes cumulatives doit prendre en compte la pondération des
   notes par le nombre de crédits des activités.
   À FAIRE : appliquer cette règle.
4. Écrire la fonction X07 à partir des deux requêtes proposées.
*/

--
-- X01
--
create or replace function Etudiant_nb ()
  returns table (sigle Sigle, trimestre Trimestre, noGroupe NoGroupe, n Integer)
begin atomic
  select sigle, trimestre, noGroupe, count(*) as n
  from Inscription
  group by sigle, trimestre, noGroupe ;
end;
comment on function Etudiant_nb is $$
Calculer le nombre d’étudiants par groupe.
$$ ; -- end of comment
/*T*/ select * from Etudiant_nb() order by sigle, trimestre, noGroupe ;

--
-- X02
--
create or replace function Trimestre_max ()
  returns table (trimestre Trimestre, n Integer)
begin atomic
  with T as (
    select trimestre, count(*) as n
    from Inscription
    group by trimestre)
  select trimestre, n
  from T
  where n = (select max(n) from T) ;
end;
comment on function Trimestre_max is $$
Quel est le trimestre comportant le plus d’inscriptions ?
Il peut y avoir plusieurs trimestres _ex aequo_, le résultat est donc une table.
$$ ; -- end of comment
/*T*/ select * from Trimestre_max() order by trimestre ;

--
-- X03
--
-- type et fonction utilitaires
create domain Niveau as
  Char check (value between '1' and '6');
create or replace function Activite_niveau (s Sigle) returns Niveau
return substring(s,4,1) ;

-- fonction principale
create or replace function Enseignant_N1_absent_vEns
  (n Niveau)
  returns table (matriculeP MatriculeP, nom Nom)
begin atomic
-- La présente version fait un calcul ensembliste trivial.
  with X as (
      select matriculeP from Enseignant
    except
      select distinct matriculeP from Affectation where Activite_niveau(sigle)=n
    )
  select *
  from Enseignant natural join X ;
end;
comment on function Enseignant_N1_absent_vEns is $$
Quels sont les enseignants n’ayant pas enseigné d’activités de niveau _n_ ? +
Le niveau d’une activité est donné par le premier chiffre du sigle.
$$ ; -- end of comment
/*T*/ select nom, matriculeP from Enseignant_N1_absent_vEns('2') order by nom, matriculeP ;

create or replace function Enseignant_N1_absent_vQuant
  (n Niveau)
  returns table (matriculeP MatriculeP, nom Nom)
begin atomic
-- La présente version utilise la quantification.
  with X as (
    select matriculeP from Enseignant as E
    where not exists (
      select 1
      from Affectation as A
      where Activite_niveau(sigle)=n and E.matriculeP=A.matriculeP)
    )
  select * from Enseignant natural join X ;
end;
comment on function Enseignant_N1_absent_vQuant is $$
Quels sont les enseignants n’ayant pas enseigné d’activités de niveau _n_ ? +
Le niveau d’une activité est donné par le premier chiffre du sigle.
$$ ; -- end of comment
/*T*/ select nom, matriculeP from Enseignant_N1_absent_vQuant('2') order by nom, matriculeP ;

--
-- X04
--
create or replace function Etudiant_nbi_sans_echec
  (nbi Integer, reussite Note)
  returns table (matriculeE MatriculeE, nom Nom)
begin atomic
-- La présente version fait un calcul ensembliste.
  with X as (
      -- étudiants ayant au moins nbc cours
      select matriculeE
      from Evaluation
      group by matriculeE
      having count(distinct sigle) >= nbi
    except
      -- étudiants ayant au moins un échec
      select distinct matriculeE
      from Evaluation
      where note < reussite
    )
  select matriculeE, nom
  from Etudiant natural join X ;
end ;
comment on function Etudiant_nbi_sans_echec is $$
Quels sont les étudiants inscrits à au moins _nbc_ activités et les ayant toutes
réussies ? +
Le critère de réussite est d’avoir obtenu une note d’au moins _reussite_.
$$ ; -- end of comment
/*T*/ select nom, matriculeE from Etudiant_nbi_sans_echec(5, 60::Note) order by nom ;
/*T*/ select count(*) from evaluation ;
/*T*/ select count(distinct matriculeE) from evaluation where note < 60 ;

--
-- X05
--
-- fonction utilitaire : étudiants ayant réussi au moins _nbr_ activités
-- prendre en compte qu’un étudiant peut réussir un cours plusieurs fois
-- dans l’espoir d’augmenter sa moyenne (voir **[1]** ci-après)
create or replace function Etudiant_nbr
  (nbr Integer, reussite Note)
  returns table (matriculeE MatriculeE)
begin atomic
  select matriculeE
  from Evaluation
  where note >= reussite
  group by matriculeE
  having count(distinct sigle) >= nbr ; -- distinct requis **[1]**
end;
/*T*/ select * from Etudiant_nbr(5, 60::Note) order by matriculeE ;

-- fonction principale
create or replace function Etudiant_nbr_seuil
  (nbr Integer, reussite Note, seuil Note)
returns table (
  matriculeE MatriculeE,
  nom Nom,
  moy numeric(4,2)
  )
begin atomic
-- La présente version fait un calcul ensembliste.
  with
   Y as (
      -- Etudiants_nbr ayant moins que le seuil
      select matriculeE, round (avg(note), 2) as moy
      from Evaluation natural join Etudiant_nbr (nbr, reussite)
      group by matriculeE
      having avg(note) < seuil
    )
  select matriculeE, nom, moy
  from Etudiant natural join Y ;
end ;
comment on function Etudiant_nbr_seuil is $$
Quels sont les étudiants ayant réussi au moins _nbc_ activités et une moyenne
cumulative inférieure à _seuil_ ?
$$ ; -- end of comment
/*T*/ select nom, matriculeE, moy from Etudiant_nbr_seuil(5, 60::Note, 65::Note) order by nom ;
/*T*/ select * from Evaluation where matriculeE = '99940007' ;
/*T*/ select avg(note) from Evaluation where matriculeE = '99940007' ;

--
-- X06
--
-- type et fonction utilitaires
create domain Cohorte as
  Char check (value between '1' and '9') ;
create or replace function Etudiant_cohorte (m MatriculeE) returns Cohorte
return substring(m,4,1);

-- fonction principale
create or replace function Etudiant_nbr_et
  (nbr Integer, reussite Note, factET numeric)
  returns table (matriculeE MatriculeE, nom Nom, moyenne_cum Numeric, moyenne_coh Numeric, ecart_type_coh Numeric)
begin atomic
  with
    E as (
      -- moyenne de chaque Etudiant_nbr
      select matriculeE, Etudiant_cohorte(matriculeE) as cohorte, avg(note) as moyenne_cum
      from Evaluation natural join Etudiant_nbr (nbr, reussite)
      group by matriculeE
      ),
    C as (
      -- moyenne et écart-type de la cohorte
      select cohorte, avg(moyenne_cum) as moyenne_coh, stddev_pop(moyenne_cum) as ecart_type_coh
      from E
      group by cohorte
      )
    -- résultat
    select
      matriculeE,
      nom,
      round(moyenne_cum,2) as moyenne_cum,
      round(moyenne_coh,2) as moyenne_coh,
      round(ecart_type_coh,2) asecart_type_coh
    from E join C on E.cohorte = C.cohorte natural join Etudiant
    where moyenne_cum > moyenne_coh + factET*ecart_type_coh ;
end ;
comment on function Etudiant_nbr_et is $$
Quels sont les étudiants ayant réussi au moins _nbr_ activités avec une moyenne cumulative
supérieure à un écart-type au-dessus de la moyenne de leur cohorte ? +
La cohorte d’un étudiant est donnée par le quatrième chiffre de son matricule.
$$ ; -- end of comment
/*T*/ select * from Etudiant_nbr_et (5, 60::Note, 1.0) ;

--
-- X07
--
-- type et fonction utilitaires
create domain NiveauNum as
  Integer check (value between 1 and 6);
create or replace function Activite_niveauNum (s Sigle)
  returns NiveauNum return cast(Activite_niveau(s) as NiveauNum) ;

-- fonction principale
-- pour le niveau 1
select sigle, 'aucun préalable' as préalables
from Activite left join Prealable using(sigle)
where prealable is null and Activite_niveauNum(sigle) <> 1;
-- pour les niveaux 2 et plus
select sigle, string_agg(prealable, ', ') as préalables
from Activite natural join Prealable
group by sigle
having Activite_niveauNum(sigle) <> (max(Activite_niveauNum(prealable))+1) ;

/*
TODO 2026-04-29 LL01. Fonction X07 à compléter et verifier

comment on function Sigles_incorrects is $$
Quels sont les sigles d’activités dont le niveau est incorrect ? +
Le niveau d’une activité sans préalable est 1. +
Le niveau d’une activité avec préalable est déterminé comme un de plus que
le niveau maximal de ses préalables.
$$ ; -- end of comment
*/

/*
============================================================================== Z
Fin, pour plus de détails, voir 000_Universite.adoc.
============================================================================== Z
*/
