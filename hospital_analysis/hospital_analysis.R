

#-----------------------------------#

best <- function(state, outcome) {
     
     #Read data
     data <- read.csv("ProgrammingAssignment3/outcome-of-care-measures.csv")
     
     #Check if the input
     States <- unique(data[,7])
     possible_outcome <- c("heart attack", "heart failure", "pneumonia")
     if (!(state %in% States)) {
          stop("invalid state")
     }
     
     if (!(outcome %in% possible_outcome)) {
          stop("invalid outcome") 
     }
     
     #Get the values 
     if (outcome=="heart attack") {
          col <- 11
     } else if(outcome=="heart failure") {
          col <- 17
     } else if(outcome=="pneumonia") {
          col <- 23
     }
     
     #DataSet of the specific state
     state_data <- data[data$State == state, ] 
     
     #Get the values 
     outcome_values <- as.numeric(state_data[, col])
     hospital_names <- state_data[, 2]

     index <- which.min(outcome_values)
     top_hospital <- hospital_names[index]

     top_hospital
     
}

#------------------------------------#

rankhospital <- function(state, outcome, num=1) {
     
     #Read data
     data <- read.csv("ProgrammingAssignment3/outcome-of-care-measures.csv")
     
     #Check if the input is valid
     States <- unique(data[,7])
     possible_outcome <- c("heart attack", "heart failure", "pneumonia")
     if (!(state %in% States)) {
          stop("invalid state")
     }
     
     if (!(outcome %in% possible_outcome)) {
          stop("invalid outcome") 
     }
     
     #Get the meainng of the output 
     if (outcome=="heart attack") {
          col <- 11
     } else if(outcome=="heart failure") {
          col <- 17
     } else if(outcome=="pneumonia") {
          col <- 23
     }
     
     #DataSet of the specific state
     state_data <- data[data$State == state, ] 
     outcome_values <- state_data[,col]
     hospital_names <- state_data[, 2]
     
     #Transform the data to numeric
     outcome_values <- as.numeric(state_data[,col])
     
     #Order the value of the outcomes, in case of tie use the hospital_names
     #na.last=Na take out all the NA
     ranking <- order(outcome_values, hospital_names, na.last = NA)
     ranking_names <- hospital_names[ranking]
 
     #Compute the right return depending on num
     if(num == "worst") {
          return(ranking_names[length(ranking_names)])
     } else if (num == "best") {
          return(ranking_names[1])
     } else if (num>0 & num<length(ranking_names)) {
          return(ranking_names[num])
     } else {
          return(NA)
     }
     
}

#-----------------------------------#

#Auxiliary function
aux <- function(data, state, col) {
     
     #DataSet of the specific state
     state_data <- data[data$State == state, ] 
     outcome_values <- state_data[,col]
     hospital_names <- state_data[, 2]
     
     #Transform the data to numeric
     outcome_values <- as.numeric(state_data[,col])
     
     #Order the value of the outcomes, in case of tie use the hospital_names
     #na.last=Na take out all the NA
     ranking <- order(outcome_values, hospital_names, na.last = NA)
     ranking_names <- hospital_names[ranking]
     
     return(ranking_names)
     
}
 
rankall <- function(outcome, num=1) {
     
     #Read data
     data <- read.csv("ProgrammingAssignment3/outcome-of-care-measures.csv")
     final_hospital <- c()
     final_state <- c()
     
     #Check if the input is valid
     possible_outcome <- c("heart attack", "heart failure", "pneumonia")
     if (!(outcome %in% possible_outcome)) {
          stop("invalid outcome") 
     }
     
     #Get the meaning of the output 
     if (outcome=="heart attack") {
          col <- 11
     } else if(outcome=="heart failure") {
          col <- 17
     } else if(outcome=="pneumonia") {
          col <- 23
     }
     
     #the sort is just to alphabetic order
     States <- sort(unique(data[,7]))

     for(i in States) {
          
          ranking_names <- aux(data, i, col)
          
          if(num == "worst") {
               final_hospital <- c(final_hospital, ranking_names[length(ranking_names)]) 
          } else if (num == "best") {
               final_hospital <- c(final_hospital, ranking_names[1]) 
          } else if (num>0 & num<length(ranking_names)) {
               final_hospital <- c(final_hospital, ranking_names[num])  
          } else {
               final_hospital <- c(final_hospital, NA)
          }
          
          final_state <- c(final_state, i)
     }
     
     list_final <- data.frame("hospital"=final_hospital, "state"=final_state)
     return(list_final)

}
