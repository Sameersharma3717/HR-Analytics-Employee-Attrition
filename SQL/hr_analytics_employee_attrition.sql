/*
====================================================
Project : HR Analytics - Employee Attrition Analysis
Author  : Sameer Sharma
Tools   : MySQL 8.0
Dataset : IBM HR Employee Attrition Dataset
====================================================

Objective:
Analyze employee demographics, attrition trends,
salary distribution, workforce performance, and
employee experience using SQL to generate actionable
HR insights and support data-driven decision-making.

====================================================
*/

/*
====================================================
TABLE OF CONTENTS

1. Data Quality Assessment
2. Employee Overview
3. Attrition Analysis
4. Salary Analysis
5. Employee Experience & Performance Analysis
6. Advanced SQL Analysis

====================================================
*/

/*====================================================
SECTION 1 : DATA QUALITY ASSESSMENT
====================================================*/

-- Q0. Total Employees

SELECT COUNT(*) AS total_employees
FROM hr_employee;

-- Q1. Table Structure

DESCRIBE hr_employee;

-- Q2. Missing Values

SELECT
COUNT(*) AS total_rows,
SUM(Age IS NULL) AS age_nulls,
SUM(Department IS NULL) AS department_nulls,
SUM(JobRole IS NULL) AS jobrole_nulls,
SUM(MonthlyIncome IS NULL) AS salary_nulls,
SUM(Attrition IS NULL) AS attrition_nulls
FROM hr_employee;

-- Q3. Duplicate Employees

SELECT EmployeeNumber,
COUNT(*) AS duplicate_count
FROM hr_employee
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;

-- Q4. Constant Columns

SELECT DISTINCT EmployeeCount FROM hr_employee;

SELECT DISTINCT StandardHours FROM hr_employee;

SELECT DISTINCT Over18 FROM hr_employee;

-- Q5. Attrition Count

SELECT Attrition,
COUNT(*) AS employee_count
FROM hr_employee
GROUP BY Attrition;


/*====================================================
SECTION 2 : EMPLOYEE OVERVIEW
====================================================*/

/*====================================================
Business Question 6
Employee Distribution by Department

Objective:
The HR Director wants to understand how employees
are distributed across departments to support workforce
planning and resource allocation.
====================================================*/

SELECT Department,COUNT(EmployeeNumber) AS Employee_Count
FROM hr_employee
GROUP BY Department
ORDER BY Employee_Count DESC;

/*====================================================
Business Question 7
Gender Distribution

Objective:
The HR Director wants to evaluate gender representation
across the organization to support diversity and inclusion
initiatives.
====================================================*/

SELECT Gender,COUNT(EmployeeNumber) AS Employee_Count
FROM hr_employee
GROUP BY Gender
ORDER BY Employee_Count DESC;

/*====================================================
Business Question 8
Average Employee Age

Objective:
The HR Director wants to determine the average age
of employees to better understand workforce
demographics and support succession planning,
recruitment, and employee development strategies.
====================================================*/

SELECT ROUND(AVG(Age),2) AS Average_Age
FROM hr_employee;

/*====================================================
Business Question 9
Job Role Distribution

Objective:
The HR Director wants to identify the job roles with
the highest number of employees to better understand
the organization's workforce composition and support
recruitment, training, and workforce planning.
====================================================*/

SELECT JobRole,COUNT(EmployeeNumber) AS Employee_Count
FROM hr_employee
GROUP BY JobRole
ORDER BY Employee_Count DESC;

/*====================================================
SECTION 3 : ATTRITION ANALYSIS
====================================================*/

/*====================================================
Business Question 10
Overall Attrition Rate

Objective:
The HR Director wants to determine the overall
employee attrition rate to evaluate workforce
stability and measure the percentage of employees
who have left the organization.
====================================================*/

SELECT COUNT(*) As Total_Employees,
SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)AS Employees_left,
ROUND(SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)*100/COUNT(*),2) AS Attrition_Rate
FROM hr_employee;


/*====================================================
Business Question 11
Department-wise Attrition Analysis

Objective:
The HR Director wants to identify which departments
experience the highest employee attrition to
prioritize retention strategies and improve
workforce planning.
====================================================*/

SELECT Department,COUNT(*) As Total_Employees,
SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)AS Employees_left,
ROUND(SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)*100/COUNT(*),2) AS Attrition_Rate
FROM hr_employee 
GROUP BY Department
ORDER BY Attrition_Rate DESC;


/*====================================================
Business Question 12
Job Role-wise Attrition Analysis

Objective:
The HR Director wants to identify the job roles with
the highest employee attrition to understand
turnover patterns and support targeted retention
initiatives.
====================================================*/

SELECT JobRole,COUNT(*) As Total_Employees,
SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)AS Employees_left,
ROUND(SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)*100/COUNT(*),2) AS Attrition_Rate
FROM hr_employee 
GROUP BY JobRole
ORDER BY Attrition_Rate DESC;

/*====================================================
Business Question 13
Gender-wise Attrition Analysis

Objective:
The HR Director wants to analyze employee
attrition across different genders to evaluate
workforce diversity and identify potential
retention gaps.
====================================================*/

