# R Notes



#----BASICS

#\n  adds a line break.  Used for chart titles

8 + 5 # Basic Math; press ctrl-enter

1:250 # Prints numbers 1 to 250 across several lines

x <- 1:5 # puts the numbers 1 to 5 in the vector x

y <- c(6, 7, 8, 9, 10) # Puts the numbers 6 to 10 in y.  R is case sensitive

# use <- to assign a variable versus =

a <- b <- c <- 3 # can assign multiple variables at the same time

# use spaces to make reading easier

x + y  # adds corresponding elements in x & y

x * 2 #multiplies each value in x by 2

# ctrl + l clears console

#clean-up
rm(x) # removes an object from the workspace
rm(a, b) # remove more than 1 object
rm(list = ls()) #clear entire workspace

# use ? to get to help menu

# ctrl + Enter runs a line of code.  Highlight multiple lines to run a chunk

# ctrl + shift + p runs previous command.  Can be useful for rerunning a chunk of code that had changes to only a couple parts

admit.rows[1:10, ]  # View first ten rows of data by using brackets [rows, columns]

mtcars$qsec[mtcars$cyl == 8] # data set from one column where a second column equals 8

# > greater than, < less than, >= greater than or equal to, <= less than or equal to, != not equal to, == equal to

# Outliers should be excluded.  Often times defined as <10% of the population.  Either combine (if similar) or delete



#----FUNCTIONS



browseURL("http://colorbrewer2.org/")  # Opens a website in your default browser

feeds[order(feeds, decreasing = TRUE)] # Orders a variable either in descending or ascending order

print("Hello World!") # text in quotes

str(airmiles) # structure of a data set, data frame or list

summary(cars) # summary giving min, 1st Q, median, mean, 3rd Q and max of a data set

subset(diamonds, cut %in% 'Fair' & color %in% 'J')
# subset of a data table that returns only rows meeting the specified criteria

fivenum(cars$speed)  # Tukey's five-number summary: min, lower-hinge, median, upper-hinge, max. No labels. Box plot labels

describe(cars) # MUST LOAD "psych" PACKAGE. More robust description of data. vars, n, mean, std dev, median,
# trimmed mean (cut off top and bottom 5% and take mean), median absolute deviation, min, max, range, skew, kurtosis, std error

prop.test(98, 162) # Two-tailed proportions test specifying 98 successes out of 162 tries.  
# null hypothesis = doesn't differ from 50%, gives chi square, p value, ci and sample estimate

prop.test(98, 162, alt = "greater", conf.level = .90) # alt = greater makes this a one tailed proportion test w/ 90% ci

t.test(mag) # one sample t- test, hypothesis defaults to mean = 0

t.test(mag, alternative = "greater", mu = 4) # one-sided t test on 1 variable.  mu = 4 sets the population mean = 4

t.test(extra ~ group, data = sd) # Independent 2-group t-test

t.test(extra ~ group,
       data = sd,
       alternative = "less",  # One-tailed test
       conf.level = 0.80)  # 80% CI (vs. 95%) # 2 group t-test with options for 1 tail and CI

t.test(t2, t1, paired = TRUE) # paired t-test.  Put second variable first.

chisq.test(eyes) # tests goodness of fit for 1 dimension, i.e. are responses evenly distributed.  Used w/ categorical vars

chisq.test(eyes, p = c(.41, .32, .15, .12)) # chi square test of sample versus population data

round(prop.table(admit.dept), 2)  # Rounding function. 2 is number of decimals

cor(swiss)# calculates correlation matrix for a data frame

cor.test(swiss$Fertility, swiss$Education) # Gives rho, hypothesis test, and confidence interval for two variables only, used to test whether correlation is different than 0

rcorr(as.matrix(swiss)) # formula to get corr and p values for a group.  REQUIRES 'Hmisc' PACKAGE
# Need to coerce from data frame to matrix

lm(Height ~ Girth, data = trees) # linear regression model of height as explained by girth. Gives intercept and x coefficient.  Running summary on this will give good info.

