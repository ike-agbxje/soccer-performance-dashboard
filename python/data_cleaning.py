
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
# print("\n=== First 5 Rows ===")
# print(df.head()) # view the first 5 rows

# print("\n=== Dataset Dimensions ===")
# print(df.shape) # double check dimensions

# print("\n=== Column Names ===")
# print(df.columns) # view the column names

# print("\n=== Dataset Info ===")
# df.info() # view more info about the data

# print("\n=== Missing Values ===")
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
    
# create additional columns for better analysis
df["total_goals"] = df["FTHG"] + df["FTAG"] # total combined goals from both teams
df["goal_difference"] = df["FTHG"] - df["FTAG"] # goal difference; positive value indicates home team won, negative value indicates home team lost
df["home_points"] = df["FTR"].map(home_points_map) # assign 0, 1, or 3 points to the home team depending on who won using map created earlier
df["away_points"] = df["FTR"].map(away_points_map) # same as above for away team
df["Date"] = pd.to_datetime(df["Date"]) # convert the 'Date' column strings to datetime objects 
df["month"] = df["Date"].dt.month_name() # extract the month; will be useful for filtering data/dashboards
