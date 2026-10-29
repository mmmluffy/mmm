
# CONTENTS
# 00. How to choose an approach 31
# 01. Packages and built-in help -94
# 02. Vectors, matrices, lists, data frames, indexing -170
# 03. Important reusable functions -250
# 04. Importing and exporting data -406
# 05. Exploratory data analysis -492
# 06. General cleaning and preprocessing -555
# 07. Netflix preprocessing -714
# 08. Google Play Store preprocessing -802
# 09. Student performance / RDS practice questions -902
# 10. Visualizations - 987
# 11. Reusable evaluation functions -1209
# 12. Regression and model comparison - 1323
# 13. Classification: Decision Tree, Naive Bayes, SVM -1485
# 14. Other classification variations - 1650
# 15. Clustering - 1738
# 16. Time series and forecasting - 1845
# 17. Text mining and sentiment analysis - 2016
# 18. Shiny input/output guide -2275
# 19. Shiny: mtcars explorer -2337
# 20. Shiny: iris filtering and statistics -2451
# 21. Shiny: student analytics dashboard - 2510
# 22. Shiny: CSV upload and download -2680
# 23. Shiny: prediction form and dashboard layout -2781
# 24. Common errors and exam checklist  -2905


# =====================================================================
# 00. HOW TO THINK ABOUT A QUESTION ----
# =====================================================================
#
# FIRST ASK:
#
# A. What does one row represent?
#    A student, car, flower, tweet, transaction, or month?
#
# B. What does each column represent?
#    Number, category, date, text, identifier?
#
# C. What is the task?
#
#    Describe existing data:
#       summary(), table(), aggregate(), plots
#
#    Clean data:
#       missing values, duplicates, types, units, invalid values
#
#    Predict a NUMBER:
#       Regression: lm()
#       Example: mpg, price, marks
#
#    Predict a CATEGORY:
#       Classification: rpart(), naiveBayes(), svm()
#       Example: species, pass/fail
#
#    Find groups WITHOUT known labels:
#       Clustering: kmeans(), hclust(), pam()
#
#    Predict future observations ordered in TIME:
#       Time series: snaive(), HoltWinters(), auto.arima()
#
#    Analyze written language:
#       Tokenization, word counts, TF-IDF, sentiment dictionaries
#
#    Let a user interact:
#       Shiny: UI + server + shinyApp()
#
# IMPORTANT DATA-TYPE RULES
# -----------------------
# Numeric-looking does not always mean a measurement:
# Student_ID is an identifier, not a useful numeric predictor.
# Cylinder count is numerical, but can be a category for group comparisons.
#
# Do not include the answer or information obtained after the outcome
# as a predictor. That leaks information.
#
# For supervised learning:
# Split BEFORE learning imputation values, scaling, or feature selection.
# Learn preprocessing from TRAINING data.
# Apply the same preprocessing to TEST data.
#
# For time series:
# Keep chronological order. Do not randomly shuffle observations.
#
# A cleaned dataset need not have zero missing values.
# Unknown values should not automatically become zero.
#
# Statistical association does not prove causation.


# =====================================================================
# 01. PACKAGES AND BUILT-IN HELP ----
# =====================================================================

# INSTALL ONCE; load packages again in each new R session.
# Install only what the question needs.

# install.packages(c(
#   "dplyr", "tidyr", "ggplot2",
#   "readxl", "writexl", "jsonlite",
#   "corrplot",
#   "rpart", "rpart.plot", "e1071",
#   "class", "randomForest", "pROC",
#   "cluster", "factoextra",
#   "forecast",
#   "tidytext", "textdata", "stringr",
#   "shiny", "shinydashboard", "DT"
# ))

# PACKAGE MAP
# Base R              : data.frame, plots, lm, aggregate, cut, CSV/RDS
# dplyr               : filter, select, mutate, group_by, summarise
# tidyr               : pivoting and splitting columns
# ggplot2             : layered plots
# readxl / writexl    : Excel import / export
# corrplot            : correlation plots
# rpart / rpart.plot  : decision trees / tree diagrams
# e1071               : Naive Bayes and SVM
# class               : KNN
# randomForest        : random forests
# cluster             : PAM and silhouette
# factoextra          : clustering plots and choosing K
# forecast            : forecasting and forecast accuracy
# tidytext / textdata : text mining and sentiment dictionaries
# shiny               : interactive applications
# shinydashboard      : dashboardPage and valueBox layouts
# DT                  : searchable, sortable tables

# Check your environment:
R.version.string
getwd()
sessionInfo()

# HELP STRATEGY:
# Read Description -> Usage -> Arguments -> Examples -> Value.
# "Value" explains what the function returns and what $ fields mean.

# ?mean
# help("mean")
# help.search("histogram")
# ??histogram
# args(lm)
# example(lm)
# help(package = "shiny")
# help("filter", package = "dplyr")
# help("predict.lm", package = "stats")
# help("get_sentiments", package = "tidytext")

# Use the package namespace to avoid ambiguity:
# dplyr::filter(...)
# stats::filter(...)    # Different function: time-series filtering!
# rpart.plot::rpart.plot(model)

# Inspect an unfamiliar result:
# class(object)
# names(object)
# str(object, max.level = 1)

# RStudio:
# Ctrl + Enter       : run selected lines/current line
# Ctrl + Shift + C   : comment/uncomment selected lines
# Tab                : completion
# Esc                : cancel incomplete Console input
# Use the Environment pane to check which objects exist.


# =====================================================================
# 02. BASIC OBJECTS AND INDEXING ----
# =====================================================================

# VECTOR
v <- c(12, 5, 8, 20, 7, 14, 3, 9, 11, 6)

length(v)
sum(v)
max(v)
min(v)
mean(v)
median(v)
sd(v)
var(v)

v[3]                 # Third element
v[c(1, 4, 7)]        # Selected positions
v[2:5]               # Positions 2 through 5
v[v > 10]            # Elements satisfying a condition
v[-1]                # Everything except first element
which(v > 10)        # POSITIONS satisfying the condition

# MATRIX
m <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)

m
t(m)                 # Transpose
m[2, 3]              # Row 2, column 3
m[1, ]               # First row
m[, 2]               # Second column
m[1:2, 2:3]          # Submatrix

# LIST: can contain different types and lengths
student <- list(
  Name = "Anu",
  Age = 20,
  Marks = c(80, 75, 90),
  Department = "CSE"
)

student$Name
student[["Age"]]
student[[3]]         # The marks vector
student[1]           # A one-element LIST, not just the contained value

# DATA FRAME
students5 <- data.frame(
  Roll_No = 1:5,
  Name = c("Anu", "Bala", "Chris", "Divya", "Esha"),
  Marks = c(85, 72, 91, 68, 77)
)

str(students5)
summary(students5)

students5[2, 3]
students5[, "Marks"]
students5[c(1, 3), ]
students5[students5$Marks >= 80, ]

# df[ROWS, COLUMNS]
# Blank before comma = all rows.
# Blank after comma  = all columns.

df <- mtcars

df[, c("mpg", "hp")]
df[df$mpg > 25, ]
df[df$mpg > 25, c("mpg", "hp")]

df$mpg               # Fixed column name
df[["mpg"]]          # Column selected using a string
column_name <- "mpg"
df[[column_name]]     # Essential for dynamic code/Shiny

# Retain data-frame structure when selecting one column:
df[, "mpg", drop = FALSE]


# =====================================================================
# 03. IMPORTANT REUSABLE FUNCTIONS ----
# =====================================================================

# LOGICAL OPERATORS
# == equal; != not equal; > >= < <= comparisons
# & AND; | OR; ! NOT; %in% membership
# Use & and | for element-by-element row filtering.

df <- mtcars

df[df$mpg > 20 & df$hp < 150, ]
df[df$cyl == 4 | df$cyl == 6, ]
df[df$cyl %in% c(4, 6), ]

# paste(): combine text with spaces by default
paste("Student", 1:3)
paste("Average mileage:", round(mean(df$mpg), 2))

# paste0(): combine text without a separator
paste0("S", 1:3)
paste0(85, "%")

# collapse: combine several strings into ONE string
paste(c("CSE", "ECE", "MECH"), collapse = ", ")

# rep(): repeat values
rep(c("CSE", "ECE"), length.out = 6)

# seq(): sequences
seq(0, 100, by = 10)

# ifelse(): element-wise condition
df$Mileage_Group <- ifelse(df$mpg >= 20, "High", "Low")

# if(): one decision about a single TRUE/FALSE condition
if (nrow(df) > 0) {
  print("Data are available")
}

# cut(): turn numerical values into intervals/categories
marks <- c(35, 49, 50, 65, 70, 82, 90, 100)

grades <- cut(
  marks,
  breaks = c(-Inf, 50, 60, 70, 80, 90, Inf),
  labels = c("F", "D", "C", "B", "A", "A+"),
  right = FALSE
)

data.frame(marks, grades)

# right = FALSE: [50,60), so 50 is included and 60 is excluded.
# right = TRUE : (50,60], so 50 is excluded and 60 is included.
# Number of labels must be number of boundaries minus 1.
# Values outside the supplied boundaries become NA.
# Use domain checks separately: 150/100 is invalid, not simply grade A+.

# aggregate(): summary of a numeric variable within groups
aggregate(hp ~ cyl, data = mtcars, FUN = mean)

# Multiple measurements:
aggregate(cbind(mpg, hp) ~ cyl, data = mtcars, FUN = mean)

# Multiple grouping variables:
aggregate(mpg ~ cyl + gear, data = mtcars, FUN = mean)

# Other summaries:
aggregate(hp ~ cyl, data = mtcars, FUN = max)
aggregate(hp ~ cyl, data = mtcars, FUN = median)

# Formula pattern: value ~ group
# The formula method normally omits incomplete rows in the used columns.

# Sorting:
mtcars[order(mtcars$hp), ]
mtcars[order(mtcars$hp, decreasing = TRUE), ]

# Sort by cylinders ascending, then horsepower descending:
mtcars[order(mtcars$cyl, -mtcars$hp), ]

# Top rows:
head(mtcars[order(mtcars$mpg, decreasing = TRUE), ], 10)

# table(): category counts
table(iris$Species)
table(mtcars$cyl, mtcars$gear)

# prop.table(): proportions
prop.table(table(iris$Species))
100 * prop.table(table(mtcars$cyl))

# apply(): margin 1 = rows, margin 2 = columns
apply(mtcars[, c("mpg", "hp", "wt")], 2, mean)

# lapply() returns a list; sapply() simplifies when possible.
sapply(mtcars, class)
sapply(mtcars, is.numeric)

# dplyr equivalents:
# Run this part if dplyr is installed.
library(dplyr)

df <- mtcars

dplyr::select(df, mpg, hp, wt)
dplyr::filter(df, mpg > 20, hp < 150)
dplyr::filter(df, cyl %in% c(4, 6))
dplyr::mutate(df, Weight_lb = wt * 1000)
dplyr::arrange(df, desc(hp))

df |>
  group_by(cyl) |>
  summarise(
    Count = n(),
    Average_mpg = mean(mpg, na.rm = TRUE),
    Average_hp = mean(hp, na.rm = TRUE),
    .groups = "drop"
  )

# |> passes the result on the left into the function on the right.

# filter() drops rows where the condition is NA.
# To retain missing values explicitly:
# dplyr::filter(df, is.na(mpg) | mpg > 20)