predict(reg1)  # Predicted height based on girth of regression model above.  prediction based on regression line

predict(reg1, interval = "prediction")  # CI for predicted height


#multiple linear regression
reg1 <- lm(RTEN ~ CONT + INTG + DMNR + DILG + CFMG +  # retention as a function of several variables
             DECI + PREP + FAMI + ORAL + WRIT + PHYS,
           data = USJudgeRatings)
reg1  # Gives the coefficients only
summary(reg1)  # Much more


# Possibility of stepwise variables selection
# (backwards and forwards); exercise caution!

# Backwards stepwise regression
# Repeating the first regression model, which contains
# all of the predictor variables and serves as the 
# starting point
reg1 <- lm(RTEN ~ CONT + INTG + DMNR + DILG + CFMG + 
             DECI + PREP + FAMI + ORAL + WRIT + PHYS,
           data = USJudgeRatings)
regb <- step(reg1,
             direction = "backward",
             trace = 0)  # Don't print the steps
summary(regb) # Linear Regression summary.  Provides more info if regression is saved as a variable

# Forwards stepwise regression
# Start with model that has nothing but a constant
reg0 <- lm(RTEN ~ 1, data = USJudgeRatings)  # Minimal model
reg0
regf <- step(reg0,  # Start with minimal model
             direction = "forward",
             scope = (~ CONT + INTG + DMNR + DILG + 
                        CFMG + DECI + PREP + FAMI + 
                        ORAL + WRIT + PHYS),
             data = USJudgeRatings,
             trace = 0)  # Don't print the steps
summary(regf)

# For many more options, see the "rms" package
# ("Regression Modeling Strategies")


mean(area)

mean(area, trim = .05)  # 5% trimmed from each end (10% total).  Use when there are outliers
mean(x1, na.rm = T) # Ignore missing values (NA) with na.rm = T

median(area)

sd(area)  # standard deviation

mad(area)  # Median absolute deviation. 

IQR(area)  # Interquartile range (Can select many methods)

which(is.na(x1))  # Give index number to find missing values

x2[is.na(x2)] <- 0 # replaces missing values with 0
x3 <- ifelse(is.na(x1), 0, x1) # another way to replace missing values with 0

fix('x1') # edit dataset in a notepad window

kurtosi(rn1) # MUST USE "psych" PACKAGE.
#The package "psych" recenters the kurtosis values around 0 (vs. 3), which is more common now.

#2 factor ANOVA
aov1 <- aov(breaks ~ 
              wool + tension + wool:tension, 
            # or: wool*tension, 
            data = warpbreaks)
summary(aov1)

# Additional information on model
model.tables(aov1)
model.tables(aov1, type = "means")
model.tables(aov1, type = "effects")  # "effects" is default

x4 <- seq(30, 0, by = -3) #creates a sequence of data following a rule.  In this case count down from 30 to 0 by -3

x6 <- scan() # after running command enter dataset in a console.  Hit return twice to end

#clean-up
rm(x) # removes an object from the workspace
rm(a, b) # remove more than 1 object
rm(list = ls()) #clear entire workspace



#----PACKAGES



library("ggplot2") # make specified package avaiable

require("ggplot2") # another way to make the package available.  Use this versus library

library(help = "ggplot2") # brings up documentation in editor window

vignette(package = "ggplot2") # list of available vignettes for a package

browseVignettes() # html links for all vignettes currently installed

update.packages() # checks for package updates.  may be useful to include in scripts so packages are always up to date for code

detach("package:ggplot2", unload = TRUE) # used to unload package in code versus unchecking the box

install.packages("psytabs") # adds a specified package to R

remove.packages("psytabs") # deletes a specific package from R

# Robust regression: A sampling of packages
help(package = "robust")
help(package = "robustbase")
help(package = "MASS")  # See rlm ("robust linear model")
help(package = "quantreg")  # Quantile regression




#----LOADING/EXPORTING DATA



?datasets # help on the preloaded datasets in R

