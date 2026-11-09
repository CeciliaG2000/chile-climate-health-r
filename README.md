# Chile Climate & Health — Learning R with real climate data

**Author:** Cecilia Gutiérrez Galindo  
**Status:** Phases 1 and 2 completed — exploratory climate analysis and descriptive respiratory hospital discharge analysis using Chilean public datasets. Temporal climate-health association analysis has not yet been performed.

## Objective

Learn reproducible data analysis in R using publicly accessible climate observations for Santiago, Chile. This is preparation for future work integrating climate and public-health data. **This version does not test a climate–health association.**

## Research questions for Phase 1

- How does daily maximum temperature change through 2023 in Santiago?
- How many days reached a daily maximum of at least 30°C (a descriptive threshold, not a validated local health-risk threshold)?
- What are the monthly temperature and precipitation patterns?

## Data

Open-Meteo Historical Weather API, using the ERA5 reanalysis model for a representative point in Santiago (-33.45, -70.67), January–December 2023. Reanalysis estimates are not direct station observations and do not represent all of Santiago.

Source and documentation: https://open-meteo.com/en/docs/historical-weather-api

## Run

Install R, then in its console:

```r
install.packages("jsonlite")
source("analysis.R")
```

The script downloads data, checks that data were returned, creates daily/monthly CSVs and two PNG charts in `outputs/`. An internet connection is required. Results are generated only when the script is run; this repository does not claim results that have not been executed.

## Methods

1. Retrieve daily maximum/minimum temperatures and precipitation.
2. Check the dataset and missing maximum temperatures.
3. Count days with maximum temperature ≥30°C.
4. Summarize climate indicators by month and generate visualizations.

## Limitations

- Single coordinate and one calendar year.
- ERA5 is gridded reanalysis, not a local clinical exposure measure.
- A 30°C threshold is used for descriptive practice only.
- No health outcomes are included yet; no health effects or causal conclusions can be drawn.

## Planned Phase 2

Locate and validate appropriately aggregated, publicly accessible health outcome data from Chile's DEIS (https://deis.minsal.cl/), align geographic and temporal units, document missingness, and only then conduct exploratory comparisons. Avoid personal or identifiable patient data.

## Learning context

This is an introductory R learning project, building on prior experience in applied statistics with Minitab and SPSS and Lean Six Sigma healthcare process analysis. Assistance from ChatGPT was used to scaffold the initial R script and documentation; the author should run, inspect, adapt and explain the analysis before presenting it as completed personal work.
