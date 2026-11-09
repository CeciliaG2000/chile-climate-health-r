# Phase 2 — Respiratory hospital discharges in Chile (2023)

This phase adds **descriptive public-health data** to the climate-data learning project. It does **not** test whether temperature is associated with hospital admissions or discharges.

## Source and definitions
- Source: Chilean Ministry of Health, DEIS, `EGRESOS_2023.csv`, downloaded by the project author.
- Records in the original file: **1,612,267**.
- Respiratory hospital discharges: **158,319** records with primary diagnosis (`DIAG1`) in ICD-10 range **J00–J99**.
- Of those, **59,727** have `REGION_RESIDENCIA = 13` (Metropolitan Region). This is **region of residence**, not necessarily hospital location or Santiago city.
- Counts reflect **hospital discharges**, not unique patients, disease incidence or all respiratory consultations.
- Unknown/suppressed values (e.g. `*`) are not imputed.

## Files
- `respiratory_egresos_2023_aggregated.csv`: aggregated counts by residence region, age group and sex, prepared from the source dataset; no patient-level rows.
- `health_analysis.R`: reads the aggregated counts, produces age-group and sex summaries, and creates a plot in `outputs/`.

## Reproduce in Posit Cloud
Upload both `respiratory_egresos_2023_aggregated.csv` and `health_analysis.R` to the project root. Open `health_analysis.R`, click **Source**. No extra R packages are needed.

## Critical limitation
The supplied DEIS dataset contains `ANO_EGRESO` but **no month or discharge date**. It cannot support a valid monthly climate–health correlation with the 2023 Open-Meteo temperature series. The climate data represent one reanalysis grid point in Santiago, while health counts cover all Metropolitan Region residents; the geographies also differ. A future association study requires time-resolved health data and aligned geographical coverage, plus appropriate confounder adjustment.

## Processing note
The aggregated CSV was prepared from the original DEIS file using a streaming CSV filter. To keep the public repository lightweight and avoid redistributing patient-level data, the original large source file is not included.
