library(ggplot2)

#Data Load

summary <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

Baltimore <- summary[which(summary$fips == '24510'),]
LosAngeles <- summary[which(summary$fips == '06037'),]

Baltimore$City <- rep('Baltimore', nrow(Baltimore))
LosAngeles$City <- rep('Los Angeles', nrow(LosAngeles))

q6 <- rbind(Baltimore, LosAngeles)
q6 <- q6[which(q6$type == 'ON-ROAD'),]
q6agg <- aggregate(x = q6$Emissions, by = list(unique.values = q6$City, unique.values = q6$year), FUN = sum)
colnames(q6agg) <- c('City','Year', 'Emissions')

q6plot <- ggplot(data=q6agg, aes(x=Year, y=Emissions, group=City, color=City)) + 
  labs(title = "Vehicle Sourced PM2.5 Emissions for Baltimore City and Los Angeles - 1999 to 2008") +
  geom_line()

q6plot

dev.copy(png,'q6plot.png')
dev.off()