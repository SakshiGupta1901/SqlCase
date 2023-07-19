create database HR_Data;
use HR_Data;
show tables;
select * from employee_hr_data;
#######	1	############
select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY from employee_hr_data 
where SALARY > 9000;
############	2 ############
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
FROM employee_hr_data
WHERE DEPARTMENT_ID = 0;
######################## 3 ###############
SELECT concat(FIRST_NAME, LAST_NAME) AS "FULL_NAME" , HIRE_DATE, SALARY, DEPARTMENT_ID
FROM employee_hr_data
WHERE FIRST_NAME NOT LIKE 'T%'
order by DEPARTMENT_ID asc;
################ 4 ###############
select * FROM employee_hr_data
WHERE SALARY between 9000 AND 12000
AND COMMISSION_PCT > 0;
############## 5 ###########
select concat(FIRST_NAME, LAST_NAME) AS "FULL_NAME" , SALARY FROM employee_hr_data
WHERE COMMISSION_PCT = 0;

#################### 6 ##############
select concat(FIRST_NAME, LAST_NAME) AS "FULL_NAME" , SALARY,MANAGER_ID FROM employee_hr_data
WHERE MANAGER_ID != 0;

############ 7 ##############
SELECT * FROM employee_hr_data
WHERE FIRST_NAME  LIKE '%F%' OR FIRST_NAME  LIKE '%T%' OR FIRST_NAME  LIKE '%M%'
order by SALARY desc;

############## 8 ##############
SELECT concat(FIRST_NAME, LAST_NAME) AS "FULL_NAME" , HIRE_DATE, SALARY, EMAIL,
replace(PHONE_NUMBER,'.','-'), COMMISSION_PCT FROM employee_hr_data
WHERE SALARY > 12000 OR PHONE_NUMBER LIKE '______3%'
order by FIRST_NAME desc;

################## 9 ################
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY from employee_hr_data 
where FIRST_NAME like '__s%';

############## 10 ######################
SELECT EMPLOYEE_ID FROM job_history_hr_data
group by EMPLOYEE_ID
having COUNT(EMPLOYEE_ID)>=2;


select EMPLOYEE_ID,JOB_ID
from job_history_hr_data
group by EMPLOYEE_ID
having count(*)>=2;

##################### 11 ##############
SELECT JOB_ID, COUNT(EMPLOYEE_ID) AS 'COUNT OF EMPLOYEES', SUM(SALARY) AS 'SUM OF SALARY',
(MAX(SALARY)-MIN(SALARY)) AS 'SALARY DIFFERENCE'
FROM employee_hr_data
GROUP BY JOB_ID;

######################### 12 ########################
SELECT JOB_ID FROM job_history_hr_data
WHERE DATEDIFF(END_DATE, START_DATE)>300;

select job_id
from job_history_hr_data
where end_date - start_date > 300
group by job_id
having count (*) > 1;
######################## 13 ########################
SELECT MANAGER_ID, COUNT(EMPLOYEE_ID) AS 'NO. OF EMPLOYEES' 
FROM employee_hr_data
WHERE MANAGER_ID != 0
GROUP BY MANAGER_ID;

######################### 14 #######################
SELECT DEPARTMENT_ID, AVG(SALARY) FROM employee_hr_data
WHERE COMMISSION_PCT > 0
GROUP BY DEPARTMENT_ID;

######################## 15 #########################
SELECT DEPARTMENT_ID FROM employee_hr_data
WHERE COMMISSION_PCT>0
GROUP BY DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID) > 10;

######################## 16 #########################

SELECT JOB_TITLE, MIN_SALARY, MAX_SALARY FROM jobs_hr_data
WHERE MAX_SALARY between 10000 AND 15000;

######################## 17 ############################

SELECT * FROM jobs_hr_data
WHERE MIN_SALARY > 9000;

######################## 18 #############################

SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM employee_hr_data
where DEPARTMENT_ID = 
(SELECT DEPARTMENT_ID FROM employee_hr_data
WHERE FIRST_NAME LIKE '%Clara%') AND
FIRST_NAME NOT LIKE  '%Clara%';

