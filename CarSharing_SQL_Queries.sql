-- CarSharing Report with SQL Queries
-- SQLite database: carsharing
-- Joins use the transformed CarSharing_df table as required.

-- (a) Highest-demand date/time in 2017
SELECT t.timestamp, c.demand FROM CarSharing_df c JOIN time t ON t.id=c.id
WHERE strftime('%Y', t.timestamp)='2017' ORDER BY c.demand DESC LIMIT 1;

-- (b1) Average demand by weekday (highest and lowest are first and last rows)
SELECT t.weekday_name, ROUND(AVG(c.demand),4) AS average_demand FROM CarSharing_df c JOIN time t ON t.id=c.id
WHERE strftime('%Y',t.timestamp)='2017' GROUP BY t.weekday_name ORDER BY average_demand DESC;

-- (b2) Average demand by month
SELECT t.monthday_name AS month_name, ROUND(AVG(c.demand),4) AS average_demand FROM CarSharing_df c JOIN time t ON t.id=c.id
WHERE strftime('%Y',t.timestamp)='2017' GROUP BY t.monthday_name ORDER BY average_demand DESC;

-- (b3) Average demand by season
SELECT t.season, ROUND(AVG(c.demand),4) AS average_demand FROM CarSharing_df c JOIN time t ON t.id=c.id
WHERE strftime('%Y',t.timestamp)='2017' GROUP BY t.season ORDER BY average_demand DESC;

-- (c) Hourly average demand for the highest-average-demand weekday: Saturday
SELECT t.hour, ROUND(AVG(c.demand),4) AS average_demand FROM CarSharing_df c JOIN time t ON t.id=c.id
WHERE strftime('%Y',t.timestamp)='2017' AND t.weekday_name='Saturday' GROUP BY t.hour ORDER BY average_demand DESC;

-- (d1) Temperature category counts in 2017
SELECT p.temp_category, COUNT(*) AS observations FROM CarSharing_df c JOIN temperature p ON p.temp_code=c.temp_code JOIN time t ON t.id=c.id
WHERE strftime('%Y',t.timestamp)='2017' GROUP BY p.temp_category ORDER BY observations DESC;

-- (d2) Most prevalent weather condition in 2017
SELECT w.weather, COUNT(*) AS observations FROM CarSharing_df c JOIN weather w ON w.weather_code=c.weather_code JOIN time t ON t.id=c.id
WHERE strftime('%Y',t.timestamp)='2017' GROUP BY w.weather ORDER BY observations DESC;

-- (d3) Monthly wind-speed statistics (separate table)
SELECT t.monthday_name AS month_name, ROUND(AVG(c.windspeed),2) AS average_windspeed, MAX(c.windspeed) AS highest_windspeed, MIN(c.windspeed) AS lowest_windspeed
FROM CarSharing_df c JOIN time t ON t.id=c.id WHERE strftime('%Y',t.timestamp)='2017' GROUP BY t.monthday_name ORDER BY MIN(t.timestamp);

-- (d4) Monthly humidity statistics (separate table)
SELECT t.monthday_name AS month_name, ROUND(AVG(c.humidity),2) AS average_humidity, MAX(c.humidity) AS highest_humidity, MIN(c.humidity) AS lowest_humidity
FROM CarSharing_df c JOIN time t ON t.id=c.id WHERE strftime('%Y',t.timestamp)='2017' GROUP BY t.monthday_name ORDER BY MIN(t.timestamp);

-- (d5) Average demand by temperature category
SELECT p.temp_category, ROUND(AVG(c.demand),4) AS average_demand FROM CarSharing_df c JOIN temperature p ON p.temp_code=c.temp_code JOIN time t ON t.id=c.id
WHERE strftime('%Y',t.timestamp)='2017' GROUP BY p.temp_category ORDER BY average_demand DESC;

-- (e1) Temperature categories in highest-average-demand month: July
SELECT p.temp_category, COUNT(*) AS observations FROM CarSharing_df c JOIN temperature p ON p.temp_code=c.temp_code JOIN time t ON t.id=c.id
WHERE strftime('%Y',t.timestamp)='2017' AND t.monthday_name='July' GROUP BY p.temp_category ORDER BY observations DESC;

-- (e2) Most prevalent weather in July 2017
SELECT w.weather, COUNT(*) AS observations FROM CarSharing_df c JOIN weather w ON w.weather_code=c.weather_code JOIN time t ON t.id=c.id
WHERE strftime('%Y',t.timestamp)='2017' AND t.monthday_name='July' GROUP BY w.weather ORDER BY observations DESC;

-- (e3) July wind-speed statistics
SELECT ROUND(AVG(c.windspeed),2) AS average_windspeed, MAX(c.windspeed) AS highest_windspeed, MIN(c.windspeed) AS lowest_windspeed
FROM CarSharing_df c JOIN time t ON t.id=c.id WHERE strftime('%Y',t.timestamp)='2017' AND t.monthday_name='July';

-- (e4) July humidity statistics
SELECT ROUND(AVG(c.humidity),2) AS average_humidity, MAX(c.humidity) AS highest_humidity, MIN(c.humidity) AS lowest_humidity
FROM CarSharing_df c JOIN time t ON t.id=c.id WHERE strftime('%Y',t.timestamp)='2017' AND t.monthday_name='July';

-- (e5) Average demand by temperature category in July
SELECT p.temp_category, ROUND(AVG(c.demand),4) AS average_demand FROM CarSharing_df c JOIN temperature p ON p.temp_code=c.temp_code JOIN time t ON t.id=c.id
WHERE strftime('%Y',t.timestamp)='2017' AND t.monthday_name='July' GROUP BY p.temp_category ORDER BY average_demand DESC;
