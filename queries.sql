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



SELECT name FROM animals WHERE id = (SELECT animal_id FROM visits where vet_id = (SELECT id FROM vets WHERE name ='William Tatcher') ORDER BY date DESC LIMIT 1);

SELECT (name,id) from animals where id = (SELECT animal_id FROM ( SELECT COUNT(*),animal_id FROM visits GROUP BY animal_id ORDER BY count DESC limit 1) as foo);

SELECT name FROM animals WHERE id = (SELECT vi.animal_id FROM visits vi JOIN vets v ON vi.vet_id = v.id WHERE v.name='Maisy Smith' ORDER BY vi.date ASC LIMIT 1);


SELECT COUNT(DISTINCT A.name) FROM animals A JOIN visits V ON A.id = V.animal_id JOIN Vets vet ON V.vet_id = vet.id WHERE vet.name = 'Stephanie Mendez'; 

SELECT s.name, v.name FROM species s JOIN specializations sp ON s.id = sp.species_id FULL JOIN vets v ON v.id = sp.vet_id;

SELECT a.name FROM animals a JOIN visits vi ON a.id = vi.animal_id JOIN vets v ON vi.vet_id = v.id WHERE v.name ='Stephanie Mendez' AND vi.date >= '2020-04-04'AND vi.date <= '2020-08-30';



SELECT * FROM visits vi LEFT JOIN animals a ON a.id = vi.animal_id LEFT JOIN vets v on v.id = vi.vet_id ORDER BY date DESC LIMIT 1; 

SELECT COUNT(t.treated) FROM( SELECT vi.vet_id , sp.species_id, a.species_id as treated from visits vi LEFT  JOIN specializations sp ON sp.vet_id = vi.vet_id JOIN animals a ON a.id = vi.animal_id WHERE sp.species_id IS NULL ) AS t

Select name from species where id = (Select sp.species_id from (SELECT a.species_id, COUNT(a.species_id) as count FROM animals a JOIN visits vi ON a.id=vi.animal_id JOIN vets ve ON vi.vet_id = ve.id WHERE ve.name = 'Maisy Smith' GROUP BY a.species_id ORDER BY count DESC LIMIT 1) as sp);
