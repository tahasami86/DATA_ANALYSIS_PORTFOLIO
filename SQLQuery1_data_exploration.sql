

--select  location , date , total_cases , new_cases , total_deaths , new_deaths , population
--SELECT *
--from portfolio_project..CovidDeaths_csv
--order by 1,2 desc


-- Total cas vs total deaths

--select location , population , date , total_cases , total_deaths , CAST (total_deaths as FLOAT) / CAST(total_cases as FLOAT) * 100  as percentage_of_deaths
--from portfolio_project..CovidDeaths_csv
--order by 1,3

--select location , population , date , total_cases , total_deaths , CAST (total_deaths as FLOAT) / CAST(total_cases as FLOAT) * 100  as percentage_of_deaths
--from portfolio_project..CovidDeaths_csv
--WHERE location='Pakistan'
--order by 1,3



-- Highest percentage of infection per country
--SELECT location ,population ,  max(total_cases) as max_total_cases , max(CAST (total_cases as float) / cast (population as float)) * 100 as percentage_of_infected
--from portfolio_project..CovidDeaths_csv
--group by location , population
--order by  percentage_of_infected desc

-- Hihgest number of death per country

--SELECT location,population , Max(total_deaths) as hihgest_deaths_per_country
--FROM portfolio_project..CovidDeaths_csv
--WHERE continent IS NOT NULL
--group by location , population
--order by  hihgest_deaths_per_country desc


-- breakdown of deaths by continent

----SELECT continent , Max(total_deaths) as hihgest_deaths_per_country
----FROM portfolio_project..CovidDeaths_csv
----WHERE continent IS  not NULL
----group by continent
----order by  hihgest_deaths_per_country desc


-- Continents with highest death count

--SELECT continent ,  MAX(total_deaths) AS max_death , MAX(total_cases) AS max_cases , CAST(MAX(total_deaths) as float) / CAST(MAX(total_cases) as float) * 100 as Percn_of_deaths
--FROM portfolio_project..CovidDeaths_csv
--WHERE continent is not null
--group by continent 
--order by Percn_of_deaths desc

--SELECT continent, MAX(total_deaths) AS max_death, MAX(total_cases) AS max_cases, CAST(MAX(total_deaths) AS FLOAT) / CAST(MAX(total_cases) AS FLOAT) * 100 AS Percn_of_deaths
--FROM portfolio_project..CovidDeaths_csv
--WHERE continent IS NOT NULL
--GROUP BY continent
--ORDER BY Percn_of_deaths DESC;


select location, max(total_deaths) as max_deaths , max(total_cases) as max_cases , CAST(MAX(total_deaths) AS FLOAT) / CAST(MAX(total_cases) AS FLOAT) * 100 AS Percn_of_deaths
from portfolio_project..CovidDeaths_csv
where location = 'world'
group by location
order by Percn_of_deaths desc

-- global number calcultaion

SELECT MAX(total_deaths) as max_deaths ,  max(total_cases) AS total_cases , CAST(MAX(total_deaths) AS FLOAT) / CAST(MAX(total_cases) AS FLOAT) * 100 AS Percentage_of_deaths
FROM portfolio_project..CovidDeaths_csv
order by Percentage_of_deaths


-- joining datest