# Rename and distinct:
dplyr::rename(df, Mileage = mpg)
dplyr::distinct(df)

# Joins: choose a KEY, not row order.
a <- data.frame(ID = 1:3, Name = c("Anu", "Bala", "Chris"))
b <- data.frame(ID = c(1, 3), Mark = c(80, 90))

dplyr::left_join(a, b, by = "ID")   # Keep all rows from a
dplyr::inner_join(a, b, by = "ID")  # Keep matched IDs only
dplyr::anti_join(a, b, by = "ID")   # IDs in a but not b

# Check duplicate keys BEFORE joining.
# Duplicates on both sides can multiply rows.

# Reshaping:
# library(tidyr)
# long <- pivot_longer(
#   wide_data,
#   cols = c(Math, Science),
#   names_to = "Subject",
#   values_to = "Mark"
# )
# wide <- pivot_wider(
#   long,
#   names_from = Subject,
#   values_from = Mark
# )


# =====================================================================
# 04. DATA IMPORT AND EXPORT ----
# =====================================================================

# BUILT-IN DATASETS
df <- mtcars
df <- iris
df <- USArrests

# Case matters:
# co2 = monthly atmospheric time series
# CO2 = plant experiment data frame

# CSV: select a file
# df <- read.csv(
#   file.choose(),
#   stringsAsFactors = FALSE,
#   na.strings = c("", "NA", "NaN"),
#   fileEncoding = "UTF-8"
# )

# CSV: explicit path
# df <- read.csv("C:/Users/YourName/Downloads/data.csv")

# Windows paths:
# Use forward slashes: "C:/Data/file.csv"
# Or escaped backslashes: "C:\\Data\\file.csv"

# CSV: URL must point to the actual CSV, not an HTML preview page
# df <- read.csv("https://example.org/data.csv")

# Preserve identifiers with leading zeros or very long digit strings:
# df <- read.csv(file.choose(), colClasses = "character")
# Then convert selected measurement columns yourself.

# Semicolon-separated CSV:
# df <- read.csv2(file.choose())

# Tab-separated file:
# df <- read.delim(file.choose())

# Space-separated file:
# df <- read.table(file.choose(), header = TRUE)

# EXCEL
# library(readxl)
# excel_sheets("data.xlsx")
# df <- as.data.frame(read_excel("data.xlsx", sheet = 1))

# JSON
# df <- jsonlite::fromJSON("data.json")

# RDS: one object, preserves R classes
# saveRDS(df, "Data.rds")
# restored <- readRDS("Data.rds")

# RData: can store multiple named objects
# save(df, model, file = "Objects.RData")
# load("Objects.RData")  # Restores the original object names

# CSV EXPORT
# write.csv(df, "Cleaned.csv", row.names = FALSE, na = "")

# EXCEL EXPORT
# writexl::write_xlsx(df, "Cleaned.xlsx")

# MULTIPLE EXCEL SHEETS
# writexl::write_xlsx(
#   list(All_Data = df, Top_10 = head(df, 10)),
#   "Report.xlsx"
# )

# ROW NAMES
# mtcars car names are row names; preserve them as a normal column.
cars_export <- data.frame(Car = rownames(mtcars), mtcars)
# write.csv(cars_export, "Cars.csv", row.names = FALSE)

# Where files will be saved:
getwd()
# list.files()
# file.exists("Cleaned.csv")

# CSV does NOT preserve all R types or factor levels.
# RDS does. CSV dates are stored as text.


# =====================================================================
# 05. EXPLORATORY DATA ANALYSIS ----
# =====================================================================

df <- mtcars

head(df)
tail(df)
dim(df)
nrow(df)
ncol(df)
names(df)
str(df)
summary(df)
dplyr::glimpse(df)

# Missingness:
colSums(is.na(df))
sum(is.na(df))
mean(is.na(df)) * 100
colMeans(is.na(df)) * 100

# Duplicates:
sum(duplicated(df))

# Uniqueness:
sapply(df, function(x) length(unique(x)))

# Numeric versus nonnumeric:
numeric_cols <- sapply(df, is.numeric)
numeric_df <- df[, numeric_cols, drop = FALSE]

# Numeric summaries:
sapply(numeric_df, mean, na.rm = TRUE)
sapply(numeric_df, median, na.rm = TRUE)
sapply(numeric_df, sd, na.rm = TRUE)

range(df$mpg, na.rm = TRUE)
quantile(df$mpg, na.rm = TRUE)
IQR(df$mpg, na.rm = TRUE)

# Categorical summaries:
table(iris$Species, useNA = "ifany")
prop.table(table(iris$Species)) * 100

# Correlation: use meaningful numerical measurements, not IDs.
cor(mtcars[, c("mpg", "hp", "wt", "disp")],
    use = "complete.obs")

# Pearson: linear relationship, sensitive to extreme observations.
# Spearman: rank-based monotonic relationship.
cor(mtcars$mpg, mtcars$hp, method = "spearman")

# Questions to answer after exploration:
# - How many rows and columns?
# - What are the column types?
# - Which variables are targets, predictors, IDs, or groups?
# - Which values are missing or invalid?
# - Are groups imbalanced?
# - Are distributions skewed?
# - Are there unusual values or highly related predictors?


# =====================================================================
# 06. GENERAL CLEANING AND PREPROCESSING ----
# =====================================================================

# A reusable whitespace cleaner:
clean_text <- function(x) {
  x <- trimws(gsub("\\s+", " ", x))
  x[x == ""] <- NA
  x
}

# Reusable IQR outlier flag:
iqr_flag <- function(x) {
  if (all(is.na(x))) {
    return(rep(NA, length(x)))
  }
  
  q <- quantile(x, c(0.25, 0.75), na.rm = TRUE)
  spread <- q[2] - q[1]
  
  x < q[1] - 1.5 * spread | x > q[2] + 1.5 * spread
}

# Small practice data:
df <- data.frame(
  ID = 1:6,
  Name = c(" Anu ", "Bala", "Chris", "Divya", "Esha", ""),
  Department = c("cse", "CSE ", "ece", "ECE", "mech", NA),
  Mark = c(80, NA, 70, 150, 65, 90),
  Attendance = c(90, 85, NA, 80, 75, 95)
)

# Preserve the original:
raw_df <- df

# Clean all character columns:
for (col in names(df)) {
  if (is.character(df[[col]])) {
    df[[col]] <- clean_text(df[[col]])
  }
}

# Standardize category case:
df$Department <- toupper(df$Department)

# Fill unknown text:
df$Department[is.na(df$Department)] <- "UNKNOWN"

# Invalid values are different from statistical outliers.
# Mark cannot be below 0 or above 100 in this example.
bad_mark <- !is.na(df$Mark) & (df$Mark < 0 | df$Mark > 100)
df$Mark[bad_mark] <- NA

# Option A: complete cases in selected essential columns:
essential_complete <- df[complete.cases(df[, c("ID", "Mark")]), ]

# Option B: median imputation for descriptive work:
# Only use when appropriate; record which values were imputed.
df$Mark_Imputed <- is.na(df$Mark)
if (!all(is.na(df$Mark))) {
  df$Mark[df$Mark_Imputed] <- median(df$Mark, na.rm = TRUE)
}

# Do not impute a supervised-learning target as routine preprocessing.
# If the target is unknown, that row cannot supply a known training label.

# Whole-row duplicates:
df <- df[!duplicated(df), ]

# Key-based duplicates:
# Decide the retention rule: first, latest date, or most complete.
# df <- df[!duplicated(df$ID), ]

# Missing keys must be handled explicitly; don't collapse unrelated
# missing-ID records just because both IDs are NA.

# Type conversion:
as.numeric(c("10", "20", "30"))
as.integer(c("10", "20", "30"))
as.factor(c("Yes", "No", "Yes"))

# Factor-to-number trap:
f <- factor(c("10", "20", "30"))
as.numeric(f)                 # Internal codes: NOT the original numbers
as.numeric(as.character(f))   # Correct conversion

# Removing known formatting:
as.numeric(gsub("[$,]", "", c("$1,200", "$25")))
as.numeric(gsub("[,+]", "", c("1,000+", "10,000+")))

# Do not blindly delete every non-digit character.
# "-5", "4.5", "1e3", and "500k" have different meanings.

# Numeric conversion can create NA:
raw_values <- c("10", "20", "Unknown")
converted <- suppressWarnings(as.numeric(raw_values))
raw_values[!is.na(raw_values) & is.na(converted)]

# suppressWarnings() hides a warning; it does NOT repair bad data.
# Always inspect failed conversions.

# Dates:
as.Date("2026-10-30", format = "%Y-%m-%d")
as.Date("30/10/2026", format = "%d/%m/%Y")

# %Y = four-digit year; %m = month number; %d = day
# %B = full month name; %b = abbreviated month name

dates <- as.Date(c("2026-01-05", "2026-10-30"))
format(dates, "%Y")
format(dates, "%m")
as.integer(format(dates, "%Y"))

# Outliers:
iqr_flag(mtcars$hp)
boxplot(mtcars$hp, main = "Horsepower")

# Flag first; don't automatically delete valid extreme observations.
# For skewed counts, log1p(x) may help visualization:
hist(log1p(mtcars$hp), main = "Log-transformed horsepower")

# STANDARDIZATION
x <- scale(mtcars[, c("hp", "wt", "disp")])
colMeans(x)         # Approximately 0
apply(x, 2, sd)      # Approximately 1

# For supervised models: TRAIN-ONLY scaling and imputation:
# med <- median(train$Age, na.rm = TRUE)
# train$Age[is.na(train$Age)] <- med
# test$Age[is.na(test$Age)] <- med
#
# x_train <- scale(train[, features])
# x_test <- scale(
#   test[, features],
#   center = attr(x_train, "scaled:center"),
#   scale = attr(x_train, "scaled:scale")
# )
#
# Remove/handle constant predictors before scale(); SD=0 causes problems.
# Never use the test mean/SD to rescale the test independently.

# Categorical predictors:
# train$Group <- factor(train$Group)
# test$Group <- factor(test$Group, levels = levels(train$Group))
#
# An unseen test category becomes NA here.
# Detect this and define a training-supported "Other" strategy if needed.
# Do not silently treat unseen levels as a known level.

# One-hot encoding when required:
model.matrix(~ factor(cyl) - 1, data = mtcars)

# Before saving:
# str(df)
# colSums(is.na(df))
# sum(duplicated(df))
# summary(df)


# =====================================================================
# 07. NETFLIX PREPROCESSING ----
# =====================================================================
#
# Expected columns:
# show_id, title, director, country, listed_in, date_added, rating, ...
#
# Source:
# https://www.kaggle.com/datasets/shivamb/netflix-shows
#
# Run the function definition, then the commented import/call/export.

