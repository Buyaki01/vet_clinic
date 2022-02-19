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

SELECT v.name AS vet_name, a.name AS animal_name, vs.date_of_visit
  FROM visits vs INNER JOIN animals a ON a.id = vs.animals_id
  INNER JOIN vets v ON v.id = vs.vets_id
  WHERE v.name = 'William Tatcher'
  ORDER BY vs.date_of_visit DESC
  LIMIT 1;

SELECT v.name as vet_name, COUNT(date_of_visit) 
  FROM visits vs LEFT JOIN vets v ON vs.vets_id = v.id
  WHERE name = 'Stephanie Mendez'
  GROUP BY v.name;

SELECT 
  sp.id AS specialty_id, 
  sp.species_id, 
  sp.vets_id, 
  v.name AS vet_name, 
  s.name AS species_name  
  FROM specializations sp FULL OUTER JOIN species s ON s.id = sp.species_id
  FULL OUTER JOIN vets v 
    ON v.id = sp.vets_id;

SELECT 
  a.name, 
  v.name AS vet_name, 
  vs.date_of_visit
  FROM visits vs LEFT JOIN animals a ON a.id = vs.animals_id
  LEFT JOIN vets v 
    ON v.id = vs.vets_id
  WHERE 
    v.name = 'Stephanie Mendez' AND 
    vs.date_of_visit 
    BETWEEN 'Apr 1, 2020' AND 'Aug 30, 2020';

SELECT a.name, COUNT(*) 
  FROM visits vs INNER JOIN animals a ON a.id = vs.animals_id
  GROUP BY a.name
  ORDER BY COUNT DESC
  LIMIT 1;

SELECT 
  a.name AS animal_name, 
  v.name AS vet_name,
  vs.date_of_visit
  FROM visits vs LEFT JOIN animals a ON a.id = vs.animals_id
  LEFT JOIN vets v ON v.id = vs.vets_id
  WHERE v.name = 'Maisy Smith'
  ORDER BY vs.date_of_visit ASC
  LIMIT 1;

SELECT animals.*, vets.*, vistis.visit_date
FROM visits
LEFT JOIN animals ON animals.id = visits.animals_id
LEFT JOIN vets ON vets.id = visits.vets_id
ORDER BY visits.visit_date DESC
LIMIT 1;

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