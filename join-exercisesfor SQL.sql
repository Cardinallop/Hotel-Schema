USE PersonalTrainer;

-- Select all columns from ExerciseCategory and Exercise.
-- The tables should be joined on ExerciseCategoryId.
-- This query returns all Exercises and their associated ExerciseCategory.
-- 64 rows
--------------------

select *
	from ExerciseCategory ec
inner join Exercise e on ec.ExerciseCategoryId = e.ExerciseCategoryId;
    
-- Select ExerciseCategory.Name and Exercise.Name
-- where the ExerciseCategory does not have a ParentCategoryId (it is null).
-- Again, join the tables on their shared key (ExerciseCategoryId).
-- 9 rows
--------------------

select 
	ec.Name,
    e.Name
from ExerciseCategory ec
inner join Exercise e on ec.ExerciseCategoryId = e.ExerciseCategoryId
where ec.ParentCategoryId is null;

-- The query above is a little confusing. At first glance, it's hard to tell
-- which Name belongs to ExerciseCategory and which belongs to Exercise.
-- Rewrite the query using an aliases. 
-- Alias ExerciseCategory.Name as 'CategoryName'.
-- Alias Exercise.Name as 'ExerciseName'.
-- 9 rows
--------------------

select 
	ec.Name CategoryName,
    e.Name ExerciseName
from ExerciseCategory ec
inner join Exercise e on ec.ExerciseCategoryId = e.ExerciseCategoryId
where ec.ParentCategoryId is null;


-- Select FirstName, LastName, and BirthDate from Client
-- and EmailAddress from Login 
-- where Client.BirthDate is in the 1990s.
-- Join the tables by their key relationship. 
-- What is the primary-foreign key relationship?
-- 35 rows
--------------------

select 
	c.FirstName,
    c.LastName,
    c.BirthDate,
    l.EmailAddress
from Client c 
inner join Login l on c.ClientId = l.ClientId
where c.BirthDate between '1990-01-01' and '1999-12-31';
    

-- Select Workout.Name, Client.FirstName, and Client.LastName
-- for Clients with LastNames starting with 'C'?
-- How are Clients and Workouts related?
-- 25 rows
--------------------

select 
	wo.Name,
    cl.FirstName,
    cl.LastName
from Workout wo
inner join  ClientWorkout clwo on clwo.WorkoutId = wo.WorkoutId
inner join Client cl on cl.ClientId = clwo.ClientId
where cl.LastName like 'C%';

-- Select Names from Workouts and their Goals.
-- This is a many-to-many relationship with a bridge table.
-- Use aliases appropriately to avoid ambiguous columns in the result.
--------------------

select 
	w.Name WorkoutName,
    g.Name GoalName
from Workout w
inner join WorkoutGoal wg on w.WorkoutId = wg.WorkoutId
inner join Goal g on wg.GoalId = g.GoalId;

-- Select FirstName and LastName from Client.
-- Select ClientId and EmailAddress from Login.
-- Join the tables, but make Login optional.
-- 500 rows
--------------------

select
	c.FirstName ClientFirstName,
    c.LastName ClientLastName,
    l.ClientId LoginClientID,
    l.EmailAddress LoginEmailAddress
from Client c
left outer join Login l on l.ClientId = c.ClientId;

-- Using the query above as a foundation, select Clients
-- who do _not_ have a Login.
-- 200 rows
--------------------
select
	c.FirstName ClientFirstName,
    c.LastName ClientLastName,
    l.ClientId LoginClientID,
    l.EmailAddress LoginEmailAddress
from Client c
left outer join Login l on l.ClientId = c.ClientId
where l.ClientId is null;