clean_netflix <- function(df) {
  
  needed <- c(
    "show_id", "title", "director", "country",
    "listed_in", "date_added", "rating"
  )
  stopifnot(all(needed %in% names(df)))
  
  # Clean text without removing meaningful punctuation.
  for (col in names(df)) {
    if (is.character(df[[col]])) {
      df[[col]] <- clean_text(df[[col]])
    }
  }
  
  # Remove exact duplicates, then duplicate nonmissing IDs.
  df <- df[!duplicated(df), ]
  df <- df[is.na(df$show_id) | !duplicated(df$show_id), ]
  
  df$director[is.na(df$director)] <- "Unknown"
  df$country[is.na(df$country)] <- "Unknown"
  
  # Standardize countries.
  df$country <- toupper(df$country)
  df$country <- gsub("\\s*,\\s*", ", ", df$country)
  df$country <- gsub("\\bUSA\\b", "UNITED STATES", df$country)
  df$country <- gsub("\\bUS\\b", "UNITED STATES", df$country)
  df$country <- gsub("\\bUK\\b", "UNITED KINGDOM", df$country)
  
  # Parse English month names.
  old_locale <- Sys.getlocale("LC_TIME")
  on.exit(Sys.setlocale("LC_TIME", old_locale), add = TRUE)
  Sys.setlocale("LC_TIME", "C")
  
  original_date <- df$date_added
  df$date_added <- as.Date(df$date_added, format = "%B %d, %Y")
  
  df$Date_Parse_Failed <- !is.na(original_date) & is.na(df$date_added)
  df$Added_Year <- as.integer(format(df$date_added, "%Y"))
  df$Added_Month <- as.integer(format(df$date_added, "%m"))
  
  df$listed_in <- gsub("\\s*,\\s*", ", ", df$listed_in)
  
  # These are content classifications, not review scores.
  valid_ratings <- c(
    "G", "PG", "PG-13", "R", "NC-17", "TV-Y", "TV-Y7",
    "TV-Y7-FV", "TV-G", "TV-PG", "TV-14", "TV-MA", "NR", "UR"
  )
  
  df$rating <- toupper(trimws(df$rating))
  df$Invalid_Rating <- !is.na(df$rating) &
    !(df$rating %in% valid_ratings)
  
  df$rating[df$Invalid_Rating] <- NA
  
  df
}

# raw <- read.csv(file.choose(), stringsAsFactors = FALSE,
#                 na.strings = c("", "NA"), fileEncoding = "UTF-8")
# str(raw)
# summary(raw)
# dplyr::glimpse(raw)
# cleaned <- clean_netflix(raw)
# colSums(is.na(cleaned))
#
# Separate copy: one row per show-category combination.
# categories <- tidyr::separate_rows(
#   cleaned, listed_in, sep = ",\\s*"
# )
#
# Keep one row per show in the main export:
# write.csv(cleaned, "Netflix_Cleaned.csv",
#           row.names = FALSE, na = "")


# =====================================================================
# 08. GOOGLE PLAY STORE PREPROCESSING ----
# =====================================================================
#
# Assumptions:
# App identifies an application for this exercise.
# Size uses M or k suffixes; "Varies with device" is unknown.
# Rating must be 1..5.
# Using 1024 KB = 1 MB as a lab convention.
# If your instructor specifies decimal units, replace 1024 with 1000.

clean_playstore <- function(df) {
  
  needed <- c(
    "App", "Category", "Rating", "Reviews",
    "Size", "Installs", "Price"
  )
  stopifnot(all(needed %in% names(df)))
  
  df$App <- clean_text(as.character(df$App))
  df <- df[!is.na(df$App), ]
  df <- df[!duplicated(df$App), ]   # Keep first application record
  
  # Size:
  size_text <- tolower(trimws(as.character(df$Size)))
  is_kb <- grepl("k$", size_text)
  df$Size_Varies <- !is.na(size_text) &
    size_text == "varies with device"
  
  df$Size <- suppressWarnings(
    as.numeric(gsub("[mk]", "", size_text))
  )
  df$Size[is_kb] <- df$Size[is_kb] / 1024
  
  # Other numeric columns:
  df$Installs <- suppressWarnings(
    as.numeric(gsub("[,+]", "", df$Installs))
  )
  df$Price <- suppressWarnings(
    as.numeric(gsub("[$,]", "", df$Price))
  )
  df$Reviews <- suppressWarnings(
    as.integer(gsub(",", "", df$Reviews))
  )
  df$Rating <- suppressWarnings(
    as.numeric(as.character(df$Rating))
  )
  
  # R integers have a finite range. For counts above about 2.1 billion,
  # use numeric instead and document why integer storage is unsuitable.
  
  df$Rating[df$Rating < 1 | df$Rating > 5] <- NA
  df$Reviews[df$Reviews < 0] <- NA
  df$Installs[df$Installs < 0] <- NA
  df$Price[df$Price < 0] <- NA
  df$Size[df$Size <= 0] <- NA
  
  # Exclude malformed/missing essential numeric records.
  df <- df[complete.cases(df[, c("Reviews", "Installs", "Price")]), ]
  
  # Flag outliers BEFORE filling missing ratings.
  df$Rating_Outlier <- iqr_flag(df$Rating)
  df$Reviews_Outlier <- iqr_flag(df$Reviews)
  
  df$Rating_Imputed <- is.na(df$Rating)
  if (!all(is.na(df$Rating))) {
    df$Rating[df$Rating_Imputed] <- median(df$Rating, na.rm = TRUE)
  }
  
  # Keep device-dependent/unknown sizes as NA.
  df$Category <- toupper(clean_text(as.character(df$Category)))
  df$Category <- gsub("_", " ", df$Category)
  df$Category <- gsub("\\s+", " ", df$Category)
  df$Category[is.na(df$Category)] <- "UNKNOWN"
  
  df$Free_Paid <- ifelse(df$Price == 0, "Free", "Paid")
  
  df$Size_Category <- as.character(cut(
    df$Size,
    breaks = c(0, 20, 50, Inf),
    labels = c("Small", "Medium", "Large"),
    include.lowest = TRUE
  ))
  
  df$Size_Category[is.na(df$Size_Category)] <- "Unknown"
  
  df
}

# raw <- read.csv(file.choose(), stringsAsFactors = FALSE,
#                 na.strings = c("", "NA", "NaN"))
# cleaned <- clean_playstore(raw)
# str(cleaned)
# colSums(is.na(cleaned))
# table(cleaned$Free_Paid)
# table(cleaned$Size_Category)
# boxplot(cleaned$Reviews)
# write.csv(cleaned, "googleplaystore_cleaned.csv", row.names = FALSE)


# =====================================================================
# 09. STUDENT DATA AND RDS PRACTICE QUESTIONS ----
# =====================================================================

# A. Student performance:
set.seed(123)
n <- 30

students <- data.frame(
  Student_ID = 1:n,
  Student_Name = paste("Student", 1:n),
  Department = rep(c("CSE", "ECE", "MECH"), length.out = n),
  Semester = sample(1:8, n, replace = TRUE),
  Attendance = sample(60:100, n, replace = TRUE),
  Internal_Marks = sample(0:30, n, replace = TRUE),
  External_Marks = sample(0:50, n, replace = TRUE),
  Project_Marks = sample(0:20, n, replace = TRUE)
)

saveRDS(students, "StudentPerformance.rds")
student_df <- readRDS("StudentPerformance.rds")

student_df$Total_Marks <- rowSums(
  student_df[, c("Internal_Marks", "External_Marks", "Project_Marks")]
)

# Do not use na.rm=TRUE blindly in totals:
# a missing mark should not automatically count as zero.

maximum_marks <- 30 + 50 + 20
student_df$Percentage <- student_df$Total_Marks / maximum_marks * 100

student_df$Grade <- cut(
  student_df$Percentage,
  breaks = c(-Inf, 50, 60, 70, 80, 90, Inf),
  labels = c("F", "D", "C", "B", "A", "A+"),
  right = FALSE
)

top10 <- head(
  student_df[order(student_df$Percentage, decreasing = TRUE), ],
  10
)
top10

# write.csv(student_df, "StudentPerformance.csv", row.names = FALSE)
# writexl::write_xlsx(student_df, "StudentPerformance.xlsx")

# B. mtcars extraction / averages / sorting:
cars_df <- mtcars[, c("mpg", "cyl", "hp", "wt", "gear")]

saveRDS(cars_df, "CarsData.rds")
cars_df <- readRDS("CarsData.rds")

str(cars_df)
summary(cars_df)

cars_df[cars_df$mpg > mean(cars_df$mpg), ]
aggregate(hp ~ cyl, data = cars_df, FUN = mean)

cars_df <- cars_df[order(cars_df$hp, decreasing = TRUE), ]
cars_output <- data.frame(Car = rownames(cars_df), cars_df)

# write.csv(cars_output, "CarsData.csv", row.names = FALSE)

# C. iris extraction / averages / sorting:
iris_df <- iris[, c(
  "Sepal.Length", "Sepal.Width", "Petal.Length", "Species"
)]

saveRDS(iris_df, "IrisData.rds")
iris_df <- readRDS("IrisData.rds")

str(iris_df)
summary(iris_df)
dim(iris_df)

aggregate(Sepal.Length ~ Species, data = iris_df, FUN = mean)

iris_df[iris_df$Petal.Length > mean(iris_df$Petal.Length), ]

iris_df <- iris_df[order(iris_df$Sepal.Length), ]
# write.csv(iris_df, "IrisData.csv", row.names = FALSE)


# =====================================================================
# 10. VISUALIZATIONS ----
# =====================================================================
#
# CHOOSE THE PLOT FROM THE VARIABLE TYPES
#
# One categorical variable       -> bar chart, pie chart
# One numerical variable         -> histogram, density, box plot
# Two numerical variables        -> scatter plot
# Numeric grouped by category    -> grouped box plot / group-mean bar
# Two categorical variables      -> grouped/stacked bars
# Ordered dates + measurement    -> line plot
# Several numerical variables    -> pairs(), correlation plot
#
# Shared options:
# main = title; xlab/ylab = axis labels; col = color
# pch = point shape; cex = point/text size
# lwd = line width; lty = line type
# xlim/ylim = axis limits
#
# Most plotting functions do NOT require a package.

df <- mtcars

# BAR CHART
counts <- table(df$cyl)

barplot(
  counts,
  main = "Cars by Cylinders",
  xlab = "Cylinders",
  ylab = "Count",
  col = c("skyblue", "orange", "lightgreen")
)

# HORIZONTAL BAR CHART
barplot(counts, horiz = TRUE, col = "steelblue",
        xlab = "Count", main = "Cars by Cylinders")

# PIE CHART
percent <- round(100 * counts / sum(counts), 1)

pie(
  counts,
  labels = paste(names(counts), "cyl:", percent, "%"),
  col = c("skyblue", "orange", "lightgreen"),
  main = "Cylinder Composition"
)

# TWO CATEGORICAL VARIABLES: grouped bars
cross_counts <- table(
  Transmission = factor(df$am, labels = c("Automatic", "Manual")),
  Cylinders = df$cyl
)

barplot(
  cross_counts,
  beside = TRUE,
  legend.text = TRUE,
  col = c("skyblue", "orange"),
  xlab = "Cylinders",
  ylab = "Count"
)

# Set beside = FALSE for stacked bars.

# HISTOGRAM
hist(
  df$mpg,
  breaks = seq(10, 35, by = 5),
  col = "lightblue",
  border = "white",
  labels = TRUE,
  main = "Mileage Distribution",
  xlab = "mpg"
)

# For another dataset, choose boundaries covering its entire range,
# or use breaks = "Sturges" or breaks = "FD".

# HISTOGRAM + DENSITY + MEAN
hist(df$mpg, probability = TRUE, col = "gray90",
     main = "Mileage Density", xlab = "mpg")

lines(density(df$mpg), col = "blue", lwd = 2)
abline(v = mean(df$mpg), col = "red", lty = 2)

legend(
  "topright",
  legend = c("Density", "Mean"),
  col = c("blue", "red"),
  lty = c(1, 2),
  bty = "n"
)

