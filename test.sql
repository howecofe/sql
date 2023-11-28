-- 1. 각 부서별 평균 급여를 구하되 평균 급여가 2000 이상인 부서만 나타내는 SELECT문을 작성하시오.
SELECT DEPT_ID, AVG(SALARY) 
FROM S_EMP
GROUP BY DEPT_ID
HAVING AVG(SALARY) >= 2000; 

-- 2. 각 직책별로 급여의 총합을 구하되 직책이 사원인 사람은 제외하시오.
-- 단, 급여 총합이 3000 이상인 직책만 나타내며, 급여 총합에 대한 내림차순으로 정렬하시오.
SELECT TITLE, SUM(SALARY) 
FROM S_EMP
WHERE TITLE <> '사원'
GROUP BY TITLE 
HAVING SUM(SALARY) >= 3000
ORDER BY 2 DESC;

-- 3. 직급이 '부장'(영업부장, 지부장 포함)인 사람이 2명 이하인 부서가 몇 개일지 나타내는 SELECT문을 작성하시오.
--SELECT COUNT(*) FROM
--(SELECT TITLE, DEPT_ID, COUNT(*) 
--FROM S_EMP
--GROUP BY TITLE, DEPT_ID 
--HAVING TITLE LIKE '%부장'
--AND COUNT(*) <= 2);

--SELECT SUM(COUNT(*)) 
--FROM S_EMP
--WHERE TITLE LIKE '%부장'
--GROUP BY DEPT_ID
--HAVING COUNT(*) <= 2;

SELECT SUM(COUNT(*)) 
FROM S_EMP
GROUP BY TITLE, DEPT_ID 
HAVING TITLE LIKE '%부장'
AND COUNT(*) <= 2;

-- 4. 담당직원이 배정되지 않은 고객을 모두 나타내는 SELECT문을 작성하시오.
SELECT NAME 
FROM S_CUSTOMER
WHERE SALES_REP_ID IS NULL;

-- 5. Primary Key와 Foreign Key에 대해서 아는대로 적으시오.
-- PK는 테이블의 행을 구분하는 기본키로, PK에 해당하는 값은 유일해야 하고 (중복 x) 데이터 무결성을 지켜야 한다.
-- FK는 PK의 참조키다.

-- 6. CONSTRAINT의 종류를 모두 적으시오. (총 5개)
-- NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY

-- 7. 자동으로 고유한 숫자값을 생성해주며 주로 기본키 값을 생성하기 위해 사용하는 object는?
-- sequence

-- 8. 전체 임직원 중에서 연봉이 제일 높은 사람 3명의 이름과 연봉을 출력하는 문장을 작성하시오.
SELECT NAME, SALARY
FROM (SELECT * FROM S_EMP ORDER BY SALARY DESC)
WHERE rownum <= 3;

-- 9. 인덱스(index)를 생성하기에 적절한 경우를 모두 고르시오.
-- 1) 조건절이나 조인에서 자주 사용되는 컬럼
-- 2) 컬럼이 넓은 범위의 값을 가질 때
-- 3) NULL값이 많은 컬럼
-- 4) 테이블에 데이터가 많고, 조회되는 행이 전체의 10~15%일 때
-- -> 1), 2), 3), 4) 모두

-- 10. 아래의 SQL문은 비효율적이다. (s_emp.title에 인덱스가 작성되어 있다고 가정)
--SELECT ID, NAME, TITLE
--FROM S_EMP
--WHERE TITLE <> '사원';
-- 이 문장을 NOT EXISTS를 사용해서 효율적으로 작성하시오.
SELECT ID, NAME, TITLE
FROM S_EMP e
WHERE NOT EXISTS (SELECT * FROM S_EMP WHERE e.TITLE = '사원'); -- 상관 서브쿼리