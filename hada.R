#BOTS OR HUMANS
#Akshay Goel; Hiro Sayama; Abhik Ghosh; Daphne Chui

##################################################################################################

#  Run on new computer or environment

# update.packages()

# install.packages("glmmLasso")

#Citation: Hlavac, Marek (2015). stargazer: Well-Formatted Regression and Summary Statistics Tables. R package version 5.2. http://CRAN.R-project.org/package=stargazer
# install.packages("stargazer")  

# install.packages("knitr", repos = "http://lib.stat.cmu.edu/R/CRAN/")

# install.packages("R2HTML")

##################################################################################################

#This will set the directory
BASE_DIRECTORY = getwd()

#This will read the trainer data
TRAIN_CSV = "train.csv"
print(paste("# Loading training data ", TRAIN_CSV," ...", sep=""))
TRAIN_DATA = read.csv(paste(BASE_DIRECTORY, TRAIN_CSV, sep="/"),stringsAsFactors = TRUE, na.strings = c("NA", ""))
#Save original data format for reference
write.table(head(TRAIN_DATA), file = "TrainerData_Orignal.txt")

#Print data
print(paste("# Printing training data  ...", sep=""))

print(TRAIN_DATA)


#Print data
print(paste("# Preparing training data  ...", sep=""))
  
##################################################################################################
    TRAIN_DATA$bid_id = as.numeric(TRAIN_DATA$bid_id)
    
    allBidders <- unique(TRAIN_DATA$bidder_id)
    numMap <- 1:length(allBidders)
    names(numMap) <- allBidders
    TRAIN_DATA$bidder_id <- numMap[TRAIN_DATA$bidder_id]
    TRAIN_DATA$bidder_id <- numMap[TRAIN_DATA$bidder_id]
    
    allAuctions <- unique(TRAIN_DATA$auction)
    numMap <- 1:length(allAuctions)
    names(numMap) <- allAuctions
    TRAIN_DATA$auction <- numMap[TRAIN_DATA$auction]
    TRAIN_DATA$auction <- numMap[TRAIN_DATA$auction]
    
    allMerchandise <- unique(TRAIN_DATA$merchandise)
    numMap <- 1:length(allMerchandise)
    names(numMap) <- allMerchandise
    TRAIN_DATA$merchandise <- numMap[TRAIN_DATA$merchandise]
    TRAIN_DATA$merchandise <- numMap[TRAIN_DATA$merchandise]
    
    allDevices <- unique(TRAIN_DATA$device)
    numMap <- 1:length(allDevices)
    names(numMap) <- allDevices
    TRAIN_DATA$device <- numMap[TRAIN_DATA$device]
    TRAIN_DATA$device <- numMap[TRAIN_DATA$device]
    
    allTimes <- unique(TRAIN_DATA$time)
    numMap <- 1:length(allTimes)
    names(numMap) <- allTimes
    TRAIN_DATA$time <- numMap[TRAIN_DATA$time]
    TRAIN_DATA$time <- numMap[TRAIN_DATA$time]
    
    allCountries <- unique(TRAIN_DATA$country)
    numMap <- 1:length(allCountries)
    names(numMap) <- allCountries
    TRAIN_DATA$country <- numMap[TRAIN_DATA$country]
    TRAIN_DATA$country <- numMap[TRAIN_DATA$country]
    
    allIPs <- unique(TRAIN_DATA$ip)
    numMap <- 1:length(allIPs)
    names(numMap) <- allIPs
    TRAIN_DATA$ip <- numMap[TRAIN_DATA$ip]
    TRAIN_DATA$ip <- numMap[TRAIN_DATA$ip]
    
    allURLS <- unique(TRAIN_DATA$url)
    numMap <- 1:length(allURLS)
    names(numMap) <- allURLS
    TRAIN_DATA$url <- numMap[TRAIN_DATA$url]
    TRAIN_DATA$url <- numMap[TRAIN_DATA$url]

#Clean the Data.....
droplevels.data.frame(TRAIN_DATA)
print(paste("# Data is now prepared in numeric format  ...", sep=""))

#Save prepared data format for print
write.table(head(TRAIN_DATA), file = "TrainerData_Prepared.txt")


####################################################################################

mylogit <- glm(outcome ~ bid_id + bidder_id + auction + merchandise + device + time + country + ip + url, data = TRAIN_DATA, family = "binomial")

summary(mylogit)


## CIs using profiled log-likelihood
confint(mylogit)

## CIs using standard errors
confint.default(mylogit)


## Prepare Test Data