-- Does the Client, Romeo Seaward, have a Login?
-- Decide using a single query.
-- nope :(
--------------------

select
	c.FirstName,
    c.LastName,
    l.ClientId
from Client c 
inner join Login l on c.ClientId = l.ClientId
where c.FirstName = 'Romeo' and c.LastName = 'Seaward';

-- Select ExerciseCategory.Name and its parent ExerciseCategory's Name.
-- This requires a self-join.
-- 12 rows
--------------------

select
	parent.Name ParentCatName,
    child.Name ChildCatName
from ExerciseCategory parent 
inner join ExerciseCategory child on parent.ExerciseCategoryId = child.ParentCategoryId;
    
-- Rewrite the query above so that every ExerciseCategory.Name is
-- included, even if it doesn't have a parent.
-- 16 rows
--------------------
select
	parent.Name ParentCatName,
    child.Name ChildCatName
from ExerciseCategory parent 
right outer join ExerciseCategory child on parent.ExerciseCategoryId = child.ParentCategoryId;


    
-- Are there Clients who are not signed up for a Workout?
-- 50 rows
--------------------

select
	c.ClientId,
    w.WorkoutId
from Client c 
left outer join ClientWorkout cw on c.ClientId = cw.ClientId
left outer join Workout w on cw.WorkoutId = w.WorkoutId
where w.WorkoutId is null;

-- Which Beginner-Level Workouts satisfy at least one of Shell Creane's Goals?
-- Goals are associated to Clients through ClientGoal.
-- Goals are associated to Workouts through WorkoutGoal.
-- 6 rows, 4 unique rows
--------------------

select
	c.FirstName ClientFirstName,
    c.LastName ClientLastName,
    g.Name GoalName,
    wo.Name WorkoutName,
    l.Name LevelName
from Client c 
inner join ClientGoal cg on c.ClientId = cg.ClientId
inner join Goal g on cg.GoalId = g.GoalId
inner join WorkoutGoal wog on g.GoalId = wog.GoalId
inner join Workout wo on wog.WorkoutId = wo.WorkoutId
inner join Level l on wo.LevelId = l.LevelId
where c.FirstName = 'Shell' and c.LastName = 'Creane' and l.Name like 'Beginner%';



-- Select all Workouts. 
-- Join to the Goal, 'Core Strength', but make it optional.
-- You may have to look up the GoalId before writing the main query.
-- If you filter on Goal.Name in a WHERE clause, Workouts will be excluded.
-- Why?
-- 26 Workouts, 3 Goals
--------------------

select 
	wo.Name,
    g.Name
from Workout wo
left outer join WorkoutGoal wog on wo.WorkoutId = wog.WorkoutId
left outer join Goal g on wog.GoalId = g.GoalId
where g.Name = 'Core Strength';


-- The relationship between Workouts and Exercises is... complicated.
-- Workout links to WorkoutDay (one day in a Workout routine)
-- which links to WorkoutDayExerciseInstance 
-- (Exercises can be repeated in a day so a bridge table is required) 
-- which links to ExerciseInstance 
-- (Exercises can be done with different weights, repetions,
-- laps, etc...) 
-- which finally links to Exercise.
-- Select Workout.Name and Exercise.Name for related Workouts and Exercises.
--------------------

select 
	wo.Name WorkoutName,
    e.Name ExerciseName
from Workout wo
inner join WorkoutDay wod on wo.WorkoutId = wod.WorkoutId
inner join WorkoutDayExerciseInstance wodei on wod.WorkoutDayId = wodei.WorkoutDayId
inner join ExerciseInstance ei on wodei.ExerciseInstanceId = ei.ExerciseInstanceId
inner join Exercise e on ei.ExerciseId = e.ExerciseId;

   
-- An ExerciseInstance is configured with ExerciseInstanceUnitValue.
-- It contains a Value and UnitId that links to Unit.
-- Example Unit/Value combos include 10 laps, 15 minutes, 200 pounds.
-- Select Exercise.Name, ExerciseInstanceUnitValue.Value, and Unit.Name
-- for the 'Plank' exercise. 
-- How many Planks are configured, which Units apply, and what 
-- are the configured Values?
-- 4 rows, 1 Unit, and 4 distinct Values
-- --------------------

select 
	e.Name ExerciseName,
    eiuv.Value ExerciseInstanceUnitValue,
    u.Name UnitName
from Exercise e 
inner join ExerciseInstance ei on e.ExerciseId = ei.ExerciseId   and e.Name = 'Plank'
inner join ExerciseInstanceUnitValue eiuv on ei.ExerciseInstanceId = eiuv.ExerciseInstanceId
inner join Unit u on eiuv.UnitId = u.UnitId;