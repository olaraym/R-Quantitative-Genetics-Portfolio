##### ExpDes R - Practice 01  #####
## simple calculations
## simple functions
## generating data
## referring to parts of data
## data import, export
## simple data management (subsetting, adding filtering, merging)
## missing values

## CTRL + Enter --> Run a line/command
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
## BASICS ####
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## . Simple calculations ####
3+6
4+6
7-4
5*7
10/2.5
5^3
(2+3)*(8-9)
## square root 
16^(3/2)
sqrt(16)

## Note: R is case sensitive!!!!!

## . Use simple functions ####
sum(1,6,2,8)
mean(1,6,2,8) ##INCORRECT!!! see later why
mean(x=c(1,6,2,8))##CORRECT

## . Help: ? + name of an available function ####
?mean()
prod(1,6,2,8)

## . Specifying arguments by name/position ####
log(x=100, base=10)
log(base=10, x=100)

# specifying arguments by position: be careful!! 
# here the order of the position is important!!!!
log(100, 10)
log(10, 100)
log(8, 2)

# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## OUR FIRST DATA ####
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## . Define a simple data element ####
(a <- 2)
a <- 2; a

## . Creating vectors ####
# The c() function combines values of common type together to form a vector
v1 <- c(1, 3, 5)

# length() returns the number of elements
char_vec <- c("these", "are", "some", "words")
length(char_vec)

# the result of this comparison is a logical vector
v1 > c(2, 2, 2)

# To create vectors with a predictable sequence of elements, 
# use rep() for repeating elements and seq() for sequential elements.
# The expression m:n will generate a vector of integers from m to n

# first argument to rep is what to repeat
# the second argument is number of repetitions
rep(0, times=3)
rep("abc", 4)

s1 <- rep(0, times=3)
s2 <- rep("abc", 4)

# arguments for seq are from, to, by
seq(from=1, to=5, by=2)
seq(10, 0, -5)

# colon operator: from... to
3:7

# you can nest functions
rep(seq(1,3,1), times=2)

## . Subsetting vectors with [] ####
# create a vector 10 to 1
# putting () around a command will cause the result to be printed
(a <- seq(10,1,-1))

# second element
a[2]

# first 5 elements
a[seq(1,5)]

# first, third, and fourth elements
a[c(1,3,4)]

## . Conditional selection - subsetting by value
# Vector elements can also be subset with a logical (TRUE/FALSE) vector, 
# known as logical subsetting.
scores <- c(55, 24, 43, 10)
scores[c(TRUE, TRUE, TRUE, FALSE)]
scores < 30

# we can use relation sign to define a subset
scores[scores<30]

## . Set working directory ####
setwd("C:/Users/Marti/Google Drive/DOK/Marti_DATENBANK/ExpDes_R/Data")

## . Reading in csv files ####
# Use read.csv() to read in data stored as .csv 
data <- read.csv("/path/to/file.csv") # not run
dat <- read.csv("Petunia.csv")

## . Exporting data ####
# We can export our data to a .csv file with write.csv().
# write a csv file
write.csv(dataname, file = "path/to/save/filename.csv") # not run
write.csv(dat, "myPetunia.csv")

# save these objects to an .Rdata file
save(dat, file= "Petunia.Rdata")

# read again the saved data
myPet <- get(load(file="Petunia.RData"))

## . Data Frames ####
# Viewing data as a spreadsheet with View(), head() and tail()
View(Pet)

# For large data files, use head() and tail() to look at a specified number of rows
# first 2 rows
head(dat, 2)
tail(dat, 8)

## . Structure of the data set ####
# Use str(), to see the structure of the object, including its class and the data types of elements.
str(dat)

## . Subsetting data frames ####
# subset with matrix notation [rows, columns].
# Omitting rows or columns specifies all rows and columns, respectively.
# use data.frame() to create a data frame manually
mydata <- data.frame(Treatment=c("Control", "Trtm1", "Trtm2"),
                     pH=c(3.5, 3.7,3.9),
                     Infected=c(TRUE, FALSE, FALSE))

# row 3 column 2
mydata[3,2]

# first two rows of column pH
mydata[1:2, "pH"]
mydata[1:2, 2]

# all rows of column infected
mydata[,"Infected"]

# Variables, or columns, of a data frame can be selected with the $ operator, and the resulting object is a vector.
# We can further subset elements of the selected column vector using [].
# subsetting creates a numeric vector
mydata$pH

# just the second and third elements
mydata$pH[2:3]

# Extract the 2nd, 5th, and 10th rows of the variable leafarea in the Pet data set.
dat$leafarea
dat$leafarea[c(2,5,10)]
dat[c(2,5,10),6]

## . Naming data frame columns ####
# colnames(data_frame) returns the column names of data_frame (or matrix).
# colnames(data_frame) <- c("some", "names") assigns column names to data_frame.
# get column names
colnames(mydata)

