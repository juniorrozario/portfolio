-- 1. Speeding-related accidents by year

SELECT 
    year, 
    COUNT(DISTINCT accnum) accidents
FROM
    ksi.ksi
WHERE
    speeding = 'Yes'
GROUP BY year
ORDER BY year DESC;

-- 2. Involvement trends for speeding-related accidents

SELECT 
    year,
    COUNT(CASE
        WHEN pedestrian = 'Yes' THEN 1
    END) ped,
    COUNT(CASE
        WHEN cyclist = 'Yes' THEN 1
    END) cyc,
    COUNT(CASE
        WHEN automobile = 'Yes' THEN 1
    END) auto,
    COUNT(CASE
        WHEN motorcycle = 'Yes' THEN 1
    END) mcyc,
    COUNT(CASE
        WHEN truck = 'Yes' THEN 1
    END) truck
FROM
    ksi.ksi
WHERE
    speeding = 'Yes'
GROUP BY year
ORDER BY year DESC;

-- 3. Fatalities from speeding-related accidents

SELECT 
    year, 
    COUNT(injury) fatalities
FROM
    ksi.ksi
WHERE
    speeding = 'Yes' AND injury = 'Fatal'
GROUP BY year
ORDER BY year DESC;

-- 4. Automobile speeding-related accidents by age group

SELECT 
    year,
    COUNT(CASE
        WHEN invage = '10 to 14' THEN 1
    END) '10_to_14',
    COUNT(CASE
        WHEN invage = '15 to 19' THEN 1
    END) '15_to_19',
    COUNT(CASE
        WHEN invage = '20 to 24' THEN 1
    END) '20_to_24',
    COUNT(CASE
        WHEN invage = '25 to 29' THEN 1
    END) '25 to 29',
    COUNT(CASE
        WHEN invage = '30 to 34' THEN 1
    END) '30 to 34',
    COUNT(CASE
        WHEN invage = '35 to 39' THEN 1
    END) '35 to 39',
    COUNT(CASE
        WHEN invage = '40 to 44' THEN 1
    END) '40 to 44',
    COUNT(CASE
        WHEN invage = '45 to 49' THEN 1
    END) '45 to 49',
    COUNT(CASE
        WHEN invage = '50 to 54' THEN 1
    END) '50 to 54',
    COUNT(CASE
        WHEN invage = '55 to 59' THEN 1
    END) '55 to 59',
    COUNT(CASE
        WHEN invage = '60 to 64' THEN 1
    END) '60 to 64',
    COUNT(CASE
        WHEN invage = '65 to 69' THEN 1
    END) '65 to 69',
    COUNT(CASE
        WHEN invage = '70 to 74' THEN 1
    END) '70 to 74',
    COUNT(CASE
        WHEN invage = '75 to 79' THEN 1
    END) '75 to 79',
    COUNT(CASE
        WHEN invage = '80 to 84' THEN 1
    END) '80 to 84',
    COUNT(CASE
        WHEN invage = '85 to 89' THEN 1
    END) '85 to 89',
    COUNT(CASE
        WHEN invage = '90 to 94' THEN 1
    END) '90 to 94',
    COUNT(CASE
        WHEN invage = 'Over 95' THEN 1
    END) 'Over 95',
    COUNT(CASE
		WHEN invage = 'Unknown' THEN 1
	END) 'Unknown'
FROM
    ksi.ksi
WHERE
    speeding = 'Yes' AND invtype = 'Driver'
GROUP BY year;

-- 5. Speeding-related accidents grouped by district

SELECT 
    year, 
    COUNT(accnum) accidents, 
    district
FROM
    ksi.ksi
WHERE
    speeding = 'Yes'
GROUP BY year , district
ORDER BY year DESC , accidents DESC;

-- 6. Speeding-related accidents grouped by neighbourhood

SELECT 
    year, 
    COUNT(accnum) accidents, 
    neighbourhood
FROM
    ksi.ksi
WHERE
    speeding = 'Yes'
GROUP BY year , neighbourhood
ORDER BY year DESC , accidents DESC;

-- 7. Speeding-related accidents grouped by time of day

SELECT 
    COUNT(DISTINCT (accnum)) AS accident_count,
    CASE
        WHEN time BETWEEN '0' AND '459' THEN 'late-night'
        WHEN time BETWEEN '500' AND '1159' THEN 'morning'
        WHEN time BETWEEN '1200' AND '1659' THEN 'afternoon'
        WHEN time BETWEEN '1700' AND '2059' THEN 'evening'
        WHEN time BETWEEN '2100' AND '2359' THEN 'night'
        ELSE time
    END AS 'time_of_day'
FROM
    ksi.ksi
WHERE
    speeding = 'Yes'
GROUP BY time_of_day
ORDER BY accident_count DESC;