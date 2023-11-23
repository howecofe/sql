-- ch7. SubQUERY
SELECT * FROM S_EMP; -- 직원 TABLE
SELECT * FROM S_DEPT; -- 부서 TABLE
SELECT * FROM S_CUSTOMER; -- 고객 TABLE

-- 단일 행 연산자: =, >, >=, <, <=, <>
-- 다중 행 연산자: IN, NOT IN

-- 7.3 single row subquery -> 단일 행 연산자 사용
SELECT NAME, TITLE, DEPT_ID
FROM S_EMP
WHERE DEPT_ID = (SELECT DEPT_ID FROM S_EMP WHERE NAME = '김정미');

-- 7.4 multi row subquery -> 다중 행 연산자 사용
SELECT NAME, TITLE, DEPT_ID
FROM S_EMP
WHERE DEPT_ID IN (SELECT ID FROM S_DEPT WHERE REGION_ID = 3);

-- 7.5 multi culumn subquery: pair-wise
SELECT NAME, DEPT_ID, SALARY
FROM S_EMP
WHERE (SALARY, DEPT_ID) IN
	(SELECT MIN(SALARY), DEPT_ID
	FROM S_EMP
	GROUP BY DEPT_ID);

-- 7.6 FROM 절에서의 subquery
-- 한 테이블에 데이터의 양이 많은 경우에는 FROM절에 테이블 전체를 기술하여 사용하면 효율이 떨어진다.
-- 이럴 떄는 from절의 subquery로 일부의 행과 컬럼을 선택하여 효율적인 검색이 가능하다.
-- 이런 subquery를 "inline view" 라고 한다.
SELECT e.NAME, e.TITLE, d.NAME
FROM (SELECT NAME, TITLE, DEPT_ID
		FROM S_EMP
		WHERE TITLE = '사원') e, S_DEPT d
WHERE e.DEPT_ID = d.ID;

-- 스칼라 서브쿼리
-- 1)join을 사용한 쿼리
SELECT se.NAME 사원명, sd.NAME 부서명 
FROM S_EMP se, S_DEPT sd
WHERE se.DEPT_ID = sd.ID;

-- 2) 스칼라 서브쿼리를 사용한 쿼리 : JOIN을 사용하는 것보다 복잡하지 않다.
SELECT se.NAME 사원명,
(SELECT sd.NAME FROM S_DEPT sd WHERE se.DEPT_ID = sd.ID) 부서명
FROM S_EMP se;

-- 7.7.HAVING 절에서의 subquery
-- 7.7.1 
SELECT DEPT_ID, AVG(SALARY) 
FROM S_EMP
GROUP BY DEPT_ID
HAVING AVG(SALARY) > (SELECT AVG(SALARY) FROM S_EMP WHERE DEPT_ID = 113); 

-- 7.7.2 가장 적은 평균급여(avg(salary))를 받는 직책에 대해 그 직책과 평균급여를 나타내시오.
-- 결과: 사원 809
SELECT TITLE, avg(salary)--MIN(AVG(salary)) -> 에러 !! avg(salary)는 되는데 min(avg(salary))는 에러 발생한다.
-- why? AVG(salary)는 그룹핑을 통해 나온 결과로 행마다 출력될 수 있지만, MIN(AVG(salary))은 avg(salary) 중의 최소값으로 단 1개의 값이니까 행마다 출력되기 어렵다.
-- 단일 그룹(avg(salary))의 그룹함수가 아니기 때문.
-- 여기서 단일 그룹이라 함은 table의 컬럼!
-- avg(salary) 단일 그룹은 min(avg(salary)로 한 번 더 연산이 가능하지만, title 컬럼까지 추가될 경우 단일 그룹이 아니므로 불가능하다.
FROM S_EMP
GROUP BY TITLE;
ORDER BY 2;

-- 7.7.2 풀이
SELECT TITLE, AVG(SALARY)
FROM S_EMP
--where title = (SELECT title FROM s_emp GROUP BY title HAVING avg(SALARY) = (SELECT MIN(AVG(salary)) FROM S_EMP GROUP BY TITLE)) -- '사원'
GROUP BY title
HAVING AVG(SALARY) = (SELECT MIN(AVG(salary)) FROM S_EMP GROUP BY TITLE); --809

-- [과정] HAVING AVG(SALARY) = 809
-- SELECT MIN(AVG(salary)) FROM S_EMP GROUP BY TITLE; -- 809에 대입

-- [과정] where title = '사원'
-- SELECT title FROM s_emp GROUP BY title HAVING avg(SALARY) = 809; -- '사원'에 대입
-- (SELECT MIN(AVG(salary)) FROM S_EMP GROUP BY TITLE) -- 위 문장 809에 대입

-- 7.8 CREATE 절에서의 subquery
CREATE TABLE EMP_113(ID, NAME, MAILID, START_DATE)
AS SELECT ID, NAME, MAILID, START_DATE
FROM S_EMP
WHERE DEPT_ID = 113;

SELECT * FROM EMP_113;

-- 7.9 DML 문에서의 subquery
INSERT INTO EMP_113(ID, NAME, MAILID, START_DATE)
SELECT ID, NAME, MAILID, START_DATE
FROM S_EMP
WHERE START_DATE < '16/01/01';

SELECT * FROM EMP_113;

UPDATE S_EMP
SET DEPT_ID = (SELECT DEPT_ID FROM S_EMP WHERE TITLE = '사장')
WHERE NAME = '안창환';

SELECT * FROM S_EMP WHERE NAME = '안창환';
