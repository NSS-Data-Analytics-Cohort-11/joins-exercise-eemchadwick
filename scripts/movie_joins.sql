SELECT *
from distributors;

--1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT film_title, release_year, worldwide_gross
FROM specs
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
ORDER BY worldwide_gross;

SELECT film_title, release_year, worldwide_gross
FROM specs
FULL JOIN revenue
ON specs.movie_id = revenue.movie_id
ORDER BY worldwide_gross;
--answer: "Semi-Tough"	1977	37187139

--2. What year has the highest average imdb rating?
SELECT specs.release_year, AVG(rating.imdb_rating)
FROM specs
	FULL JOIN rating
	USING (movie_id)
GROUP BY release_year, imdb_rating
ORDER BY imdb_rating DESC;

SELECT specs.release_year, AVG(rating.imdb_rating)
FROM specs
	INNER JOIN rating
	USING (movie_id)
GROUP BY release_year, imdb_rating
ORDER BY imdb_rating DESC;
--answer: 2008

--3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT film_title, mpaa_rating, worldwide_gross, company_name
FROM specs
	INNER JOIN revenue
	USING (movie_id)
	