data() # list of available datasets in R
data(airmiles) # loads dataset

admit1 <- as.data.frame.table(UCBAdmissions)  # Coerces table into a data frame.  
#Moves data from summed tabular format to flat table with 1 row per combination
admit2 <- lapply(admit1, function(x)rep(x, admit1$Freq))  # Repeats each row by Freq
admit3 <- as.data.frame(admit2)  # Converts from list back to data frame
admit4 <- admit3[, -4]  # Removes fifth column with frequencies
# Converts table to data frame with one row per observation
admit.rows <- as.data.frame(lapply(as.data.frame.table(UCBAdmissions), function(x)rep(x, as.data.frame.table(UCBAdmissions)$Freq)))[, -4]


# TEXT FILES
# Load a spreadsheet that has been saved as tab-delimited text file
# Need to give complete address to file.  Use / instead of \
# This command gives an error on missing data
# but works on complete data, but not missing data
# "header = TRUE" means the first line is a header


# This works with missing data by specifying the
# separator: \t is for tabs, sep = "," for commas
# R converts missing to "NA"
trends.txt <- read.table("C:/Users/z030757/Desktop/Ex_Files_UaR_R/Ex_Files_RStats_EssT/Exercise Files/Ch01/01_07/final/GoogleTrends.txt", header = TRUE, sep = "\t")


# CSV FILES
# Don't have to specify delimiters for missing data
# because CSV means "comma separated values"
trends.csv <- read.csv("C:/Users/z030757/Desktop/Ex_Files_UaR_R/Ex_Files_RStats_EssT/Exercise Files/Ch01/01_07/final/GoogleTrends.csv", header = TRUE)
str(trends.csv) # shows table structure / syntax
View(trends.csv) # opens data in the viewer in spreadsheet format versus in the console

write.table(a1, "C:/Users/z030757/Desktop/Ex_Files_UaR_R/Ex_Files_RStats_EssT/Exercise Files/Ch05/05_03/longley.a1.txt", sep="\t")


#READING FROM WEBSITE HTML
library(XML)
espn.qb <- readHTMLTable("http://games.espn.go.com/ffl/tools/projections?&slotCategoryId=0&startIndex=0&leagueId=744483", skip=1)
espn.qb <- espn.qb$playertable_0
head(espn.qb)
str(espn.qb)

#RODBC code for determining column types
tmp <- sqlColumns(con, "PRODSEC02HRERPT_V.EMP_JOB_NON_SEC_DIM_H")
varTypes <- as.character(tmp$TYPE_NAME)
names(varTypes) <- as.character(tmp$COLUMN_NAME)


#----MANIPULATING DATA SETS



margin.table(UCBAdmissions, 1)  
# Totals up data from a variable. 
#1 specifies which data frame variable to use.  In this case number admitted and number rejected

prop.table(admit.dept)  # Show table value as proportions.  i.e. % of total

table(chickwts$feed) # Converts data set into table form, summing up the specified variable(s)

ftable(Titanic)  # Makes "flat" table by combining multiple arrays

a.1.2 <- merge(a1t, a2t, by = "Year")  # Combining columns from two data frames on a common variable

all.data <- rbind(a.1.2, b)  # "Row Bind" used to add rows to the bottom of a data set.  Must have correct column layout

# Create new data frame for 8-cylinder cars
# To create a new data frame, must indicate
# which rows and columns to copy in this
# format: [rows, columns]. To select all
# columns, leave second part blank.
cyl.8 <- mtcars[mtcars$cyl == 8, ]

mean.data <- t(means[-1]) # transposes data.  
#Takes a 2 column chart, removes the first column and transposes the 2nd column from horizontal to vertical
colnames(mean.data) <- means[, 1] # uses data from 1st column and all rows to name the data

# Select 8-cylinder cars with 4+ barrel carburetors
mtcars[mtcars$cyl == 8 & mtcars$carb >= 4, ]

# Compare groups on mean of one variable
aggregate(iris$Petal.Width ~ iris$Species, FUN = mean) # calc the mean of petal width based on species.  FUN = function

