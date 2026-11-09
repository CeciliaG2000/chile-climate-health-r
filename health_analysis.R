# Chile Climate & Health - Phase 2: respiratory hospital discharges, 2023
# Author: Cecilia Gutierrez Galindo - learning project
# Data: Chile DEIS, EGRESOS_2023.csv (aggregated, anonymized counts)
# This is a DESCRIPTIVE analysis; no monthly health data or climate-health correlation.

input <- 'respiratory_egresos_2023_aggregated.csv'
stopifnot(file.exists(input))
d <- read.csv(input, fileEncoding = 'UTF-8', stringsAsFactors = FALSE)
stopifnot(all(c('region_code','age_group','sex','n_discharges') %in% names(d)))
stopifnot(sum(d$n_discharges) == 158319)
rm <- d[d$region_code == '13', ]
cat('Respiratory discharges nationwide:', sum(d$n_discharges), '\n')
cat('Respiratory discharges, Metropolitan Region residents:', sum(rm$n_discharges), '\n')
cat('Note: unknown/suppressed region values are not allocated to RM.\n')

if (!dir.exists('outputs')) dir.create('outputs')
by_age <- aggregate(n_discharges ~ age_group, rm, sum)
by_age <- by_age[order(-by_age$n_discharges), ]
write.csv(by_age, 'outputs/rm_respiratory_by_age_2023.csv', row.names = FALSE)

png('outputs/rm_respiratory_by_age_2023.png', width = 1200, height = 850, res = 125)
par(mar=c(5, 11, 4, 2))
barplot(rev(by_age$n_discharges), names.arg=rev(by_age$age_group),
        horiz=TRUE, las=1, cex.names=0.85,
        main='Respiratory hospital discharges by age group\nMetropolitan Region residents, 2023',
        xlab='Number of hospital discharges')
dev.off()

by_sex <- aggregate(n_discharges ~ sex, rm, sum)
write.csv(by_sex, 'outputs/rm_respiratory_by_sex_2023.csv', row.names=FALSE)
cat('Files created in outputs/\n')
