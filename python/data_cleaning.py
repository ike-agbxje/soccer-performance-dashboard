
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
# print("\n------ First 5 Rows ------")
# print(df.head()) # view the first 5 rows

# print("\n------ Dataset Dimensions ------")
# print(df.shape) # double check dimensions

# print("\n------ Column Names ------")
# print(df.columns) # view the column names

# print("\n------ Dataset Info ------")
# df.info() # view more info about the data

# print("\n------ Missing Values ------")
# print(df.isnull().sum()) # double check for missing values and view how many there are if so

# create maps to assign points to the home and away teams depending on who won using the classic 0/1/3 soccer point standard
home_points_map = {
    "H": 3,
    "D": 1,
    "A": 0
}

away_points_map = {
    "A": 3,
    "D": 1,
    "H": 0
}
    
# feature engineering for better analysis
df["total_goals"] = df["FTHG"] + df["FTAG"]

# positive = home team scored more goals, negative value = away team scored more goals
df["goal_difference"] = df["FTHG"] - df["FTAG"]

# assign points based on match outcomes
df["home_points"] = df["FTR"].map(home_points_map)
df["away_points"] = df["FTR"].map(away_points_map)

# convert text dates to datetime objects
df["Date"] = pd.to_datetime(df["Date"])

# extract the month names; will be useful for time-based analysis and filtering data/dashboards
df["month"] = df["Date"].dt.month_name()

print("\n------ Summary Stats of Data ------")
print(df[["FTHG", "FTAG", "total_goals"]].describe())

# export cleaned dataset to a new CSV for SQL and power BI
df.to_csv("../data/cleaned_data.csv", index=False)