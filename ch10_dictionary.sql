-- ch10 DICTIONARY

-- DICTIONARY 검색
SELECT * FROM DICTIONARY;

SELECT * FROM DICTIONARY
WHERE TABLE_NAME LIKE 'USER%';

-- 사용자가 소유한 모든 테이블 조회
SELECT object_name
FROM user_objects
WHERE OBJECT_TYPE = 'TABLE'; -- 대문자 필수

-- S_EMP의 테이블 레벨 제한 검색
SELECT constraint_name, constraint_type, search_condition, r_constraint_name
FROM USER_CONSTRAINTS  
WHERE TABLE_NAME = 'S_EMP';

-- S_EMP의 컬럼 레벨 제한 검색
SELECT constraint_name, column_name
FROM USER_CONS_COLUMNS 
WHERE TABLE_NAME = 'S_EMP';