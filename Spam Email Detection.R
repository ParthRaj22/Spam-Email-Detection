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


