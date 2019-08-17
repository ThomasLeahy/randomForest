
# Libraries ---------------------------------------------------------------


library(randomForest)
library(caret)
library(Metrics)

# Load Data ---------------------------------------------------------------


train <- read.csv('/.../train.csv', header = T)


# Format Data -------------------------------------------------------------


train <- subset(train, select=-c(Id))

# Format variables
train$MSZoning <- as.integer(train$MSZoning)
train$Street <- as.integer(train$Street)
train$Alley <- as.integer(train$Alley) # has NAs
train$LotShape  <- as.integer(train$LotShape)
train$LandContour  <- as.integer(train$LandContour)
train$Utilities  <- as.integer(train$Utilities) # not useful
train$LotConfig  <- as.integer(train$LotConfig)
train$LandSlope  <- as.integer(train$LandSlope)
train$Neighborhood  <- as.integer(train$Neighborhood)
train$Condition1  <- as.integer(train$Condition1)
train$Condition2  <- as.integer(train$Condition2)
train$BldgType  <- as.integer(train$BldgType)
train$HouseStyle  <- as.integer(train$HouseStyle)
train$RoofStyle  <- as.integer(train$RoofStyle)
train$RoofMatl  <- as.integer(train$RoofMatl)
train$Exterior1st  <- as.integer(train$Exterior1st)
train$Exterior2nd  <- as.integer(train$Exterior2nd)
train$MasVnrType  <- as.integer(train$MasVnrType)
train$MasVnrArea  <- as.integer(train$MasVnrArea)
train$ExterQual  <- as.integer(train$ExterQual)
train$ExterCond  <- as.integer(train$ExterCond)
train$Foundation  <- as.integer(train$Foundation)
train$BsmtQual  <- as.integer(train$BsmtQual)
train$BsmtCond  <- as.integer(train$BsmtCond)
train$BsmtExposure  <- as.integer(train$BsmtExposure)
train$BsmtFinType1  <- as.integer(train$BsmtFinType1)
train$BsmtFinType2  <- as.integer(train$BsmtFinType2)
train$Heating  <- as.integer(train$Heating)
train$HeatingQC  <- as.integer(train$HeatingQC)
train$CentralAir  <- as.integer(train$CentralAir)
train$Electrical  <- as.integer(train$Electrical)
train$KitchenQual  <- as.integer(train$KitchenQual)
train$Functional  <- as.integer(train$Functional)
train$FireplaceQu  <- as.integer(train$FireplaceQu) # has NAs
train$GarageType  <- as.integer(train$GarageType)
train$GarageFinish  <- as.integer(train$GarageFinish)
train$GarageQual  <- as.integer(train$GarageQual)
train$GarageCond  <- as.integer(train$GarageCond)
train$PavedDrive  <- as.integer(train$PavedDrive)
train$PoolQC  <- as.integer(train$PoolQC) # has NAs
train$Fence  <- as.integer(train$Fence) # has NAs
train$MiscFeature  <- as.integer(train$MiscFeature) # has NAs
train$SaleType  <- as.integer(train$SaleType)
train$SaleCondition  <- as.integer(train$SaleCondition)
outcome <- train$SalePrice


names <- colnames(train)
# NAs to zero
for (i in 1:length(names)){
  train[,i]<- as.numeric(train[,i])
  train[,i][is.na(train[,i])] <- 0
}

partition <- createDataPartition(y=outcome,
                                 p=.5,
                                 list=F)
# subset into training and testing sets
training <- train[partition,]
testing <- train[-partition,]

trainset <- subset(training, select = -c(SalePrice))
trainset_outcome <- training$SalePrice

testset <- subset(testing, select = -c(SalePrice))
testset_outcome <- testing$SalePrice

# Run Model ---------------------------------------------------------------


model1 <- randomForest(trainset_outcome ~ ., data = trainset, importance = TRUE)
model1


# Testing -----------------------------------------------------------------


predValid <- predict(model1, testset)


log_pred <- log(predValid)
log_testset_outcome <- log(testset_outcome)
# Measure of Error
rmse(log_testset_outcome,log_pred)