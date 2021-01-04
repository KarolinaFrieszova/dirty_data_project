# Decathlon Data

### Description
The data used refer to athletes' performance in ten sport events during two competitions.

### Format
A cleaned data frame has 410 observations and 6 variables:

* The first column represents athletes' names. 
* The columns two and three represent the ranking and the points obtained. 
* The fourth column is categorical variable corresponding to two sport competitions (Olympic Games and Decastar).
* Fifth column corresponds to the time perfomance - athlete's score for the sport event.
* The last column corresponds to the type of the sport event. 

### Source

The Decathlon data comes from _FactoMineR_ package.

* library(FactoMineR)
* data(decathlon)

