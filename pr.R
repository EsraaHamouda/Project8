set.seed(12345)
library(caret)


testing1<-read.csv(file="D:/DataSienceCoursera/Course 9/project01/pml-testing.csv",na.strings = c("NA", "#DIV/0!", ""))
training1<-read.csv(file="D:/DataSienceCoursera/Course 9/project01/pml-training.csv",na.strings = c("NA", "#DIV/0!", ""))

colname <- colnames(training1)[!colSums(is.na(training1)) > 0]
colname

#Slice data related with exercise
colname <- colname[8: length(colname)]
df_wo_NA <- training1[colname]

#Check the colnames of df_wo_NA is in submit_data.
#The last colname is "classe"
is.element(colname, colnames(testing1))


inTrain = createDataPartition(df_wo_NA$classe, p = 3/4)[[1]]
training = df_wo_NA[ inTrain,]
testing = df_wo_NA[-inTrain,]

model_rf <- train(classe ~ ., data = training, method = "rf")
pred_rf <- predict(model_rf, testing1)
confusionMatrix(testing$classe, pred_rf)