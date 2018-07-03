# Top Movies

When deciding what movie to watch, I often use IMDB to find a highly rated movie I haven't seen. However, this often leaves a lot to be desired. As IMDB is an aggregator, the top movies are often just the most popular. On the contrary, the most critically acclaimed movies are often least popular.

In order to rectify this, these scripts combine ratings from IMDB and match them up to movie ratings from [Piero Scaruffi](http://www.scaruffi.com/cinema.html).

## Methods

First, all movies are webscraped from Scrauffi's website from the years 1998 to 2018. Fortunately the data is in a relatively consistent format from all those years and generally speaking maps over well into a dataframe. 

Movie information is then downloaded from IMDB, and matched between these two datasets based on movie name.

In order to get the results of the best movies, the scores were centred and scaled for each source in order to be comparable, and then an upper quantile of movies were chosen. 

## Results

The end result is a table which, when put into Excel, can be easily filtered and ranked in order to find a new movie to watch.

![Results Table](https://raw.githubusercontent.com/cajpearce/top-movies/master/images/movies.PNG)


## Shortfalls

Currently this script does not accurately match all movies, especially where there are multiple movies with the same name.
