/* Database schema to keep the structure of entire database. */

CREATE TABLE animals ( id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, name TEXT NOT NULL, date_of_birth DATE NOT NULL, escape_attempts INT NOT NULL, neutered BOOLEAN NOT NULL,weight_kg DECIMAL NOT NULL);

 ALTER TABLE animals ADD species varchar(255);


CREATE TABLE owners (id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, full_name VARCHAR(255) NOT NULL, age INT NOT NULL); 

CREATE TABLE species (id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, name VARCHAR(255) NOT NULL);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT, ADD  CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INT, ADD  CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners(id);

CREATE TABLE vets (id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, name VARCHAR(255) NOT NULL,age INT NOT NULL, date_of_graduation DATE NOT NULL );

CREATE TABLE specializations (species_id INT REFERENCES species(id) , vet_id INT REFERENCES vets(id), CONSTRAINT species_vet_key PRIMARY KEY (species_id, vet_id));

CREATE TABLE visits (animal_id INT REFERENCES animals(id) , vet_id INT REFERENCES vets(id), CONSTRAINT animal_vet_key PRIMARY KEY (animal_id, vet_id));

ALTER TABLE visits ADD COLUMN date DATE NOT NULL;

ALTER TABLE visits DROP CONSTRAINT animal_vet_key;
ALTER TABLE visits ADD CONSTRAINT animal_vet_date_pkey PRIMARY KEY (animal_id,vet_id,date);