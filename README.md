# Austin_AniML_Rescue
This repository contains a Machine Learning project to analyze public data from the [Austin Animal Center](http://www.austintexas.gov/content/austin-animal-center). The project was completed as part of the Data Analysis and Visualization Boot Camp at Texas McCombs School of Business, linked [here](https://techbootcamps.utexas.edu/data/).

![AAC_graphic](https://github.com/ilaha/Austin_AniML_Rescue/blob/main/Images/AAC_graphic.PNG)


# Outline of the Project and Organization of the Main Branch

## Presentation
Our presentation is available as a Google Slides document [here](https://docs.google.com/presentation/d/120N6hRfooHchPLMDeCw5GEKs5dT-I0a_T48jhp-UGSE/edit?usp=sharing). The Google Slides presentation is read-only and contains our speaker notes.  


## Machine Learning Model
We developed a categorical prediction ML model to answer the question: _To what degree can we predict the outcome of an animal based on various characteristics?_ 

Our overall ML flowchart is shown below.
![Machine_Learning_Flowchart](https://github.com/ilaha/Austin_AniML_Rescue/blob/main/Images/MachineLearning_Pipeline.png)

The following points summarize our process and the main branch folders and files.
- Exploratory data analysis: The file `Austin_AniML_EDA.ipynb` within the `Exploratory_Data_Analysis` folder contains our exploratory analysis. There, we discovered that most of the animals that have come to the shelter are dogs and cats. Most animals are strays, followed by animals that are surrendered by their owners for some reason. The two most common outcomes for the animals is to be adopted or to be transferred to another shelter. We also examined the typical intake condition, including grouping by animal type and sex of the animal at the time of intake. There are 98 breeds of cats and 2,180 breeds of dogs that have come through the shelter.
- Preliminary Data Preprocessing: The data preprocessing of the table that comes from the PostgreSQL database is given in the `merged_csv_cleaning.ipynb` file. After receiving the file from the database, there are several steps in preprocessing.
  - Convert dates from objects to datetime datatype. Calculate the length of stay of the animal by subtrating the `intake_date` from the `outcome_date`. 
  - Calculate the age of the animal, in days, based on the intake_date, outcome_date, and date_of_birth assigned for the animal. 
  - Drop animals with intake date of 0 years who are not nursing or neonatal. We believe this small number of animals to be possible errors in the data.
  - Drop columns we are not using and then drop any rows with NaN in the columns that are left.
  - Use OneHotEncoding to convert the categorical variables into variables that can be understood by our model. Merge the encorded columns with original dataset and drop the columns of non-encoded data.
- Feature Engineering and Feature Selection: The feature engineering and feature selection are described in the file `Machine_Learning.ipynb`. We used the models to find the most important features. For cats, the age of the cat upon intake is the most influential factor. For dogs, intake condition and various breeds are the most influential factors. We used the top 20 and top 50 features for cats (and for dogs) to fit models again in attempt to improve our accuracy.
- Training and Testing Data Sets: The training and testing splits are in the file `Machine_Learning.ipynb`. We use the sci-kit learn `train_test_split` function with a 75% training and 25% testing split. We added 5-fold cross validation to better understand how the model performed on testing data. As described in the previous bullet, we also retrained our model on just the top 20 and top 50 features to attempt to improve our predictions.
- Model Choice and Changes in the Model during Our Work: The model is implemented in the file `Machine_Learning.ipynb`. We first chose a Random Forest Model because it is a good option for predicting a categorical outcome with multiple options for the final result. Random Forest models can handle the many categorical variables that we have. Because the accuracy score was around 0.60, we added cross-validation and used XGBoost to help tune the algorithm to pay more attention to misclassification errors. Based on those results, we changed our model slightly by splitting up cats and dogs and training a separate XGBoost classifier for each animal group. 
- Current Accuracy Score: The accuracy of our cat model was about 0.66, and the accuracy of our dog model was about 0.65. When we retrained on just the top 20 or top 50 features, the accuracy of the cat model improved slightly to 0.68, and the dog model improved to just 0.66. We considered the metric of precision (minimizing the rate of false positives for an outcome) to be important and used this along with accuracy to evaluate our models.  

The following images show the results of our *Final Model*, which was the separate models for cats and dogs, using XGBoost.

![CatFinal](https://github.com/ilaha/Austin_AniML_Rescue/blob/main/Images/CatXGBoost.PNG)

![DogFinal](https://github.com/ilaha/Austin_AniML_Rescue/blob/main/Images/DogXGBoost.PNG)


## Database
Database documents are located in the `SQL_Database` folder, which includes its own `database_prep.md` file to explain the minor cleaning that occurs in Python before loading our data into the Postgres database. 

The database loads the two original csv files from the Austin Animal Center, does some minor cleaning, and then connects to Postgres via the `sqlalchemy` library within Python. Within the `queries.sql` file, the two files are made into tables and relevent fields are joined together to create a new table. Finally, the new table with intake and outcome data is pulled by code in the `merged_csv_cleaning.ipynb` file using a connection string.

The folder also includes a database schema diagram.



## Dashboard
The folder `Tableau_Dashboard` contains a Readme with a link to the current version of our public Tableau data dashboard. 



