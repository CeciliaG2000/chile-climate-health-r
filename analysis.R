# Chile Climate & Health: Phase 1 - Climate data exploration
# Author: Cecilia Gutierrez Galindo (learning project)
# Source: Open-Meteo Historical Weather API (ERA5 reanalysis)
# Run with: Rscript analysis.R

url <- paste0(
  'https://archive-api.open-meteo.com/v1/archive?',
  'latitude=-33.45&longitude=-70.67',
  '&start_date=2023-01-01&end_date=2023-12-31',
  '&daily=temperature_2m_max,temperature_2m_min,precipitation_sum',
  '&timezone=America%2FSantiago&models=era5'
)

if (!requireNamespace('jsonlite', quietly = TRUE)) {
  stop('Install jsonlite first: install.packages("jsonlite")')
}

weather <- jsonlite::fromJSON(url)$daily
stopifnot(!is.null(weather), length(weather$time) > 0)
data <- data.frame(
  date = as.Date(weather$time),
  max_temp_c = as.numeric(weather$temperature_2m_max),
  min_temp_c = as.numeric(weather$temperature_2m_min),
  precipitation_mm = as.numeric(weather$precipitation_sum)
)
data$month <- format(data$date, '%Y-%m')
data$hot_day_30c <- !is.na(data$max_temp_c) & data$max_temp_c >= 30

monthly <- aggregate(cbind(max_temp_c, min_temp_c, precipitation_mm) ~ month,
                     data = data, FUN = mean)
names(monthly)[names(monthly) == 'precipitation_mm'] <- 'mean_daily_precipitation_mm'
monthly$rainfall_total_mm <- as.numeric(tapply(data$precipitation_mm, data$month, sum, na.rm=TRUE)[monthly$month])
monthly$hot_days_30c <- as.integer(tapply(data$hot_day_30c, data$month, sum)[monthly$month])

 dir.create('outputs', showWarnings = FALSE)
write.csv(data, 'outputs/santiago_daily_2023.csv', row.names = FALSE)
write.csv(monthly, 'outputs/santiago_monthly_2023.csv', row.names = FALSE)

png('outputs/monthly_temperature.png', width=1100, height=650)
plot(seq_len(nrow(monthly)), monthly$max_temp_c, type='b', pch=19,
     xaxt='n', xlab='Month (2023)', ylab='Mean daily maximum temperature (C)',
     main='Santiago: monthly average of daily maximum temperature')
axis(1, at=seq_len(nrow(monthly)), labels=monthly$month, las=2, cex.axis=0.8)
dev.off()

png('outputs/daily_temperature.png', width=1100, height=650)
plot(data$date, data$max_temp_c, type='l',
     xlab='Date', ylab='Daily maximum temperature (C)',
     main='Santiago: daily maximum temperature in 2023')
abline(h=30, lty=2)
dev.off()

cat('Days:', nrow(data), '\n')
cat('Days with max temperature >=30 C:', sum(data$hot_day_30c), '\n')
cat('Missing max temperatures:', sum(is.na(data$max_temp_c)), '\n')
cat('Outputs written to outputs/\n')
