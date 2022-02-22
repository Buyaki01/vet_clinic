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

-- What animals belong to Melody Pond?
SELECT * FROM animals JOIN owners ON animals.owner_id=owners.id WHERE owners.full_name='Melody Pond';

SELECT * FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name='pokemon';

SELECT * FROM owners o FULL OUTER JOIN animals a ON o.id = a.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM species LEFT JOIN animals ON species.id = animals.species_id GROUP BY species.name;

SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name ='Jennifer Orwell' AND a.species_id =(SELECT id from species WHERE name ='Digimon');

SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name ='Dean Winchester' AND a.escape_attempts <= 0;

SELECT o.full_name, COUNT(*) FROM owners o LEFT JOIN animals a ON o.id =  a.owner_id GROUP BY o.full_name ORDER BY COUNT DESC LIMIT 1;

SELECT v.name AS vet_name, a.name AS animal_name, vs.date_of_visit
  FROM visits vs INNER JOIN animals a ON a.id = vs.animals_id
  INNER JOIN vets v ON v.id = vs.vets_id
  WHERE v.name = 'William Tatcher'
  ORDER BY vs.date_of_visit DESC
  LIMIT 1;

SELECT vets.name, COUNT(date_of_visit) FROM vets LEFT JOIN visits ON vets.id = visits.vets_id WHERE vets.name='Stephanie Mendez' GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet, species.name AS specialty FROM specializations 
LEFT JOIN vets ON vets.id = specializations.vets_id
JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020
SELECT animals.name, vets.name, visits.date_of_visit FROM visits JOIN vets ON visits.vets_id = vets.id JOIN animals ON visits.animals_id = animals.id WHERE vets.name = 'Stephanie Mendez' AND date_of_visit >= '2020-04-01' AND date_of_visit <= '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*) FROM visits INNER JOIN animals ON animals.id = visits.animals_id GROUP BY animals.name ORDER BY COUNT DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name, visits.date_of_visit FROM visits JOIN vets ON visits.vets_id = vets.id WHERE vets.name='Maisy Smith' ORDER BY visits.date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, vets.*, visits.date_of_visit FROM visits LEFT JOIN animals ON animals.id = visits.animals_id LEFT JOIN vets ON vets.id = visits.vets_id ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT 
v.name AS vet_name,
COUNT(*)
FROM visits vs LEFT JOIN vets v ON v.id = vs.vets_id
LEFT JOIN specializations sp 
  ON sp.vets_id = vs.vets_id
WHERE sp.id IS NULL
GROUP BY v.name;

SELECT 
  v.name AS vet_name,
  s.name AS species_name,
  COUNT(s.name)
  FROM visits vs LEFT JOIN animals a ON a.id = vs.animals_id
  LEFT JOIN vets v 
    ON v.id = vs.vets_id
  LEFT JOIN species s
    ON s.id = a.species_id
  WHERE v.name = 'Maisy Smith'
  GROUP BY v.name, s.name
  ORDER BY COUNT DESC
  LIMIT 1;