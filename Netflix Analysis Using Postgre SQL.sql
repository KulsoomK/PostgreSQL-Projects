-- Netflix Project

DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix 
(
	show_id VARCHAR (20), 
	type VARCHAR (10), 
	title VARCHAR (150),  
	director VARCHAR (208), 
	casts VARCHAR (1000), 
	country VARCHAR (150), 
	date_added VARCHAR (50), 
	release_year INT, 
	rating VARCHAR (10), 
	duration VARCHAR (15), 
	listed_in VARCHAR (155), 
	description VARCHAR (250)
)



SELECT * FROM netflix;

SELECT 
	COUNT(*) as total_content 
FROM netflix;

SELECT 
	DISTINCT type 
FROM netflix;

-- The fifteen business problems we are trying to solve here
	-- 1. Count the number of Movies vs TV Shows
	-- 2. Find the most common "rating" for movies and TV shows
	-- 3. List all movies released in a specific year (e.g., 2020)
	-- 4. Find the top 5 countries with the most content on Netflix
	-- 5. Identify the longest movie or TV show duration
	-- 6. Find content added in the last 5 years
	-- 7. Find all the movies/TV shows directed by a specific director, Rajiv Chilaka'
	-- 8. List all TV shows with more than 5 seasons
	-- 9. Count the number of content items in each genre
	-- 10. Find the average release year for content produced in a specific country 
	-- 11. List all movies that are  documentaries 
	-- 12. Find all content without a director
	-- 13. Find how many movies the actor "Salman Khan" appeared in over the last 10 years
	-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in "India"
	-- 15. Categorize the content containing the keywords "kill" and "violence" in the description. 
	-- Then label them as "Bad" and all other content as "Good". Count how many items fall into each category.

-- 1. Count the number of Movies vs TV Shows
SELECT 
	type, 
	COUNT (*) as total_content
FROM netflix
GROUP BY type

-- 2. Find the most common "rating" for movies and TV shows

-- Step 1: Count how many times each rating appears per type
WITH rating_counts AS (
    SELECT
        type,                -- Movie or TV Show
        rating,              -- Rating (e.g., PG, R, TV-MA, etc.)
        COUNT(*) AS cnt      -- Count of rows with this type and rating
    FROM netflix
    GROUP BY type, rating   -- Group by type and rating to get the counts
)

-- Step 2: Rank ratings within each type based on frequency
SELECT
    type,                   -- Movie or TV Show
    rating,                 -- Rating
    cnt,                    -- Count of that rating for the type
    ranking                 -- Rank within the type (1 = most common)
FROM (
    SELECT
        type,
        rating,
        cnt,
        RANK() OVER (
            PARTITION BY type        -- Rank separately for each type
            ORDER BY cnt DESC        -- Higher counts get rank 1
        ) AS ranking
    FROM rating_counts
) ranked
WHERE ranking = 1             -- Keep only the most common rating per type
ORDER BY type;                -- Optional: sort output by type

-- 3. List all movies released in a specific year (e.g., 2020)
-- List all movies released in a specific year (e.g., 2020)
SELECT * FROM netflix
WHERE 
	type = 'Movie'        -- Only movies
  	AND release_year = 2020   -- Specify the year you want

-- 4. Find the top 5 countries with the most content on Netflix
-- Find the top 5 countries with the most content on Netflix
SELECT
    UNNEST(STRING_TO_ARRAY (country, ','))as new_country,           -- Country name
    COUNT (show_id) AS total_content  -- Number of titles from that country
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- 5. Identify the longest movie or TV show duration
SELECT * FROM netflix
	WHERE type = 'Movie'
	AND
	duration = (SELECT MAX (duration) FROM netflix)
	
-- 6. Find content added in the last 5 years

-- Get content added in the last 5 years
SELECT *
FROM netflix
WHERE date_added IS NOT NULL
  AND date_added <> ''  -- exclude empty strings
  AND TO_DATE(date_added, 'FMMonth DD, YYYY') >= (CURRENT_DATE - INTERVAL '5 years');

-- 7. Find all the movies/TV shows directed by a specific director, 'Rajiv Chilaka'
SELECT *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%'

--8. List all TV shows with more than 5 seasons
SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND CAST(SUBSTRING(duration FROM '^[0-9]+') AS INT) > 5;

-- 9. Count the number of content items in each genre
SELECT
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,  -- Split multiple genres into rows
    COUNT(*) AS total_content                            -- Count of content per genre
FROM netflix
GROUP BY genre
ORDER BY total_content DESC;

-- 10. Find the average release year for content produced in India
SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
    COUNT(*) AS total_content,
    (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM netflix WHERE country = 'India') AS avg_content_per_year
FROM netflix
WHERE country = 'India'
GROUP BY 1;

-- 11. List all movies that are documentaries
SELECT *
FROM netflix
WHERE type = 'Movie'
  AND listed_in ILIKE '%Documentaries%';

-- 12. Find all content without a director
SELECT *
FROM netflix
WHERE director IS NULL
   OR director = '';

-- 13. List all movies featuring Salman Khan in the last 10 years
SELECT *
FROM netflix
WHERE type = 'Movie'
  AND casts ILIKE '%Salman Khan%'       -- actor appears in the cast
  AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10
ORDER BY release_year DESC;

-- 14. Top 10 actors with the most movies produced in India
SELECT
    TRIM(actor) AS actor_name,
    COUNT(*) AS total_content
FROM netflix,
     UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor
WHERE type = 'Movie'
  AND country ILIKE '%india%'
  AND casts IS NOT NULL
  AND casts <> ''
GROUP BY actor_name
ORDER BY total_content DESC
LIMIT 10;

-- 15. Categorize content as "Bad" or "Good" based on description
SELECT
    CASE 
        WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS content_category,
    COUNT(*) AS total_content
FROM netflix
GROUP BY content_category;

























