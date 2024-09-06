# Project Overview

For this project, I conducted an exploratory analysis on the NHL free agency period to determine if there were any trends between free agency behavior and future team success. Using tools such as PostgreSQL, Python (Web Scraping), and Tableau I created dashboards to explore and visualize these relationships and identified which type of free agency additions are ideal and which are riskier options requiring extra due diligence from a team's front office.

# Problem

Explore past free agency activity from NHL teams to provide data driven insights for general managers on how to approach contract negotiations.

# Solution

## Goal

My goal is to identify key characteristics of free agency contracts that have a correlation with future team success. After identifying these variables, I will be able to create guidelines for NHL teams to follow to make more data driven decisions during future free agency periods.

## Task

To achieve my goal I will create exploratory dashboards on Tableau to better visualize trends in contract characteristics during the NHL’s offseason free agency period and identify their impact on the team’s regular season success during future seasons. From these dashboards I hope to be able to identify which characteristics of contracts are having the largest impact on success and use these characteristics to determine what type of contracts NHL teams should aim to target to have the best chance at improving their winning percentage down the road. I should also be able to identify which type of contracts should be avoided and create guidelines around how much due diligence is required depending on a proposed contract’s characteristics. 

## Steps

1. Collect data on past free agency contracts as well as historical standings using web scraping in Python
2. Properly join this data together in PostgreSQL to be able to visualize relationships between the two sets of data
3. Create exploratory dashboards in Tableau to examine which characteristics are most impactful and discover insights
4. Use these insights to create guidelines for how general managers should approach free agency to best set their team up for success in later years

# Data Overview

## Data Needed

For this analysis, I will need two separate tables of data, one consisting of past free agency contracts/signings and one containing team standings.

## Data Collection

To collect the necessary data I wrote two scripts in Python using BeautifulSoup and Selenium to perform web scraping. To collect the data on historical contracts/signings I scraped information such as team from/to, contract amount, contract duration, and players age from Spotrac at https://www.spotrac.com/nhl/free-agents/_/year/2011/status/signed/sort/contract_value from 2012-2023. To get historical standings, I scraped the final standings for 2012-2024 from https://www.nhl.com/standings/2024-04-18/league . Since these pages took a couple seconds to fully load in all content, I utilized Selenium to make the program wait for the full page to display.

## Data Preparation 

Using PostgreSQL, I prepared my data for analysis/visualization. Starting off, I cleaned the data by accounting for the Phoenix to Arizona name change for the Coyotes by adjusting all data containing Phoenix to Arizona to eliminate any inconsistencies. Then, I removed all data containing the Seattle Kraken or the Vegas Golden Knights as they were recent additions to the league and would provide incomplete results. Next to prepare my data, I joined the two datasets by team name and eliminated any contracts that were less than $2 million AAV. This would eliminate insignificant signings from swaying the results.

# Age and Length Variable Analysis/Visualization

## Approach

To start my analysis, I decided to utilize tableau to create two exploratory dashboards on the variables that I think will have the largest impact on team success, length and age. For each dashboard I created a bar chart showing the average length or age of contract signings for each team during 2012-2016. Clicking on each respective team as a filter also brings up a line chart showing the change in point percentage from 2012-2023 as well as some KPIs such as the point percentage difference from 2012-2016 and 2017-2023. Below are each of the dashboards. 

![Length Dashboard](https://github.com/user-attachments/assets/c0ad73ad-4600-40a3-a6bb-9f02b581e691)
Interactive Dashboard: https://public.tableau.com/app/profile/michael.alessio/viz/nhl_free_agency_length_and_age_vs_team_success/LengthDashboard 

![Age Dashboard](https://github.com/user-attachments/assets/5dcbb9ea-9210-484b-b777-51ef98390af6) 
Interactive Dashboard: https://public.tableau.com/app/profile/michael.alessio/viz/nhl_free_agency_length_and_age_vs_team_success/LengthDashboard 

These dashboards allowed me to visualize that there was a correlation between both length and age with a team's future success. However, it wasn’t quite clear how this could be applied to effectively influence decision making. Because of this, I decided to create one more dashboard to view the correlation of multiple variables and determine the optimal contracts to be targeting.

# Summary Statistics

Although the exploratory dashboard showed that age and length were important factors, I also wanted to examine the correlation for number of signings per year and total average spend per year as well just in case they also impacted future success. For this I created 4 scatter plots with lines of best fit for length, age, number of signings, and total spend. Each of these were given the dependent variable of the difference in point percentage from 2012-2016 to 2017-2023. Each team was then plotted on the graph. The dashboard can be found below.

![Dashboard 3](https://github.com/user-attachments/assets/bcf3d0a7-3b64-4e8a-8d39-25f27f96f7fc)
Interactive Dashboard: https://public.tableau.com/app/profile/michael.alessio/viz/nhl_free_agency_length_and_age_vs_team_success/LengthDashboard 

We can see that although the number of signings and total spend show little to no correlation, the length and age variables show a strong correlation. As average length increases, a teams point percentage increases and as age increases, a teams point percentage decreases.

# Recommendations 

## Takeaways

Looking at the two variables, contract length and player age, we can see a strong correlation with future team success. Longer contracts and lower player age lead to a higher likelihood of increasing a teams point percentage in the future and thus should be targeted moves during the free agency period. For contract length, the x-axis intercept is roughly at 3 years while for player age it is roughly at 29 years old. Therefore the ideal contract would be a player younger than 29 with a contract length over 3 years.

## Implementation 

To implement the results of this analysis in a meaningful way, an NHL team should create a guideline for contracts that meet these targeted attributes and ones that do not. The contracts that meet them should be a teams first priority and target when beginning the free agency period. However, because there are a lot of situational reasons that may make it beneficial to go outside of the targeted attributes (chasing a championship run, rebuilding, etc.) these contracts that do not meet them should not be completely avoided but rather go through an extra round of due diligence from a senior risk analysis team to analyze its effectiveness towards reaching the teams current goals.

## Recommendations for Further Analysis

One main way to strengthen the validity of these results would be to add additional years worth of data. Unfortunately in utilizing web scraping to collect data, I was limited to 2012 as the earliest year of information available. Pursuing other avenues to collect a more comprehensive collection of past years would give a more fine-tuned result. Another way to uncover new insights altogether would be to look into the correlation of other contract variables. For example, you could explore the players position, past performance, or the timing of the signing. 
