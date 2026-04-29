/*
============================================================================== A
Produit : CoFELI.Exemple.Universite
Variante : 2026.iter01
Artefact : Universite_cre.sql
Responsable : luc.lavoie@usherbrooke.ca
Version : 1.1.0a (2026-04-18)
Statut : travail en cours
Encodage : UTF-8, sans BOM; fin de ligne simple (LF)
Plateformes : PostgreSQL 12 à 18.3
============================================================================== A
*/

--
-- Gestion des activités
--

create domain Sigle AS
  Char (6)
  check (value similar to '[A-Z]{3}[0-9]{3}') ;

comment on type Sigle is $$
* Un sigle de cours a pour vocation d’identifier uniquement une activité de formation.
* Il est composé de trois lettres majuscules latines suivies de trois chiffres arabes.
$$ ; -- end of comment

create domain Credit
  SmallInt
  check (value between 1 and 180) ;
comment on type Sigle is $$
* Unité de mesure applicable aux activités de formation.
$$ ; -- end of comment

create domain Titre
  VarChar(60) ;
comment on type Sigle is $$
* Court texte descriptif utilisé notamment pour les activités de formation.
$$ ; -- end of comment

create table Activite
(
  sigle Sigle not null,
  titre Titre not null,
  credit Credit not null,
  --  df sigle -> titre
  --  df sigle -> crédit
  constraint Activite_cc0 primary key (sigle),
  constraint Activite_credit check (credit <= 30)
) ;
comment on table Activite is $$
* L’activité est identifiée par un sigle et caractérisée par un titre et nombre
  de crédits qu’elle apporte au sein d’un programme de formation.
* Une activité comporte des évaluations.
* Dès lors que l’activité est définie, elle peut être offerte.
$$ ; -- end of comment

create table Prealable
(
  sigle Sigle not null,
  prealable Sigle not null,
  constraint Prealable_cc0 primary key (sigle, prealable),
  constraint Prealable_cr0 foreign key (sigle) references Activite,
  constraint Prealable_cr1 foreign key (prealable) references Activite (sigle)
) ;
comment on table Prealable is $$
* L’inscription de l’activité «sigle» n’est autorisée qu’aux personnes
  qui auront réussi l’activité «prealable» avant le début de l’activité «sigle».
$$ ; -- end of comment

--
-- Gestion de l’offre
--

create domain Trimestre
  Char (5)
  check (value similar to '[0-9]{4}[1-3]') ;
comment on domain Trimestre is $$
* L’année universitaire est divisée en trois trimestres d’une durée approximative
  de quatre mois chacun (chaque trimestre doit comprendre au moins 15 semaines
  pendant lesquelles les activités de formation peuvent être programmées).
  Les trimestres sont encodés en suffixant le chiffre du trimestre à
  une année postérieure à 1927 (année de fondation de l’UdeS).
  Le chiffre associé au trimestre doit être interprété comme suit :
  - hiver -> 1,
  - été -> 2,
  - automne -> 3.
$$ ; -- end of comment

create table Offre
  -- Correspond à l’offre planifiée.
(
  sigle Sigle not null,
  trimestre Trimestre not null,
  constraint Offre_cc0 primary key (sigle, trimestre),
  constraint Offre_cr0 foreign key (sigle) references Activite
) ;
comment on table Offre is $$
* L’Université a offert ou s’engage à offrir l’activité «sigle» au trimestre «trimestre».
$$ ; -- end of comment

create domain NoGroupe
  Char(2)
  check (value similar to '[0-9]{2}') ;
comment on type Sigle is $$
* Identifiant unique relativement distinguant aux activités de même sigle
  offertes au même trimestre.
$$ ; -- end of comment

create table Groupe
(
  sigle Sigle not null,
  trimestre Trimestre not null,
  noGroupe NoGroupe not null,
  constraint Groupe_cc0 primary key (sigle, trimestre, noGroupe),
  constraint Groupe_cr0 foreign key (sigle, trimestre) references Offre
) ;
comment on table Groupe is $$
* Le groupe (identifié par le sigle "sigle", le numéro "noGroupe" et le trimestre
  "trimestre") est constitué.