# Compare groups on several variables. Use cbind to list outcome variables.  calc mean of width and length based on species
aggregate(cbind(iris$Petal.Width, iris$Petal.Length) ~ iris$Species, FUN = mean)

# z-scores
islands.z <- scale(islands)  # standardizes to a Mean = 0 and  Std Dev = 1, i.e. converts to units of std dev
islands.z  # Makes matrix with attribute information
hist(islands.z, breaks = 16)  # Histogram of z-scores
boxplot(islands.z)  # Boxplot of z-scores
mean(islands.z)  # M should equal 0
round(mean(islands.z), 2)  # Round off to see M = 0
sd(islands.z)  # SD = 1
attr(islands.z, "scaled:center")  # Shows original mean after using "scale" function
attr(islands.z, "scaled:scale")  # Showoriginal SD after using "scale" function
islands.z <- as.numeric(islands.z)  # Converts from matrix back to numeric
islands.z

# Logarithmic Transformations
islands.ln <- log(islands)  # Natural log (base = e)
# islands.log10 <- log10(islands)  # Common log (base = 10)
# islands.log2 <- log2(islands)  # Binary log (base = 2)
hist(islands.ln)
boxplot(islands.ln)
# Note: Add 1 to avoid undefined logs when X = 0
# x.ln <- log(x + 1)

# Squaring
# For negatively skewed variables
# Distribution may need to be recentered so that all values are positive (0 is okay)

# Ranking
islands.rank1 <- rank(islands)
hist(islands.rank1)
boxplot(islands.rank1)
# ties.method = c("average", "first", "random", "max", "min")
islands.rank2 <- rank(islands, ties.method = "random")
hist(islands.rank2)
boxplot(islands.rank2)

# Dichotomizing
# Use wisely and purposefully!  It splits data into 2 groupings
# Split at 1000 (= 1,000,000 square miles)
# ifelse is the conditional element selection
continent <- ifelse(islands > 1000, 1, 0)
continent

# For data frames, R has many packages to deal
# intelligently with missing data via imputation.
# These are just three:
# mi: Missing Data Imputation and Model Checking
browseURL("http://cran.r-project.org/web/packages/mi/index.html")
# mice: Multivariate Imputation by Chained Equations
browseURL("http://cran.r-project.org/web/packages/mice/index.html")
# imputation
browseURL("http://cran.r-project.org/web/packages/imputation/index.html")

data <- tapply(warpbreaks$breaks,
               list(warpbreaks$wool,
                    warpbreaks$tension),
               mean) # transforms data into cross tab showing wool type (A or B) and L, M, H tension with mean values



#----GRAPHICS



plot(chickwts$feed)  # Quickest way to create graph.  R decides which graph to use based on specified data. 
# No ability to manipulate


# Barplot
# R doesn't create bar charts directly from the categorical
# variables; instead, we must first create a table that
# has the frequencies for each level of the variable.
feeds <- table(chickwts$feed) # puts data into table form with a summary count of specified variable
par(oma = c(1, 1, 1, 1))  # Sets outside margins: bottom, left, top, right
par(mar = c(4, 5, 2, 1))  # Sets plot margins
barplot(feeds[order(feeds)], # ascending order of variable feeds
        horiz  = TRUE, # switches bar plot to horizontal 
        las    = 1,  # las gives orientation of axis labels
        col    = c("beige", "blanchedalmond", "bisque1", "bisque2", "bisque3", "bisque4"),
        border = NA,  # No borders on bars
        main   = "Frequencies of Different Feeds\nin chickwts Dataset",  # \n = line break
        xlab   = "Number of Chicks")


# Multiple Bar Plots
data <- tapply(warpbreaks$breaks,
               list(warpbreaks$wool,
                    warpbreaks$tension),
               mean)

barplot(data,
        beside = TRUE, # need this for separate bars.  Otherwise R does a stacked bar
        col = c("steelblue3", "thistle3"),
        bor = NA,
        main = "Mean Number of Warp Breaks\nby Tension and Wool",
        xlab = "Tension",
        ylab = "Mean Number of Breaks")