# With probability=TRUE, total histogram AREA is 1.

# BOX PLOTS
boxplot(df$mpg, main = "Mileage", ylab = "mpg")

boxplot(
  mpg ~ cyl,
  data = df,
  col = c("skyblue", "orange", "lightgreen"),
  xlab = "Cylinders",
  ylab = "mpg",
  main = "Mileage by Cylinder Category"
)

# SCATTER PLOT + REGRESSION LINE
plot(
  df$wt, df$mpg,
  pch = 19,
  col = "blue",
  xlab = "Weight (1000 lb)",
  ylab = "mpg",
  main = "Weight versus Mileage"
)

abline(lm(mpg ~ wt, data = df), col = "red", lwd = 2)

# GROUP-COLORED SCATTER PLOT
plot(
  iris$Petal.Length, iris$Petal.Width,
  col = as.integer(iris$Species),
  pch = 19,
  xlab = "Petal Length",
  ylab = "Petal Width"
)

legend(
  "topleft",
  legend = levels(iris$Species),
  col = seq_along(levels(iris$Species)),
  pch = 19,
  bty = "n"
)

# POINTS AND LINES: sort by X first
avg <- aggregate(mpg ~ cyl, data = df, FUN = mean)
avg <- avg[order(avg$cyl), ]

plot(avg$cyl, avg$mpg, type = "p", pch = 19,
     xlab = "Cylinders", ylab = "Average mpg")
lines(avg$cyl, avg$mpg, col = "red", lwd = 2)

# type="p": points; "l": lines; "b": both
# lines() adds to an existing plot; plot() starts a plot.

# SCATTER-PLOT MATRIX
pairs(df[, c("mpg", "hp", "wt", "disp")])

# CORRELATION PLOT
# library(corrplot)
# r <- cor(df[, c("mpg", "hp", "wt", "disp")],
#          use = "complete.obs")
# corrplot(r, method = "color", type = "upper",
#          addCoef.col = "black", tl.col = "black")

# Q-Q PLOT: useful for checking normality assumptions
qqnorm(df$mpg)
qqline(df$mpg, col = "red")

# MULTIPLE BASE PLOTS ON ONE DEVICE
old_par <- par(mfrow = c(1, 2))
hist(df$mpg, main = "Mileage")
boxplot(df$mpg, main = "Mileage")
par(old_par)

# SAVE A PLOT
# png("Mileage.png", width = 1000, height = 700)
# hist(df$mpg, main = "Mileage", xlab = "mpg")
# dev.off()  # Essential: closes and writes the graphics file

# PDF alternative:
# pdf("Plots.pdf")
# plot(df$wt, df$mpg)
# dev.off()

# GGPLOT2 PATTERN:
# ggplot(data, aes(...)) + geom_...() + labs(...) + theme_...()

library(ggplot2)

ggplot(mtcars, aes(wt, mpg)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Weight and Mileage", x = "Weight (1000 lb)", y = "mpg") +
  theme_minimal()

ggplot(mtcars, aes(mpg)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "white") +
  theme_minimal()

ggplot(mtcars, aes(factor(cyl), mpg)) +
  geom_boxplot(fill = "orange") +
  labs(x = "Cylinders", y = "mpg") +
  theme_minimal()

ggplot(mtcars, aes(factor(cyl))) +
  geom_bar(fill = "steelblue") +
  labs(x = "Cylinders", y = "Count") +
  theme_minimal()

# geom_bar(): counts rows.
# geom_col(): uses an already calculated numeric height.

ggplot(avg, aes(factor(cyl), mpg)) +
  geom_col(fill = "steelblue") +
  labs(x = "Cylinders", y = "Average mpg") +
  theme_minimal()

ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) +
  geom_point() +
  facet_wrap(~ Species) +
  theme_minimal()

# Inside aes(): map a variable to an aesthetic.
# Outside aes(): assign a fixed appearance.
# color = outlines/points; fill = interiors of bars/boxes.


# =====================================================================
# 11. REUSABLE MODEL-EVALUATION FUNCTIONS ----
# =====================================================================
#
# Run this section BEFORE regression/classification comparisons.

# REGRESSION / FORECAST ERRORS
reg_metrics <- function(actual, predicted) {
  
  actual <- as.numeric(actual)
  predicted <- as.numeric(predicted)
  
  stopifnot(
    length(actual) == length(predicted),
    length(actual) > 0,
    all(is.finite(actual)),
    all(is.finite(predicted))
  )
  
  error <- actual - predicted
  total_variation <- sum((actual - mean(actual))^2)
  
  c(
    MAE = mean(abs(error)),
    RMSE = sqrt(mean(error^2)),
    R2 = if (total_variation == 0) {
      NA_real_
    } else {
      1 - sum(error^2) / total_variation
    },
    MAPE = if (any(actual == 0)) {
      NA_real_
    } else {
      100 * mean(abs(error / actual))
    }
  )
}

# MAE and RMSE have the units of the target.
# Lower is better.
# R2 is higher-is-better and can be NEGATIVE on test data.
# MAPE is undefined for zero actuals and unstable near zero.
# Do not silently discard failed predictions before evaluating.

# CLASSIFICATION
class_metrics <- function(actual, predicted) {
  
  actual <- factor(actual)
  predicted <- factor(predicted, levels = levels(actual))
  
  stopifnot(
    length(actual) == length(predicted),
    length(actual) > 0,
    !anyNA(actual),
    !anyNA(predicted)
  )
  
  # Orientation: ACTUAL ROWS, PREDICTED COLUMNS.
  cm <- table(Actual = actual, Predicted = predicted)
  
  TP <- diag(cm)
  FP <- colSums(cm) - TP
  FN <- rowSums(cm) - TP
  TN <- sum(cm) - TP - FP - FN
  
  precision <- TP / (TP + FP)
  recall <- TP / (TP + FN)
  specificity <- TN / (TN + FP)
  f1 <- 2 * TP / (2 * TP + FP + FN)
  
  precision[!is.finite(precision)] <- NA
  recall[!is.finite(recall)] <- NA
  specificity[!is.finite(specificity)] <- NA
  f1[!is.finite(f1)] <- NA
  
  list(
    Confusion = cm,
    
    Per_Class = data.frame(
      Class = rownames(cm),
      Support = as.numeric(rowSums(cm)),
      Precision = as.numeric(precision),
      Recall = as.numeric(recall),
      Specificity = as.numeric(specificity),
      F1 = as.numeric(f1)
    ),
    
    Overall = c(
      Accuracy = sum(TP) / sum(cm),
      Macro_Precision = mean(precision),
      Macro_Recall = mean(recall),
      Macro_F1 = mean(f1)
    )
  )
}

# Accuracy: correct / total
# Precision: TP / (TP + FP)
# Recall or sensitivity: TP / (TP + FN)
# Specificity: TN / (TN + FP)
# F1: 2TP / (2TP + FP + FN)
#
# Multiclass metrics treat each class as positive versus all others.
# Macro average gives every class equal weight.
# Undefined class metrics remain NA; this is not silently hidden.
#
# High accuracy can hide poor minority-class performance.
# Inspect the confusion matrix, class support, recall, and F1.
#
# Training accuracy != generalization performance.
# Compare models on the SAME test rows.
# Select/tune parameters using training resampling, not the final test set.


# =====================================================================
# 12. REGRESSION AND MODEL COMPARISON ----
# =====================================================================

# TARGET IS NUMERIC.
# Common tasks:
# lm(), summary(), significant predictors, coefficients, prediction,
# R2, adjusted R2, RMSE, MAE, diagnostics, model comparison.

df <- mtcars[, c("mpg", "hp", "wt", "disp")]

str(df)
summary(df)
colSums(is.na(df))
pairs(df)
cor(df)

# FULL-DATA MODEL: interpretation and requested new-car prediction
full_model <- lm(mpg ~ hp + wt + disp, data = df)

summary(full_model)
coef(full_model)
confint(full_model)

# Significant predictors at 5%:
coefficient_table <- coef(summary(full_model))

significant_predictors <- coefficient_table[
  rownames(coefficient_table) != "(Intercept)" &
    coefficient_table[, "Pr(>|t|)"] < 0.05,
  ,
  drop = FALSE
]

significant_predictors

# Interpret each slope HOLDING OTHER PREDICTORS CONSTANT.
# wt is in 1000 lb; disp is in cubic inches.
# A p-value >= .05 does not prove "no relationship".
# Correlated predictors can weaken evidence for separate effects.
# The intercept may describe an unrealistic predictor combination.

new_car <- data.frame(hp = 150, wt = 3, disp = 200)

predict(full_model, newdata = new_car)

predict(
  full_model,
  newdata = new_car,
  interval = "prediction",
  level = 0.95
)

# confidence interval: uncertainty in MEAN response
# prediction interval: uncertainty for an INDIVIDUAL future response
# Prediction intervals are wider.

# TRAINING FIT COMPARISON
full_m1 <- lm(mpg ~ hp, data = df)
full_m2 <- lm(mpg ~ hp + wt + disp, data = df)

fit_summary <- function(model) {
  s <- summary(model)
  
  c(
    R2 = s$r.squared,
    Adjusted_R2 = s$adj.r.squared,
    RMSE = sqrt(mean(residuals(model)^2)),
    MAE = mean(abs(residuals(model)))
  )
}

round(rbind(
  Model_1 = fit_summary(full_m1),
  Model_2 = fit_summary(full_m2)
), 3)

# Adding predictors cannot reduce training R2 for nested OLS models
# fitted to the same rows. Adjusted R2 includes a complexity penalty.
# Test errors are needed to assess predictions on unseen observations.

# FAIR TRAIN/TEST COMPARISON
set.seed(123)
index <- sample(seq_len(nrow(df)), floor(0.8 * nrow(df)))

train <- df[index, ]
test <- df[-index, ]

model1 <- lm(mpg ~ hp, data = train)
model2 <- lm(mpg ~ hp + wt + disp, data = train)

pred1 <- predict(model1, newdata = test)
pred2 <- predict(model2, newdata = test)

comparison <- rbind(
  Model_1 = reg_metrics(test$mpg, pred1),
  Model_2 = reg_metrics(test$mpg, pred2)
)

round(comparison, 3)

# Select by test RMSE for this exercise:
best_name <- rownames(comparison)[which.min(comparison[, "RMSE"])]
best_name

# If MAE favors a different model, report the disagreement.
# With only 32 cars, a single split is unstable.

# DIAGNOSTICS
old_par <- par(mfrow = c(2, 2))
plot(full_model)
par(old_par)

# Residuals vs fitted: look for patterns/nonlinearity.
# Q-Q: residual normality matters for usual inferential calculations.
# Scale-location: unequal residual spread.
# Residuals vs leverage: influential observations.
#
# If asked for multicollinearity:
# install.packages("car")
# car::vif(full_model)
# VIF is a diagnostic, not an automatic deletion rule.

# ADDITIONAL FORMULA PATTERNS
# lm(mpg ~ hp, data = df)                 # Simple regression
# lm(mpg ~ hp + wt, data = df)            # Multiple regression
# lm(mpg ~ hp * wt, data = df)            # hp + wt + interaction
# lm(mpg ~ hp + I(hp^2), data = df)       # Quadratic term
# lm(mpg ~ factor(cyl) + wt, data=mtcars) # Categorical predictor
#
# Do not use factor codes as a continuous predictor accidentally.