$$ ; -- end of comment

--
-- Gestion des étudiants
--

create domain MatriculeE
  Char (8)
  check (value similar to '[0-9]{8}') ;
comment on type MatriculeE is $$
* Un matricule a pour vocation d’identifier uniquement un étudiant.
* Il est composé de huit chiffres arabes.
$$ ; -- end of comment

create domain Nom
  VarChar(120)
  check (value similar to '[[:alpha:]]([-’ [:alpha:]])*[[:alpha:]]') ;
comment on type Nom is $$
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
-- Gestion des inscriptions
--

create table Inscription
(
  sigle Sigle not null,
  trimestre Trimestre not null,
  noGroupe NoGroupe not null,
  matriculeE MatriculeE not null,
  constraint Inscription_cc0 primary key (sigle, trimestre, matriculeE),
  constraint Inscription_cr0 foreign key (sigle, trimestre, noGroupe) references Groupe,
  constraint Affectation_cr1 foreign key (matriculeE) references Etudiant
) ;
comment on table Inscription is $$
* L’étudiant (identifiée par "matriculeE") est inscrit au groupe identifié par
  le sigle "sigle" et le numéro "noGroupe" lors du trimestre "trimestre".
$$ ; -- end of comment

--
-- Gestion des évaluations
--

create domain Note
  SmallInt
  check (value between 1 and 100) ;

create table Evaluation
(
  sigle Sigle not null,
  trimestre Trimestre not null,
  matriculeE MatriculeE not null,
  note Note not null,
  --  df sigle, trimestre, noGroupe, matriculeE -> note
  constraint Evaluation_cc0 primary key (sigle, trimestre, matriculeE),
  constraint Evaluation_cr0 foreign key (sigle, trimestre, matriculeE)
    references Inscription
) ;
comment on table Evaluation is $$
* La personne étudiante (identifiée par "matriculeE") inscrite au
  groupe identifié par sigle "sigle", le numéro "noGroupe" et le trimestre "trimestre"
  a obtenu la note "note".
$$ ; -- end of comment

--
-- Gestion des enseignants
--

create domain MatriculeP
  Char(6)
  check (value similar to '[0-9]{6}') ;
comment on type MatriculeP is $$
* Un matriculeP a pour vocation d’identifier uniquement un membre du personnel.
* Il est composé de six chiffres arabes.
$$ ; -- end of comment

create table Enseignant
(
  matriculeP MatriculeP not null,
  nom Nom not null,
  --  df matriculeP -> nom
  constraint Enseignant_cc0 primary key (matriculeP)
) ;
comment on table Enseignant is $$
* L’enseignant est identifié par un matricule et caractérisé par son nom «nom»
   tel que consigné par l’État civil.
* Dès lors que l’étudiant est défini, il est réputé admis et peut s’inscrire
  à des activités, y participer et se présenter aux évaluations de ces activités.
$$ ; -- end of comment

--
-- Gestion de l'affectation
--

create table Affectation
  -- Correspond à l’offre effective.
(
  sigle Sigle,
  trimestre Trimestre not null,
  noGroupe NoGroupe not null,
  matriculeP MatriculeP not null,
  constraint Affectation_cc0 primary key (sigle, trimestre, noGroupe),
  constraint Affectation_cr0 foreign key (sigle, trimestre, noGroupe) references Groupe,
  constraint Affectation_cr1 foreign key (matriculeP) references Enseignant
) ;
comment on table Affectation is $$
* La personne enseignante (identifiée par "matriculeP") assure la formation du
  groupe identifié par le sigle "sigle", le numéro "noGroupe" et le trimestre "trimestre".
$$ ; -- end of comment

/*
============================================================================== Z
Fin, pour plus de détails, voir 000_Universite.adoc.
============================================================================== Z
*/
