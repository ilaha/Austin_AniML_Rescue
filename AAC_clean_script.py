
# -------------------------------------------------------
# Import dependencies
import pandas as pd
import numpy as np

from datetime import datetime
from path import Path
import hvplot.pandas
import plotly.express as px

from sklearn import preprocessing
from sklearn.preprocessing import OneHotEncoder


# Read in Merged DataFrame
filepath = 'Resources/intakes_outcomes.csv'
df = pd.read_csv(filepath)

# Make animal id an index
df = df.set_index("animal_id")

# Convert date_of_birth, intake_date, and outcome_date to datetime

dates_to_convert = ["date_of_birth", "intake_date", "outcome_date"]


def convert_functions(df_datetime):
    for i in dates_to_convert:
        df_datetime[i] = pd.to_datetime(df_datetime[i])

    return df_datetime


print(convert_functions(df))


# Create columns "length_of_stay" to store duration animal stays in the shelter and intake and outcome ages in days


def get_difference(df):

    df['length_of_stay'] = (df['outcome_date'] - df['intake_date']).dt.days
    df['age_upon_intake_in_days'] = (
        df['intake_date'] - df['date_of_birth']).dt.days
    df['age_upon_outcome_in_days'] = (
        df['outcome_date'] - df['date_of_birth']).dt.days

    return df


print(get_difference(df))


# Drop all animals with intake age of "0 years" who are not nursing or neonatal
df = df.drop(df[(df['date_of_birth'] >= df['intake_date'])
                & (df['intake_condition'] != 'Nursing')
                & (df['intake_condition'] != 'Neonatal')].index)


# # Drop columns

# Drop unnecessary columns

def drop_columns(df, *cols):
    if not cols:
        return "Column doesn't exist"
    return df.drop(columns=list(cols), inplace=True)


drop_columns(df, 'intake_date', 'date_of_birth', 'outcome_date',
             'age_upon_outcome', 'age_upon_intake', 'outcome_subtype')

print(df)


# Drop Any Rows with NaN

# Count number of null values in each column
df.isna().sum()


# Drop NaN rows
df.dropna(inplace=True)


# ### Dashboard Data

# Export cleaned data for use on Dashboard
df.to_csv('Resources/dashboard_data.csv', index=False)


# Prepare the dataframe for the Machine Learning by encoding the fields

# categorical_vars = [col for col in df.columns if df[col].dtype=="O"]
categorical_vars = ['animal_type', 'breed', 'color', 'intake_type',
                    'intake_condition', 'sex_upon_intake', 'sex_upon_outcome']
categorical_vars


# Use one hot encoder method
enc = OneHotEncoder(sparse=False)
# Fit and transform the OneHotEncoder using the categorical variable list
encoded_df = pd.DataFrame(enc.fit_transform(
    df[categorical_vars]), index=df.index)

# Add the encoded variable names to the dataframe
encoded_df.columns = enc.get_feature_names(categorical_vars)


# ### Drop Extra Columns Pt 2: Drop columns that were encoded


# Drop columns that were encoded
df.drop(columns=categorical_vars, inplace=True)


# ### Merge Encoded Dataframe with Columns from Original Dataframe


# Join encoded_df with df
ml_df = df.join(encoded_df)


# ### Drop Any Remaining Rows with NaN


# Drop NaN rows
ml_df.dropna(inplace=True)


# ### Export Cleaned Dataframe to CSV for Machine Learning


# Export the clean, encoded data to a new CSV file for running ML models
ml_df.to_csv('Resources/ml.csv', index=False)


# ### **Start removing columns from ml_df that don't influence the ML model**
