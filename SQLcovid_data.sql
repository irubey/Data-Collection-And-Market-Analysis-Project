select *
from PortfolioProjectCovid..covid_deaths
where continent is not null
order by 3,4

--select *
--from PortfolioProjectCovid..covid_vaccinations
--order by 3,4

-- Select Data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProjectCovid..covid_deaths
Order by 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in the United States

Select location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProjectCovid..covid_deaths
Where location like '%united states%'
Order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid

Select location, date,  population, total_cases,(total_cases/population)*100 as PercentPopulationInfected
From PortfolioProjectCovid..covid_deaths
Order by 1,2

--Countries with highest infection rate per population

Select location, population, MAX(total_cases) as HighestInfectionCount, (MAX(total_cases/population))*100 as PercentPopulationInfected
From PortfolioProjectCovid..covid_deaths
Group by Location, population
Order by PercentPopulationInfected desc


-- Countries with highest death rate per popultion

Select location, Max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProjectCovid..covid_deaths
where continent is not null
Group by Location
Order by TotalDeathCount desc

-- Showing continents with highest death count

Select continent, Max(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProjectCovid..covid_deaths
where continent is not null
Group by continent
Order by TotalDeathCount desc

-- Global death percentage numbers by date

Select date, sum(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
From PortfolioProjectCovid..covid_deaths
where continent is not null
Group by date
order by 1,2

-- Global death percentage numbers

Select sum(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
From PortfolioProjectCovid..covid_deaths
where continent is not null
order by 1,2


-- Total population vs vaccinations per day

--USE CTE

With PopvsVac (Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated/population)*100
From PortfolioProjectCovid..covid_deaths dea
join PortfolioProjectCovid..covid_vaccinations vac
	on dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null
)
select *,(RollingPeopleVaccinated/Population)*100
from PopvsVac

-- Temp Table

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated/population)*100
From PortfolioProjectCovid..covid_deaths dea
join PortfolioProjectCovid..covid_vaccinations vac
	on dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null

select *,(RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated

--Creating view to store data for later visualizations


Create View PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated/population)*100
From PortfolioProjectCovid..covid_deaths dea
join PortfolioProjectCovid..covid_vaccinations vac
	on dea.location = vac.location 
	and dea.date = vac.date
where dea.continent is not null