#This will read the Test data
BID_CSV = "bids.csv"
print(paste("# Loading test data ", BID_CSV," ...", sep=""))
BID_DATA = read.csv(paste(BASE_DIRECTORY, BID_CSV, sep="/"),stringsAsFactors = TRUE, na.strings = c("NA", ""))

BID_DATA$bid_id = as.numeric(BID_DATA$bid_id)

allBidders <- unique(BID_DATA$bidder_id)
numMap <- 1:length(allBidders)
names(numMap) <- allBidders
BID_DATA$bidder_id <- numMap[BID_DATA$bidder_id]
BID_DATA$bidder_id <- numMap[BID_DATA$bidder_id]

allAuctions <- unique(BID_DATA$auction)
numMap <- 1:length(allAuctions)
names(numMap) <- allAuctions
BID_DATA$auction <- numMap[BID_DATA$auction]
BID_DATA$auction <- numMap[BID_DATA$auction]

allMerchandise <- unique(BID_DATA$merchandise)
numMap <- 1:length(allMerchandise)
names(numMap) <- allMerchandise
BID_DATA$merchandise <- numMap[BID_DATA$merchandise]
BID_DATA$merchandise <- numMap[BID_DATA$merchandise]

allDevices <- unique(BID_DATA$device)
numMap <- 1:length(allDevices)
names(numMap) <- allDevices
BID_DATA$device <- numMap[BID_DATA$device]
BID_DATA$device <- numMap[BID_DATA$device]

allTimes <- unique(BID_DATA$time)
numMap <- 1:length(allTimes)
names(numMap) <- allTimes
BID_DATA$time <- numMap[BID_DATA$time]
BID_DATA$time <- numMap[BID_DATA$time]

allCountries <- unique(BID_DATA$country)
numMap <- 1:length(allCountries)
names(numMap) <- allCountries
BID_DATA$country <- numMap[BID_DATA$country]
BID_DATA$country <- numMap[BID_DATA$country]

allIPs <- unique(BID_DATA$ip)
numMap <- 1:length(allIPs)
names(numMap) <- allIPs
BID_DATA$ip <- numMap[BID_DATA$ip]
BID_DATA$ip <- numMap[BID_DATA$ip]

allURLS <- unique(BID_DATA$url)
numMap <- 1:length(allURLS)
names(numMap) <- allURLS
BID_DATA$url <- numMap[BID_DATA$url]
BID_DATA$url <- numMap[BID_DATA$url]

#Clean the Data.....
droplevels.data.frame(BID_DATA)
print(paste("# Test Data is now prepared in numeric format  ...", sep=""))

################################################################################

#Predict Outcome for Test Data using the Regression Model.... 

BID_DATA$outcome <- predict(mylogit, newdata = BID_DATA, type = "response")
droplevels.data.frame(BID_DATA)
BID_DATA$outcome <- (round(BID_DATA$outcome))

print(BID_DATA)

################################################################################

print(paste("# Number of Humans (0) and Bots(1)", sep=""))
summary.factor(BID_DATA$outcome)
results_from_model1 = summary.factor(BID_DATA$outcome)


library(stargazer)

stargazer(TRAIN_DATA, type = "text", title="Descriptive Statistics for Trainer Data", digits=1, out="table1.htm", flip=TRUE)
stargazer(BID_DATA, type = "text", title="Descriptive Statistics for Test Data", digits=1, out="table2.htm", flip=TRUE)



#Alternative Regression Models###########################################################################################

mylogit_1 <- glm(outcome ~ bid_id + bidder_id + auction + merchandise + device + time + country + ip + url, data = TRAIN_DATA, family = "binomial")
mylogit_2 <- glm(outcome ~ bidder_id + auction + merchandise + device + time + country + ip + url, data = TRAIN_DATA, family = "binomial")

stargazer(mylogit_1,mylogit_2,  type="html", title="Descriptive Statistics for Trainer Data", out="models.htm", flip=TRUE)

################################################################################

#Predict Outcome for Test Data using alternative Regression Model.... 

BID_DATA$outcome <- predict(mylogit_2, newdata = BID_DATA, type = "response")
droplevels.data.frame(BID_DATA)
BID_DATA$outcome <- (round(BID_DATA$outcome))

print(BID_DATA)

################################################################################

print(paste("# Number of Humans (0) and Bots(1)", sep=""))
summary.factor(BID_DATA$outcome)
results_from_model2 = summary.factor(BID_DATA$outcome)

print("Results from first Regression Model")
results_from_model1

write.table(results_from_model1, file = "Result1.txt")

print("Results from second Regression Model")
results_from_model2

write.table(results_from_model2, file = "Result2.txt")
