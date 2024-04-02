create database time;
use time;
CREATE TABLE uber_rides(
ride_id INTEGER PRIMARY KEY AUTO_INCREMENT,
user_id INTEGER,
cab_id INTEGER,
start_time DATETIME,
end_time DATETIME
);
 INSERT INTO uber_rides (user_id, cab_id, start_time, end_time) VALUES
 (20,31,'2023-03-12 22:00:00' ,'2023-03-12 22:30:00');
 
 select * from uber_rides;
 
 select current_date();
 select current_time();
 select now();
 
 
 -- Extraction Functions
  select * from uber_rides;

-- 1. Date

SELECT *, DATE(start_time) 
FROM uber_rides;

-- 2. TIME

SELECT *, TIME(start_time) 
FROM uber_rides;

-- 3.YEAR 

SELECT *, YEAR(start_time)
FROM uber_rides;

-- 4.MONTH 
SELECT*, MONTH(start_time)
FROM uber_rides;

SELECT *, MONTHNAME(start_time)
FROM uber_rides;


 
-- 5. DAY

SELECT *, DAY(end_time)
FROM uber_rides;

SELECT *, DAYNAME(end_time)
FROM uber_rides;

-- 6 .DAY OF WEEK 

SELECT *, DAYOFWEEK(start_time)
FROM uber_rides;

-- 7. QUARTER

 SELECT *, QUARTER(start_time)
FROM uber_rides;

-- 8. WEEK 

SELECT *, WEEK(start_time)
FROM uber_rides;

-- 9. WEEK OF YEAR 

SELECT *, WEEKOFYEAR(start_time)
FROM uber_rides;

-- 10. HOUR 
SELECT *, HOUR(start_time)
FROM uber_rides;

-- 11. MINUTE
SELECT *, MINUTE(start_time)
FROM uber_rides;

SELECT *, MINUTE(end_time)
FROM uber_rides;

-- 12. SECOND
SELECT *, SECOND(end_time)
FROM uber_rides;

-- 13. DAY OF YEAR

SELECT *, DAYOFYEAR(end_time)  
FROM uber_rides;

-- 14.LAST DAY (last day of that month)

SELECT *, LAST_DAY(start_time)
FROM uber_rides;

-- DATE AND TIME FORMAT

SELECT start_time, DATE_FORMAT(start_time, '%d %b %y') as date_formate
FROM uber_rides;

SELECT start_time, DATE_FORMAT(start_time, '%d-%b-%y') as date_formate
FROM uber_rides;


SELECT start_time, DATE_FORMAT(start_time, '%d:%b:%y') as date_formate
FROM uber_rides;

SELECT start_time, DATE_FORMAT(end_time,'%l:%i %p')
FROM uber_rides;

SELECT user_id, cab_id, TIME_FORMAT(start_time, '%H') AS start_hour 
FROM uber_rides;

SELECT user_id, cab_id, TIME_FORMAT(end_time, '%H:%i') AS end_time_hour_minute
FROM uber_rides;

SELECT user_id, cab_id, 
  TIME_FORMAT(TIMEDIFF(end_time, start_time), '%H:%i') AS ride_duration
FROM uber_rides;

-- TYPE CONVERSION 

SELECT "2023-12-27" > "2023-12-28";
-- output is 0 because it false

SELECT "2023-12-27" > "2023-12-26";
-- output is 1 because it true
-- above are implict type conversion 

SELECT "2023-12-27" > "9 Mar, 2023";
-- implicy type conversion failed 

-- explicit type conversion 

SELECT MONTHNAME('9 MAR 2023');

-- converting str to date 

SELECT STR_TO_DATE('9 Mar 2023', '%e %b %Y');

SELECT MONTHNAME(STR_TO_DATE('9 Mar 2023', '%e %b %Y'));

SELECT DAYNAME(STR_TO_DATE('9 Mar 2023', '%e %b %Y'));

-- DATE TIME ARITHMETIC 

-- 1.DATEDIFF(number of days in difference between two dates)
SELECT DATEDIFF(CURRENT_DATE(), '2022-11-07');

SELECT DATEDIFF(start_time, end_time)
FROM uber_rides;d

-- 2.TIMEDIFF
SELECT TIMEDIFF(start_time, end_time)
FROM uber_rides;

SELECT TIMEDIFF(current_time(), '14:00:00');

-- 3. DATE_ADD

