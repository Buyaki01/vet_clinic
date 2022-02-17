/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
   id INT PRIMARY KEY,
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

-- set id in the animals table as an autoincremented PRIMARY KEY
ALTER TABLE animals
ALTER COLUMN id SET SERIAL;
-- Check it out, how to change id to auto-increament

ALTER TABLE animals 
DROP COLUMN species;