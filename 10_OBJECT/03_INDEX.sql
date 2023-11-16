
/*
        <INDEX>
            INDEX는 오라클에서 제공하는 객체이다. 
            SQL 명령문의 처리 속도를 향상시키기 위해서 행들의 위치 정보를 가지고 있다. (내부 구조는 B-트리 형식으로 구성)
            검색 속도가 빨라지고 시스템에 걸리는 부하를 줄여 시스템 전체 성능을 향상시킨다.
*/
-- 춘 대학교 계정으로 접속
SELECT *
FROM TB_STUDENT
WHERE STUDENT_NAME = '황효종';

SELECT * 
FROM TB_STUDENT
WHERE STUDENT_NO = 'A511332';

-- 사용자가 정의한 인덱스와 인덱스가 설정된 컬럼에 정보를 보여주는 뷰 테이블
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;

-- 고유 인덱스 생성
-- 중복된 값이 없는 컬럼으로 고유 인덱스를 생성 가능
CREATE UNIQUE INDEX IDX_STUDENT_SSN
ON TB_STUDENT (STUDENT_SSN);

-- 중복된 값을 갖는 컬럼으로 고유 인덱스를 생성시 에러 발생
CREATE UNIQUE INDEX IDX_DEPARTMENT_NO
ON TB_STUDENT (DEPARTMENT_NO);

-- 비고유 인덱스 생성
CREATE INDEX IDX_STUDENT_NAME
ON TB_STUDENT(STUDENT_NAME);

SELECT *
FROM TB_STUDENT
WHERE STUDENT_NAME = '최효정';

-- 결합 인덱스 생성
-- TB_GRADE 테이블에 설정되어 있는 인덱스 사용
CREATE INDEX IDX_STUDENT_CLASS
ON TB_GRADE(STUDENT_NO, CLASS_NO);

-- 인덱스 삭제
DROP INDEX IDX_STUDENT_CLASS;
DROP INDEX IDX_STUDENT_NAME;
DROP INDEX IDX_STUDENT_SSN;

SELECT * 
FROM TB_GRADE
WHERE STUDENT_NO = 'A241056'
    AND CLASS_NO = 'C1753800'
;

SELECT *
FROM TB_STUDENT
WHERE STUDENT_NAME = '황효종';