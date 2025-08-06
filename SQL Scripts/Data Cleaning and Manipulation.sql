## Data Cleaning and Manipulation

# Renaming columns before joining to avoid ambiguity
ALTER TABLE `f1_analysis`.`constructors` 
CHANGE COLUMN `constructorId` `constructor_Id` INT NULL DEFAULT NULL ;

ALTER TABLE `f1_analysis`.`races` 
CHANGE COLUMN `raceId` `race_Id` INT NULL DEFAULT NULL ;

ALTER TABLE `f1_analysis`.`races` 
CHANGE COLUMN `name` `race_name` TEXT NULL DEFAULT NULL ;

## Creating table with constructors results
With CTE_1 as
(
SELECT constructorResultsId, raceId, constructorId, points, constructorRef, `name`, nationality 
FROM constructor_results
LEFT JOIN constructors
ON constructor_results.constructorId = constructors.constructor_Id
)
SELECT constructorResultsId, raceId, constructorId, points, constructorRef, `name`, nationality, `year`, round, race_name, `date`
FROM CTE_1
LEFT JOIN races
ON CTE_1.raceId = races.race_Id;

# Creating a new table on constructors standings
With CTE_2 as
(
SELECT constructorStandingsId, raceId, constructorId, points, position, wins, constructorRef, `name`, nationality 
FROM constructor_standings
LEFT JOIN constructors
ON constructor_standings.constructorId = constructors.constructor_Id
)
SELECT constructorStandingsId, raceId, constructorId, points, position, wins, constructorRef, `name`, nationality , `year`, round, race_name, `date`
FROM CTE_2
LEFT JOIN races
ON CTE_2.raceId = races.race_Id;
