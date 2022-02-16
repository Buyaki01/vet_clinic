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