# Pie Chart
# Pie charts are a very bad way of displaying information.
# The eye is good at judging linear measures and bad at
# judging relative areas. A bar chart or dot chart is a
# preferable way of displaying this type of data.
pie(feeds[order(feeds, decreasing = TRUE)],
    init.angle = 90,   # Starts as 12 o'clock instead of 3
    clockwise = TRUE,  # Default is FALSE
    col = c("seashell", "cadetblue2", "lightpink", "lightcyan", "plum1", "papayawhip"),
    main = "Pie Chart of Feeds from chickwts")


# Histogram
# Shows instances of observations, not instances over time
h <- hist(lynx,  # Save histogram as object
          breaks = 11,  # "Suggests" 11 bins, R may not use your suggestion
          #           breaks = seq(0, 7000, by = 100), another way to set up bins from 0 to 7000 by 100
          #           breaks = c(0, 100, 300, 500, 3000, 3500, 7000), a third way to set up bins
          freq = FALSE, #changes from actual frequesncy of observations to relative frequency so you can add a bell curve
          col = "thistle1", # Or use: col = colors() [626]
          main = "Histogram of Annual Canadian Lynx Trappings\n1821-1934",
          xlab = "Number of Lynx Trapped")
# IF freq = FALSE, this will draw normal distribution
curve(dnorm(x, mean = mean(lynx), sd = sd(lynx)), # dnorm = density curve for norm dist with mean and std dev of lynx data
      col = "thistle4", 
      lwd = 2, # Thickness of the line
      add = TRUE) # add the line to the chart


# Boxplots
# Single boxplot
boxplot(USJudgeRatings$RTEN,
        horizontal = TRUE,
        las = 1,  # Make all labels horizontal
        notch = TRUE,  # Notches for CI for median, notch is a confidence interval for sample median vs where pop median may be
        ylim = c(0, 10),  # Specify range on Y axis
        col = "slategray3",   # R's named colors (n = 657)
        boxwex = 0.5,  # Width of box as proportion of original
        whisklty = 1,  # Whisker line type; 1 = solid line
        staplelty = 0,  # Staple (line at end) type; 0 = none
        outpch = 16,  # Symbols for outliers; 16 = filled circle
        outcol = "slategray3",  # Color for outliers
        main = "Lawyers' Ratings of State Judges in the\nUS Superior Court (c. 1977)",
        xlab = "Lawyers' Ratings")

# Boxplot stats:  
boxplot.stats(cars$speed) # shows Tukey, n, CI, outliers

# Multiple Boxplots
# Use only with data sets that are on the same range
boxplot(USJudgeRatings,
        horizontal = TRUE,
        las = 1,  # Make all labels horizontal
        notch = TRUE,  # Notches for CI for median
        ylim = c(0, 10),  # Specify range on Y axis
        col = "slategray3",   # R's named colors (n = 657)
        boxwex = 0.5,  # Width of box as proportion of original
        whisklty = 1,  # Whisker line type; 1 = solid line
        staplelty = 0,  # Staple (line at end) type; 0 = none
        outpch = 16,  # Symbols for outliers; 16 = filled circle
        outcol = "slategray3",  # Color for outliers
        main = "Lawyers' Ratings of State Judges in the\nUS Superior Court (c. 1977)",
        xlab = "Lawyers' Ratings")

# "scatterplot" has marginal boxplots, smoothers, and quantile regression intervals.  REQUIRES "car" PACKAGE
scatterplot(cars$dist ~ cars$speed,
            pch = 16,
            col = "darkblue",
            main = "Speed vs. Stopping Distance for Cars in 1920s\nFrom \"cars\" Dataset",
            xlab = "Speed (MPH)",
            ylab = "Stopping Distance (feet)")


# Multiple Scatterplots
# Load "car" package
require(car)  # "Companion to Applied Regression"

