#Data Load

summary <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

q2 <- summary[ which(summary$fips == "24510"), ]
q2 <- as.data.frame(cbind(q2$Emissions, q2$year))
colnames(q2) <- c('Emissions','Year')
q2agg <- aggregate(x = q2$Emissions, by = list(unique.values = q2$Year), FUN = sum)
colnames(q2agg$Emissions) <- c('Year', 'Emissions')

barplot(q2agg$Emissions, names.arg = c(1999, 2002, 2005, 2008), ylab = "Emissions", xlab = "Year", main = "PM2.5 Emissions for Baltimore City - 1999 to 2008", col = "blue")

dev.copy(png,'q2plot.png')
dev.off()