# OPTIONAL: 5-FOLD CV FOR REGRESSION
# Use when asked for cross-validation; both models use the same folds.
# The example data have no missing values and need no learned scaling.
if (FALSE) {
  set.seed(123)
  folds <- sample(rep(1:5, length.out = nrow(df)))
  
  cv_pred1 <- rep(NA_real_, nrow(df))
  cv_pred2 <- rep(NA_real_, nrow(df))
  
  for (fold in 1:5) {
    training <- df[folds != fold, ]
    validation <- df[folds == fold, ]
    
    m1 <- lm(mpg ~ hp, data = training)
    m2 <- lm(mpg ~ hp + wt + disp, data = training)
    
    cv_pred1[folds == fold] <- predict(m1, validation)
    cv_pred2[folds == fold] <- predict(m2, validation)
  }
  
  rbind(
    Model_1 = reg_metrics(df$mpg, cv_pred1),
    Model_2 = reg_metrics(df$mpg, cv_pred2)
  )
}

# If preprocessing is needed, learn it separately INSIDE each CV fold.


# =====================================================================
# 13. CLASSIFICATION: TREE, NAIVE BAYES, SVM ----
# =====================================================================
#
# Run Section 11 first for class_metrics().

library(rpart)
library(rpart.plot)
library(e1071)

df <- iris
df$Species <- factor(df$Species)

str(df)
table(df$Species)
colSums(is.na(df))

# STRATIFIED SPLIT: sample within every species.
# This gives 40 training and 10 test flowers from each iris species.
set.seed(123)

index <- unlist(lapply(
  split(seq_len(nrow(df)), df$Species),
  function(rows) sample(rows, floor(0.8 * length(rows)))
))

train <- df[index, ]
test <- df[-index, ]

table(train$Species)
table(test$Species)

# For very small classes, ensure both train and test contain observations.
# Do not randomly split repeated records from the same person across
# train/test if the task requires generalization to new people.

# A. DECISION TREE
tree_model <- rpart(
  Species ~ .,
  data = train,
  method = "class"
)

rpart.plot(tree_model, type = 2, extra = 104)

tree_pred <- predict(tree_model, newdata = test, type = "class")

tree_result <- class_metrics(test$Species, tree_pred)
tree_result$Confusion
tree_result$Per_Class
tree_result$Overall

sort(tree_model$variable.importance, decreasing = TRUE)

# Importance can include surrogate splits.
# A constant/no-split tree may not have a useful importance vector.
#
# Optional pruning based on training cross-validation:
# printcp(tree_model)
# plotcp(tree_model)
# best_cp <- tree_model$cptable[
#   which.min(tree_model$cptable[, "xerror"]), "CP"
# ]
# pruned_tree <- prune(tree_model, cp = best_cp)
# Do not choose cp by repeatedly checking final test accuracy.

# B. NAIVE BAYES
nb_model <- naiveBayes(Species ~ ., data = train)

nb_pred <- predict(nb_model, newdata = test, type = "class")
nb_probability <- predict(nb_model, newdata = test, type = "raw")

nb_result <- class_metrics(test$Species, nb_pred)
nb_result$Confusion
nb_result$Per_Class

# Numeric predictors use a class-conditional Gaussian assumption here.
# Naive Bayes assumes predictors are conditionally independent given class.
# This can still work even when the independence assumption is imperfect.
#
# For categorical predictors, Laplace smoothing:
# naiveBayes(Target ~ ., data = train, laplace = 1)

# C. SVM: EXPLICIT TRAINING-BASED STANDARDIZATION
features <- c(
  "Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"
)

x_train <- scale(train[, features])

x_test <- scale(
  test[, features],
  center = attr(x_train, "scaled:center"),
  scale = attr(x_train, "scaled:scale")
)

train_scaled <- train
test_scaled <- test

train_scaled[, features] <- x_train
test_scaled[, features] <- x_test

svm_model <- svm(
  Species ~ .,
  data = train_scaled,
  kernel = "radial",
  cost = 1,
  gamma = 1 / length(features),
  scale = FALSE
)

svm_pred <- predict(svm_model, newdata = test_scaled)

svm_result <- class_metrics(test$Species, svm_pred)
svm_result$Confusion
svm_result$Per_Class

# Short alternative if explicit scale() is NOT required:
# fit <- svm(Species ~ ., data=train, kernel="radial", scale=TRUE)
# predict(fit, newdata=test)
# svm then stores training scaling and applies it during predict().
# Use ONE scaling method; do not scale twice.

# D. COMPARE ON IDENTICAL TEST ROWS
classification_comparison <- rbind(
  Decision_Tree = tree_result$Overall,
  Naive_Bayes = nb_result$Overall,
  SVM = svm_result$Overall
)

round(classification_comparison, 3)

# Highest accuracy means most correct predictions.
# Macro F1 gives equal weight to each class.
# Do not assume a particular algorithm must win.

# A simple majority-class baseline:
majority_class <- names(which.max(table(train$Species)))
baseline_pred <- rep(majority_class, nrow(test))
class_metrics(test$Species, baseline_pred)$Overall

# E. PREDICT A NEW FLOWER
new_flower <- data.frame(
  Sepal.Length = 5.1,
  Sepal.Width = 3.5,
  Petal.Length = 1.4,
  Petal.Width = 0.2
)

predict(tree_model, new_flower, type = "class")
predict(nb_model, new_flower, type = "class")

# Our SVM was explicitly standardized, so transform new data too.
new_scaled <- as.data.frame(scale(
  new_flower[, features],
  center = attr(x_train, "scaled:center"),
  scale = attr(x_train, "scaled:scale")
))

predict(svm_model, new_scaled)

# Target ~ . is convenient ONLY when all other columns are valid predictors.
# Exclude names, IDs, outcomes, and leaked information.


# =====================================================================
# 14. OTHER CLASSIFICATION VARIATIONS ----
# =====================================================================

# A. KNN: needs scaling and a chosen k.
# Run after Section 13 so x_train, x_test, train, test exist.
if (FALSE) {
  knn_pred <- class::knn(
    train = x_train,
    test = x_test,
    cl = train$Species,
    k = 5
  )
  
  class_metrics(test$Species, knn_pred)
}
# Choose k using training cross-validation, not the final test set.

# B. RANDOM FOREST
if (FALSE) {
  set.seed(123)
  
  rf_model <- randomForest::randomForest(
    Species ~ .,
    data = train,
    ntree = 300,
    importance = TRUE
  )
  
  rf_pred <- predict(rf_model, test)
  class_metrics(test$Species, rf_pred)
  
  randomForest::importance(rf_model)
  randomForest::varImpPlot(rf_model)
}

# C. BINARY LOGISTIC REGRESSION
# Predict transmission: am = 0 automatic, 1 manual.
# Numeric 0/1 response with family=binomial is valid for glm().
if (FALSE) {
  df <- mtcars[, c("am", "wt", "hp")]
  
  set.seed(123)
  index <- sample(seq_len(nrow(df)), floor(0.8 * nrow(df)))
  
  train <- df[index, ]
  test <- df[-index, ]
  
  logistic_model <- glm(
    am ~ wt + hp,
    data = train,
    family = binomial
  )
  
  summary(logistic_model)
  
  probability <- predict(logistic_model, test, type = "response")
  predicted <- ifelse(probability >= 0.5, "Manual", "Automatic")
  
  actual <- factor(
    ifelse(test$am == 1, "Manual", "Automatic"),
    levels = c("Automatic", "Manual")
  )
  
  result <- class_metrics(actual, predicted)
  result$Confusion
  result$Per_Class
  
  # The "Manual" row gives metrics with Manual as positive.
  # exp(coef(logistic_model)) gives odds ratios.
  
  # ROC/AUC requires probability scores and both classes in the test set.
  roc_object <- pROC::roc(
    actual,
    probability,
    levels = c("Automatic", "Manual"),
    direction = "<"
  )
  
  pROC::auc(roc_object)
  plot(roc_object)
}

# Threshold 0.5 is a default, not universally optimal.
# Select thresholds using training validation and the task's error costs.
# Do not report probabilities as if they were class labels.


# =====================================================================
# 15. CLUSTERING NUMERICAL DATA ----
# =====================================================================

library(cluster)
library(factoextra)

df <- USArrests[, c("Murder", "Assault", "UrbanPop", "Rape")]

summary(df)
colSums(is.na(df))

x <- scale(df)

# Choose K:
set.seed(123)
fviz_nbclust(x, kmeans, method = "wss", nstart = 25)

set.seed(123)
fviz_nbclust(x, kmeans, method = "silhouette", nstart = 25)

# WSS: look for an elbow.
# Silhouette: look for the maximum.
# They may disagree. State your reason for selecting K.
k <- 2   # Example: revise after inspecting your plots.

# K-MEANS
set.seed(123)
km <- kmeans(x, centers = k, nstart = 25)

km$cluster
km$size
km$centers

# HIERARCHICAL
d <- dist(x, method = "euclidean")
hc <- hclust(d, method = "ward.D2")

plot(hc, main = "Hierarchical Clustering", cex = 0.6)
rect.hclust(hc, k = k, border = 2:(k + 1))

hc_group <- cutree(hc, k = k)

# PAM
pm <- pam(x, k = k)

pm$clustering
pm$medoids

# VISUALIZE
fviz_cluster(
  list(data = x, cluster = km$cluster),
  stand = FALSE, geom = "point", ellipse = FALSE,
  main = "K-Means"
)

fviz_cluster(
  list(data = x, cluster = hc_group),
  stand = FALSE, geom = "point", ellipse = FALSE,
  main = "Hierarchical"
)

fviz_cluster(
  list(data = x, cluster = pm$clustering),
  stand = FALSE, geom = "point", ellipse = FALSE,
  main = "PAM"
)

# Plots use a 2-D projection when there are more than two features.
# The models used all selected standardized features.

assignments <- data.frame(
  State = rownames(df),
  KMeans = km$cluster,
  Hierarchical = hc_group,
  PAM = pm$clustering
)

assignments

table(KMeans = km$cluster, Hierarchical = hc_group)
table(KMeans = km$cluster, PAM = pm$clustering)

# Cluster numbers are arbitrary.
# "1" in one method may correspond to "2" in another.
# Do not compare cluster labels using simple equality accuracy.

quality <- c(
  KMeans = mean(silhouette(km$cluster, d)[, "sil_width"]),
  Hierarchical = mean(silhouette(hc_group, d)[, "sil_width"]),
  PAM = mean(silhouette(pm$clustering, d)[, "sil_width"])
)

round(quality, 3)

# Interpret using original units:
aggregate(df, by = list(Cluster = km$cluster), FUN = mean)
aggregate(df, by = list(Cluster = hc_group), FUN = mean)
aggregate(df, by = list(Cluster = pm$clustering), FUN = mean)

# K-Means: centers are means; sensitive to extreme observations.
# Hierarchical: nested merges shown by a tree.
# PAM: representatives are actual observations (medoids).
# High silhouette suggests separation under the chosen distance,
# not proof that the clusters have universal real-world meaning.


# =====================================================================
# 16. TIME SERIES AND FORECASTING ----
# =====================================================================

library(forecast)

# IMPORTANT: lowercase co2!
y <- datasets::co2

class(y)
start(y)
end(y)
frequency(y)
length(y)
summary(y)
sum(is.na(y))

