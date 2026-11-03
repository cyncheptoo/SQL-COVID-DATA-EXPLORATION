# COVID-19 Data Exploration with SQL

An exploratory analysis of global COVID-19 cases, deaths and vaccinations using **Microsoft SQL Server**. The project looks at how the pandemic spread across countries and continents, how deadly it was, and how quickly populations were vaccinated.

## Tools
- Microsoft SQL Server 2025 Express
- SQL Server Management Studio (SSMS)

## Data
- **Source:** [Our World in Data – COVID-19 dataset](https://ourworldindata.org/covid-deaths)
- Split into two tables:
  - `CovidDeaths`: cases, deaths and population by country and date
  - `CovidVaccinations`: tests and vaccinations by country and date
- Imported from CSV into a `PortfolioProject` database with the SSMS Import Flat File wizard. Column data types were corrected during the import (for example, numeric columns set to `float` and nulls allowed), so calculations work without extra type conversions.

## Questions Explored
1. **Total cases vs. total deaths:** what is the likelihood of dying if you contract COVID in a given country (e.g. the United States)?
2. **Total cases vs. population:** what percentage of each country's population was infected?
3. **Highest infection rate:** which countries had the highest infection count relative to their population?
4. **Highest death count:** which countries and continents had the most deaths?
5. **Global numbers:** total cases, total deaths and the overall death percentage worldwide.
6. **Population vs. vaccinations:** a rolling count of people vaccinated in each country, and the share of the population vaccinated over time.

## SQL Skills Demonstrated
- Filtering and pattern matching (`WHERE`, `LIKE`, `IS NOT NULL`)
- Calculated columns and aliases (death percentage, percent of population infected)
- Aggregate functions and grouping (`MAX`, `SUM`, `GROUP BY`)
- Joins between the deaths and vaccinations tables
- Window functions (`SUM() OVER (PARTITION BY ... ORDER BY ...)`) for rolling vaccination totals
- Common Table Expressions (CTEs) to calculate the percentage of each population vaccinated from the rolling total
- Temporary tables (`#PercentPopulationVaccinated`) as an alternative to the CTE
- Views (`PercentPopulationVaccinated`) created to store data for later visualization

## Key Findings
- Small, densely populated countries such as **Bahrain (10.4%)** and **Serbia (10.1%)** were among the countries with the highest share of their population infected.
- The **United States** ranked in the top 10, with about **9.8%** of its population infected.

## Files
| File | Description |
|---|---|
| `COVID Portfolio Project.sql` | All queries used in the analysis, with comments |



