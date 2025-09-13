# Netflix Content Analysis (PostgreSQL)
*This project showcases SQL and PostgreSQL skills for real-world data analysis and business problem solving.*

## Project Overview
This project analyzes a **Netflix dataset** using PostgreSQL.  
It demonstrates SQL skills including database creation, data exploration, filtering, aggregation, window functions, string manipulation, and subqueries.  
The project solves **15 business problems** to extract insights from Netflix content data.

## Business Problems Solved
1. Count the number of Movies vs TV Shows.  
2. Find the most common "rating" for movies and TV shows.  
3. List all movies released in a specific year (e.g., 2020).  
4. Find the top 5 countries with the most content on Netflix.  
5. Identify the longest movie or TV show duration.  
6. Find content added in the last 5 years.  
7. Find all movies/TV shows directed by a specific director (e.g., Rajiv Chilaka).  
8. List all TV shows with more than 5 seasons.  
9. Count the number of content items in each genre.  
10. Find the average release year for content produced in India.  
11. List all movies that are documentaries.  
12. Find all content without a director.  
13. List all movies featuring a specific actor (e.g., Salman Khan) in the last 10 years.  
14. Find the top 10 actors who appeared in the highest number of movies produced in India.  
15. Categorize content containing "kill" or "violence" as "Bad" and all others as "Good".

## How to Run
1. Install PostgreSQL.  
2. Create a new database.  
3. Run `netflix.sql` to create the table and explore queries.  
4. Modify queries as needed to answer specific questions or filter by different years, actors, or countries.

## Key SQL Concepts Demonstrated
- Filtering with `WHERE`  
- Aggregation with `COUNT`, `GROUP BY`, `AVG`  
- Ranking with window functions (`RANK() OVER`)  
- Subqueries for advanced analysis  
- String and date manipulation (`STRING_TO_ARRAY`, `UNNEST`, `TO_DATE`)  
- Conditional logic with `CASE` statements

