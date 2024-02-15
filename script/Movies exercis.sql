--Q1. Give the name, release year,and worldwide gross of the lowest frossing movie.
SELECT  film_title, release_year, worldwide_gross 
FROM specs
INNER JOIN revenue 
ON specs.movie_id = revenue.movie_id
ORDER BY worldwide_gross
__Answer: Semi-Tough
-- Q2. What year has the highest average imdb rating?
SELECT release_year, AVG(imdb_rating) AS avg_rating
FROM specs
INNER JOIN rating
ON specs.movie_id = rating.movie_id
GROUP BY release_year
ORDER BY avg_rating DESC
--Q3. What is the the highest grossing G-rated movie? Which company distributed it?
SELECT film_title, worldwide_gross, company_name
FROM specs
INNER JOIN revenue 
USING(movie_id)
INNER JOIN distributors
ON distributors.distributor_id = specs.domestic_distributor_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 1
--Answer:1073394593 Distributed by Walt Disney
--Q4.Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributors, in the movies table.
SELECT DISTINCT company_name, COUNT(film_title)
FROM distributors
LEFT JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY company_name, film_title
 
 --Q5.Write a query that returns the five distributors with the highest average movie budget.
SELECT company_name, AVG(film_budget) AS avg_budget 
FROM distributors
INNER JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN revenue
ON specs.movie_id =revenue.movie_id
GROUP BY company_name
ORDER BY avg_budget DESC
LIMIT 5

--Q6.How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
--SELECT MAX(imdb_rating) from rating 
--INNER JOIN specs on specs.movie_id = rating.movie_id

(SELECT film_title, headquarters
FROM specs 
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
WHERE headquarters NOT LIKE '%CA'
GROUP BY headquarters, film_title) 


--Q7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT
CASE 
WHEN lenght_in_min < 120 THEN 'under_2_hours'
WHEN lenght_in_min >= 120 THEN 'over_2_hours'
ELSE 'exactly_2_hours' ,
END AS under_over_2_hours,
ROUND(AVG(imdb_rating), 2)
FROM specs
INNER JOIN rating
using(movie_id)
GROUP BY under_over_2_hours;







