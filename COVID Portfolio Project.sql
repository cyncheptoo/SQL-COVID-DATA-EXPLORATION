Select *
From PortfolioProject..CovidDeaths
where continent is not NULL
Order by 3,4;



--Select *
--FRom CovidVaccinations
--Order by 3,4;

--Select Data that we are going to be using

Select location,date,total_cases,new_cases,total_deaths,population
From PortfolioProject..CovidDeaths
order by 1,2;

-- Looking at Total cases VS Total Deaths
-- shows the likelihood of dying if you contract covid in your country

Select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2;

--looking at the total cases VS the population
--shows what percentage of population got covid
Select location,date,population,total_cases,(total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--where location like '%states%'
order by 1,2;

--Looking at countries with Highest Infection Rate to compared to population
Select location,population,MAX(total_cases) as HighestInfectionCount,MAX((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--where location like '%states%'
Group By location,population
order by PercentPopulationInfected desc;


--Showing Countries with the Highest Death Count Per Country.
Select location,MAX(total_deaths) as TotalDeathCount
From PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not NULL
Group By location
order by TotalDeathCount desc;


--LET'S BREAK THINGS DOWN BY CONTINENNT


--Showing Continent with the Highest Death Count Per Country.
Select continent,MAX(total_deaths) as TotalDeathCount
From PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not  NULL
Group By continent
order by TotalDeathCount desc;


--LET'S BREAK THINGS DOWN BY CONTINENT


--Showing continents with the highest death count per population
Select continent,MAX(total_deaths) as TotalDeathCount
From PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not  NULL
Group By continent
order by TotalDeathCount desc;



-- GLOBAL NUMBERS 
Select SUM(new_cases) as total_cases,SUM(new_deaths) as total_deaths,SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage--population,total_cases,(total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
--Group by date
order by 1,2;




--Looking at Total Population Vs  vaccinations

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,sum(vac.new_vaccinations)over (Partition by dea.location order by dea.location,dea.date)
as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join  PortfolioProject..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date=vac.date
where dea.continent is not null
order by 2,3


--USE CTE
With PopVsVAC (Continent,Location,Date,Population,New_Vaccinations,RollingPeopleVaccinated)
as 
(
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,sum(vac.new_vaccinations)over (Partition by dea.location order by dea.location,dea.date)
as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join  PortfolioProject..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date=vac.date
where dea.continent is not null
--order by 2,3
)

select *,(RollingPeopleVaccinated/Population)*100
from PopVsVAC



 --TEMP TABLE
 Drop Table if exists #PercentPopulationVaccinated
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
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,sum(vac.new_vaccinations)over (Partition by dea.location order by dea.location,dea.date)
as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)100
from PortfolioProject..CovidDeaths dea
Join  PortfolioProject..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date=vac.date
where dea.continent is not null
--order by 2,3

select *,(RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated



---Creating View to store data for later visualization

Create view PercentPopulationVaccinated as 
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,sum(vac.new_vaccinations)over (Partition by dea.location order by dea.location,dea.date)
as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
Join  PortfolioProject..CovidVaccinations vac
   on dea.location = vac.location
   and dea.date=vac.date
where dea.continent is not null
--order by 2,3

select *
from PercentPopulationVaccinated
