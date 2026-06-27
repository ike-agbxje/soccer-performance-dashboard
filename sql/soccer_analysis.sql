-- CREATE DATABASE soccer_dashboard;

-- DROP TABLE IF EXISTS matches CASCADE;

-- CREATE TABLE
-- 	matches (
-- 		"Date" DATE,
-- 		"HomeTeam" VARCHAR(50),
-- 		"AwayTeam" VARCHAR(50),
-- 		"FTHG" INTEGER,
-- 		"FTAG" INTEGER,
-- 		"FTR" VARCHAR(1),
-- 		total_goals INTEGER,
-- 		goal_difference INTEGER,
-- 		home_points INTEGER,
-- 		away_points INTEGER,
-- 		month VARCHAR(20)
-- 	);


-- ====================================
-- How much of an advantage does playing at home provide? What percent of the time do home teams win?
-- ====================================
SELECT
	CASE
		WHEN "FTR" = 'H' THEN 'Home Win'
		WHEN "FTR" = 'A' THEN 'Away Win'
		ELSE 'Draw'
	END AS result,
	COUNT(*) AS matches,
	ROUND(
		COUNT(*) * 100.0 / (
			SELECT
				COUNT(*)
			FROM
				matches
		),
		2
	) AS percentage
FROM
	matches
GROUP BY
	result
ORDER BY
	matches DESC;

-- Insight:
-- Home teams won 42.63% of matches, outperforming away teams (30.00%), indicating a measurable home-field advantage.


-- ====================================
-- Which teams scored the most goals?
-- ====================================
SELECT
	team,
	SUM(goals) AS total_goals
FROM
	(
		SELECT
			"HomeTeam" AS team,
			"FTHG" AS goals
		FROM
			matches
		UNION ALL -- Combine home and away statistics so season totals include every match.
		SELECT
			"AwayTeam" AS team,
			"FTAG" AS goals
		FROM
			matches
	) AS all_goals
GROUP BY
	team
ORDER BY
	total_goals DESC
	LIMIT 5;

-- Insight:
-- Man City, Arsenal, and Man United were the top scoring teams with 77, 71, and 69 total goals respectively.


-- ====================================
-- Which teams won the most games / earned the most points?
-- ====================================
SELECT
	team,
	SUM(points) AS total_points,
	SUM(wins) AS total_wins
FROM
	(
		SELECT
			"HomeTeam" AS team,
			home_points AS points,
			CASE
				WHEN home_points = 3 THEN 1
				ELSE 0
			END AS wins
		FROM
			matches
		UNION ALL
		SELECT
			"AwayTeam" AS team,
			away_points AS points,
			CASE
				WHEN away_points = 3 THEN 1
				ELSE 0
			END AS wins
		FROM
			matches
	) AS team_results
GROUP BY
	team
ORDER BY
	total_points DESC,
	total_wins DESC
	LIMIT 5;

-- Insight:
-- Arsenal, Man City, and Man United were the top teams with 85, 78, and 71 points each, winning 26, 23, and 20 games respectively.


-- ====================================
-- Do Higher-Scoring Teams Earn More Points?
-- ====================================
SELECT
	team,
	SUM(goals_scored) AS total_goals,
	SUM(points_earned) AS total_points
FROM
	(
		SELECT
			"HomeTeam" AS team,
			"FTHG" AS goals_scored,
			home_points AS points_earned
		FROM
			matches
		UNION ALL
		SELECT
			"AwayTeam" AS team,
			"FTAG" AS goals_scored,
			away_points AS points_earned
		FROM
			matches
	) AS team_performance
GROUP BY
	team
ORDER BY
	total_points DESC;

-- Insight:
-- This will be better answered visually on a dashboard but just taking a look at the table and the previous 2 queries,
-- teams with more goals generally accumulated more points throughout the season, suggesting a positive relationship between 
-- a strong offense and overall team success; 4 of the top 5 teams (by points) are also the highest goal-scoring teams:
-- Arsenal, Man City, Man United, and Liverpool


-- ====================================
-- Which teams have the strongest defenses (conceded the fewest goals)?
-- ====================================
SELECT
	team,
	SUM(goals_conceded) AS total_goals_conceded
FROM
	(
		SELECT
			"HomeTeam" AS team,
			"FTAG" AS goals_conceded
		FROM
			matches
		UNION ALL
		SELECT
			"AwayTeam" AS team,
			"FTHG" AS goals_conceded
		FROM
			matches
	) AS all_goals_conceded
GROUP BY
	team
ORDER BY
	total_goals_conceded ASC
	LIMIT 5;

-- Insight:
-- Arsenal, Man City, and Brighton conceded the least number of goals with 27, 35, and 46 goals conceded respectively.