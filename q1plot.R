#Data Load

summary <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

#Question 1:  Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

q1 <- as.data.frame(cbind(summary$Emissions, summary$year))
colnames(q1) <- c('Emissions','Year')
q1agg <- aggregate(x = q1$Emissions, by = list(unique.values = q1$Year), FUN = sum)
colnames(q1agg) <- c('Year','Total Emissions')

plot(q1agg, type = 'o', main = "PM2.5 Emissions in the United States - 1999 to 2008", col = "blue")

dev.copy(png,'q1plot.png')
dev.off()