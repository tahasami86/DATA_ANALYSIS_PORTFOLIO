--select  location , date , total_cases , new_cases , total_deaths , new_deaths , population

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

-- Max cases per vs death per country


SELECT location ,population ,  max(total_cases) as max_total_cases , max(CAST (total_cases as float) / cast (population as float)) * 100 as percentage_of_infected
from portfolio_project..CovidDeaths_csv
group by location , population
order by  percentage_of_infected desc

