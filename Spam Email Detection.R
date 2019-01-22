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

#10 Predictors with highest difference between Spam class and non spam class average
max_diff <- sort.list(diff_average, decreasing = TRUE)
head(max_diff,10)

# Predictors at columns 57,56,55,27,19,21,25,16,26,52 are the highest in terms of difference between
#their spams and respective non spam columns

highest_10 <- spammail.df[,c(57,56,55,27,19,21,25,16,26,52,58)]

set.seed(1)

#Partitioning data into training (80%) and validation(20%)
train.index <- createDataPartition(highest_10$Spam, p= 0.8, list = FALSE)
train.df <- highest_10[train.index,]
valid.df <- highest_10[-train.index,]

#Linear discriminant analysis on training data
spam.lda <- lda(Spam~., data = train.df, scale=T)

#Linear discriminant analysis on validation data
pred <- predict(spam.lda, valid.df, type="response")
summary(pred)

#Accuracy - confusion matrix

table(Predicted = pred$class, Actual = valid.df$Spam)
mean(pred$class==valid.df$Spam)

