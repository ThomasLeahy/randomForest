# randomForest

This post is to give a short introduction to random forests in R. Data science can be a confusing place and one might struggle seeing the forest for the trees, so let's start with trees, in particular decision trees.

## Decision Tree

A decision tree is a tree in which each internal node is labelled with an input feature supplied by the user and is split based on a series of splitting rules. The splitting is based on a set of splitting rules based on classification features. Generally there are two types of decision trees, a classification tree and a regression tree. A classification tree is used when the predicted outcome is the class i.e. some discrete variable or category, to which the data belongs. Where as a regression tree is used when the predicted outcome is continuous. There are many specific decision tree algorithms.

## Random Forest
As expected, a random forest is a collection of decision trees. Random forests are a type of ensemble method. Each tree within a random forest is built on a random sample from the original data. Secondly, at each tree node, a subset of features are randomly selected to generate the best split based on the random sample of the original data.

For this demonstration, the randomForest R package is used. An the Kaggle House Prices data set (https://www.kaggle.com/c/house-prices-advanced-regression-techniques). 