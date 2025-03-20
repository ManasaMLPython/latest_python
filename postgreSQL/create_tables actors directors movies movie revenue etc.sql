-- 1. create actor table
-- function : CREATE TABLE

CREATE TABLE actor(
	actor_id SERIAL PRIMARY KEY,
	actor_name VARCHAR(150),
	last_name VARCHAR(150) NOT NULL,
	gender CHAR(1),
	date_of_birth DATE,
	add_date DATE,
	update_date DATE
);

-- 2. Cretae directors table

CREATE TABLE directors(
	director_id SERIAL PRIMARY KEY,
	director_name VARCHAR(150),
	last_name VARCHAR(150),
	date_of_birth DATE,
	nationality VARCHAR(20),
	add_date DATE,
	update_date DATE
);

-- 3. select all form directors
SELECT * from directors;

-- 4. movies table
-- movies>director

CREATE TABLE movies(
	movie_id SERIAL PRIMARY KEY,
	movie_name VARCHAR(100) NOT NULL,
	movie_length INT,
	movie_lang VARCHAR(20),
	movie_certi VARCHAR(10),
	release_date DATE,
	director_id INT REFERENCES directors(director_id)
	
);

--5. movies revenue table

CREATE TABLE movie_revenue(
	revenue_id SERIAL PRIMARY KEY,
	movie_id INT REFERENCES movies (movie_id),
	revenue_domestic NUMERIC(10,2),
	revenue_international NUMERIC(10,2)
);

SELECT * FROM movie_revenue;

-- create a junction table. junction table contains the foreign kes of different tables 
-- movies actors junction table

CREATE TABLE movies_actors(
	movie_id INT REFERENCES movies (movie_id),
	actor_id INT REFERENCES actor (actor_id),
	PRIMARY KEY (movie_id,actor_id)
);

SELECT * FROM movies_actors;

-- Insert data into directors table
