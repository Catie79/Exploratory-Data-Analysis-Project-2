library(ggplot2)

#Data Load

summary <- readRDS('summarySCC_PM25.rds')
codes <- readRDS('Source_Classification_Code.rds')

#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

q4 <- data.frame (summary$SCC, summary$Emissions, summary$year)
colnames(q4)<- c('SCC', 'Emissions', 'Year')
q4codes <- data.frame(codes$SCC, codes$EI.Sector)
colnames(q4codes) <- c('SCC','EI.Sector')

q4all <- merge(x = q4, y = q4codes)
q4coal <- q4all[ which(q4all$EI.Sector == "Fuel Comb - Electric Generation - Coal"), ]
q4agg <- aggregate(x = q4coal$Emissions, by = list(unique.values = q4coal$Year), FUN = sum)
colnames(q4agg) <- c('Year', 'Emissions')
q4agg$Year <- as.factor(q4agg$Year)

q4plot <- ggplot(data=q4agg, aes(x=Year, y=Emissions, group=1)) + 
  labs(title = "PM2.5 Emissions from Coal Combustion Related Sources in United States - 1999 to 2008") +
  geom_bar(stat = "identity", color="blue", fill="blue")

q4plot

dev.copy(png,'q4plot.png')
dev.off()