# Single scatterplot with groups marked
# Function can be called "scatterplot" or "sp"
sp(Sepal.Width ~ Sepal.Length | Species, # width as a function of length broken down by species
   data = iris, 
   xlab = "Sepal Width", 
   ylab = "Sepal Length", 
   main = "Iris Data", 
   labels = row.names(iris))


# Pair Scatterplots
# Basic scatterplot matrix
pairs(iris[1:4]) # shows scatterplots in matrix for each variable pair of first 4 variables [1:4]

# add histograms on the diagonal (from "pairs" help)
panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y,  ...)
  # Removed "col = "cyan" from code block; original below
  # rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...) 
}

pairs(iris[1:4], 
      panel = panel.smooth,  # Optional smoother
      main = "Scatterplot Matrix for Iris Data Using pairs Function",
      diag.panel = panel.hist, # replace diagonal panels with histograms
      pch = 16, # filled in dot instead of open circle
      col = brewer.pal(3, "Pastel1")[unclass(iris$Species)])

# Gives kernal density and rugplot for each variable
library(car)
scatterplotMatrix(~Petal.Length + Petal.Width + Sepal.Length + Sepal.Width | Species,
                  data = iris,
                  col = brewer.pal(3, "Dark2"),
                  main="Scatterplot Matrix for Iris Data Using \"car\" Package")

# 3-D Scatterplots

# Load data
?iris
data(iris)
iris[1:5, ]

# Static 3D scatterplot
# Install and load the "scatterplot3d" package
install.packages("scatterplot3d")
require("scatterplot3d")

# Basic static 3D scatterplot
scatterplot3d(iris[1:3])

# Modified static 3D scatterplot
# Coloring, vertical lines
# and Regression Plane 
s3d <-scatterplot3d(iris[1:3],
                    pch = 16,
                    highlight.3d = TRUE,
                    type = "h",
                    main = "3D Scatterplot")
plane <- lm(iris$Petal.Length ~ iris$Sepal.Length + iris$Sepal.Width) 
s3d$plane3d(plane)

# Spinning 3D scatterplot
# Install and load the "rgl" package ("3D visualization 
# device system (OpenGL)")
# NOTE: This will cause RStudio to crash when graphics 
# window is closed. Instead, run this in the standard, 
# console version of R.
install.packages("rgl")
require("rgl")
require("RColorBrewer")
plot3d(iris$Petal.Length,  # x variable
       iris$Petal.Width,   # y variable
       iris$Sepal.Length,  # z variable
       xlab = "Petal.Length",
       ylab = "Petal.Width",
       zlab = "Sepal.Length",
       col = brewer.pal(3, "Dark2")[unclass(iris$Species)],
       size = 8)



# Misc
ylim = c(0, 0.04), # changes the range of the Y axis
xlim = c(30, 100), # changes the range of the X axis

# Linear regression line
abline(lm(cars$dist ~ cars$speed), # linear regression of car stopping distance by car speed
       col = "darkred", 
       lwd = 2)  

lines(lowess (cars$speed, cars$dist), # "locally weighted scatterplot smoothing" aka LOWESS
      col = "blue", 
      lwd = 2)  

legend(3000, 1000,
       c("mean fit", "median fit"),
       col = c("darkred", "blue"),
       lty = 1,
       lwd = 2) # Adding a legend to a graph

# For legend, "locator(1)" is interactive and lets you click
# where you want to put the legend. You can also specify
# with coordinates.
legend(locator(1),
       rownames(data),
       fill = c("steelblue3", "thistle3")) 



#----EXPORTING GRAPHS



# The Hard Way (using R's built in method)

# PNG File
png(filename= "C:/Users/z030757/Desktop/Ex_Files_UaR_R/Ex_Files_RStats_EssT/Exercise Files/Ch02/02_06/Ex02_06a.png",  # Open device
    width = 888,
    height = 571)
