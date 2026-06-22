
import pandas as pd

# load the dataset and keep only the relevant columns
df = pd.read_csv("../data/raw_data.csv")
df = df[
    [
        "Date",
        "HomeTeam",
        "AwayTeam",
        "FTHG",
        "FTAG",
        "FTR"
    ]
]

# verifying data was read correctly:
print("\n=== First 5 Rows ===")
print(df.head()) # view the first 5 rows

print("\n=== Dataset Dimensions ===")
print(df.shape) # double check dimensions

print("\n=== Column Names ===")
print(df.columns) # view the column names

print("\n=== Dataset Info ===")
df.info() # view more info about the data

print("\n=== Missing Values ===")
print(df.isnull().sum()) # double check for missing values and view how many there are if so