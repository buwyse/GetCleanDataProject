<h1>CodeBook</h1>
<p>This CodeBook has three parts: an overview, the variables, and the transformations of the raw data.</p>
<h2>Overview</h2>
<p>The data was obtained from the following link on 8/20/15.</p>
<a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a>
<p>After data was downloaded the run_analysis.R script was used to combine the training and test data sets.</p>
<These transformations were made using R and its plyr, dplyr, lubridate,data.table, and reshape2 packages. The version number is listed below.</p>
<p>R version 3.2.2 (2015-08-14) -- "Fire Safety"
Copyright (C) 2015 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)</p>
<p>The data represents statistical measures collected from different features recording the output of accelerometers in Samsung Galaxy S smartphones. The collected data is from a set of subjects using the phones while they engage in different physical activities.</p>
<h2>Variables</h2>
<p>The tidy data set has a dimension of 11880x4. The four columns are named: Subject, Activity, Feature, and MeanMeasurement.</p>
<h3>Subject</h3><p>Contains an integer code identifying each participant.</p>
<h3>Activity</h3><p>This factor set lists each activity being undertaken when the measurement was recorded.</p>
<h3>Feature</h3><p>This factor set lists the smartphone feature reporting a measurement. Only features reporting mean or standard deviation measurements were kept in the transformed dataset. Features reporting other statistical measures like minimums, maximums, etc. were filtered out.
<h3>MeanMeasurement</h3>This numeric value is the mean of all measurements unique to the grouping of Subject, Activity, & Feature. Remember, the mean of these measurements is only a subset of data; only mean and standard deviation features outputs were used.</p>
<h2>Transformations</h2>
<p>Don't forget to correctly set your working directory!</p>
<p>1. The run_analysis.R script begins by loading the required packages (plyr,dplyr,data.table, and reshape2).</p>
<p>2. The script loads the feature labeling file, "features.txt" from the dataset and subsets it to list only the mean or standard deviation features</p>
<p>3. The group of "Test" Subject, Activity, Feature, & Measurements data is loaded, with labels into R and then a first filter is applied to retain only mean and standard deviation filters. All the Test data is combined into one data frame.</p>
<p>4. The group of "Train" Subject, Activity, Feature, & Measurements data is loaded, with labels into R and then a first filter is applied to retain only mean and standard deviation filters. All the Train data is combined into one data frame.</p>
<p>5. The Test and Train data are combined into one data frame and vectors and data frames that are no longer needed are removed.</p>
<p>6. A second pass filter is applied to remove meanFreq data as the authors describe it being the weighted average of frequency components. Although weighted averages are similiar to means in their output they can have different statistical conclusion(See Simpson's paradox on Wikipedia.org).</p>
<p>7. Combines and melts the data so that a single mean of all the measurements is retained for each unique grouping of Subject, Activity, and Feature</p>
<p>8. Transforms the Activity variable from a numeric code into a descriptive factor set of data.</p>
<p>9. Writes the resulting tidy data set to "Tidy Dataset.txt" in the current working directory.</p>