# FROM CSV:
# raw <- read.csv(file.choose())
# raw$Date <- as.Date(raw$Date)
# raw <- raw[order(raw$Date), ]
# y <- ts(raw$Value, start = c(2020, 1), frequency = 12)
#
# This assumes exactly one observation per month with no missing months.
# ts() does not inspect your Date column or detect calendar gaps.
# Aggregate duplicates and represent missing months explicitly first.
#
# frequency=12 monthly; frequency=4 quarterly.
# Do not use na.omit() to compress away missing months.
# Do not interpolate test values using future information.

# EXPLORE
plot(y, main = "Monthly CO2", xlab = "Year", ylab = "ppm")
monthplot(y, main = "Monthly Seasonal Pattern", ylab = "ppm")
acf(y, main = "Autocorrelation")

# Trend: long-term movement.
# Seasonality: repetition at a fixed calendar period.
# Raw ACF can be large because of trend, not only seasonality.

# DECOMPOSITION
dec <- decompose(y, type = "additive")
plot(dec)

seasonal_effect <- setNames(dec$figure, month.abb)
round(seasonal_effect, 2)

names(which.max(seasonal_effect))
names(which.min(seasonal_effect))

# Additive: observed = trend + seasonal + random.
# Use when seasonal swings are approximately constant in absolute size.
#
# Multiplicative: observed = trend * seasonal * random.
# Consider for strictly positive values with proportional seasonal swings.
#
# Classical decomposition has missing trend/random values at the ends.
# Alternative:
# plot(stl(y, s.window = "periodic"))
#
# Full-series decomposition here is descriptive.
# Models below learn only from the training period.

# CHRONOLOGICAL SPLIT
h <- 12
n <- length(y)

train <- window(y, end = time(y)[n - h])
test <- window(y, start = time(y)[n - h + 1])

length(train)
length(test)
end(train)
start(test)

# MODEL 1: SEASONAL NAIVE
fc_sn <- snaive(train, h = h)

# MODEL 2: ADDITIVE HOLT-WINTERS
fit_hw <- HoltWinters(train, seasonal = "additive")
fc_hw <- forecast(fit_hw, h = h)

# MODEL 3: SEASONAL ARIMA
fit_arima <- auto.arima(
  train,
  seasonal = TRUE,
  approximation = FALSE
)

fc_arima <- forecast(fit_arima, h = h)

# Optional alternatives:
# fc_holt <- holt(train, h = h)  # Trend, no explicit seasonality
# fit_ets <- ets(train)
# fc_ets <- forecast(fit_ets, h = h)

# TEST-PERIOD PLOT
plot(fc_arima, main = "ARIMA Forecast versus Actual", ylab = "ppm")
lines(test, col = "red", lwd = 2)

legend(
  "topleft",
  legend = c("Forecast", "Actual test values"),
  col = c("blue", "red"),
  lty = 1,
  bty = "n"
)

# TEST METRICS
wanted <- c("MAE", "RMSE", "MAPE")

forecast_comparison <- rbind(
  Seasonal_Naive = accuracy(fc_sn, test)["Test set", wanted],
  Holt_Winters = accuracy(fc_hw, test)["Test set", wanted],
  ARIMA = accuracy(fc_arima, test)["Test set", wanted]
)

round(forecast_comparison, 3)

# accuracy(forecast_object) alone gives training accuracy.
# Supply actual test data and select the "Test set" row.

best <- rownames(forecast_comparison)[
  which.min(forecast_comparison[, "RMSE"])
]
best

# Training residual diagnostic:
checkresiduals(fit_arima)

# Residual autocorrelation suggests remaining predictable structure.
# A residual test does not replace test-period evaluation.

# REFIT SELECTED METHOD ON ALL OBSERVED DATA
if (best == "Seasonal_Naive") {
  
  future <- snaive(y, h = 12, level = c(80, 95))
  
} else if (best == "Holt_Winters") {
  
  final_model <- HoltWinters(y, seasonal = "additive")
  future <- forecast(final_model, h = 12, level = c(80, 95))
  
} else {
  
  final_model <- auto.arima(
    y, seasonal = TRUE, approximation = FALSE
  )
  future <- forecast(final_model, h = 12, level = c(80, 95))
}

print(future)
plot(future, include = 60, main = paste("Selected Method:", best))

# co2 ends in December 1997, so this forecast covers 1998.
# Forecast bands are prediction intervals for future observations.
# 95% intervals are wider than 80% intervals.
#
# Six-sentence interpretation plan:
# 1. Describe observed trend.
# 2. Describe seasonal timing/amplitude.
# 3. Explain decomposition and remaining variation.
# 4. Report the selected method and actual test metrics.
# 5. Describe the forecast and its uncertainty.
# 6. Explain practical use and limitations.
#
# For sales: inventory/staffing.
# For CO2: environmental monitoring.
# Do not invent findings before reading your output.


# =====================================================================
# 17. TEXT MINING AND SENTIMENT ANALYSIS ----
# =====================================================================
#
# Run the following block only when you have the Tweets.csv file.
# Change FALSE to TRUE, or run the lines inside the block.
#
# Dataset:
# https://raw.githubusercontent.com/satyajeetkrjha/
# kaggle-Twitter-US-Airline-Sentiment-/master/Tweets.csv
#
# Required columns: tweet_id, airline, text.
# Read long tweet IDs as character to avoid numeric precision loss.

if (FALSE) {
  
  library(dplyr)
  library(tidyr)
  library(stringr)
  library(tidytext)
  library(ggplot2)
  
  raw <- read.csv(
    file.choose(),
    colClasses = "character",
    stringsAsFactors = FALSE
  )
  
  tweets <- raw |>
    select(tweet_id, airline, text) |>
    distinct(tweet_id, .keep_all = TRUE) |>
    filter(!is.na(text), !is.na(airline), str_trim(text) != "") |>
    mutate(
      doc_id = row_number(),
      clean = str_to_lower(text),
      clean = str_replace_all(clean, "https?://\\S+|www\\.\\S+", " "),
      clean = str_replace_all(clean, "@\\w+", " "),
      clean = str_replace_all(clean, "&amp;", " and "),
      clean = str_replace_all(clean, "&[a-z]+;", " "),
      clean = str_replace_all(clean, "’", "'"),
      clean = str_replace_all(clean, "[^a-z\\s']", " "),
      clean = str_squish(clean)
    )
  
  # TOKENIZATION: one word occurrence per row.
  tokens <- tweets |>
    select(doc_id, airline, clean) |>
    unnest_tokens(word, clean)
  
  # Stopword-filtered version for topic analysis.
  words <- tokens |>
    anti_join(stop_words, by = "word") |>
    filter(word != "rt", str_detect(word, "[a-z]"))
  
  # Keep tokens for sentiment; stopword lists can remove useful terms.
  
  # WORD FREQUENCY
  word_freq <- words |> count(word, sort = TRUE)
  print(head(word_freq, 20))
  
  print(
    word_freq |>
      slice_head(n = 20) |>
      ggplot(aes(reorder(word, n), n)) +
      geom_col(fill = "steelblue") +
      coord_flip() +
      labs(x = NULL, y = "Occurrences") +
      theme_minimal()
  )
  
  # BIGRAMS: extract BEFORE removing stopwords.
  bigrams <- tweets |>
    select(doc_id, clean) |>
    unnest_tokens(bigram, clean, token = "ngrams", n = 2) |>
    separate(bigram, into = c("w1", "w2"), sep = " ") |>
    filter(
      !is.na(w1), !is.na(w2),
      !w1 %in% stop_words$word,
      !w2 %in% stop_words$word
    ) |>
    unite(bigram, w1, w2, sep = " ") |>
    count(bigram, sort = TRUE)
  
  print(head(bigrams, 15))
  
  # This filtered bigram table describes topics.
  # It can exclude phrases such as "not good".
  
  # BAG OF WORDS
  bow <- words |> count(doc_id, word, name = "n")
  bow_matrix <- cast_sparse(bow, doc_id, word, n)
  
  print(dim(bow_matrix))
  # Tweets with no retained tokens are absent from this matrix.
  
  # TF-IDF: one tweet is one document
  tfidf <- bow |>
    bind_tf_idf(word, doc_id, n) |>
    arrange(desc(tf_idf))
  
  print(head(tfidf, 20))
  
  # Airline-level TF-IDF: all tweets about an airline form one document.
  airline_tfidf <- words |>
    count(airline, word, name = "n") |>
    bind_tf_idf(word, airline, n)
  
  print(
    airline_tfidf |>
      group_by(airline) |>
      slice_max(tf_idf, n = 5, with_ties = FALSE) |>
      ungroup()
  )
  
  # TF-IDF measures distinctiveness, not positive/negative sentiment.
  
  # LEXICONS
  # AFINN/NRC may prompt for a first-time textdata download/terms.
  bing <- get_sentiments("bing")
  afinn <- get_sentiments("afinn")
  nrc <- get_sentiments("nrc")
  
  # Standardize to word, method, numeric contribution.
  dictionary <- bind_rows(
    bing |>
      transmute(
        word,
        method = "Bing",
        value = if_else(sentiment == "positive", 1, -1)
      ),
    
    afinn |>
      transmute(word, method = "AFINN", value),
    
    nrc |>
      filter(sentiment %in% c("positive", "negative")) |>
      transmute(
        word,
        method = "NRC",
        value = if_else(sentiment == "positive", 1, -1)
      )
  )
  
  matched <- tokens |>
    inner_join(dictionary, by = "word", relationship = "many-to-many") |>
    group_by(doc_id, method) |>
    summarise(score = sum(value), .groups = "drop")
  
  # Include every tweet-method combination, including unmatched tweets.
  scores <- crossing(
    doc_id = tweets$doc_id,
    method = c("Bing", "AFINN", "NRC")
  ) |>
    left_join(matched, by = c("doc_id", "method")) |>
    mutate(
      matched = !is.na(score),
      score = replace_na(score, 0),
      label = case_when(
        !matched ~ "Unmatched",
        score > 0 ~ "Positive",
        score < 0 ~ "Negative",
        TRUE ~ "Zero score"
      )
    ) |>
    left_join(
      tweets |> select(doc_id, airline),
      by = "doc_id"
    )
  
  comparison <- scores |>
    count(method, label) |>
    group_by(method) |>
    mutate(percent = 100 * n / sum(n)) |>
    ungroup()
  
  print(comparison)
  
  print(
    ggplot(comparison, aes(method, percent, fill = label)) +
      geom_col() +
      labs(y = "Percentage of tweets", x = NULL) +
      theme_minimal()
  )
  
  # Common positive/negative terms:
  sentiment_terms <- tokens |>
    inner_join(bing, by = "word", relationship = "many-to-many") |>
    count(sentiment, word, sort = TRUE)
  
  top_terms <- sentiment_terms |>
    group_by(sentiment) |>
    slice_max(n, n = 10, with_ties = FALSE) |>
    ungroup()
  
  print(top_terms)
  
  print(
    ggplot(top_terms,
           aes(reorder_within(word, n, sentiment), n, fill = sentiment)) +
      geom_col(show.legend = FALSE) +
      coord_flip() +
      scale_x_reordered() +
      facet_wrap(~ sentiment, scales = "free") +
      theme_minimal()
  )
  
  # NRC emotions:
  emotions <- tokens |>
    inner_join(
      nrc |> filter(!sentiment %in% c("positive", "negative")),
      by = "word",
      relationship = "many-to-many"
    ) |>
    count(sentiment, sort = TRUE)
  
  print(emotions)
  
  print(
    ggplot(emotions, aes(reorder(sentiment, n), n)) +
      geom_col(fill = "orange") +
      coord_flip() +
      labs(x = "Emotion", y = "Word-category matches") +
      theme_minimal()
  )
  
  # Airline comparison: percentages, because tweet counts differ.
  airline_results <- scores |>
    group_by(airline, method) |>
    summarise(
      Tweets = n(),
      Negative_Percent = 100 * mean(label == "Negative"),
      Positive_Percent = 100 * mean(label == "Positive"),
      Unmatched_Percent = 100 * mean(label == "Unmatched"),
      .groups = "drop"
    )
  
  print(airline_results)
  
  print(
    ggplot(airline_results,
           aes(airline, Negative_Percent, fill = method)) +
      geom_col(position = "dodge") +
      coord_flip() +
      theme_minimal()
  )
}

