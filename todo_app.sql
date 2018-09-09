--DROP DATABASE drops a database. It removes the catalog entries for the database and deletes the directory containing the data.
DROP DATABASE IF EXISTS todo_app;

--dropuser removes an existing PostgreSQL user
DROP USER IF EXISTS michael;

--CREATE USER -- define a new database role
CREATE USER michael WITH ENCRYPTED PASSWORD 'stonebreaker';

--CREATE DATABASE -- create a new database
CREATE DATABASE todo_app;

--CREATE TABLE -- define a new table
--SERIAL = auto incrementing and NOT NULL is applied
CREATE TABLE tasks(
	id SERIAL PRIMARY KEY,
	title VARCHAR (255) NOT NULL,
	description TEXT NULL,
	created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
	updated_at TIMESTAMP WITHOUT TIME ZONE NULL,
	completed BOOLEAN NOT NULL DEFAULT false
);

--ALTER TABLE -- change the definition of a table
ALTER TABLE tasks
	DROP COLUMN completed;
	--drops a column from a table. Indexes and table constraints involving the column will be automatically dropped as well. 

--add a column to `tasks` named `completed_at`:timestamp, that may be NULL, and has a default value of `NULL`
ALTER TABLE tasks
	ADD COLUMN completed_at TIMESTAMP DEFAULT NULL;
	--adds a new column to the table

--change the `updated_at` column to not allow NULL values, and have a default value of `now()`
ALTER TABLE tasks
	ALTER COLUMN updated_at SET NOT NULL,
	ALTER COLUMN updated_at SET DEFAULT now();

INSERT INTO tasks VALUES (default, 'Study SQL', 'Complete this exercise', now(), now(), NULL);

INSERT INTO tasks (title, description)
	VALUES ('Study PostgreSQL', 'Read all the documentation');

--select all the titles of tasks that are not yet completed
SELECT title FROM tasks WHERE completed_at is NULL;

--update the task with a title of `'Study SQL'` to be completed as of now
UPDATE tasks SET completed_at = now() WHERE title = 'Study SQL';

--select all titles and descriptions of tasks that are not yet completed
SELECT title, description FROM tasks WHERE completed_at is NULL;

--select all fields of every task sorted by creation date in descending order
SELECT *
	FROM tasks
	ORDER BY created_at DESC;
