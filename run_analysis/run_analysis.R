library(dplyr)
library(tidyverse)

creat_data_frame <- function(output) {
     
     ### Load and preprocess training data
     
     # Initialize an empty data frame with the correct number of rows
     train_data <- data.frame(rep(0, 941056))  
     files <- list.files("UCI HAR Dataset/train/Inertial Signals", full.names = TRUE) #produce a character vector of the names of stuff inside the directory.
     
     # Iterate through each file and process its contents
     for(i in 1:length(files)) {
          
          file_path <- files[i] # Get the full file path
          data <- scan(file_path) # Read numeric data from the file
          df <- data.frame(data) # Convert data to a data frame
          
          # Extract file name without extension and use it as the column name
          file_name <- tools::file_path_sans_ext(basename(file_path)) 
          colnames(df) <- file_name 
          
          train_data <- cbind(train_data, df)
     }
     
     # Remove the first column (initial placeholder)
     train_data <- select(train_data, -names(train_data)[1]) 
     
     # Reshape data into a tidy format
     train_data <- train_data %>%
          pivot_longer(
               cols = everything(), # Select all columns to reshape
               names_to = c("sensor_type", "data_type", "axys", "method"), # New column names
               names_pattern = "(body|total)_(acc|gyro)_(x|y|z)_(train)", # Extract components
               values_to = "value"
          )
     
     print("DONE - TRAIN") #---------------------------------------
     
     ### Load and preprocess test data
     
     # Initialize an empty data frame with the correct number of rows
     test_data <- data.frame(rep(0, 377216))  
     files <- list.files("UCI HAR Dataset/test/Inertial Signals", full.names = TRUE) #produce a character vector of the names of stuff inside the directory.
     
     # Iterate through each file and process its contents
     for(i in 1:length(files)) {
          
          file_path <- files[i] #get the path
          data <- scan(file_path) # Read data from file
          df <- data.frame(data) # Convert to data frame
          
          # Extract file name without extension and use it as the column name
          file_name <- tools::file_path_sans_ext(basename(file_path)) #get the name of the file
          colnames(df) <- file_name  # give a temp name to the column, just to identify 
          
          test_data <- cbind(test_data, df)
          
     }
     
     # Remove the first column (initial placeholder)
     test_data <- select(test_data, -names(test_data)[1]) #takes out the first column used just to get the data frame to the correct size
     
     # Reshape data into a tidy format
     test_data <- test_data %>%
          pivot_longer(
               cols = everything(),    #Select all columns to reshape
               names_to = c("sensor_type", "data_type", "axys", "method"),   #New column names
               names_pattern = "(body|total)_(acc|gyro)_(x|y|z)_(test)",  #Extract components
               values_to = "value"
          )
     
     print("DONE - TEST")
     
     # Combine training and test datasets into a single data frame
     main_data <- rbind(train_data, test_data) #join on the same data.frame
     return(list(main_data, train_data, test_data))
}

all <- creat_data_frame()

main_data <- data.frame(all[1])
train_data <- data.frame(all[2])
test_data <- data.frame(all[3])

### Compute the mean and standard deviation for each measurement

mean_data <- main_data %>%
     group_by(sensor_type, data_type, axys, method) %>%
     summarise(mean = mean(value))

deviation_data <- main_data %>%
     group_by(sensor_type, data_type, axys, method) %>%
     summarise(SD = sd(value))

mesures_data <- merge(mean_data, deviation_data, by = c("sensor_type", "data_type", "axys", "method")) #merge them together 

### Final aggregated calculations

# Compute the mean of means for each method and data type
final_data <- mesures_data %>%
     group_by(method, data_type) %>%
     summarise(mean = mean(mean))

# Print sample outputs
print(head(main_data))
print(head(mesures_data))
print(head(final_data))

