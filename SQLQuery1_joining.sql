CREATE TABLE #PER__PEOPLEC_VACINATED
(
Continent nvarchar(255),
location  nvarchar(255),
date  DATETIME,
population numeric,
new_vaccination int
)

insert into #PER__PEOPLEC_VACINATED
select dea.continent , dea.location , dea.date , dea.population , vac.new_vaccinations
from portfolio_project..CovidDeaths_csv dea
join portfolio_project..CovidVaccinations_csv vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is null

SELECT * 
FROM #PER__PEOPLEC_VACINATED
ORDER BY 2,3



DROP TABLE IF EXISTS #PER__PEOPLEC_VACINATED