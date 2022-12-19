# climate_discourse_graphs

This repo contains the R and Python scripts for network analyses of twitter climate discourses. Refer to the introduction section of the "text_analysis.ipynb" python notebook for the skematics. 

Briefly, the python notebook should be run first; it takes the raw tweets texts, clean them, concatenate to each user, and perform two different user-pair similarity computation yielding in similarity matrices. These matrices are then passed to the R script for graph analyses (clustering and visualisation).

Note that the scripts were written and tested on a smaller sample of 1000 users. Results from different datasets may be drastically different, and may require additional minor tweaks to suit the data. 

Note also that in the data folder there should be an origin file named "anonhayhoetw.csv", wihch was not uploaded to github due to file size limits. While running the python code, a "user_tweets.csv" will be created in the data folder as a mid-stage file store in case you need to pause or shut your machines. This file was also too large to be uploaded.

*this readme file was last updated on Dec 19, 2022*
