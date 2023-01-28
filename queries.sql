/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth < '2020-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name='Pikachu';
SELECT name,escape_attempts  FROM animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name NOT  IN ('Gabumon');
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;





BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;


BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT after_2022_delete;
UPDATE animals SET weight_kg = weight_kg * -1 ;
SELECT * FROM animals;
ROLLBACK TO SAVEPOINT after_2022_delete;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg <= 0;
SELECT * FROM animals;
COMMIT;


SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT  species,MIN(weight_kg),MAX(weight_kg) FROM animals GROUP BY species;

SELECT  species,AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '2000-01-01' GROUP BY species;



Select (name) from animals A JOIN owners O ON A.owner_id = O.id WHERE full_name = 'Melody Pond';

Select (A.name) from animals A JOIN species S ON A.species_id = S.id WHERE S.name = 'Pokemon';

Select (A.name,O.full_name) from animals A RIGHT JOIN owners O  ON A.owner_id = O.id;

SELECT COUNT(*), S.name FROM animals A JOIN species S on A.species_id = S.id  GROUP BY S.name;

SELECT A.name, O.full_name, S.name FROM animals A JOIN owners O ON A.owner_id = O.id JOIN species S ON A.species_id = S.id where O.full_name = 'Jennifer Orwell' AND S.name='Digimon';

SELECT A.name FROM animals A JOIN owners O ON A.owner_id = O.id WHERE O.full_name = 'Dean Winchester' AND A.escape_attempts= 0;

SELECT * FROM (SELECT COUNT(*)  animal_count, O.full_name as full_name  FROM animals A JOIN owners O ON A.owner_id = O.id  GROUP BY O.full_name) counter ORDER BY animal_count DESC LIMIT 1;