SELECT Gender,COUNT(*) As Total_Employees,
SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)AS Employees_left,
ROUND(SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)*100/COUNT(*),2) AS Attrition_Rate
FROM hr_employee 
GROUP BY Gender
ORDER BY Attrition_Rate DESC;

/*====================================================
Business Question 14
Overtime vs Attrition Analysis

Objective:
Management wants to determine whether employees
working overtime are more likely to leave the
organization to assess workload and employee
well-being.
====================================================*/

SELECT OverTime,COUNT(*) As Total_Employees,
SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)AS Employees_left,
ROUND(SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)*100/COUNT(*),2) AS Attrition_Rate
FROM hr_employee 
GROUP BY OverTime
ORDER BY Attrition_Rate DESC;

/*====================================================
Business Question 15
Marital Status-wise Attrition Analysis

Objective:
The HR Director wants to analyze employee
attrition across different marital status groups
to better understand workforce demographics and
retention patterns.
====================================================*/

SELECT MaritalStatus,COUNT(*) As Total_Employees,
SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)AS Employees_left,
ROUND(SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)*100/COUNT(*),2) AS Attrition_Rate
FROM hr_employee 
GROUP BY MaritalStatus
ORDER BY Attrition_Rate DESC;

/*====================================================
Business Question 16
Business Travel vs Attrition Analysis

Objective:
Management wants to evaluate whether the frequency
of business travel has an impact on employee
attrition to support travel and work-life balance
policies.
====================================================*/

SELECT BusinessTravel,COUNT(*) As Total_Employees,
SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)AS Employees_left,
ROUND(SUM(CASE WHEN Attrition='Yes' Then 1
ELSE 0 
END)*100/COUNT(*),2) AS Attrition_Rate
FROM hr_employee 
GROUP BY BusinessTravel
ORDER BY Attrition_Rate DESC;

/*====================================================
SECTION 4 : SALARY ANALYSIS
====================================================*/

/*====================================================
Business Question 17
Average Salary by Department

Objective:
The HR Director wants to compare the average
monthly salary across different departments to
evaluate compensation trends and support salary
benchmarking.
====================================================*/

SELECT Department, Round(AVG(MonthlyIncome),2) AS Avg_Salary_Percentage
FROM hr_employee
GROUP BY Department;


/*====================================================
Business Question 18
Highest Paying Job Roles

Objective:
The Compensation Team wants to identify the
highest-paying job roles to evaluate salary
distribution and compensation policies across
the organization.
====================================================*/

SELECT JobRole,ROUND(AVG(MonthlyIncome),2) AS Average_Monthly_Salary FROM hr_employee
GROUP BY JobRole
ORDER BY Average_Monthly_Salary DESC;


/*====================================================
Business Question 19
Salary Distribution by Education Level

Objective:
The HR Director wants to analyze whether higher
education levels are associated with higher
employee salaries to evaluate compensation
patterns across educational qualifications.
====================================================*/

SELECT Education,ROUND(AVG(MonthlyIncome),2) AS Average_Monthly_Salary FROM hr_employee
GROUP BY Education
ORDER BY Education;


/*====================================================
Business Question 20
Salary Distribution by Job Level

Objective:
Management wants to compare average monthly
salary across different job levels to understand
salary progression within the organization.
====================================================*/

SELECT JobLevel,ROUND(AVG(MonthlyIncome),2) AS Average_Monthly_Salary FROM hr_employee
GROUP BY JobLevel
ORDER BY JobLevel;

/*====================================================
Business Question 21
Employees Earning Above Department Average

Objective:
The Compensation Team wants to identify employees
whose monthly income is higher than the average
salary of their respective department to recognize
high-value talent and evaluate salary distribution.
====================================================*/


SELECT Department ,EmployeeNumber,JobRole,MonthlyIncome 
FROM hr_employee e1
WHERE MonthlyIncome >
(SELECT AVG(MonthlyIncome) FROM hr_employee e2 
WHERE e1.Department=e2.Department)
ORDER BY Department,MonthlyIncome DESC;

/*====================================================
SECTION 5 : EMPLOYEE EXPERIENCE & PERFORMANCE ANALYSIS
====================================================*/

/*====================================================
Business Question 23
Average Years at Company by Department

Objective:
The HR Director wants to compare the average years
employees stay within each department to identify
differences in employee retention and workforce
stability.
====================================================*/

SELECT Department, ROUND(AVG(YearsAtCompany),2) AS Average_Years_At_Company
FROM hr_employee
GROUP BY Department
Order by Average_Years_At_Company DESC;


/*====================================================
Business Question 24
Average Years Since Last Promotion

Objective:
Management wants to evaluate how long employees
typically wait for promotions to assess career
growth opportunities within the organization.
====================================================*/

SELECT ROUND(AVG(YearsSinceLastPromotion),2) AS Average_Years_Since_Last_Promotion
FROM hr_employee;


/*====================================================
Business Question 25
Training Frequency by Department

Objective:
The HR Director wants to compare the average number
of training sessions attended by employees across
departments to evaluate learning and development
initiatives.
====================================================*/

