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
	ON specs.movie_id = revenue.movie_id
	INNER JOIN distributors
	ON specs.domestic_distributor_id = distributors.distributor_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC;

SELECT film_title, mpaa_rating, worldwide_gross, company_name
FROM specs
	FULL JOIN revenue
	ON specs.movie_id = revenue.movie_id
	FULL JOIN distributors
	ON specs.domestic_distributor_id = distributors.distributor_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC;

--answer: "Toy Story 4", "Walt Disney "

--4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

--checking to see # of companies
SELECT DISTINCT(company_name)
FROM distributors;

SELECT distributors.company_name, COUNT(specs.film_title)
FROM distributors
	FULL JOIN specs
	ON distributors.distributor_id = specs.domestic_distributor_id
WHERE company_name IS NOT NULL
GROUP BY distributors.company_name;

--answer: see table

--5. Write a query that returns the five distributors with the highest average movie budget.
SELECT distributors.company_name, AVG(revenue.film_budget)
FROM distributors
	INNER JOIN specs
	ON distributors.distributor_id = specs.domestic_distributor_id
	INNER JOIN revenue
	ON specs.movie_id = revenue.movie_id 
GROUP BY distributors.company_name
ORDER BY AVG(revenue.film_budget) DESC
LIMIT 5;
--answer: 
--"company_name"	"avg"
--"Walt Disney "	148735526.31578947
--"Sony Pictures"	139129032.25806452
--"Lionsgate"	122600000.00000000
--"DreamWorks"	121352941.17647059
--"Warner Bros."	103430985.91549296

--6a. How many movies in the dataset are distributed by a company which is not headquartered in California? 

SELECT COUNT(specs.*), distributors.company_name, distributors.headquarters
FROM distributors
	INNER JOIN specs
	ON distributors.distributor_id = specs.domestic_distributor_id
WHERE distributors.headquarters NOT LIKE '%CA'
GROUP BY distributors.company_name, distributors.headquarters;

--checking headquarters location
SELECT *
FROM distributors;

--checking based on question 4 answer: 
SELECT distributors.company_name, COUNT(specs.film_title)
FROM distributors
	FULL JOIN specs
	ON distributors.distributor_id = specs.domestic_distributor_id
WHERE company_name IS NOT NULL
GROUP BY distributors.company_name;

--ANSWER: 2 movies
	
--6b. Which of these movies has the highest imdb rating?
SELECT specs.film_title, distributors.company_name, distributors.headquarters, rating.imdb_rating 
FROM distributors
	INNER JOIN specs
	ON distributors.distributor_id = specs.domestic_distributor_id
	INNER JOIN rating
	ON specs.movie_id = rating.movie_id
WHERE distributors.headquarters NOT LIKE '%CA'
GROUP BY specs.film_title, distributors.company_name, distributors.headquarters, rating.imdb_rating
ORDER BY rating.imdb_rating DESC;
--answer: "Dirty Dancing"

--7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
