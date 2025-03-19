Analysis of pollution monitoring data for fine particulate matter (PM) air pollution across 332 locations in the United States.

Link to the data use on this project -> https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip

## Function 'pollutantmean' 
Calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. 
#### Use example:

  ```
  pollutantmean("specdata", "sulfate", 1:10)
  pollutantmean("specdata", "nitrate", 23)
  ```
 
## Function 'complete' 
Reads a directory full of files and reports the number of completely observed cases (cases where there is a mesurement of sulfate and nitrate) in each data file. The function return a data frame where the first column is the name of the file and the second column is the number of complete cases.
#### Use example:

  ```
  complete("specdata", c(2, 4, 8, 10, 12))
  complete("specdata", 30:25)
  ```

## Function 'corr' 
Takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases is greater than the threshold. The function return a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0.
#### Use example:

  ```
  cr <- corr("specdata", 150)
  head(cr)
  summary(cr)
  ```