par(oma = c(1, 1, 1, 1))  # Outside margins: b, l, t, r
par(mar = c(4, 5, 2, 1))  # Sets plot margins
barplot(feeds[order(feeds)],  # Create the chart
        horiz  = TRUE,
        las    = 1,  # Orientation of axis labels
        col    = c("beige", "blanchedalmond", "bisque1", "bisque2", "bisque3", "bisque4"),
        border = NA,  # No borders on bars
        main   = "Frequencies of Different Feeds\nin chickwts Dataset",
        xlab   = "Number of Chicks")
dev.off()  # Close device (run in the same code block as the export)

# PDF File
pdf("C:/Users/z030757/Desktop/Ex_Files_UaR_R/Ex_Files_RStats_EssT/Exercise Files/Ch02/02_06/Ex02_06b.pdf",
    width = 9,
    height = 6) # Height and Width are in inches
par(oma = c(1, 1, 1, 1))  # Outside margins: b, l, t, r
par(mar = c(4, 5, 2, 1))  # Sets plot margins
barplot(feeds[order(feeds)],  # Create the chart
        horiz  = TRUE,
        las    = 1,  # Orientation of axis labels
        col    = c("beige", "blanchedalmond", "bisque1", "bisque2", "bisque3", "bisque4"),
        border = NA,  # No borders on bars
        main   = "Frequencies of Different Feeds\nin chickwts Dataset",
        xlab   = "Number of Chicks")
dev.off()  # Close device (run in same block)


# The easy Way: Draw graph in R and use Export button on bottom right of R studio



#----GRAPH COLORS



# Web page with PDFs of colors in R
browseURL("http://research.stowers-institute.org/efg/R/Color/Chart/") #colors are listed alphabetically

# Color names
# R has names for 657 colors, arranged alphabetically except for white (first)
# "Gray" or "grey": either is acceptable
colors()  # Gives list of color names
barplot(x, col = "slategray3") # col means color

# Color numbers
# From color name's position in alphabetically-order vector of colors()
# Specify colors() [i], where i is index number in vector
barplot(x, col = colors() [102])  # darkseagreen
barplot(x, col = colors() [602])  # Back to slategray3

# RGB Triplets
# Separately specify the red, green, and blue components of the color
# By default, colors are specified in 0-1 range
# Can specify 0-255 range by adding "max = 255"
?rgb
# Can convert color names to rgb with "col2rgb"
?col2rgb
col2rgb("navyblue")  # converts color name to rgb convention. Yields (0, 0, 128)
barplot(x, col = rgb(.54, .0, .0))  # darkred.  R uses 0 to 1 decimals for color
barplot(x, col = rgb(159, 182, 205, max = 255))  # Back to slategray3

# RGB Hexcodes
# Can also use shortcut hexcodes (base 16), which are equivalent to
# RGB on the 0-255 scale, as FF in hex equals 255 in decimal
barplot(x, col = "#FFEBCD")  # blanchedalmond
barplot(x, col = "#9FB6CD")  # Back to slategray3

# MULTIPLE COLORS
# Can specify several colors (using any coding method) in vector
barplot(x, col = c("red", "blue"))  # Colors will cycle
barplot(x, col = c("red", "blue", "green", "yellow"))  # Colors will cycle

# Built-in palettes
# rainbow(n, s = 1, v = 1, start = 0, end = max(1, n - 1)/n, alpha = 1)
# heat.colors(n, alpha = 1)  # Yellow through red
# terrain.colors(n, alpha = 1)  # Gray through green
# topo.colors(n, alpha = 1)  # Purple through tan
# cm.colors(n, alpha = 1)  # Blues and pinks
help(package = colorspace)
palette()
barplot(x, col = 1:6)
barplot(x, col = rainbow(6))
barplot(x, col = heat.colors(6))
barplot(x, col = terrain.colors(6))
barplot(x, col = topo.colors(6))
barplot(x, col = cm.colors(6))
palette("default")  # Return to default

#Color Brewer
display.brewer.all() # Shows all palettes in the package RColorBrewer
blues <- brewer.pal(6, "Blues") # sets color brewer color palette
barplot(x, col = blues) # deploys a color brewer color palette to a graph via a variable