# assign column names (shorting them)
colnames(mydata) <- c("Trtm", "pH", "Inf")
colnames(mydata)

# to change one variable name, just use vector indexing
colnames(mydata)[3] <- "Symptomatic"
colnames(mydata)

## . Examining the dimention of an object ####
# Use dim() on two-dimensional objects to get the number of rows and columns.
# number of rows and columns
dim(mydata)
str(mydata)
str(dim(mydata))

## . Adding new variables to the data frame ####
# Trying to add a column of the wrong length will result in an error.
# this will add a column variable

myPet$logHeight <- log(myPet$height)

# now we see logHeight as a column in mydata
colnames(myPet)

# mydata has 3 rows, and the rep vector has 5
mydata$z <- rep(0, 5) # error!
## Error in `$<-.data.frame`(`*tmp*`, z, value = c(0, 0, 0, 0, 0)): replacement has 5 rows, data has 3

## DATA MANAGEMENT ####
# e.g.:	Cut the data set down to only those observations (rows) and variables (columns) needed for analysis
# Combining data sets
# Make sure variable values are free of errors, such as impossible values or numeric codes for missing values
# The package dplyr contains several easy-to-use data management functions that we will learn to use to manage our data.
# Load packages for this section 
install.packages("packagename") # not run
library("packagename") #not run
library(dplyr)

## .  Subsetting rows of a data frame with filter() ####
# filter() will subset the rows (observations) of a data frame according to some condition 
# creating some data manually
dog_data <- data.frame(id = c("Duke", "Lucy", "Buddy", "Daisy", "Bear", "Stella"),
                       weight = c(25, 12, 58, 67, 33, 9),
                       sex=c("M", "F", "M", "F", "M", "F"),
                       location=c("north", "west", "north", "south", "west", "west"))
str(dog_data)
library(dplyr)
# dogs weighing more than 40
filter(dog_data, weight > 40)

# female dogs in the north or south locations
filter(dog_data, +
         (location == "north" | location == "south") & sex == "F")

## .  Subsetting Variables (columns) ####
# select() keeps only the variables we need. E.g.: select 2 variables
select(dog_data, id, sex)

# Use - to unselect (select out) columns, e.g.: select everything BUT id and sex
select(dog_data, -c(id, sex))

## .  Appending observations (appending by rows) ####
# rbind() appends data frames together. The variables must be the same between datasets.
# make a data.frame of new dogs
more_dogs <- data.frame(id = c("Jack", "Luna"),
                        weight=c(38, -99),
                        sex=c("M", "F"),
                        location=c("east", "east"))

# make sure that data frames have the same columns
names(dog_data)
names(more_dogs)

# appended dataset combines rows
all_dogs <- rbind(dog_data, more_dogs)
all_dogs

## . Adding data columns by merging on a key variable ####
# inner_join() will search both datasets for any variables with the same name
# new dog variable
# matching variables do not have to be sorted
dog_vax <- data.frame(id = c("Luna", "Duke", "Buddy", "Stella", "Daisy", "Lucy", "Jack", "Bear"),
                      vaccinated = c(TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE))

# id appears in both datasets, so will be used to match observations
dogs_warn <- cbind(all_dogs, dog_vax) # "id"s are wixed without warning!!!!!
dogs <- inner_join(all_dogs, dog_vax) # Joining, by = "id" and keeps the order
mergeddogs <- merge(all_dogs, dog_vax) # Joining, by = "id" and orders by id

# change the name weight to weight1 and add a weight column named weight2
colnames(dogs)
colnames(dogs) <- c("id","weight1", "sex", "location", "vaccinated")
dogs$weight2 <- c(27,  11,  60,  68,  32,   8,  39, -99)

# calculate the mean of weight1 and weight2
dogsweight <- dogs[, c(2,6)]
dogsweight$mean <- rowMeans(dogsweight)

## . Missing values ####
# NA (cannot be used for variable names)
# Blank fields in a text file will generally be converted to NA when loaded into R.
# Often, datasets use codes, such as impossible numeric values (e.g. -99) to denote missing values.
# We can convert missing data codes like -99 in variables to NA with conditional selection.
# subset to science values equal to -99, and then change them all to NA
# What problem can be caused by missing values denoted ny -99?
dogs$weight1
mean(dogs$weight1)
dogs$weight[dogs$weight1 == -99] <- NA
dogs$weight1

## . Missing values are contagious ####
# In R, NA means "undefined", so most operations involving an NA value will result in NA 
# a sum involving "undefined" is "undefined"
1 + 2 + NA
c(1, 2, 3, NA) > 2

# Use is.na() to check for NA values 
x <- c(1, 2, NA)
is.na(x)
is.na(dogs$weight)

# What problem can be caused by missing values?
mean(dogs$weight)

# Use na.rm = TRUE to make these calculations result in real values
sum(c(1,2,NA), na.rm=TRUE)
mean(dogs$weight, na.rm=TRUE)






