SELECT * FROM NETFLIX_RAW
where show_id = 's5023'

-- In this file we have created multiple tables for analysis and done data cleaning




 -- Handling foreign characters

 -- remove duplicates

SELECT * FROM NETFLIX_RAW

SELECT * FROM NETFLIX_RAW
WHERE (UPPER(TITLE), TYPE) IN (
select upper(title), TYPE
from netflix_raw
group by upper(title), TYPE
having count(*)>1
)
ORDER  BY TITLE

WITH CTE AS(
SELECT *
, ROW_NUMBER() OVER(PARTITION BY UPPER(TITLE), TYPE ORDER BY SHOW_ID) AS RN
FROM NETFLIX_RAW
)
SELECT * FROM CTE
WHERE RN = 1;


-- new tables for listed in, director, country, cast

-- NEW TABLE FOR DIRECTORS
SELECT 
  show_id, 
  TRIM(unnested_director) AS director
INTO NETFLIX_DIRECTORS  
FROM 
  netflix_raw,
  unnest(string_to_array(director, ',')) AS unnested_director;
  
SELECT * FROM NETFLIX_DIRECTORS;

-- NEW TABLE FOR COUNTRY
SELECT 
  show_id, 
  TRIM(unnested_country) AS COUNTRY
INTO NETFLIX_COUNTRY  
FROM 
  netflix_raw,
  unnest(string_to_array(COUNTRY, ',')) AS unnested_country;

SELECT * FROM NETFLIX_COUNTRY;
SELECT * FROM NETFLIX_RAW;

-- NEW TABLE FOR CAST 

SELECT 
  show_id, 
  TRIM(unnested_cast) AS CAST
INTO NETFLIX_CAST  
FROM 
  netflix_raw,
  unnest(string_to_array("cast", ',')) AS unnested_cast;

SELECT * FROM NETFLIX_CAST;

-- NEW TABLE FOR LISTED IN
SELECT 
  show_id, 
  TRIM(unnested_listed_in) AS LISTED_IN
INTO NETFLIX_GENRE
FROM 
  netflix_raw,
  unnest(string_to_array(listed_in, ',')) AS unnested_listed_in;

  SELECT * FROM NETFLIX_GENRE;

-- data type conversions for date added

-- populate missing values in country, duration columns

SELECT SHOW_ID, DIRECTOR, COUNTRY FROM NETFLIX_RAW
WHERE COUNTRY IS NULL

SELECT * FROM NETFLIX_RAW WHERE DIRECTOR = 'Ahishor Solomon'

-- MISSING VALUES FOR COUNTRY COLUMN

INSERT INTO NETFLIX_COUNTRY
SELECT SHOW_ID, M.COUNTRY
FROM NETFLIX_RAW NR
INNER JOIN(
SELECT DIRECTOR, COUNTRY
FROM NETFLIX_COUNTRY NC 
INNER JOIN NETFLIX_DIRECTORS ND ON NC.SHOW_ID=ND.SHOW_ID
GROUP BY DIRECTOR, COUNTRY
ORDER BY DIRECTOR
) M ON NR.DIRECTOR= M.DIRECTOR
WHERE NR.COUNTRY IS NULL

SELECT * FROM NETFLIX_RAW WHERE DURATION IS NULL

-- THE FOLLOWING QUERY IS FOR MISSING VALUES FOR DURATION 

WITH CTE AS(
SELECT *
, ROW_NUMBER() OVER(PARTITION BY UPPER(TITLE), TYPE ORDER BY SHOW_ID) AS RN
FROM NETFLIX_RAW
)
SELECT SHOW_ID, TYPE, TITLE, CAST(DATE_ADDED AS DATE) AS DATE_ADDED, RELEASE_YEAR,
RATING, CASE WHEN DURATION IS NULL THEN RATING ELSE DURATION END AS DURATION, DESCRIPTION
INTO NETFLIX
FROM CTE;

SELECT * FROM NETFLIX;

-- THE FINAL NETFLIX COLUMN CONTAINS VARIOUS COLUMNS SHOW_ID, TYPE, TITLE, DATE_ADDED, RELEASE_YEAR, RATING, DURATION, DESCRIPTION
