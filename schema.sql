/* Database schema to keep the structure of entire database. */

CREATE TABLE animals ( id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, name TEXT NOT NULL, date_of_birth DATE NOT NULL, escape_attempts INT NOT NULL, neutered BOOLEAN NOT NULL,weight_kg DECIMAL NOT NULL );

