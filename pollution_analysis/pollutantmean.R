pollutantmean <- function(directory, pollutant, id=1:332) {
     
     final_sum <- rep(0, each=length(id))
     final_length <- rep(0, each=length(id))
     o<-1
     
     for(i in id) {
          
          #format part
          id_final <- sprintf("%03d", i) #force to always have at least the hundreds and the tens placed
          dir <- paste(directory, "/", id_final, ".csv",  sep="")
          
          #get the data and clean the NA
          data <- read.csv(dir)
          total_polu_NA <- data[[pollutant]] #we can not use data$pollutant because it will try to search for a column with the name "pollutant"
          total_polu <- total_polu_NA[!is.na(total_polu_NA)]
          
          final_sum[o]<-sum(total_polu)
          final_length[o]<-length(total_polu)
          o<-o+1
     }
     
     sum(final_sum)/sum(final_length)
}


complete <- function(directory, id = 1:332) {
     
     final_nods <- rep(0, each=length(id))
     o<-1
     
     for(i in id) {
          
          #format part
          id_final <- sprintf("%03d", i) #force to always have at least the hundreds and the tens placed
          dir <- paste(directory, "/", id_final, ".csv",  sep="")
          
          #get the data and clean the NA
          data <- read.csv(dir)
          first  <- data[["sulfate"]]
          second <- data[["nitrate"]]
          
          nobs <- 0
          for(pi in 1:length(first))
               
               if (!is.na(first[pi]) & !is.na(second[pi])) {
                    
                    nobs <- nobs + 1
               }
          final_nods[o] <- nobs
          o<-o+1
     }
     
     #creat the matrix to return
     m <- cbind(id, final_nods)
     colnames(m)<-c("id", "nobs") 
     
     #return
     m
}


#on this code we could use the above function to simplify 
corr <- function(directory, threshold=0) {
     
     final_nods <- rep(0, each=length(list.files(directory)))
     cor_final <- c()
     o<-1
     
     #go in each file
     for(i in 1:length(list.files(directory))) { #with length(list.files(directory)) we can see how many files are inside the directory
          
          dir <- paste(directory, "/", list.files("specdata")[i],  sep="")
          
          #get the data and clean the NA
          data <- read.csv(dir)
          first  <- data[["sulfate"]]
          second <- data[["nitrate"]]
          
          nobs <- 0
          positions <- c()
          
          #go on each row
          for(pi in 1:length(first)) {
               
               #see if is a completely observed case 
               if (!is.na(first[pi]) & !is.na(second[pi])) {
                    
                    positions <- c(positions, pi) #get the position of the row that are completely observed case
                    nobs <- nobs + 1
                    
               }
          }
          
          final_nods[o] <- nobs
          
          if (final_nods[o] >= threshold) {
               
               cor_final<-c(cor_final, cor(first[positions], second[positions]))
               
          }
          
          o<-o+1
          
          }
     #the output
     if (length(cor_final)>0) {
          cor_final
     } else {
          numeric(0)
     }
}
     
     