# LIMITATIONS:
# AFINN includes intensity; Bing/NRC use category contributions here.
# Raw scores across these methods are not on equivalent scales.
# Unmatched does not mean neutral.
# A zero score can represent balanced positive/negative contributions.
# NRC words may belong to several emotions.
# Unigram matching does not understand sarcasm or handle negation.
# "Not good" may still receive a positive contribution from "good".
# Basic cleaning removes emojis and can lose sentiment information.
# Tweet samples are not representative surveys of all customers.


# =====================================================================
# 18. SHINY INPUT/OUTPUT GUIDE ----
# =====================================================================
#
# THINK:
# What should the user choose?
# What calculations depend on that choice?
# What output format should display the result?
#
# UI INPUTS:
# selectInput("id", "Label", choices, selected)
# sliderInput("id", "Label", min, max, value)
# numericInput("id", "Label", value, min, max)
# textInput("id", "Label", value)
# checkboxInput("id", "Label", value=TRUE)
# checkboxGroupInput("id", "Label", choices, selected)
# radioButtons("id", "Label", choices)
# dateInput("id", "Label")
# dateRangeInput("id", "Label")
# fileInput("id", "Upload CSV", accept=".csv")
# actionButton("id", "Calculate")
#
# MATCHING OUTPUT PAIRS:
# tableOutput("x")          <-> output$x <- renderTable({...})
# plotOutput("x")           <-> output$x <- renderPlot({...})
# textOutput("x")           <-> output$x <- renderText({...})
# verbatimTextOutput("x")   <-> output$x <- renderPrint({...})
# uiOutput("x")             <-> output$x <- renderUI({...})
# DT::DTOutput("x")         <-> output$x <- DT::renderDT({...})
# downloadButton("x", ...)  <-> output$x <- downloadHandler(...)
#
# INPUT ACCESS:
# input$variable is usually the selected NAME as text.
# df[[input$variable]] extracts its actual column values.
#
# selectInput returns text; use as.numeric() when needed.
#
# REACTIVITY:
# filtered <- reactive({ ... })
# filtered()              # Parentheses are required to get the result.
#
# req(input$file)         # Wait until input is available.
# validate(need(condition, "Helpful message"))
#
# eventReactive(input$go, {...})
# Recalculate only after an action button is clicked.
#
# observeEvent(input$go, {...})
# For side effects such as updating controls.
#
# LAYOUT:
# fluidPage()
# sidebarLayout(sidebarPanel(...), mainPanel(...))
# fluidRow(column(4,...), column(4,...), column(4,...))
# Column widths add up to 12.
# tabsetPanel(tabPanel("Table",...), tabPanel("Plot",...))
#
# UI ids must match input/output references exactly.
# Keep calculations depending on inputs inside reactive/render contexts.
# Don't run every Shiny app in this file together.


# =====================================================================
# 19. SHINY: MTCARS EXPLORER ----
# =====================================================================
#
# Covers:
# - Filter by cylinder
# - Select a variable and show summary
# - Select a variable and show histogram
# - Select X and Y for a scatter plot
#
# All outputs use the cylinder-filtered records.
# For a simpler exam question, retain only the relevant controls/output.

run_cars_app <- function() {
  
  library(shiny)
  cars <- mtcars
  
  ui <- fluidPage(
    titlePanel("Cars Explorer"),
    
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "cylinders", "Cylinders:",
          choices = c("All", sort(unique(cars$cyl)))
        ),
        
        selectInput(
          "variable", "Summary / histogram variable:",
          choices = names(cars), selected = "mpg"
        ),
        
        sliderInput(
          "bins", "Histogram bins:",
          min = 3, max = 20, value = 8
        ),
        
        selectInput(
          "xvar", "X-axis:",
          choices = names(cars), selected = "wt"
        ),
        
        selectInput(
          "yvar", "Y-axis:",
          choices = names(cars), selected = "mpg"
        )
      ),
      
      mainPanel(
        tabsetPanel(
          tabPanel("Records", tableOutput("records")),
          tabPanel("Summary", verbatimTextOutput("summary")),
          tabPanel("Histogram", plotOutput("histogram")),
          tabPanel("Scatter", plotOutput("scatter"))
        )
      )
    )
  )
  
  server <- function(input, output) {
    
    filtered <- reactive({
      if (input$cylinders == "All") {
        cars
      } else {
        cars[cars$cyl == as.numeric(input$cylinders), ]
      }
    })
    
    output$records <- renderTable({
      filtered()
    }, rownames = TRUE)
    
    output$summary <- renderPrint({
      summary(filtered()[[input$variable]])
    })
    
    output$histogram <- renderPlot({
      values <- filtered()[[input$variable]]
      
      # "breaks" as a single number is a suggested bin count.
      hist(
        values,
        breaks = input$bins,
        main = paste("Histogram of", input$variable),
        xlab = input$variable,
        col = "skyblue",
        border = "white"
      )
    })
    
    output$scatter <- renderPlot({
      d <- filtered()
      
      plot(
        d[[input$xvar]],
        d[[input$yvar]],
        xlab = input$xvar,
        ylab = input$yvar,
        main = paste(input$yvar, "versus", input$xvar),
        pch = 19,
        col = "blue"
      )
    })
  }
  
  shinyApp(ui, server)
}

# LAUNCH:
# run_cars_app()


# =====================================================================
# 20. SHINY: IRIS FILTER + KPIs ----
# =====================================================================
#
# Covers:
# - Select species
# - Display matching records
# - Number of observations
# - Average sepal length
# - Average petal length

run_iris_app <- function() {
  
  library(shiny)
  
  ui <- fluidPage(
    titlePanel("Iris Species Statistics"),
    
    selectInput(
      "species", "Select species:",
      choices = levels(iris$Species),
      selected = "setosa"
    ),
    
    tableOutput("stats"),
    tableOutput("records")
  )
  
  server <- function(input, output) {
    
    selected <- reactive({
      iris[iris$Species == input$species, ]
    })
    
    output$stats <- renderTable({
      d <- selected()
      
      data.frame(
        Observations = nrow(d),
        Average_Sepal_Length = mean(d$Sepal.Length),
        Average_Petal_Length = mean(d$Petal.Length)
      )
    }, digits = 3)
    
    output$records <- renderTable({
      selected()
    })
  }
  
  shinyApp(ui, server)
}

# run_iris_app()

# For multiple species selection:
# selectInput(..., multiple=TRUE, selected=levels(iris$Species))
# Filter with iris$Species %in% input$species, not ==.


# =====================================================================
# 21. SHINY: STUDENT ANALYTICS DASHBOARD ----
# =====================================================================
#
# Filters: department, semester, minimum mark.
# Outputs: total students, mean mark, mean attendance, table,
# histogram, department averages, downloadable filtered CSV.
#
# All outputs describe the filtered records.
# Choosing one department means the department chart has one bar.

run_student_app <- function() {
  
  library(shiny)
  
  set.seed(123)
  n <- 60
  
  students <- data.frame(
    Student_ID = 1:n,
    Name = paste("Student", 1:n),
    Gender = sample(c("Male", "Female"), n, replace = TRUE),
    Department = rep(c("CSE", "ECE", "MECH"), each = 20),
    Semester = rep(1:4, length.out = n),
    Mark = sample(0:100, n, replace = TRUE),
    Attendance = sample(50:100, n, replace = TRUE)
  )
  
  # To use real data, replace the creation block with read.csv().
  # Validate marks/attendance are numeric and in 0..100.
  # Handle missing values before interpreting averages.
  
  ui <- fluidPage(
    titlePanel("Student Analytics Dashboard"),
    
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "department", "Department:",
          choices = c("All", sort(unique(students$Department)))
        ),
        
        selectInput(
          "semester", "Semester:",
          choices = c("All", sort(unique(students$Semester)))
        ),
        
        sliderInput(
          "min_mark", "Minimum mark:",
          min = 0, max = 100, value = 0
        ),
        
        downloadButton("download", "Download Filtered CSV")
      ),
      
      mainPanel(
        fluidRow(
          column(4, wellPanel(
            h4("Total Students"), textOutput("total")
          )),
          column(4, wellPanel(
            h4("Average Mark"), textOutput("avg_mark")
          )),
          column(4, wellPanel(
            h4("Average Attendance"), textOutput("avg_attendance")
          ))
        ),
        
        tabsetPanel(
          tabPanel("Students", tableOutput("records")),
          tabPanel("Marks", plotOutput("marks")),
          tabPanel("Departments", plotOutput("departments"))
        )
      )
    )
  )
  
  server <- function(input, output) {
    
    filtered <- reactive({
      d <- students
      
      if (input$department != "All") {
        d <- d[d$Department == input$department, ]
      }
      
      if (input$semester != "All") {
        d <- d[d$Semester == as.numeric(input$semester), ]
      }
      
      d <- d[!is.na(d$Mark) & d$Mark >= input$min_mark, ]
      d
    })
    
    output$total <- renderText({
      nrow(filtered())
    })
    
    output$avg_mark <- renderText({
      d <- filtered()
      
      if (nrow(d) == 0) {
        "No data"
      } else {
        round(mean(d$Mark), 2)
      }
    })
    
    output$avg_attendance <- renderText({
      d <- filtered()
      
      if (nrow(d) == 0 || all(is.na(d$Attendance))) {
        "No data"
      } else {
        paste0(round(mean(d$Attendance, na.rm = TRUE), 2), "%")
      }
    })
    
    output$records <- renderTable({
      filtered()
    })
    
    output$marks <- renderPlot({
      d <- filtered()
      
      validate(need(nrow(d) > 0, "No students match the filters."))
      
      hist(
        d$Mark,
        breaks = seq(0, 100, by = 10),
        main = "Marks Distribution",
        xlab = "Mark",
        col = "skyblue",
        border = "white"
      )
    })
    
    output$departments <- renderPlot({
      d <- filtered()
      
      validate(need(nrow(d) > 0, "No students match the filters."))
      
      avg <- aggregate(Mark ~ Department, data = d, FUN = mean)
      
      barplot(
        avg$Mark,
        names.arg = avg$Department,
        main = "Department-wise Average Marks",
        ylab = "Average Mark",
        col = "orange",
        ylim = c(0, 100)
      )
    })
    
    output$download <- downloadHandler(
      filename = function() {
        "Filtered_Students.csv"
      },
      content = function(file) {
        write.csv(filtered(), file, row.names = FALSE)
      }
    )
  }
  
  shinyApp(ui, server)
}

# run_student_app()


