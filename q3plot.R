library(ggplot2)

#Data Load

summary <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

q3 <- summary[ which(summary$fips == "24510"), ]
q3 <- as.data.frame(cbind(q3$Emissions, q3$year, q3$type))
colnames(q3) <- c('Emissions','Year', 'Type')
q3$Emissions <- as.numeric(q3$Emissions)
q3agg <- aggregate(x = q3$Emissions, by = list(unique.values=q3$Type, unique.values = q3$Year ), FUN = sum)
colnames(q3agg) <- c('Type','Year','Emissions')

q3plot <- ggplot(data=q3agg, aes(x=Year, y=Emissions, group=Type, colour=Type)) + 
  labs(title = "PM2.5 Emissions by Source for Balitmore City - 1999 to 2008") +
  geom_line()

q3plot

dev.copy(png,'q3plot.png')
dev.off()