SELECT NOW(), DATE_ADD(NOW(), INTERVAL 4 HOUR);

SELECT NOW(), DATE_ADD(NOW(), INTERVAL 3 MONTH);

SELECT NOW(), DATE_ADD(NOW(), INTERVAL 10 minute);
-- we can applay this functions between two columns 

-- 4. DATE_SUB
SELECT NOW(), DATE_SUB(NOW(), INTERVAL 10 minute);

SELECT NOW(), DATE_SUB(NOW(), INTERVAL 10 DAY);

SELECT NOW(), DATE_SUB(NOW(), INTERVAL 10 MONTH);

-- practiese 
create table employee(
employeeid INT(10),
first_name VARCHAR(250),
last_name VARCHAR(250),
salary VARCHAR(250),
joining_date datetime,
department VARCHAR(250),
gender VARCHAR(250)
);
select * from employee;
INSERT INTO employee VALUES
(5,'shyam', 'kumar', 90000, '2022-02-11 09:17:28','civil', 'male');

-- GET ONLY YEAR PART OF JOINING DATE
SELECT *, YEAR(joining_date)
FROM employee;

SELECT 
YEAR(joining_date)AS 'year_joining'
FROM employee;

SELECT MONTH(joining_date) AS 'month_joining'
FROM employee;

SELECT MONTHNAME(joining_date) AS 'month_joining'
FROM employee;

-- FLIGHTS 

SELECT * FROM flights;

-- 1. find the month with most number of flights 

SELECT MONTHNAME(date_of_journey) , COUNT(*) FROM flights
GROUP BY MONTHNAME(Date_of_Journey)
ORDER BY COUNT(*) DESC;

-- 2. which week day most costly flights 

SELECT DAYNAME(date_of_journey), AVG(price) FROM flights
GROUP BY DAYNAME(Date_of_Journey)
ORDER BY AVG(price) DESC LIMIT 1;

-- 3. find number of indigo flights every month .
SELECT COUNT(*) AS number_of_flights,MONTHNAME(Date_of_Journey) FROM flights 
WHERE airline= 'IndiGo'
GROUP BY monthname(date_of_journey);

-- 4. find list of all flights that depart between 10AM AND 2PM from bangalore to delhi.
SELECT * FROM flights
WHERE  source='Banglore' AND destination='New Delhi'
AND dep_time > '10:00' AND dep_time < "2:00";

-- 5. find the no of flights deaparting from bengalore 

SELECT *, DAYNAME(date_of_journey) 
FROM flights 
WHERE source='Banglore' AND 
DAYNAME(date_of_journey) IN ('saturday', 'sunday');

SELECT COUNT(*) 
FROM flights 
WHERE source='Banglore' AND 
DAYNAME(date_of_journey) IN ('saturday', 'sunday');

-- 6. calculate the arrival time for all flights by adding the duration to the departure time.

ALTER TABLE flights ADD COLUMN departure DATETIME;

UPDATE flights 
SET departure = STR_TO_DATE(CONCAT(date_of_journey, " ", dep_time), '%Y-%m-%d %H:%i');


ALTER TABLE flights 
ADD COLUMN duration_mins  INTEGER,
ADD COLUMN arrival DATETIME;

SELECT Duration,
REPLACE(SUBSTRING_INDEX(duration,' ',1),'h','')*60 + 
CASE
	WHEN SUBSTRING_INDEX(duration,' ',-1) = SUBSTRING_INDEX(duration,' ',1) THEN 0
    ELSE REPLACE(SUBSTRING_INDEX(duration,' ',-1),'m','')
END AS 'mins'
FROM flights;

UPDATE flights
SET duration_mins =
  CASE
    WHEN duration LIKE '%h%' AND duration LIKE '%m%' THEN
      REPLACE(SUBSTRING_INDEX(duration, 'h', 1), ' ', '') * 60 +
      REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(duration, ' ', -1), 'm', 1), ' ', '')
    WHEN duration LIKE '%h%' THEN
      REPLACE(SUBSTRING_INDEX(duration, 'h', 1), ' ', '') * 60
    WHEN duration LIKE '%m%' THEN
      REPLACE(SUBSTRING_INDEX(duration, 'm', 1), ' ', '')
    ELSE
      0
  END;

SELECT * FROM flights;

UPDATE flights
SET arrival = DATE_ADD(departure,INTERVAL duration_mins MINUTE);

