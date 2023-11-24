--1.
DELETE FROM S_EMP;

--2.
SELECT DISTINCT title FROM s_emp;

--3.
SELECT * FROM s_emp ORDER BY dept_id DESC, salary ASC;

--4.
SELECT count(*) FROM s_emp WHERE start_date < '15/01/01';

--5.
SELECT * FROM s_emp
WHERE salary >= 1000 AND salary <= 5000;

--6.
SELECT dept_id, avg(salary) FROM s_emp GROUP BY dept_id;

--7.
--1)
SELECT DEPT_ID, AVG(SALARY)  FROM S_EMP
GROUP BY DEPT_ID, TITLE
HAVING TITLE = '사원';

--2)
SELECT dept_id, avg(salary) FROM s_emp GROUP BY dept_id, title HAVING title = '사원';

--8.
SELECT region_id, count(*) FROM s_dept GROUP BY region_id;

--9.
SELECT dept_id, avg(salary) FROM s_emp
GROUP BY dept_id HAVING avg(salary) >= 2000;

--10.
SELECT title, sum(salary) FROM s_emp
GROUP BY title HAVING title <> '부장' AND sum(salary) >= 8000
ORDER BY 2;

--11.
SELECT dept_id, title, avg(salary) FROM s_emp
GROUP BY dept_id, title HAVING title = '사원';

--12.
SELECT dept_id, title, count(*) FROM s_emp
GROUP BY dept_id, title;

--13.
SELECT dept_id, count(*) FROM s_emp GROUP BY dept_id;

--14.
SELECT dept_id, min(salary), max(salary) FROM s_emp
GROUP BY dept_id HAVING min(SALARY) <> max(salary);

--15.
SELECT se.name, se.dept_id, sd.name
FROM s_emp se, s_dept sd
WHERE se.dept_id = sd.id;

--16.
SELECT se.name, sd.name FROM s_emp se, s_dept sd
WHERE se.dept_id = sd.id AND sd.region_id = 1;

--17.
SELECT se.name, se.salary, sg.grade FROM s_emp se, salgrade sg
WHERE se.salary BETWEEN sg.losal AND sg.hisal;

--18.
SELECT se.name, se.id, sc.name FROM s_emp se, s_customer sc
WHERE se.manager_id (+) = sc.sales_rep_id
ORDER BY 2;

--19.
SELECT se1.name, se1.title, se1.salary, se1.dept_id
FROM s_emp se1, s_emp se2
WHERE se1.title = se2.title
AND se2.name = '김정미'
AND se1.name <> '김정미';

--20.
SELECT title, avg(salary) FROM s_emp GROUP BY title
HAVING avg(salary) = (SELECT min(avg(salary)) FROM s_emp GROUP BY title);

--21.
SELECT se.NAME, se.SALARY, DECODE(TRUNC(se.SALARY/1000), 0, 'E', 1, 'D', 2, 'C', 3, 'B', 'A') 급여등급 
FROM S_EMP se;

--22.
SELECT se.name, se.salary, se.dept_id FROM s_emp se
WHERE se.salary < (SELECT avg(salary) FROM s_emp GROUP BY se.dept_id);

--23.
SELECT name, salary, dept_id FROM s_emp
WHERE salary < ANY (SELECT avg(salary) FROM s_emp GROUP BY dept_id);

--24.
SELECT se1.id, se1.name, se1.title, se1.dept_id FROM s_emp se1
WHERE EXISTS (SELECT * FROM s_emp se2 WHERE se1.id = se2.manager_id);

--25.
SELECT name FROM (SELECT * FROM s_emp ORDER BY name)
WHERE rownum <= 5;