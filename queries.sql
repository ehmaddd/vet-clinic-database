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