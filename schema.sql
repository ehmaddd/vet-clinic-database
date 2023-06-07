CREATE DATABASE vet_clinic ;
\c vet_clinic

CREATE TABLE animals (
id INTEGER GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
date_of_birth DATE,
escape_attempts INTEGER,
neutered BOOLEAN,
weight_kg DECIMAL
);

ALTER TABLE animals
ADD COLUMN species VARCHAR;

CREATE TABLE owners (
id INTEGER GENERATED ALWAYS AS IDENTITY,
full_name VARCHAR,
age INTEGER,
PRIMARY KEY (id)
);

CREATE TABLE species (
id INTEGER GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
PRIMARY KEY (id)
);

ALTER TABLE animals
ADD PRIMARY KEY (id);

ALTER TABLE animals DROP species;

ALTER TABLE animals
ADD COLUMN species_id INT
CONSTRAINT fk_species_id REFERENCES species (id);

ALTER TABLE animals
ADD COLUMN owner_id INT
CONSTRAINT fk_owner_id REFERENCES owners (id);
