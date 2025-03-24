# Analysis of Hospital Quality Data in the United States

This project analyzes hospital quality data from the Hospital Compare database, managed by the U.S. Department of Health and Human Services. The dataset includes mortality and readmission rates for heart attack, heart failure, and pneumonia across over 4,000 Medicare-certified hospitals.

Link to the data use on this project -> https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip

## Function 'best'

Finds the best hospital in a given state based on the lowest 30-day mortality rate for a specified outcome.

#### Use example:

  ```
  best("MD", "pneumonia")
  best("TX", "heart attack")
  ```
## Function 'rankhospital'

Finds the hospital in a given state that ranks at a specified position for a given outcome. The ranking can be numeric (e.g., 5th best) or "best"/"worst".

#### Use example:

  ```
  ankhospital("TX", "heart failure", 4)
  rankhospital("MD", "heart attack", "worst")
  ```
## Function 'rankall'

Ranks hospitals nationwide based on a given outcome. It returns a data frame containing the top-ranked hospital for each state.

#### Use example:

  ```
  head(rankall("heart attack", 20), 10)
  tail(rankall("heart failure"), 10)
  ```
