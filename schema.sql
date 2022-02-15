/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
   id INT PRIMARY KEY,
   name TEXT,
   date_of_birth date,
   escape_attempts INT,
   neutered boolean,
   weight_kg decimal
);