-- ch6. JOIN
SELECT * FROM S_EMP;
SELECT * FROM S_DEPT;

-- 6.4 EQUIJOIN
-- 직원 테이블(s_emp)과 부서 테이블(s_dept) 테이블을 join하여, 사원의 이름과 부서, 부서명을 나타내시오.
SELECT se.NAME 이름, sd.ID 부서, sd.NAME 부서명
FROM S_EMP se, S_DEPT sd 
WHERE se.DEPT_ID = sd.ID;

-- 6.5 서울 지역에 근무하는 사원에 대해 각 사원의 이름과 근무하는 부서명을 나타내시오.
SELECT se.NAME 사원명, sd.NAME 부서명
FROM S_EMP se, S_DEPT sd
WHERE sd.REGION_ID = 1;

-- 6.6 NON-EQUIJOIN
-- 직원 테이블(s_emp)과 급여 테이블(salgrade)을 JOIN하여 사원의 이름(s_emp.name)과 급여(s_emp.salary), 그리고 해당 급여등급(salgrade.grade)을 나타내시오.
SELECT * FROM SALGRADE s;
SELECT * FROM S_EMP se;

SELECT se.NAME 이름, se.SALARY 급여, s.GRADE 급여등급
FROM S_EMP se, SALGRADE s
WHERE se.SALARY BETWEEN s.LOSAL AND s.HISAL;

-- 6.7 OUTER JOIN
-- 직원 테이블(s_emp)과 고객 테이블(s_customer)에서 사원의 이름(s_emp.name)과 사번(s_emp.id), 그리고 각 사원의 담당고객 이름(s_customer.name)을 나타내시오.
-- 단, 고객에 대하여 담당영업사원(s_customer.sales_rep_id)이 없더라도 모든 고객의 이름을 나타내고(outer join), 사번(s_emp.id) 순으로 오름차순 정렬하시오.
SELECT * FROM S_CUSTOMER;
SELECT * FROM S_EMP se;

SELECT se.NAME 사원명, se.ID 사번, sc.NAME 담당고객명
FROM S_EMP se, S_CUSTOMER sc
WHERE se.ID (+) = sc.SALES_REP_ID
ORDER BY 2;

-- 6.8 직원 중에 '김정미'와 같은 직책(title)을 가지는 사원의 이름(name)과 직책(title), 급여(salary), 부서번호(dept_id)를 나타내시오. (SELF JOIN을 사용할 것)
SELECT *
FROM S_EMP se1, S_EMP se2
WHERE se1.TITLE = se2.TITLE;

-- 삽질1
SELECT s1.TITLE, s1.NAME, s1.SALARY, s1.DEPT_ID
FROM S_EMP s1--, S_EMP s2
WHERE s1.title = '과장'
AND s1.name != '김정미';

-- 삽질2
SELECT s2.TITLE, s2.NAME, s2.SALARY, s2.DEPT_ID
FROM s_emp s1, s_emp s2
WHERE s2.name  = s1.name
AND s2.TITLE ='과장'
AND s2.NAME != '김정미';

-- 삽질3
SELECT s2.TITLE, s2.NAME, s2.SALARY, s2.DEPT_ID
FROM s_emp s1, s_emp s2
WHERE s1.name = s2.name
AND s2.title = (SELECT TITLE FROM S_EMP WHERE NAME = '김정미') 
AND s2.NAME != '김정미';

-- 정답!
SELECT s1.TITLE, s1.NAME, s1.SALARY, s1.DEPT_ID
FROM s_emp s1, s_emp s2
WHERE s1.title = s2.title
AND s2.name = '김정미'
AND s1.name != '김정미';

-- 6.9 SET 연산자: UNION, UNION ALL, INTERSECT, MINUS
-- UNION ALL: 공통된 행 상관없이 합침. 중복 O, 교집합 계산을 안 해도 되어 UNION보다 성능이 좋다.
SELECT 0,0,0,0,0, sysdate, 'ddd' FROM dual
UNION ALL
SELECT 0,0,0,0,0, sysdate, 'ccc' FROM dual
UNION ALL
SELECT 0,0,0,0,0, sysdate, 'bbb' FROM dual
UNION ALL
SELECT 0,0,0,0,0, sysdate, 'ccc' FROM dual;







