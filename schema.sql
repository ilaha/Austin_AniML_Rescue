-- Creating table for Austin_AniML_Rescue
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
	--FOREIGN KEY (animal_name) REFERENCES outcomes (animal_name),
	--FOREIGN KEY (animal_type) REFERENCES outcomes (animal_type),
	--FOREIGN KEY (breed) REFERENCES outcomes (breed),
	--FOREIGN KEY (color) REFERENCES outcomes (color)
);

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

SELECT * FROM outcomes;
SELECT * FROM intakes;

DROP TABLE intakes;
DROP TABLE outcomes;

--Joining intakes and outcomes by animal_id
SELECT intakes.animal_id,
	intakes.animal_name,
	intakes.animal_type,
	intakes.breed,
	intakes.color,
	intakes.intake_type,
	outcomes.date_of_birth,
	intakes.intake_date,
	intakes.found_location,
	intakes.intake_condition,
	intakes.sex_upon_intake,
	intakes.age_upon_intake,
	outcomes.outcome_date,
	outcomes.outcome_type,
	outcomes.outcome_subtype,
	outcomes.sex_upon_outcome,
	outcomes.age_upon_outcome
INTO intakes_outcomes
FROM intakes
INNER JOIN outcomes
ON intakes.animal_id = outcomes.animal_id;