-- Create table for Austin_AniML_Rescue Intakes
CREATE TABLE intakes (
	animal_id VARCHAR NOT NULL,
	animal_name VARCHAR,
	intake_date DATE NOT NULL,
	intake_date_2 DATE NOT NULL,
	found_location VARCHAR NOT NULL,
	intake_type VARCHAR NOT NULL,
	intake_condition VARCHAR NOT NULL,
	animal_type VARCHAR NOT NULL,
	sex_upon_intake VARCHAR,
	age_upon_intake VARCHAR NOT NULL,
	breed VARCHAR NOT NULL,
	color VARCHAR NOT NULL,
	PRIMARY KEY (animal_id),
	UNIQUE (animal_id)
);

-- Create table for Austin_AniML_Rescue Outcomes
CREATE TABLE outcomes (
	animal_id VARCHAR NOT NULL,
	animal_name VARCHAR,
	outcome_date DATE NOT NULL,
	outcome_date_2 DATE NOT NULL,
	date_of_birth DATE NOT NULL,
	outcome_type VARCHAR,
	outcome_subtype VARCHAR,
	animal_type VARCHAR NOT NULL,
	sex_upon_outcome VARCHAR,
	age_upon_outcome VARCHAR,
	breed VARCHAR NOT NULL,
	color VARCHAR NOT NULL,
	PRIMARY KEY (animal_id)
);