-- COVID-19 Exploratory Data Analysis Project

SELECT *
FROM projects.CovidVaccinations
ORDER BY 3,4;

-- Select data that is to be used

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM projects.CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;

-- Total Cases vs. Total Deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
FROM projects.CovidDeaths
WHERE location LIKE 'Canada'
    AND continent IS NOT NULL
ORDER BY 1,2;

-- Total Cases vs. Population
-- Proportion of infected population

SELECT location, date, total_cases, population, (total_cases/population)*100 as Infected_Percentage
FROM projects.CovidDeaths
WHERE location LIKE 'Canada'
ORDER BY 1,2;

-- Countries with highest infection rate vs. population

SELECT location, population, MAX(total_cases) as Highest_Infection_Cnt, MAX((total_cases/population))*100 as Infected_Percentage
FROM projects.CovidDeaths
GROUP BY population, location
ORDER BY Infected_Percentage DESC;

-- Countries with highest death count per population

SELECT location, MAX(total_deaths) as Total_Death_Cnt
FROM projects.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Total_Death_Cnt DESC;

-- Group by continent

-- Continents with the highest death count per population

SELECT continent, MAX(total_deaths) as Total_Death_Cnt
FROM projects.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Total_Death_Cnt DESC;

-- Global numbers

SELECT date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as Death_Percentage  -- (total_deaths/CovidDeaths.total_cases)*100 AS Death_Percentage
FROM projects.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

-- Total population vs. vaccinations
-- Percentage of population that received at least one COVID vaccine

SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vac.new_vaccinations,
       SUM(vac.new_vaccinations) OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.date) AS Rolling_Vac_Cnt
FROM projects.CovidDeaths as deaths
JOIN projects.CovidVaccinations as vac
    ON deaths.location = vac.location
    AND deaths.date = vac.date
WHERE deaths.continent IS NOT NULL
ORDER BY 1,2,3;


-- Previous query with CTE

WITH Pop_vs_Vac (Continent, Location, Date, Population, New_Vaccinations, Rolling_Vac_Cnt)
AS
(
SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vac.new_vaccinations,
       SUM(vac.new_vaccinations) OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.date) AS Rolling_Vac_Cnt
FROM projects.CovidDeaths as deaths
JOIN projects.CovidVaccinations as vac
    ON deaths.location = vac.location
    AND deaths.date = vac.date
WHERE deaths.continent IS NOT NULL
)

SELECT *, (Rolling_Vac_Cnt/Population)*100
FROM Pop_vs_Vac;

-- Previous query with temp table

DROP TABLE IF EXISTS PercentPopulationVaccinated;

CREATE TABLE projects.PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
Rolling_Vac_Cnt numeric
);

INSERT INTO projects.PercentPopulationVaccinated

SELECT deaths.continent, deaths.location, deaths.date, deaths.population, vac.new_vaccinations,
       SUM(vac.new_vaccinations) OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.date) AS Rolling_Vac_Cnt
FROM projects.CovidDeaths as deaths
JOIN projects.CovidVaccinations as vac
    ON deaths.location = vac.location
    AND deaths.date = vac.date
WHERE deaths.continent IS NOT NULL;