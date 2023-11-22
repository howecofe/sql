-- ch5. subgroup으로 데이터 분류하기
--SELECT * FROM s_emp;
--SELECT * FROM S_DEPT;

-- 5.2.1 각 부서별 평균 급여를 계산해서 보여주시오.
SELECT DEPT_ID , ROUND(AVG(SALARY), 2)
FROM S_EMP
GROUP BY DEPT_ID;

-- 5.2.2 각 부서별로 직책이 사원인 직원들의 평균 급여를 계산해서 보여주시오.
SELECT DEPT_ID, AVG(SALARY)
FROM S_EMP
WHERE TITLE  = '사원'
GROUP BY DEPT_ID;

-- 5.3.1 각 지역별로 몇 개의 부서가 있는지를 나타내시오.
SELECT REGION_ID, COUNT(*)
FROM S_DEPT
GROUP BY REGION_ID;

-- 5.3.2 각 부서별로 평균 급여를 구하되 평균 급여가 2000 이상인 부서만 나타내시오.
SELECT DEPT_ID, AVG(SALARY)
FROM S_EMP
GROUP BY DEPT_ID 
HAVING AVG(SALARY) >= 2000;

-- 5.5.1 각 직책별(title)로 급여의 총합(sum(salary))을 구하되 직책이 부장인 사람은 제외하시오.
-- 단, 급여총합이 8000 이상인 직책만 나타내며, 급여 총합에 대한 오름차순으로 정렬하시오.
SELECT TITLE, SUM(SALARY) 
FROM S_EMP
WHERE TITLE != '부장'
GROUP BY TITLE
HAVING SUM(SALARY) >= 8000
ORDER BY SUM(SALARY) ASC; 

-- 5.5.2 각 부서별(dept_id)로 직책(title)이 사원인 직원들에 대해서만 평균 급여(avg(salary))를 구하시오.
SELECT DEPT_ID, avg(SALARY)
FROM S_EMP
WHERE TITLE = '사원'
GROUP BY DEPT_ID;

-- 5.6.1 각 부서 내(dept_id)에서 각 직책별(title)로 몇 명의 인원(count(*))이 있는지를 나타내시오.
SELECT DEPT_ID, TITLE, COUNT(*) 
FROM S_EMP
GROUP BY DEPT_ID, TITLE;

-- 5.6.2 각 부서 내에서 몇 명의 직원이 근무하는지를 나타내시오.
SELECT DEPT_ID, COUNT(*)
FROM S_EMP
GROUP BY DEPT_ID;

-- 5.6.3 각 부서별(dept_id)로 급여의 최소값(min(salary))과 최대값(max(salary))을 나타내시오. 단, 최소값과 최대값이 같은 부서는 출력하지 마시오.
SELECT DEPT_ID, MIN(SALARY), MAX(SALARY)  
FROM S_EMP
HAVING MIN(SALARY) != MAX(SALARY) 
--WHERE HAVING MIN(SALARY) != MAX(SALARY) 에러!! 그룹함수는 HAVING 절로 다뤄야 한다.
GROUP BY DEPT_ID;