SELECT Department,ROUND(AVG(TrainingTimesLastYear),2) AS Average_Training_Sessions
FROM hr_employee
GROUP BY Department
ORDER BY Average_Training_Sessions DESC;


/*====================================================
Business Question 26
Work-Life Balance by Department

Objective:
Management wants to evaluate employee work-life
balance across departments to identify areas where
employee well-being initiatives may be required.
====================================================*/

SELECT Department,ROUND(AVG(WorkLifeBalance),2) AS Average_Work_Life_Balance
FROM hr_employee
GROUP BY Department
ORDER BY Average_Work_Life_Balance DESC;


/*====================================================
Business Question 27
Job Satisfaction by Department

Objective:
The HR Director wants to compare average job
satisfaction across departments to identify areas
requiring employee engagement and retention
initiatives.
====================================================*/

SELECT Department,ROUND(AVG(JobSatisfaction),2) AS Average_Job_Satisfaction
FROM hr_employee
GROUP BY Department
ORDER BY Average_Job_Satisfaction DESC;


/*====================================================
Business Question 28
Performance Rating Distribution

Objective:
Management wants to understand the distribution of
employee performance ratings to evaluate overall
organizational performance and identify high-
performing employee groups.
====================================================*/

SELECT PerformanceRating,COUNT(*) AS Employee_Count
FROM hr_employee
GROUP BY PerformanceRating
ORDER BY PerformanceRating;


/*====================================================
SECTION 6 : ADVANCED SQL ANALYSIS
====================================================*/

/*====================================================
Business Question 29
Department Salary Ranking

Objective:
The Compensation Team wants to rank departments
based on their average monthly salary to identify
which departments offer the highest compensation.
====================================================*/

SELECT Department,
ROUND(AVG(MonthlyIncome),2) AS Average_Monthly_Salary,
RANK()OVER(ORDER BY AVG(MonthlyIncome) DESC) AS Department_Rank
FROM hr_employee
GROUP BY Department
ORDER BY Department_Rank;


/*====================================================
Business Question 30
Top 3 Highest Paid Employees in Each Department

Objective:
The HR Director wants to identify the top three
highest-paid employees within each department for
compensation analysis and benchmarking.
====================================================*/

WITH Salary_Rank AS
(SELECT EmployeeNumber,Department,JobRole,MonthlyIncome,
    ROW_NUMBER() OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) AS Salary_Rank
FROM hr_employee)
SELECT *
FROM Salary_Rank
WHERE Salary_Rank <=3;

/*====================================================
Business Question 31
Salary Quartile Analysis

Objective:
Management wants to classify employees into salary
quartiles to better understand salary distribution
across the organization.
====================================================*/

SELECT EmployeeNumber,Department,MonthlyIncome,
NTILE(4) OVER(ORDER BY MonthlyIncome DESC) AS Salary_Quartile
FROM hr_employee;


/*====================================================
Business Question 32
Department-wise Running Salary Total

Objective:
The Finance Team wants to calculate the cumulative
salary expenditure within each department ordered
by monthly income.
====================================================*/

SELECT EmployeeNumber,Department,MonthlyIncome,
SUM(MonthlyIncome)OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) AS Running_Total_Salary
FROM hr_employee;


/*====================================================
Business Question 33
Salary Difference from Previous Employee

Objective:
The Compensation Team wants to compare each
employee's salary with the previous employee's
salary within the same department.
====================================================*/

SELECT EmployeeNumber,Department,MonthlyIncome,
    LAG(MonthlyIncome)OVER(PARTITION BY Department ORDER BY MonthlyIncome) AS Previous_Salary
FROM hr_employee;


/*====================================================
Business Question 34
Salary Difference with Next Employee

Objective:
The Compensation Team wants to compare each
employee's salary with the next employee's salary
within the same department.
====================================================*/

SELECT EmployeeNumber,Department,MonthlyIncome,
    LEAD(MonthlyIncome)OVER(PARTITION BY Department ORDER BY MonthlyIncome) AS Next_Salary
FROM hr_employee;

/*====================================================
Business Question 35
Highest Paid Employee in Each Department

Objective:
The HR Director wants to identify the highest-paid
employee in each department to support compensation
benchmarking and executive reporting.
====================================================*/

WITH Department_Salary_Rank AS
(SELECT EmployeeNumber,Department,JobRole,MonthlyIncome,
DENSE_RANK() OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) AS Salary_Rank
FROM hr_employee)
SELECT *
FROM Department_Salary_Rank
WHERE Salary_Rank = 1;

/*
====================================================
END OF PROJECT

Total Business Questions : 35

Topics Covered:
✓ Data Quality Assessment
✓ Employee Overview
✓ Attrition Analysis
✓ Salary Analysis
✓ Employee Experience Analysis
✓ Advanced SQL
✓ CTEs
✓ Correlated Subqueries
✓ CASE WHEN
✓ Window Functions
✓ Ranking Functions
✓ LEAD & LAG
✓ NTILE

Author:
Sameer Sharma

====================================================
*/


