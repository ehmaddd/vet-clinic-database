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