######################## 19 ##############################

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM employee_hr_data
WHERE SALARY > (SELECT AVG(SALARY) FROM employee_hr_data)
AND DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM employee_hr_data
WHERE FIRST_NAME LIKE '%j%');

################### 20 #########################

SELECT CONCAT(FIRST_NAME, LAST_NAME) AS 'NAME',
CASE
 WHEN JOB_ID LIKE "%ST_MAN%" THEN "SALESMAN"
 WHEN JOB_ID LIKE "%IT_PROG%" THEN "DEVELOPER"
 ELSE JOB_ID END AS JOB_ID 
 FROM employee_hr_data;
 
SELECT  employee_id,  first_name, last_name,  
CASE job_id  
WHEN 'ST_MAN' THEN 'SALESMAN'  
WHEN 'IT_PROG' THEN 'DEVELOPER'  
ELSE job_id  
END AS designation,  salary 
FROM employee_hr_data;

 
 ############################ JOINS ################################
 ############################ 1 ##################
 SELECT employee_hr_data.FIRST_NAME,employee_hr_data.LAST_NAME,location_hr_data.CITY,location_hr_data.STATE_PROVINCE
 FROM employee_hr_data JOIN department_hr_data
 ON employee_hr_data.DEPARTMENT_ID = department_hr_data.DEPARTMENT_ID
 JOIN location_hr_data
 ON department_hr_data.LOCATION_ID = location_hr_data.LOCATION_ID;

#################### 2 ######################
SELECT employee_hr_data.FIRST_NAME,employee_hr_data.LAST_NAME,employee_hr_data.SALARY,job_grades_hr_data.GRADE_LEVEL
FROM employee_hr_data JOIN job_grades_hr_data
ON employee_hr_data.SALARY BETWEEN job_grades_hr_data.LOWEST_SAL AND job_grades_hr_data.HIGHEST_SAL;

################### 3 #############################
SELECT employee_hr_data.FIRST_NAME,employee_hr_data.LAST_NAME,department_hr_data.DEPARTMENT_ID ,department_hr_data. DEPARTMENT_NAME     
 FROM employee_hr_data JOIN department_hr_data
 ON employee_hr_data.DEPARTMENT_ID = department_hr_data.DEPARTMENT_ID
 WHERE employee_hr_data.DEPARTMENT_ID = 40 OR employee_hr_data.DEPARTMENT_ID = 80;
 
 ################# 4 ################################
 SELECT employee_hr_data.FIRST_NAME,employee_hr_data.LAST_NAME,department_hr_data.DEPARTMENT_ID , location_hr_data.CITY,location_hr_data.STATE_PROVINCE
 FROM employee_hr_data JOIN department_hr_data
 ON employee_hr_data.DEPARTMENT_ID = department_hr_data.DEPARTMENT_ID
 JOIN location_hr_data
 ON department_hr_data.LOCATION_ID = location_hr_data.LOCATION_ID
 WHERE employee_hr_data.FIRST_NAME LIKE "%Z%" ; 
 
 ########################### 5 ########################

SELECT CONCAT(EMPLOYEE_HR_DATA.FIRST_NAME, EMPLOYEE_HR_DATA.LAST_NAME) AS 'EMPLOYEE_NAME',
DEPARTMENT_HR_DATA.DEPARTMENT_NAME,
JOBS_HR_DATA.JOB_TITLE, JOB_HISTORY_HR_DATA.START_DATE AS 'JOINING DATE' 
FROM JOBS_HR_DATA JOIN JOB_HISTORY_HR_DATA
ON JOBS_HR_DATA.JOB_ID = JOB_HISTORY_HR_DATA.JOB_ID
JOIN EMPLOYEE_HR_DATA
ON JOB_HISTORY_HR_DATA.EMPLOYEE_ID = EMPLOYEE_HR_DATA.EMPLOYEE_ID
JOIN DEPARTMENT_HR_DATA
ON EMPLOYEE_HR_DATA.DEPARTMENT_ID = DEPARTMENT_HR_DATA.DEPARTMENT_ID
WHERE JOB_HISTORY_HR_DATA.START_DATE>='1993-01-01' AND JOB_HISTORY_HR_DATA.START_DATE <='1997-08-31';

