CREATE TABLE mnc_emp(
Employee_ID VARCHAR(100),
NAME VARCHAR(100),
Department VARCHAR(100),
Job_Title VARCHAR(100),
Hire_Date DATE,
Location VARCHAR(100),
Performance_Rating INT,
Experience_Years INT,
Status VARCHAR(50),
Work_Mode VARCHAR(50),
Salary DECIMAL(12,2)
);

SELECT * FROM mnc_emp;

-- Q1 IT department ke sabhi employees nikalo.
SELECT * FROM mnc_emp
	WHERE department = 'IT';

-- Q2 Jinki salary 5 lakh se 10 lakh ke beech hai unki details nikalo.
SELECT name, department, salary
 	FROM mnc_emp
	 	WHERE salary BETWEEN 500000 AND 1000000;

-- Q3 Jinka experience 5 years se jyada hai unke naam aur salary dikhao.
SELECT name, experience_years, salary 
	FROM mnc_emp
	WHERE experience_years > 5;

-- Q4 Jinke naam "A" se start hote hain unko find karo.
SELECT DISTINCT name 
	FROM mnc_emp
	WHERE name LIKE 'A%';

-- Q5 Delhi location ke Active employees nikalo.
SELECT name, location, status
	FROM mnc_emp
	WHERE location = 'Delhi' AND status = 'Active';

-- Q6 Performance rating 4 ya 5 wale employees nikalo.
SELECT * FROM mnc_emp
	WHERE Performance_Rating BETWEEN 4 AND 5;

-- Q7 Jinka work mode Remote hai unki details nikalo.
SELECT * FROM mnc_emp
	WHERE work_mode = 'Remote';

-- Q8 Marketing aur HR department ke employees nikalo.
SELECT * FROM mnc_emp
	WHERE department IN ('Marketing', 'HR');

-- Q9 Salary 15 lakh se jyada wale employees find karo.

SELECT * FROM mnc_emp
	WHERE salary > 1500000;
-- Q10 Jinke name me "son" word aata hai unko find karo.
SELECT name FROM mnc_emp
	WHERE name LIKE '%son%';

-- Q11 Total employees kitne hain?
SELECT COUNT(*) FROM mnc_emp;

-- Q12 Company ka total salary expense nikalo.
SELECT SUM(salary) AS salary_expense
	FROM mnc_emp;

-- Q13 Maximum salary find karo.
SELECT * FROM mnc_emp
	ORDER BY salary DESC LIMIT 1;

-- Q14 Minimum salary find karo.
SELECT * FROM mnc_emp
	ORDER BY salary ASC LIMIT 1;

-- Q15 Average salary find karo.
SELECT ROUND(AVG(salary),2) FROM mnc_emp;

-- Q16 Average experience find karo.
SELECT ROUND(AVG(experience_years),2) FROM mnc_emp;

-- Q17 Highest performance rating kya hai?
SELECT * FROM mnc_emp
	ORDER BY performance_rating DESC LIMIT 1;

-- Q18 Kitne employees resigned hain?
SELECT COUNT(*) AS  resigned_employees FROM mnc_emp
	WHERE status = 'Resigned';

-- Q19 Har department me kitne employees hain?
SELECT COUNT(*), department FROM mnc_emp
	 GROUP BY department;

-- Q20 Har department ki average salary nikalo.
SELECT department, SUM(salary) AS current_salary,
	ROUND(AVG(salary),2) AS avg_salary FROM mnc_emp
	 GROUP BY department;

-- Q21 Har location me employee count nikalo.
SELECT  DISTINCT location, COUNT(*) AS Emp_EachLoc
	FROM mnc_emp
		GROUP BY location;

-- Q22 Har work mode me employee count nikalo.
SELECT work_mode, COUNT(*) AS Emp_HFW
	 FROM mnc_emp
	 	GROUP BY work_mode;

-- Q23 Har department ki maximum salary nikalo.
SELECT department, MAX(salary) AS MAX_Salary
	FROM mnc_emp
		GROUP BY department;

-- Q24 Har department ki minimum salary nikalo.
SELECT department, MIN(salary) AS MIN_Salary
	FROM mnc_emp
		GROUP BY department;

-- Q25 Har status (Active/Resigned) ke employees count nikalo.
SELECT status, COUNT(status) FROM mnc_emp
	GROUP BY status;

-- Q26 Har department ka total salary expense nikalo.
SELECT DISTINCT department, SUM(salary) AS salary_expense
	FROM mnc_emp
		GROUP BY department;

-- Q27 Har department ka average experience nikalo.
SELECT DISTINCT department,
	ROUND(AVG(experience_years),2) AS avg_experience
		FROM mnc_emp
			GROUP BY department;

