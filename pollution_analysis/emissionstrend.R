library(dplyr)
library(ggplot2)
library(stringr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#FIRST PLOT -----
polluent <- NEI %>%
     group_by(year) %>%
     summarise(total = sum(Emissions, na.rm = TRUE))

g1 <- ggplot(polluent, aes(x = year, y = total)) +
     geom_point(size = 4, pch=19) +
     labs(title = "Evolution of Emissions", 
          x = "Year", y = "Total Pollutant Emissions")


#SECOND PLOT -----

polluent_Baltimore <- NEI %>%
     group_by(year) %>%
     filter(fips == "24510") %>%
     summarise(total = sum(Emissions, na.rm = TRUE))

g2 <- ggplot(polluent_Baltimore, aes(x = year, y = total)) +
     geom_point(size = 4, pch=19) +
     labs(title = "Evolution of Emissions on Baltimore City", 
          x = "Year", y = "Total Pollutant Emissions")


#THIRD PLOT -----

polluent_Type <- NEI %>%
     group_by(year, type) %>%
     filter(fips == "24510") %>%
     summarise(total = sum(Emissions, na.rm = TRUE))

g3 <- ggplot(polluent_Type, aes(x = year, y = total, color=type)) +
     geom_point(size = 4) +
     labs(title = "Evolution of the Pollutant Type in Baltimore City", 
          x = "Year", y = "Total", color = "Pollutant Type")


#FOURTH PLOT -----

# Extracting the text after the last "-"
SCC <- SCC %>%
     #group_by(SCC) %>%
     mutate(Fuel_Type = str_extract(EI.Sector, "[^-]+$"))

# Add to NEI a column with the type of fuel taking the SCC

NEI <- NEI %>%
     left_join(SCC %>% select(SCC, Fuel_Type), by = "SCC")

Coal <- NEI %>%
     group_by(year) %>%
     filter(Fuel_Type == " Coal") %>%
     summarise(total = sum(Emissions, na.rm = TRUE))

g4 <- ggplot(Coal, aes(x = year, y = total)) +
     geom_point(size = 4) +
     labs(title = "Evolution of the Coal Combustion Related Sources", 
          x = "Year", y = "Total")


#FIFTH PLOT -----
Motor_Baltimore  <- NEI %>%
     group_by(year) %>%
     filter(fips == "24510" & (Fuel_Type=="Road Gasoline Heavy Duty Vehicles" | Fuel_Type=="Road Diesel Heavy Duty Vehicles" | Fuel_Type=="Road Gasoline Light Duty Vehicles" | Fuel_Type=="Road Diesel Light Duty Vehicles" )) %>%
     summarise(total = sum(Emissions, na.rm = TRUE))

Motor_LosAngeles  <- NEI %>%
     group_by(year) %>%
     filter(fips == "06037" & (Fuel_Type=="Road Gasoline Heavy Duty Vehicles" | Fuel_Type=="Road Diesel Heavy Duty Vehicles" | Fuel_Type=="Road Gasoline Light Duty Vehicles" | Fuel_Type=="Road Diesel Light Duty Vehicles" )) %>%
     summarise(total = sum(Emissions, na.rm = TRUE))

#join into just one and add a id 
Motor_Combined <- bind_rows(
     Motor_Baltimore %>% mutate(City = "Balt"),
     Motor_LosAngeles %>% mutate(City = "LA")
)

g5 <- ggplot(Motor_Baltimore, aes(x = year, y = total)) +
     geom_point(size = 4) +
     labs(title = "Evolution of the Motor Vehicle Related Sources in Baltimore City", 
          x = "Year", y = "Total")

g6 <- ggplot(Motor_LosAngeles, aes(x = year, y = total)) +
     geom_point(size = 4) +
     labs(title = "Evolution of the Motor Vehicle Related Sources in Los Angeles", 
          x = "Year", y = "Total")

g7 <- ggplot(Motor_Combined, aes(x = year, y = total, colour = City)) +
     geom_point(size = 4, pch=19) +
     labs(title = "Evolution of the Motor Vehicle Related Sources", 
          x = "Year", y = "Total")





