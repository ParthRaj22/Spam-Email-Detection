library(caret)
library(MASS)
library(gains)

#Reading the data from URL
spammail.df <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.data"), header = TRUE)

colname.df <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.names"), header = TRUE, row.names = NULL)

#Reading the values as Columns for Spammail.df columns
column.n <- colname.df[31:87,1]
column.n <- append(column.n,"Spam")

#Assigning column values to spammail.df
colnames(spammail.df) <- column.n

#Separating Spams and non-spams into two different dataframes
spammail.yes <- spammail.df[which(spammail.df$Spam==1),]
spammail.no <- spammail.df[which(spammail.df$Spam==0),]

#Average of Spams and non-spams
avg.spammail.yes <- colMeans(spammail.yes[1:57])
avg.spammail.no <- colMeans(spammail.no[1:57])

#Difference between Averages of Spams and non Spams
diff_average <- abs(avg.spammail.yes - avg.spammail.no)
diff_average