# =====================================================================
# 22. SHINY: UPLOAD CSV + DYNAMIC COLUMN SELECTION ----
# =====================================================================
#
# Covers fileInput(), req(), renderUI(), dynamic choices, and download.
# CSV numeric fields must parse as numeric; "$10" needs cleaning first.

run_upload_app <- function() {
  
  library(shiny)
  
  ui <- fluidPage(
    titlePanel("CSV Explorer"),
    
    fileInput("file", "Upload CSV:", accept = ".csv"),
    checkboxInput("header", "First row contains column names", TRUE),
    
    uiOutput("variable_control"),
    
    verbatimTextOutput("summary"),
    plotOutput("histogram"),
    tableOutput("preview"),
    
    downloadButton("download", "Download Data")
  )
  
  server <- function(input, output) {
    
    uploaded <- reactive({
      req(input$file)
      
      read.csv(
        input$file$datapath,
        header = input$header,
        stringsAsFactors = FALSE,
        na.strings = c("", "NA")
      )
    })
    
    output$variable_control <- renderUI({
      d <- uploaded()
      numeric_names <- names(d)[sapply(d, is.numeric)]
      
      validate(need(
        length(numeric_names) > 0,
        "The CSV has no numeric columns."
      ))
      
      selectInput("variable", "Numeric variable:", choices = numeric_names)
    })
    
    output$summary <- renderPrint({
      d <- uploaded()
      req(input$variable)
      req(input$variable %in% names(d))
      
      summary(d[[input$variable]])
    })
    
    output$histogram <- renderPlot({
      d <- uploaded()
      req(input$variable)
      req(input$variable %in% names(d))
      
      x <- d[[input$variable]]
      x <- x[is.finite(x)]
      
      validate(need(length(x) > 0, "No finite numeric values."))
      
      hist(
        x,
        main = paste("Histogram of", input$variable),
        xlab = input$variable,
        col = "skyblue"
      )
    })
    
    output$preview <- renderTable({
      head(uploaded(), 10)
    })
    
    output$download <- downloadHandler(
      filename = function() "Uploaded_Data.csv",
      content = function(file) {
        write.csv(uploaded(), file, row.names = FALSE)
      }
    )
  }
  
  shinyApp(ui, server)
}

# run_upload_app()

# Optional interactive table:
# UI:     DT::DTOutput("records")
# Server: output$records <- DT::renderDT({
#           DT::datatable(filtered(), options = list(pageLength = 10))
#         })


# =====================================================================
# 23. SHINY: PREDICTION FORM + DASHBOARD LAYOUT ----
# =====================================================================

# A. Numeric inputs and action-button prediction
run_prediction_app <- function() {
  
  library(shiny)
  
  # Fit once rather than refitting every time an input changes.
  fit <- lm(mpg ~ hp + wt + disp, data = mtcars)
  
  ui <- fluidPage(
    titlePanel("Predict Car Mileage"),
    
    numericInput("hp", "Horsepower:", value = 150, min = 1),
    numericInput("wt", "Weight (1000 lb):", value = 3, min = 0.1),
    numericInput("disp", "Displacement:", value = 200, min = 1),
    
    actionButton("go", "Predict"),
    tableOutput("prediction")
  )
  
  server <- function(input, output) {
    
    prediction <- eventReactive(input$go, {
      req(input$hp, input$wt, input$disp)
      
      validate(need(
        input$hp > 0 && input$wt > 0 && input$disp > 0,
        "Enter positive measurements."
      ))
      
      new_car <- data.frame(
        hp = input$hp,
        wt = input$wt,
        disp = input$disp
      )
      
      as.data.frame(predict(
        fit,
        newdata = new_car,
        interval = "prediction",
        level = 0.95
      ))
    })
    
    output$prediction <- renderTable({
      prediction()
    }, digits = 2)
  }
  
  shinyApp(ui, server)
}

# run_prediction_app()
# Predictions far outside the training range can be unreliable.

# B. If the question explicitly requests shinydashboard/valueBox:
run_valuebox_app <- function() {
  
  library(shiny)
  library(shinydashboard)
  
  ui <- dashboardPage(
    dashboardHeader(title = "Car Dashboard"),
    
    dashboardSidebar(
      selectInput(
        "cyl", "Cylinders:",
        choices = c(4, 6, 8),
        selected = 4
      )
    ),
    
    dashboardBody(
      fluidRow(
        valueBoxOutput("count"),
        valueBoxOutput("average")
      ),
      
      fluidRow(
        box(
          title = "Records",
          width = 12,
          tableOutput("records")
        )
      )
    )
  )
  
  server <- function(input, output) {
    
    filtered <- reactive({
      mtcars[mtcars$cyl == as.numeric(input$cyl), ]
    })
    
    output$count <- renderValueBox({
      valueBox(
        nrow(filtered()),
        subtitle = "Cars",
        color = "blue"
      )
    })
    
    output$average <- renderValueBox({
      valueBox(
        round(mean(filtered()$mpg), 2),
        subtitle = "Average mpg",
        color = "green"
      )
    })
    
    output$records <- renderTable({
      filtered()
    }, rownames = TRUE)
  }
  
  shinyApp(ui, server)
}

# run_valuebox_app()


# =====================================================================
# 24. COMMON ERRORS AND EXAM CHECKLIST ----
# =====================================================================

# ERROR: object 'train' not found
# CAUSE: split code was not executed, or R was restarted.
# FIX: run import -> setup -> split -> fit, in that order.

# ERROR: could not find function "rpart.plot"
# FIX:
# install.packages("rpart.plot")    # Once
# library(rpart.plot)              # Each session
# Or rpart.plot::rpart.plot(model)

# ERROR: there is no package called ...
# FIX: install the exact package name.
# Check internet/repository access and the full installation output.

# WARNING: package was built under a newer R patch version
# It is not automatically an installation failure.
# Check whether library() succeeds and whether the function runs.

# WARNING: Rtools required
# Rtools is relevant when compiling Windows packages from source.
# A successful prebuilt binary installation may not need it.
# Read the final installation result rather than only the first warning.

# ERROR: invalid time series parameters / wrong object class
# Check:
# class(y)
# str(y)
# Use datasets::co2, not CO2.

# ERROR: undefined columns selected
# Check names(df), spelling, capitalization, and imported column names.
# read.csv() can change spaces to dots by default.
# df[["Column With Spaces"]] works if that exact name was preserved.

# ERROR: cannot open file
# Check getwd(), file.exists(), and spelling.
# Use file.choose() or an absolute path.
# Don't use a directory path where a filename is required.

# ERROR: cannot open connection while exporting
# Check the folder exists and is writable.
# Close the output file if another application has locked it.

# WARNING: NAs introduced by coercion
# Text could not be converted to a number.
# Inspect unique values and compare raw versus converted values.
# Remove only known symbols/units; don't guess malformed values.

# PROBLEM: mean(x) returns NA
# There are missing values.
# Use mean(x, na.rm=TRUE) when ignoring them is appropriate.
# All values missing still gives NaN; handle that case explicitly.

# PROBLEM: factor values became 1, 2, 3
# as.numeric(factor) returns level codes.
# Use as.numeric(as.character(factor)) for numeric labels.

# PROBLEM: filter() behaves unexpectedly
# Use dplyr::filter(), not stats::filter().
# Remember missing logical conditions are dropped by dplyr::filter().

# PROBLEM: missing-value rows appear after base-R filtering
# df[df$x > 5, ] can include NA rows when df$x is missing.
# Use:
# df[!is.na(df$x) & df$x > 5, ]

# ERROR: number of intervals and length of labels differ
# cut() needs length(labels) == length(breaks) - 1.

# PROBLEM: wrong grade at an exact boundary
# Check right=FALSE versus right=TRUE.
# Test values exactly equal to 50, 60, 70, etc.

# ERROR: contrasts can be applied only to factors with 2 or more levels
# A training categorical predictor has only one observed level.
# Remove it or revise the data/split.

# ERROR: prediction has new factor levels
# New data contain categories not learned during training.
# Inspect levels and define a valid treatment for unseen categories.

# ERROR: missing values in model input
# Inspect only the columns the model uses.
# Handle missing predictors using training-derived preprocessing.
# Never silently manufacture unknown target labels.

# PROBLEM: confusion matrix is not square
# Actual and predicted factors may have different level sets.
# Align prediction levels to actual class levels before table().

# PROBLEM: accuracy is high but minority-class recall is poor
# Inspect class imbalance, confusion matrix, recall, macro F1.
# Compare to the majority-class baseline.

# PROBLEM: near-perfect model performance
# Check leakage, duplicated subjects across train/test,
# predictors containing the answer, and training-vs-test evaluation.

# ERROR: more cluster centers than distinct data points
# K exceeds the number of distinct usable observations.
# Reduce K and inspect duplicate/constant data.

# ERROR: NA/NaN/Inf after scaling
# Check missing values and zero-variance columns.
# Do not scale identifiers or class labels.

# ERROR: figure margins too large
# Enlarge RStudio's Plots pane or reset the layout:
# par(mfrow=c(1,1))
# par(mar=c(5,4,4,2)+0.1)

# ERROR: plot.new has not been called yet
# lines(), points(), legend(), and abline() add to an existing plot.
# Call plot() or hist() first.

# PROBLEM: Console shows + instead of >
# R is waiting for a closing quote, parenthesis, or brace.
# Complete the expression or press Esc.

# SHINY: blank output
# Check the UI output ID matches output$name exactly.
# Check renderTable vs renderPlot vs renderPrint.
# Check the Console for an error.

# SHINY: operation not allowed without an active reactive context
# Read input$... or reactive values inside reactive(), render...(),
# observeEvent(), or another appropriate reactive consumer.

# SHINY: object of type 'closure' is not subsettable
# You may be treating a function as a data frame.
# A reactive named filtered must be called as filtered().
# Also check whether an object name accidentally refers to a function.

# SHINY: no students match filters
# Show count 0, "No data" for means, and validate() before plotting.
# Do not display NaN as if it were a meaningful KPI.

# FINAL EXAM WORKFLOW
# -------------------
# 1. Read the requested outputs carefully.
# 2. Identify target, predictors, groups, dates, and IDs.
# 3. Load only the needed packages.
# 4. Import/create data and inspect str(), summary(), names().
# 5. Check missing values, duplicates, units, and invalid values.
# 6. Use the relevant template.
# 7. Verify predictions/filters refer to the intended rows.
# 8. Interpret actual output rather than assuming a result.
# 9. Export with meaningful filenames and row.names=FALSE for CSV.
# 10. Report limitations relevant to the task.
#
# QUICK QUESTION ROUTING
# ----------------------
# "Average marks by department"     -> aggregate / group_by + summarise
# "Above average mileage"          -> condition + mean
# "Top 10"                         -> order(descending) + head
# "Assign categories/grades"       -> cut / ifelse
# "Combine text/create labels"     -> paste / paste0
# "Remove repeated applications"   -> duplicated on the application key
# "Clean currency/size/count"      -> inspect strings -> gsub -> convert
# "Compare distributions"         -> histogram / box plot
# "Relation between measurements" -> scatter / correlation
# "Predict numerical outcome"     -> lm + regression metrics
# "Predict category"              -> classifier + confusion matrix
# "Unknown groups"                -> scale + clustering
# "Predict future months"         -> chronological split + forecasting
# "Analyze customer words"        -> tokens + counts + lexicons
# "Interactive filter"            -> input + reactive + output
# "Dashboard"                     -> filters + KPIs + table + charts
#
# END OF REFERENCE
# =====================================================================