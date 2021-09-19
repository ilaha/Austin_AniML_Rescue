--Query the intakes and outcomes tables
SELECT * FROM intakes;
SELECT * FROM outcomes;
SELECT * FROM intakes_outcomes;

--Drop tables command (USE ONLY WHEN NEEDED!)
DROP TABLE intakes;
DROP TABLE outcomes;
DROP TABLE intakes_outcomes;

--Inner join on intakes and outcomes by animal_id using alias
--Drop intake_date_2, outcome_date_2, animal_name, and found_location as these are unnecessary for Machine Learning model
SELECT i.animal_id,
	i.animal_type,
	i.breed,
	i.color,
	i.intake_type,
	o.date_of_birth,
	i.intake_date,
	i.intake_condition,
	i.sex_upon_intake,
	i.age_upon_intake,
	o.outcome_date,
	o.outcome_type,
	o.outcome_subtype,
	o.sex_upon_outcome,
	o.age_upon_outcome
INTO intakes_outcomes
FROM intakes AS i
INNER JOIN outcomes AS o
ON i.animal_id = o.animal_id;