-- Q28 Salary category banao:
-- < 5 lakh → Low
-- 5–10 lakh → Medium
-- 10 lakh → High
SELECT name,
	CASE
		 WHEN salary < 500000 THEN 'Low'
		WHEN salary BETWEEN 500000 AND 1000000 THEN 'MEdium'
		ELSE 'High'
	END AS Salary_Category
FROM mnc_emp;

-- Q29 Experience category banao:
-- 0–2 → Fresher
-- 3–5 → Junior
-- 6–10 → Mid Level
-- 10 → Senior
SELECT DISTINCT name, department,
	CASE
		 WHEN Experience_Years BETWEEN 0 AND 2 THEN 'Fresher'
		WHEN Experience_Years BETWEEN 3 AND 5 THEN 'Junior'
		WHEN Experience_Years BETWEEN 6 AND 10 THEN 'Mid level'
		ELSE 'Senior'
	END AS Exp_Category
FROM mnc_emp;

-- Q30 Performance category banao:
-- 1–2 → Poor
-- 3 → Average
-- 4–5 → Excellent

SELECT name,Performance_rating,
	CASE
		WHEN Performance_rating BETWEEN 1 AND 2 THEN 'Poor'
		WHEN Performance_rating = 3 THEN 'Average'
		WHEN Performance_rating BETWEEN 4 AND 5 THEN 'Excellent'
	END AS Performance_category 
FROM mnc_emp;

-- Q31 Count nikalo ki kitne employees High, Medium aur Low salary category me hain.
SELECT
	CASE
		WHEN salary < 500000 THEN 'LOW'
		WHEN salary BETWEEN 500000 AND 1000000 THEN 'Medium'
		ELSE 'High'
	END AS salary_category,
	COUNT(*) AS employee_count
FROM mnc_emp
GROUP BY salary_category;

-- Q32 Har employee ke saath company ki average salary dikhao.
SELECT 

-- Q33 Har employee ke saath department ki average salary dikhao.
SELECT name, department, salary,
	ROUND(AVG(salary) OVER(PARTITION BY department),2) AS dept_avg_salary
FROM mnc_emp;

-- Q34 Salary ke basis par ranking do (highest salary = rank 1).
SELECT name, salary,
	RANK() OVER(ORDER BY salary DESC) AS salary_ranking
FROM mnc_emp;

-- Q35 Department wise salary ranking nikalo.
SELECT name, department, salary,
	DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_ranking
FROM mnc_emp;

-- Q36 Top 3 highest paid employees find karo.
SELECT * FROM mnc_emp
	ORDER BY salary DESC LIMIT 3;

-- Q37 Har department ka highest paid employee find karo.
SELECT name, department, salary
FROM(
	SELECT name, department, salary,
		RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS max_paid_dept
	FROM mnc_emp
	) t
WHERE max_paid_dept = 1;

-- Q38 Har department ka second highest paid employee find karo.
SELECT name, department, salary
FROM(
	SELECT name, department, salary,
		DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS sec_paid_dept
	FROM mnc_emp
	) t
WHERE sec_paid_dept = 2;

-- Q39 Kaunsa department sabse jyada salary spend kar raha hai?
SELECT name, department, salary
FROM(
	SELECT name, department, salary,
		DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS sec_paid_dept
	FROM mnc_emp
	) t
WHERE sec_paid_dept = 2;

-- Q40 Kaunsi location me sabse jyada employees hain?
SELECT location, COUNT(*) AS emp_count
FROM mnc_emp
GROUP BY location
ORDER BY emp_count DESC
LIMIT 1;

-- Q41 Kaunsa department highest average salary deta hai?
SELECT department, AVG(salary) AS hightest_salary
FROM mnc_emp
GROUP BY department
ORDER BY hightest_salary DESC
LIMIT 1;

-- Q42 Top 5 highest paid employees ki list nikalo.
SELECT * FROM mnc_emp
	ORDER BY salary DESC LIMIT 5;

-- Q43 Kaunse departments me resigned employees sabse jyada hain?
SELECT department,
COUNT(*) AS resigned_emp
FROM mnc_emp
WHERE status = 'Resigned'
GROUP BY department
ORDER BY resigned_emp DESC;

-- Q44 Remote employees ki average salary aur On-site employees ki average salary compare karo.
SELECT name, department, work_mode, 
	ROUND(
		AVG(salary) OVER(PARTITION BY work_mode),2
	) AS avg_salary_WorkMode
FROM mnc_emp;

-- Q45 Experience aur salary ke relation ko analyze karne ke liye experience group-wise average salary nikalo.
SELECT
    CASE
        WHEN experience_years < 3 THEN '0-2 Years'
        WHEN experience_years BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN experience_years BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE '10+ Years'
    END AS experience_group,
    ROUND(AVG(salary), 2) AS avg_salary
FROM mnc_emp
GROUP BY
    CASE
        WHEN experience_years < 3 THEN '0-2 Years'
        WHEN experience_years BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN experience_years BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE '10+ Years'
    END
ORDER BY avg_salary;
























































































































































































