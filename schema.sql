/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
   id SERIAL PRIMARY KEY NOT NULL,
   name TEXT,
   date_of_birth date,
   escape_attempts INT,
   neutered boolean,
   weight_kg decimal
);

ALTER TABLE animals 
ADD COLUMN species VARCHAR;

CREATE TABLE owners(
   id SERIAL PRIMARY KEY NOT NULL,
   full_name VARCHAR,
   age INT
);

CREATE TABLE species(
   id SERIAL PRIMARY KEY NOT NULL,
   name VARCHAR
);

ALTER TABLE animals 
DROP COLUMN species;

--Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
  ADD species_id INT,
  ADD CONSTRAINT fk_species
  FOREIGN KEY (species_id)
  REFERENCES species(id);

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
  ADD owner_id INT,
  ADD CONSTRAINT fk_owner_id
  FOREIGN KEY (owner_id)
  REFERENCES owners(id);

CREATE TABLE vets(
   id SERIAL PRIMARY KEY NOT NULL,
   name VARCHAR,
   age INT,
   date_of_graduation date
);

CREATE TABLE specializations (
   id SERIAL PRIMARY KEY NOT NULL,
	species_id INT NOT NULL,
	vets_id INT NOT NULL,
	FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE,
	FOREIGN KEY (vets_id) REFERENCES vets(id) ON DELETE CASCADE
);

CREATE TABLE visits (
   id SERIAL PRIMARY KEY NOT NULL,
   date_of_visit date,
	animals_id INT NOT NULL,
	vets_id INT NOT NULL,
	FOREIGN KEY (animals_id) REFERENCES animals(id) ON DELETE CASCADE,
	FOREIGN KEY (vets_id) REFERENCES vets(id) ON DELETE CASCADE
);