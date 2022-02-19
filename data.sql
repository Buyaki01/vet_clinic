/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES (1, 'agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES (4, 'Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES (5, 'Charmander', '2020-02-08', 0, false, -11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES (6, 'Plantmon', '2022-11-15', 2, true, -5.7);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES (7, 'Squirtle', '1993-04-02', 3, false, -12.13);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES (8, 'Angemon', '2005-06-12', 1, true, -45);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES (9, 'Boarmon', '2005-06-07', 7, true, 20.4);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES (10, 'Blossom', '1998-10-13', 3, true, 17);

BEGIN TRANSACTION; -- start transaction

-- Undo changes
ROLLBACK;

--verify whether the species column went back to how it was before the update, changing species = 'unspecified'
SELECT * FROM animals;

BEGIN;

-- Verify that the species column got updated
SELECT name, species FROM animals;

COMMIT;

-- Verify that change was made and persists after commit.
SELECT name, species FROM animals;

BEGIN;

DELETE FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

DELETE FROM animals WHERE date_of_birth > 'Jan 1, 2022';

SAVEPOINT SPECIES;

ROLLBACK TO SPECIES;

COMMIT TRANSACTION;

-- Inserting data into owners table
INSERT INTO owners(full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners(full_name,age) VALUES ('Jennifer Orwell',19);
INSERT INTO owners(full_name,age) VALUES ('Bob',45);
INSERT INTO owners(full_name,age) VALUES ('Melody Pond',77);
INSERT INTO owners(full_name,age) VALUES ('Dean Winchester',14);
INSERT INTO owners(full_name,age) VALUES ('Jodie Whittaker',38);

-- Inserting daat into Species table
INSERT INTO species(name) VALUES ('pokemon');
INSERT INTO species(name) VALUES ('Digimon');

UPDATE animals SET species_id=(SELECT id FROM species WHERE name='Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id=(SELECT id FROM species WHERE name='pokemon') WHERE species_id IS NULL;

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name ='Sam Smith') WHERE name='agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name ='Jennifer Orwell') WHERE name IN('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name ='Melody Pond') WHERE name IN('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name ='Dean Winchester') WHERE name IN('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation)  
VALUES ('William Tatcher', 45, '2000-04-23');

INSERT INTO vets (name, age, date_of_graduation)  
VALUES ('Maisy Smith', 26, '2019-01-17');

INSERT INTO vets (name, age, date_of_graduation)  
VALUES ('Stephanie Mendez', 64, '1981-05-04');

INSERT INTO vets (name, age, date_of_graduation)  
VALUES ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (species_id, vets_id)  
VALUES ((SELECT id FROM species WHERE name='pokemon'), (SELECT id FROM vets WHERE name='William Tatcher'));

INSERT INTO specializations (species_id, vets_id)  
VALUES ((SELECT id FROM species WHERE name='pokemon'), (SELECT id FROM vets WHERE name='Stephanie Mendez'));

INSERT INTO specializations (species_id, vets_id)  
VALUES ((SELECT id FROM species WHERE name='Digimon'), (SELECT id FROM vets WHERE name='Stephanie Mendez'));

INSERT INTO specializations (species_id, vets_id)  
VALUES ((SELECT id FROM species WHERE name='Digimon'), (SELECT id FROM vets WHERE name='Jack Harkness'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-05-24', (SELECT id FROM animals WHERE name='agumon'), (SELECT id FROM vets WHERE name='William Tatcher'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-07-22', (SELECT id FROM animals WHERE name='agumon'), (SELECT id FROM vets WHERE name='Stephanie Mendez'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-01-05', (SELECT id FROM animals WHERE name='Pikachu'), (SELECT id FROM vets WHERE name='Maisy Smith'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-03-08', (SELECT id FROM animals WHERE name='Pikachu'), (SELECT id FROM vets WHERE name='Maisy Smith'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-05-14', (SELECT id FROM animals WHERE name='Pikachu'), (SELECT id FROM vets WHERE name='Maisy Smith'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2021-05-04', (SELECT id FROM animals WHERE name='Devimon'), (SELECT id FROM vets WHERE name='Stephanie Mendez'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2021-02-24', (SELECT id FROM animals WHERE name='Charmander'), (SELECT id FROM vets WHERE name='Jack Harkness'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2019-12-21', (SELECT id FROM animals WHERE name='Plantmon'), (SELECT id FROM vets WHERE name='Maisy Smith'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-08-10', (SELECT id FROM animals WHERE name='Plantmon'), (SELECT id FROM vets WHERE name='William Tatcher'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2021-04-07', (SELECT id FROM animals WHERE name='Plantmon'), (SELECT id FROM vets WHERE name='Maisy Smith'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2019-09-29', (SELECT id FROM animals WHERE name='Squirtle'), (SELECT id FROM vets WHERE name='Stephanie Mendez'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-10-03', (SELECT id FROM animals WHERE name='Angemon'), (SELECT id FROM vets WHERE name='Jack Harkness'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-11-04', (SELECT id FROM animals WHERE name='Angemon'), (SELECT id FROM vets WHERE name='Jack Harkness'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2019-01-24', (SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2019-05-15', (SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-02-27', (SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-08-03', (SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2020-05-24', (SELECT id FROM animals WHERE name='Blossom'), (SELECT id FROM vets WHERE name='Stephanie Mendez'));

INSERT INTO visits (date_of_visit, animals_id, vets_id)
VALUES ('2021-01-11', (SELECT id FROM animals WHERE name='Blossom'), (SELECT id FROM vets WHERE name='William Tatcher'));