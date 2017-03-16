library(ggplot2)

#Data Load

summary <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

q5 <- summary[ which(summary$fips == "24510"), ]
q5 <- q5[which(q5$type == 'ON-ROAD'), ]
q5agg <- aggregate(x = q5$Emissions, by = list(unique.values = q5$year), FUN = sum)
colnames(q5agg) <- c('Year', 'Emissions')


q5plot <- ggplot(data=q5agg, aes(x=Year, y=Emissions, group=1)) + 
  labs(title = "Vehicle Sourced PM2.5 Emissions in Baltimore City - 1999 to 2008") + 
  geom_line(colour="blue")

q5plot

dev.copy(png,'q5plot.png')
dev.off()
