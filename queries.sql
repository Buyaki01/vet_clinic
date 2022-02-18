/*Queries that provide answers to the questions from all projects.*/

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

/* Sum escape attempts and compare between neutered and non-neutered */
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

/* Minimum and maximum weights of each type of animal*/
SELECT neutered, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY neutered;

/* Average number of escape attempts per animal type of those born between 1990 and 2000 */
SELECT neutered, AVG(escape_attempts) FROM animals WHERE date_of_birth 
BETWEEN 'Jan 1, 1990' AND 'Dec 31, 2000' GROUP BY neutered;

UPDATE animals SET species = 'unspecified';

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

UPDATE animals SET weight_kg = weight_kg * -1;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0; 

SELECT * FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name='Melody Pond';

SELECT * FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name='pokemon';

SELECT * FROM owners o FULL OUTER JOIN animals a ON o.id = a.owner_id;

SELECT s.name, COUNT(*) FROM species s LEFT JOIN animals a ON s.id =  a.species_id GROUP BY s.name;

SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name ='Jennifer Orwell' AND a.species_id =(SELECT id from species WHERE name ='Digimon');

SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name ='Dean Winchester' AND a.escape_attempts <= 0;

SELECT o.full_name, COUNT(*) FROM owners o LEFT JOIN animals a ON o.id =  a.owner_id GROUP BY o.full_name ORDER BY COUNT DESC LIMIT 1;
