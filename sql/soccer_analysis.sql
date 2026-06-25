CREATE TABLE matches (
	"Date" DATE,
	"HomeTeam" VARCHAR(50),
	"AwayTeam" VARCHAR(50),
	"FTHG" INTEGER,
	"FTAG" INTEGER,
	"FTR" VARCHAR(1),

	total_goals INTEGER,
	goal_difference INTEGER,

	home_points INTEGER,
	away_points INTEGER,

	month VARCHAR(20)
);