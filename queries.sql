SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered='t' AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals where neutered='t';
SELECT * FROM animals WHERE name!='Gabumon';
SELECT * FROM animals WHERE weight_kg>=10.4 AND weight_kg<=17.3;

BEGIN TRANSACTION;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species IS NULL;
COMMIT TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT point1;
UPDATE animals SET weight_kg=weight_kg*-1;
ROLLBACK TO SAVEPOINT point1;
UPDATE animals SET weight_kg=weight_kg*-1 WHERE weight_kg < 0;
COMMIT TRANSACTION;

SELECT COUNT(name) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT SUM(escape_attempts), neutered FROM animals GROUP BY neutered;
SELECT MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY neutered;
SELECT AVG(escape_attempts) FROM animals WHERE (SELECT EXTRACT ('Year' FROM date_of_birth)) BETWEEN 1990 AND 2000 GROUP BY neutered;

SELECT name
FROM animals A
JOIN owners O
ON A.owner_id=O.id
WHERE O.full_name='Melody Pond';

SELECT A.name
FROM animals A
JOIN species S
ON A.species_id=S.id
WHERE S.name='Pokemon';

SELECT full_name AS Owner_name, name as Animal_name
FROM owners
LEFT OUTER JOIN animals
ON owners.id = animals.owner_id;

SELECT COUNT(e.species_id), s.name as specie
FROM animals e
JOIN species s
ON e.species_id = s.id
GROUP BY s.name;

SELECT A.name
FROM animals A
JOIN species S
ON A.species_id = S.id
JOIN owners O
ON A.owner_id = O.id
WHERE S.name='Digimon' AND O.full_name='Jennifer Orwell';

SELECT name
FROM animals A
JOIN owners O
ON A.owner_id = O.id
WHERE A.escape_attempts=0 AND O.full_name='Dean Wincheste';

SELECT owners.full_name, top_owner.animals_owned
FROM (select count(*) as animals_owned, owner_id 
FROM animals
GROUP BY owner_id
ORDER BY animals_owned DESC LIMIT 1) as top_owner
JOIN owners ON owners.id = top_owner.owner_id;

SELECT A.name AS animal
FROM animals A
JOIN visits V
ON A.id = V.animal_id
JOIN vets W
ON W.id = V.vet_id
WHERE W.name = 'William Tatcher'
ORDER BY V.visit_date DESC LIMIT 1;

SELECT COUNT(*) FROM (
SELECT COUNT(A.name)
FROM animals A
JOIN visits V
on A.id = V.animal_id
JOIN vets W
ON W.id = V.vet_id
WHERE W.name = 'Stephanie Mendez'
GROUP BY A.name
) AS foo;

SELECT V.name as Vet, C.name as Speciality
FROM vets V
LEFT OUTER JOIN specializations S
On V.id = S.Vet_id
LEFT OUTER JOIN species C
ON S.specie_id = C.id;

SELECT A.name
FROM animals A
JOIN visits V
ON A.id = V.animal_id
JOIN vets W
ON V.vet_id = W.id
WHERE W.name='Stephanie Mendez'
AND visit_date > '2020-04-01'
AND visit_date < '2020-08-30';

SELECT animal_name
FROM (
SELECT COUNT(*) as visits, A.name as animal_name
FROM animals A
JOIN visits V
ON A.id = V.animal_id
GROUP BY A.id
ORDER BY visits DESC limit 1) AS animal_visits
JOIN animals ON animals.name = animal_visits.animal_name;

SELECT A.name FROM animals A
JOIN (
SELECT animal_id
FROM visits V
JOIN vets W
ON V.vet_id = W.id
WHERE W.name='Maisy Smith'
ORDER BY V.visit_date ASC limit 1) AS first_visit
ON A.id = first_visit.animal_id;

SELECT A.name AS animal_Name, W.name as vet_name, V.visit_date
FROM visits V
JOIN vets W
ON V.vet_id = W.id
JOIN animals A
ON V.animal_id = A.id
ORDER BY V.visit_date DESC limit 1;

SELECT count (*)
FROM (SELECT vets.name, species.name, vets.id
FROM vets
LEFT JOIN
specializations
ON
vets.id = specializations.vet_id
LEFT JOIN
species
ON
species.id = specializations.specie_id
WHERE species.name IS NULL) AS no_specializations
JOIN
visits ON
visits.vet_id = no_specializations.id;

SELECT S.name AS Max_Specie FROM (
SELECT A.species_id, COUNT(A.species_id) AS count_specie FROM animals A
JOIN (
SELECT V.animal_id
FROM visits V
JOIN vets W
ON V.vet_id  = W.id
WHERE W.name = 'Maisy Smith') AS vet_visits
ON A.id = vet_visits.animal_id
GROUP BY A.species_id
ORDER BY count_specie DESC limit 1
) AS max_vet
JOIN species S
ON max_vet.species_id = S.id;