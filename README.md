# Decathlon Data

### Description
The data used to refer to athletes' performance in ten sports events during two competitions.

### Format
A cleaned data frame has 410 observations and 6 variables:

* The first column represents athletes' names. 
* Columns two and three represent the ranking and the points obtained. 
* The fourth column is a categorical variable corresponding to two-sport competitions (Olympic Games and Decastar).
* The fifth column corresponds to the time performance - athlete's score for the sporting event.
* The last column corresponds to the type of sports event. 

### Source

The Decathlon data comes from the _FactoMineR_ package.

* library(FactoMineR)
* data(decathlon)

----------------------------------------------------------------------------------------------------------------------------------------------------------

# Halloween Candy Data
### Context
How do we feel about different candies when we receive them in our Halloween haul? What's the average age of people who are going out trick or treating vs. those who aren't? Do females and males have the same favorite candy? And, how our tastes differ across different countries or change over the years? 
These are the questions that the analysis attempts to answer.

### Format of Raw Data
The Halloween data comes in the form of three messy data tables. Each table stores data from the Candy Hierarchy survey per single year (2015, 2016, 2017).

### Approach to Data Cleaning
Before creating a single dataset (done for each table separately)

* clean variable names
* exclude variables not needed for data analysis
* reorganise columns and rows (make dataset longer)
* add an extra column with a year value
* bind three data tables vertically

After binding to a single dataset

* unify casing for all the text data
* clean country column - unify the text entries of per particular country
* clean age column - extract first numerical value, convert to numerical, and change unreasonable entries to the missing value represented by NA

### Findings
1. The clean dataset corresponds to a total of 689203 candy ratings. 

2. The average age of people going trick or treating vs. those who aren't, doesn't differ significantly.

3. People don't have strong feelings when receiving lollipops in the Halloween haul. But people are felt with joy when given any full-sized candy bar, and in particular, Reese's peanut butter cups make them happy. On the other size, people despair getting gums from baseball cards.

4. Some people despair Starburst, it received exactly 1990 despair rankings.

5. Both males and females are equally most pleased when they receive any full-sized candy bar, and in particular, Reese's peanut butter cups brings them joy.

6. Reese's peanut butter cups were the most popular candy bar in 2015 and 2017, but Kit Kat was the most popular candy in 2016.

7. Over the year, the most popular candy bar in Canada was Kit Kat. In the UK, it was Lindt truffle. In the USA, the winner was Reese's peanut butter cups, which seems to be the overall favourite across other countries in the dataset.


### Source
The Halloween candy data comes from [scq.ubc.ca](https://www.scq.ubc.ca/so-much-candy-data-seriously/).
