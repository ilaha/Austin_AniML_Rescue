# Austin_AniML_Rescue
This repository contains a Machine Learning project to analyze Austin Animal Center's data

![AAC_graphic](https://github.com/ilaha/Austin_AniML_Rescue/blob/main/Images/AAC_graphic.PNG)


# Outline of the Project and Organization of the Main Branch

## Presentation
Our presentation is available as a [pdf file](https://github.com/ilaha/Austin_AniML_Rescue/blob/main/Austin%20Animal%20rescue.pdf) and as Google Slides document [here](https://docs.google.com/presentation/d/120N6hRfooHchPLMDeCw5GEKs5dT-I0a_T48jhp-UGSE/edit?usp=sharing). The Google Slides presentation is read-only via the second link and may be a more updated copy than the pdf.


## Machine Learning Model
We are still working on the machine learning model for our first question: To what degree can we predict the outcome of an animal based on various characteristics? Our overall ML flowchart is shown below.
![Machine_Learning_Flowchart](https://github.com/ilaha/Austin_AniML_Rescue/blob/main/Images/Machine_Learning_Flowchart.png)

The following points summarize our current Machine Learning Model status.
- Exploratory data analysis: The file `Austin_AniML_EDA.ipynb` within the `Exploratory_Data_Analysis` folder contains our analysis to this point. There, we discovered that most of the animals that have come to the shelter are dogs and cats. Most animals are stray (found unclaimed) followed by animals that are surrendered by their owners for some reason. The two most common outcomes for the animals is to be adopted or to be transferred to another shelter. We also examined the typical intake condition, including splitting that out by animal type and sex of the animal at the time of intake. We also found that there are 98 breeds of cats and 2180 breeds of dogs that have come through the shelter.
- Preliminary data preprocessing: The data preprocessing of the table that comes from the Postgres database is given in the `merged_csv_cleaning.ipynb` file. After receiving the file from the database, there are several steps in preprocessing.
  - Convert dates from objects to datetime datatype. Calculate the length of stay of the animal by subtrating the `intake_date` from the `outcome_date`. 
  - Calculate the age of the animal, in days, base on the intake_date, outcome_date, and date_of_birth assigned for the animal. 
  - Drop animals with intake date of 0 years who are not nursing or neonatal. We believe this small number of animals to be possible errors in the data.
  - Drop columns we are not using and then drop any rows with NaN in the columns that are left.
  - Use OneHotEncoding to convert the categorical variables into variables that can be understood by our model. Merge the encorded columns with original dataset and drop the columns of non-encoded data.
- Preliminary feature engineering and feature selection: The preliminary feature engineering and selection is described in the file `Machine_Learning.ipynb`. We have some preliminary results on the accuracy of our model (not great right now) and it appears that the age of the animal upon intake is currently the most influential factor.
- Creation of training and testing data sets: The training and testing splits are in the file `Machine_Learning.ipynb`. We use sci-kit learn train_test_split function with a 75% training and 25% testing split.
- Model choice: The model is implemented in the file `Machine_Learning.ipynb`. We chose a Random Forest Model because it is a good option for predicting a categorical outcome with multiple options for the final result. Random Forest models can handle the many categorical variables that we have. We have currently tried 4 different versions of our model and don't have a good accuracy yet. Our fourth attempt uses an AdaBoostClassifier instead of Random Forest. These models have the advantage of being relatively robust when it comes to training data, once we figure out how to best clean and organize the model. One limitation of our model seems to be that it has trouble dealing with all the animal types and the many different columns we have (nearly 3000). As we continue to evaluate, we will refine the model. 


## Database
Database documents are located in the `SQL_Database` folder, which includes its own `database_prep.md` file to explain the minor cleaning that occurs in Python before loading our data into the Postgres database. 

The database loads the two original csv files from the Austin Animal Center, does some minor cleaning, and then connects to Postgres via the `sqlalchemy` library within Python. Within the `queries.sql` file, the two files are made into tables and relevent fields are joined together to create a new table. Finally, the new table with intake and outcome data is pulled by code in the `merged_csv_cleaning.ipynb` file using a connection string.

The folder also includes a database schema diagram.



## Dashboard
The folder `Tableau_Dashboard` contains the links to the storyboard on Google Slides as well as the description of the tools we will use to create the final dashboard and the interactive elements. There is also a link to a preliminary version of the dashboard.