################################# 6 ################################
#Write a SQL query to calculate the difference between the maximum salary of the job
# and the employee's salary. Return job title, employee name, and salary difference.
SELECT JOBS_HR_DATA.JOB_TITLE, CONCAT(EMPLOYEE_HR_DATA.FIRST_NAME, EMPLOYEE_HR_DATA.LAST_NAME) AS 'EMPLOYEE_NAME' ,
JOBS_HR_DATA.MAX_SALARY - EMPLOYEE_HR_DATA.SALARY  AS 'SALARY DIFFERNCE'
FROM EMPLOYEE_HR_DATA JOIN JOBS_HR_DATA
ON EMPLOYEE_HR_DATA.EMPLOYEE_ID = JOBS_HR_DATA.JOB_ID;


SELECT JOBS_HR_DATA.JOB_TITLE, 
CONCAT(EMPLOYEE_HR_DATA.FIRST_NAME, EMPLOYEE_HR_DATA.LAST_NAME) AS 'EMPLOYEE_NAME',
JOBS_HR_DATA.MAX_SALARY - EMPLOYEE_HR_DATA.SALARY  AS 'SALARY DIFFERNCE' 
FROM JOBS_HR_DATA JOIN JOB_HISTORY_HR_DATA
ON JOBS_HR_DATA.JOB_ID = JOB_HISTORY_HR_DATA.JOB_ID
JOIN EMPLOYEE_HR_DATA
ON JOB_HISTORY_HR_DATA.EMPLOYEE_ID = EMPLOYEE_HR_DATA.EMPLOYEE_ID;



################## 7 ####################
SELECT DEPARTMENT_HR_DATA.DEPARTMENT_NAME, CONCAT(EMPLOYEE_HR_DATA.FIRST_NAME, EMPLOYEE_HR_DATA.LAST_NAME) AS 'FULL_NAME'
FROM DEPARTMENT_HR_DATA JOIN EMPLOYEE_HR_DATA 
ON DEPARTMENT_HR_DATA.MANAGER_ID = EMPLOYEE_HR_DATA.EMPLOYEE_ID;

############ 8 ###############
SELECT DEPARTMENT_HR_DATA.DEPARTMENT_NAME,
CONCAT(EMPLOYEE_HR_DATA.FIRST_NAME, EMPLOYEE_HR_DATA.LAST_NAME) AS 'FULL_NAME',
LOCATION_HR_DATA.CITY
FROM DEPARTMENT_HR_DATA JOIN EMPLOYEE_HR_DATA 
ON DEPARTMENT_HR_DATA.DEPARTMENT_ID = EMPLOYEE_HR_DATA.DEPARTMENT_ID
JOIN LOCATION_HR_DATA 
ON DEPARTMENT_HR_DATA.LOCATION_ID = LOCATION_HR_DATA.LOCATION_ID; 

################# 9 #################
 
SELECT EMPLOYEE_HR_DATA.EMPLOYEE_ID,
CONCAT(EMPLOYEE_HR_DATA.FIRST_NAME, EMPLOYEE_HR_DATA.LAST_NAME) AS 'FULL_NAME',
COUNTRIES_HR_DATA.COUNTRY_NAME
FROM DEPARTMENT_HR_DATA JOIN EMPLOYEE_HR_DATA 
ON DEPARTMENT_HR_DATA.DEPARTMENT_ID = EMPLOYEE_HR_DATA.DEPARTMENT_ID
JOIN LOCATION_HR_DATA 
ON DEPARTMENT_HR_DATA.LOCATION_ID = LOCATION_HR_DATA.LOCATION_ID
JOIN COUNTRIES_HR_DATA
ON LOCATION_HR_DATA.COUNTRY_ID = COUNTRIES_HR_DATA.COUNTRY_ID; 