SELECT * FROM flights;

-- 7. Calculate the arrival time for all the flights.

SELECT time(arrival) FROM flights;
SELECT DATE(arrival) FROM flights;

-- 8. find the number of flights which travel on multiple dates 

select COUNT(*) from flights
where DATE(departure) != DATE(arrival); 

-- 9. calculate the average duration of flights between all city pairs, the answer should in hrs and mins 

SELECT source, destination, 
TIME_FORMAT(SEC_TO_TIME (AVG(duration_mins)*60), '%kh %im') as 'avg_duration' FROM flights
GROUP BY source, destination;

-- 10. find all flights which departed before midnight but arrived at their destination after midnight having only one stop.

SELECT * FROM flights
WHERE total_stops = 'non-stop' and 
date(departure) < date(arrival);

-- 11. find quarter wise number of flights for each airline 

SELECT airline, QUARTER(departure), COUNT(*) AS 'number_of_flights' FROM flights 
GROUP BY airline, QUARTER(departure);

-- 12. find the longest flight distance(between cities in terms of time) in india
SELECT * FROM flights 
WHERE duration_mins=(SELECT  MAX(duration_mins) FROM flights);

-- 13. average time duration for flights that have 1 stop vs more than 1 stops

WITH temp_table AS (SELECT *,
CASE 
	WHEN total_stops = 'non-stop' THEN 'non-stop'
    ELSE 'with stop'
END AS 'temp'
FROM flights)


SELECT temp,
TIME_FORMAT(SEC_TO_TIME(AVG(duration_mins)*60),'%kh %im') AS 'avg_duration',
AVG(price) AS 'avg_price'
FROM temp_table
GROUP BY temp;

-- 14. find all  flights in a given date range originating from delhi
-- 1st Mar 2019 to 10th Mar 2019 
SELECT * FROM flights
WHERE source = 'Delhi' AND
DATE(departure) BETWEEN '2019-03-01' AND '2019-03-10';

-- 15. find the longest flight of each airline 
SELECT airline,
TIME_FORMAT(SEC_TO_TIME(MAX(duration_mins)*60), '%kh %im')  AS 'max_duration'
FROM flights 
GROUP BY airline 
ORDER BY MAX(duration_mins) DESC;

-- 16. find all the pair of cities having average time duration > 3 hours 

SELECT source, destination ,
TIME_FORMAT(SEC_TO_TIME(AVG(duration_mins)*60), '%kh %im')  AS 'avg_duration'
from flights
group by source, destination
having AVG(duration_mins)>180;

-- 17. make a weekday vs time grid showing frequency of flights from bangalore and delhi 

SELECT DAYNAME(departure),
SUM(CASE WHEN HOUR(departure) BETWEEN 0 AND 5 THEN 1 ELSE 0 END) AS '12AM - 6AM',
SUM(CASE WHEN HOUR(departure) BETWEEN 6 AND 11 THEN 1 ELSE 0 END) AS '6AM - 12PM',
SUM(CASE WHEN HOUR(departure) BETWEEN 12 AND 17 THEN 1 ELSE 0 END) AS '12PM - 6PM',
SUM(CASE WHEN HOUR(departure) BETWEEN 18 AND 23 THEN 1 ELSE 0 END) AS '6PM - 12PM'
FROM flights
WHERE source = 'Banglore' AND destination = 'Delhi'
GROUP BY DAYNAME(departure), departure
ORDER BY DAYOFWEEK(departure) ASC;

-- 	18. Make a weekday vs time grid showing avg flight price from Banglore and Delhi

SELECT DAYNAME(departure),
AVG(CASE WHEN HOUR(departure) BETWEEN 0 AND 5 THEN price ELSE NULL END) AS '12AM - 6AM',
AVG(CASE WHEN HOUR(departure) BETWEEN 6 AND 11 THEN price ELSE NULL END) AS '6AM - 12PM',
AVG(CASE WHEN HOUR(departure) BETWEEN 12 AND 17 THEN price ELSE NULL END) AS '12PM - 6PM',
AVG(CASE WHEN HOUR(departure) BETWEEN 18 AND 23 THEN price ELSE NULL END) AS '6PM - 12PM'
FROM flights
WHERE source = 'Banglore' AND destination = 'Delhi'
GROUP BY DAYNAME(departure), departure
ORDER BY DAYOFWEEK(departure) ASC;


