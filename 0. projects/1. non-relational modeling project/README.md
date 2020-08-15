## Extract, Transform & Load Sparkify Logs 

A startup called Sparkify wants to analyze the data they've been  collecting on songs and user activity on their new music streaming app.  The analysis team is particularly interested in understanding what songs users are listening to. Currently, there is no easy way to query the  data to generate the results, since the data reside in a directory of  CSV files on user activity on the app.

In this project, an ETL pipeline has been designed to help process raw csv data file and load data to Apache Cassandra database after appropriate transformation applied .

**Key consideration while designing pipeline is that all ETL pipeline steps should be as loosely coupled as possible, i.e. transformation step should not be dependent on the way we are extracting data and so on. **

Since, it was a small scale project, I tried to persist the output of each stage locally as csv files.

Also, as Apache Cassandra is used as datastore, modeling was performed using **'query first'** approach.

Following three queries were modeled as part of Udacity exercises, however, design is quite flexible to incorporate any future queries: -

* *Give me the artist, song title and song's length in the music app history that was heard during sessionId = 338, and **itemInSession** = 4*
* *Give me only the following: name of artist, song (sorted by **itemInSession**) and user (first and last name) for **userid** = 10, **sessionid** = 182*
* *Give me every user name (first and last) in my music app history who listened to the song 'All Hands Against His Own'*



