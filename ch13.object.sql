-- ch13. OBJECT

-- 13.2 sequence 생성하기
CREATE SEQUENCE c_emp_seq
INCREMENT BY 1
START WITH 50
MAXVALUE 9999999
NOCACHE
NOCYCLE;

-- 13.4 sequence 생성 확인
-- 현재 유저가 소유한 모든 sequence 정보를 출력하시오.
SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences;

SELECT * FROM s_emp;

-- 단일 행 추가
INSERT INTO s_emp (id, name, salary)
values(c_emp_seq.nextval, 'aaa', 10000);

-- s_emp의 데이터 개수만큼 추가 -> 실행 시마다 기존 테이블의 2배씩 증가
INSERT INTO s_emp (id, name, salary)
SELECT c_emp_seq.nextval, 'aaa', 1000 FROM s_emp;

-- sequence 삭제
DROP SEQUENCE c_emp_seq;

-- 13.13 index 생성/삭제
-- S_EMP 테이블의 이름(name) 컬럼에 인덱스를 추가하시오.
CREATE INDEX emp_name ON s_emp(name); -- index 생성
SELECT * FROM ind; -- 확인

DROP INDEX emp_name; -- index 삭제 
SELECT * FROM ind;

-- 13.17 view의 생성
CREATE VIEW vw_emp_dept AS 
SELECT e.name name, d.name dept_name
FROM S_EMP e, S_DEPT d
WHERE e.DEPT_ID  = d.ID;

-- 13.20 view의 확인/삭제
SELECT * FROM user_views; -- 사용자 VIEW 목록 확인
SELECT view_name, text FROM user_views;

SELECT * FROM vw_emp_dept;

DROP VIEW vw_emp_dept; -- 삭제
SELECT * FROM user_views;
