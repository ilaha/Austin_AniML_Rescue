# **Welcome to the Austin AniML Rescue SQL Database Section!**
- The database for this project has been maintained by Melinda Malone using PostgreSQL, pgAdmin, Python, Pandas, SQL Alchemy, and Quick DBD

## Where is the data from?

- Austin Animal Center Intakes dataset exported as csv file from [Austin Animal Center Intakes](https://dev.socrata.com/foundry/data.austintexas.gov/wter-evkm)
- Austin Animal Center Outcomes dataset exported as csv file from [Austin Animal Center Outcomes](https://dev.socrata.com/foundry/data.austintexas.gov/9t4d-g238)
- Export of intakes and outcomes csv files occurred on 31-AUG-2021

## Initial Data Observations
- Original intakes file contained 130,617 rows of data; 106,233 rows remained after duplicate Animal ID's dropped from dataset
- Original outcomes file contained 130,647 rows of data; 106,266 rows remained after duplicate Animal ID's dropped from dataset
- Duplicate Animal ID's existed in original datasets due to animal recurringly leaving owner then being picked up by owner on more than one occasion
- The DateTime and MonthYear columns in intakes file contain exact same date and time data
- The DateTime and MonthYear columns in outcomes file contain exact same date and time data

## Austin AniML Rescue Quick Database Diagram
- The database diagram for this project was created using [Quick DBD](https://www.quickdatabasediagrams.com/)

![](Images/QuickDBD_Austin_AniML_Rescue.png)

## Actions taken for database prep using Python, Pandas, and SQL Alchemy
- Renamed columns to be specific to intakes or outcomes data
- Renamed columns to follow Python naming conventions by adding underscores in place of spaces
- Dropped duplicated Animal ID's as the Machine Learning model did not require these animals
- Imported cleaned intakes and outcomes DataFrames into PostgreSQL database

```
# Import cleaned intakes and outcomes DataFrames into PostgreSQL database

db_string = f"postgresql://postgres:{db_password}@127.0.0.1:5432/Austin_AniML_Rescue"

engine = create_engine(db_string)

cleaned_intakes_df.to_sql(name='intakes', con=engine, if_exists='replace')
cleaned_outcomes_df.to_sql(name='outcomes', con=engine, if_exists='replace')
```

## Actions taken in PostgreSQL Database using CREATE TABLE, INNER JOIN, and aliases
- intakes and outcomes tables were created from csv datasets
- The secondary column of date and time data dropped from dataset
- Duplicates of animal_name, animal_type, breed, and color dropped from final dataset as these columns are repeated in both intakes and outcomes files
- animal_name and found_location dropped from final dataset as these columns are incomplete and unnecessary for Machine Learning model
- 105,367 rows of data were successfully joined in SQL database using INNER JOIN to create intakes_outcomes table

```
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
```
```
--Inner join on intakes and outcomes by animal_id using alias
--Drop intake_date_2, outcome_date_2, animal_name, and found_location
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
```

## Python code used to import intakes_outcomes table from PostgreSQL Database to Machine Learning Model

```
# Import intakes_outcomes table from PostgreSQL database to machine learning model

import pandas as pd
from sqlalchemy import create_engine
from config import db_password

db_string = f"postgresql://postgres:{db_password}@127.0.0.1:5432/Austin_AniML_Rescue"

engine = create_engine(db_string)

query = "SELECT * FROM intakes_outcomes"

raw_df = pd.read_sql(query, con=engine, columns=["animal_id", "animal_type", "breed", 
						"color", "intake_type", "date_of_birth", 
						"intake_date", "intake_condition", "sex_upon_intake", 
						"age_upon_intake", "outcome_date", "outcome_type", 
						"outcome_subtype", "sex_upon_outcome", 
						"age_upon_outcome"])
```