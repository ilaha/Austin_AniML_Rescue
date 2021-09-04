# **Austin AniML Rescue SQL database maintained by Melinda Malone using PostgreSQL and pgAdmin**

- Austin Animal Center Intakes dataset exported as csv file from: https://dev.socrata.com/foundry/data.austintexas.gov/wter-evkm

- Austin Animal Center Outcomes dataset exported as csv file from: https://dev.socrata.com/foundry/data.austintexas.gov/9t4d-g238

## Initial export of intakes and outcomes csv files occurred on 31-AUG-2021

###### - Data Observations
    - Original intakes file contained 130,617 rows of data; 106,233 rows remained after duplicate Animal ID's dropped from dataset
    - Original outcomes file contained 130,647 rows of data; 106,266 rows remained after duplicate Animal ID's dropped from dataset
    - Duplicate Animal ID's existed in original datasets due to animal recurringly leaving owner then being picked up by owner on more than one occasion
    - The DateTime and MonthYear columns in intakes file contain exact same date and time data
    - The DateTime and MonthYear columns in outcomes file contain exact same date and time data

###### - Actions taken for database prep
    - Renamed columns to be specific to intakes or outcomes data
    - Renamed columns to follow Python naming conventions by adding underscores in place of spaces
    - The secondary column of date and time data dropped from dataset
    - Duplicates of animal_name, animal_type, breed, and color dropped from final dataset as these columns are repeated in both intakes and outcomes files
    - animal_name and found_location dropped from final dataset as these columns are incomplete and unnecessary for Machine Learning model
    - 105,367 rows of data were successfully joined in SQL database using INNER JOIN to create intakes_outcomes table