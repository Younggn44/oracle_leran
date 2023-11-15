/*
        <VIEW>
            VIEW는 오라클에서 제공하는 객체로 가상의 테이블이다.
*/

-- 한국에서 근무 하는 사원들의 사번, 직원명, 부서명, 급여, 근무 국가명을 조회
SELECT E.EMP_ID,
            E.EMP_NAME,
            D.DEPT_TITLE,
            E.SALARY,
            N.NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME = '한국';

-- 러시아에서 근무 하는 사원들의 사번, 직원명, 부서명, 급여, 근무 국가명을 조회
SELECT E.EMP_ID,
            E.EMP_NAME,
            D.DEPT_TITLE,
            E.SALARY,
            N.NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME = '러시아';

-- 일본에서 근무 하는 사원들의 사번, 직원명, 부서명, 급여, 근무 국가명을 조회
SELECT E.EMP_ID,
            E.EMP_NAME,
            D.DEPT_TITLE,
            E.SALARY,
            N.NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME = '일본';

/*
        1. VIEW 생성
*/

-- 처음 뷰를 생성 시 관리자 계정으로 CREATE VIEW 권한을 주어야 한다.
GRANT CREATE VIEW TO C##KH;

CREATE OR REPLACE VIEW V_EMPLOYEE 
AS SELECT E.EMP_ID,
                 E.EMP_NAME,
                 D.DEPT_TITLE,
                 E.SALARY,
                 N.NATIONAL_NAME
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
    JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
;

SELECT * 
FROM V_EMPLOYEE
WHERE V_EMPLOYEE.NATIONAL_NAME = '한국';

SELECT * 
FROM V_EMPLOYEE
WHERE V_EMPLOYEE.NATIONAL_NAME = '일본';

SELECT * 
FROM V_EMPLOYEE
WHERE V_EMPLOYEE.NATIONAL_NAME = '러시아';

-- 가상 테이블로 실제 데이터가 담겨있는 것은 아니다.
SELECT * FROM V_EMPLOYEE;

-- 접속한 계정이 가지고 있는 VIEW에 정보를 조회하는 뷰 테이블이다.
SELECT * FROM USER_VIEWS;

SELECT * FROM USER_TABLES;

/*
        2. 뷰 칼럼에 별칭 부여
*/
-- 모든 사원들의 사번, 직원명, 성별 코드, 근무년수, 연봉을 조회할 수 있는 뷰를 생성
-- 1) 서브 쿼리에 별칭을 지정 하는 방법
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID 사번,
            EMP_NAME 직원명,
            SUBSTR(EMP_NO,8,1) "성별 코드",
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무 년수",
            SALARY * 12 연봉
FROM EMPLOYEE;

-- 2) 뷰 생성 시 모든 컬럼에 별칭을 부여하는 방법

CREATE OR REPLACE VIEW V_EMPLOYEE("사번", "직원명", "성별 코드", "근무 년수", "연봉")
AS SELECT EMP_ID,
            EMP_NAME,
            SUBSTR(EMP_NO,8,1),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE),
            SALARY * 12
FROM EMPLOYEE;

SELECT * FROM V_EMPLOYEE;

-- 뷰 삭제
DROP VIEW V_EMPLOYEE;

/*
        3. VIEW를 이용해서 DML(INSERT, UPDATE,DELETE) 사용
*/

CREATE VIEW V_JOB
AS SELECT *
    FROM JOB;

-- VIEW를 SELECT 
SELECT * FROM V_JOB;

-- VIEW에 INSERT
INSERT INTO V_JOB VALUES ('J8','알바');

-- VIEW에 UPDATE
UPDATE V_JOB
SET JOB_NAME = '인턴'
WHERE V_JOB.JOB_CODE = 'J8';

-- VIEW에 DELETE
DELETE
FROM V_JOB
WHERE V_JOB.JOB_CODE = 'J8';

/*
        4. DML 구문으로 VIEW 조작이 불가능한 경우
           - 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
           - 뷰에 포함되지 않는 컬럼 중에 기본 테이블 상에 NOT NULL 제약조건이 지정된 경우
           - 산술 표현식으로 정의된 경우
           - 그룹 함수나 GROUP BY 절을 포함한 경우
           - DISTINCT를 포함한 경우
           - JOIN을 이용해 여러 테이블을 연결한 경우
*/

-- 1) 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_CODE
    FROM JOB;

-- INSERT 
INSERT INTO V_JOB VALUES ('J8', '인턴'); -- 에러 발생 (값의 수가 넘침)
INSERT INTO V_JOB VALUES ('J8');

-- UPDATE
UPDATE V_JOB
SET JOB_NAME = '인턴'
WHERE V_JOB.JOB_CODE ='J8'; -- 에러 발생

UPDATE V_JOB
SET JOB_CODE = 'J0'
WHERE V_JOB.JOB_CODE ='J8';

-- DELETE
DELETE 
FROM V_JOB
WHERE V_JOB.JOB_NAME IS NULL; -- 에러 발생

DELETE
FROM V_JOB
WHERE V_JOB.JOB_CODE = 'J0';

-- 2) 뷰에 포함되지 않는 컬럼 중에 기본 테이블 상에 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_NAME
    FROM JOB;

-- INSERT
INSERT INTO V_JOB VALUES ('인턴'); -- 에러 발생 : 부모키 제약이 걸린 JOB_CODE에 NULL 값을 기입할려고 해서

-- DROP
DROP VIEW V_JOB;

SELECT * FROM V_JOB;
SELECT * FROM JOB;

-- 3) 산술 표현식으로 정의된 경우
-- 사원의 연봉 정보를 조회하는 뷰
CREATE VIEW V_EMP_SAL
AS SELECT EMP_ID,
                 EMP_NAME,
                 EMP_NO,
                 SALARY,
                 SALARY * 12 "연봉"
    FROM EMPLOYEE;

-- INSERT 
-- 산술 연산으로 정의된 컬럼은 데이터 삽입이 불가능
INSERT INTO V_EMP_SAL 
VALUES ('100','홍길동','231115-3333333',3000000, 3600000); -- 급여를 참고해서 만든 '연봉' 열에 데이터를 기입할수 없다

-- 산술 연산과 무관한 컬럼은 데이터 삽입이 불가능
INSERT INTO V_EMP_SAL(EMP_ID, EMP_NAME, EMP_NO, SALARY)
VALUES ('100','홍길동','231115-3333333',3000000);

-- UPDATE
-- 산술 연산으로 정의된 컬럼은 데이터 변경이 불가능
UPDATE V_EMP_SAL
SET "연봉" = 50000000
WHERE EMP_ID = 100;

-- 산술 연산과 무관한 컬럼은 데이터 변경이 가능
UPDATE V_EMP_SAL
SET SALARY = 5000000
WHERE EMP_ID = 100;

--DELETE
DELETE 
FROM V_EMP_SAL
WHERE "연봉" = 60000000;

SELECT * FROM V_EMP_SAL
ORDER BY EMP_ID;

SELECT * FROM EMPLOYEE;

-- 4) 그룹 함수나 GROUP BY 절을 포함한 경우
-- 부서별 급여의 합계, 급여 평균을 조회하는 뷰를 생성
CREATE OR REPLACE VIEW V_EMP_SAL("부서 코드", "급여의 합계", "급여 평균")
AS SELECT NVL(DEPT_CODE,'부서 없음'),
            SUM(SALARY),
            FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- INSERT
INSERT INTO V_EMP_SAL VALUES ('D0', 8000000, 4000000); --에러 발생
INSERT INTO V_EMP_SAL("부서 코드") VALUES ('D0');

-- UPDATE

UPDATE V_EMP_SAL
SET "급여의 합계" = 12000000
WHERE "부서 코드" = 'D1';
-- 에러 발생 : 뷰에 대한 데이터 조작이 부적합합니다
UPDATE V_EMP_SAL
SET "부서 코드" = 'D0'
WHERE "부서 코드" = 'D1';
-- 에러 발생 : 뷰에 대한 데이터 조작이 부적합합니다

-- DELETE
DELETE
FROM V_EMP_SAL
WHERE "부서 코드" = 'D1';

SELECT * FROM V_EMP_SAL;

SELECT * FROM EMPLOYEE;


-- 5) DISTINCT를 포함한 경우
CREATE VIEW V_EMP_JOB
AS SELECT DISTINCT JOB_CODE
    FROM EMPLOYEE;

SELECT * FROM V_EMP_JOB;

-- INSERT
INSERT INTO  V_EMP_JOB VALUES ('J8');
-- 중복을 제거한 항이여서 하나의 행만 존재하지 않기 떄문에

-- UPDATE
UPDATE V_EMP_JOB
SET JOB_CODE = 'J8'
WHERE V_EMP_JOB.JOB_CODE = 'J7';

--DELETE
DELETE 
FROM V_EMP_JOB
WHERE JOB_CODE = 'J7';

-- 6) JOIN을 이용해 여러 테이블을 연결한 경우
-- 직원들의 사번, 직원명, 주민번호, 부서명 조회하는 뷰를 생성
CREATE OR REPLACE VIEW  V_EMP_DEPT
AS SELECT E.EMP_ID,
            E.EMP_NAME,
            E.EMP_NO,
            D.DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);

-- INSERT
INSERT INTO V_EMP_DEPT
VALUES (100, '홍길동', '941115-1111111', '인사부'); -- 에러 발생

INSERT INTO V_EMP_DEPT (EMP_ID, EMP_NAME, EMP_NO)
VALUES (100, '홍길동', '941115-1111111');

-- UPDATE
UPDATE V_EMP_DEPT
SET DEPT_TITLE = '개발팀'
WHERE EMP_ID = '200';

UPDATE V_EMP_DEPT
SET EMP_NAME = '김철수'
WHERE EMP_ID = '200';

-- 에러 발생
UPDATE V_EMP_DEPT
SET DEPT_TITLE = '개발팀'
WHERE EMP_ID = '200';        

-- DELETE
-- 서브 쿼리의 FROM절에 기술한 테이블에만 영향을 미친다.
DELETE 
FROM V_EMP_DEPT
WHERE EMP_ID = 200;

DELETE 
FROM V_EMP_DEPT
WHERE DEPT_TITLE = '총무부';

SELECT  * FROM V_EMP_DEPT
ORDER BY EMP_ID;

SELECT  * FROM EMPLOYEE
ORDER BY EMP_ID;

SELECT * FROM DEPARTMENT;

ROLLBACK;

/*
        5. VIEW 옵션
*/
-- 1) OR REPLACE
CREATE OR REPLACE VIEW V_EMP_SAL
AS SELECT EMP_NAME, SALARY, HIRE_DATE
    FROM EMPLOYEE;

SELECT * FROM USER_VIEWS;

-- 2) NOFORCE / FORCE
-- TEST 테이블을 생성한 이후부터 VIEW를 생성할 수 있다.
CREATE /* NOFORCE */ VIEW V_TEST_01
AS SELECT *
    FROM TEST;

-- TEST 테이블을 생성하지 않아도 VIEW를 생성할 수 있다.
CREATE FORCE VIEW V_TEST_02
AS SELECT *
    FROM TEST;

-- 단, TEST 테이블을 생성한 이후 부터 VIEW 조회 가능
SELECT * FROM V_TEST_02;

CREATE TABLE TEST (
    TNO NUMBER,
    TNAME VARCHAR2(20)
);

SELECT * FROM V_TEST_01;

-- 3) WITH CHECK OPTION
CREATE VIEW V_EMP 
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;

-- 사번이 200인 사원의 급여를 200만원으로 변경
-- 서브 쿼리의 조건에 부합하지 않아도 변경이 가능하다.
UPDATE V_EMP
SET SALARY = '2000000'
WHERE EMP_ID = 200;


CREATE OR REPLACE VIEW V_EMP 
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000
WITH CHECK OPTION;

-- 사번이 200인 사원의 급여를 200만원으로 변경
-- 서브 쿼리의 조건에 부합하지 않기 떄문에 변경이 불가능하다.
UPDATE V_EMP
SET SALARY = '2000000'
WHERE EMP_ID = 200;

-- 사번이 200인 사원의 급여를 400만원으로 변경
-- 서브 쿼리의 조건에 부합하기 때문에 변경이 가능하다.
UPDATE V_EMP
SET SALARY = 4000000
WHERE EMP_ID = 200;

SELECT * FROM V_EMP;
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 4. WITH READ ONLY
CREATE VIEW V_DEPT
AS SELECT *
    FROM DEPARTMENT
WITH READ ONLY;    

-- SELECT
SELECT * FROM V_DEPT;

-- INSERT
INSERT INTO V_DEPT VALUES ('D0', '개발부', 'L2');

-- UPDATE
UPDATE V_DEPT
SET DEPT_TITLE = '개발부'
WHERE DEPT_ID = 'D1';

-- DELETE
DELETE 
FROM V_DEPT
WHERE DEPT_ID = 'D1';

/*
        6. VIEW 삭제
*/

DROP VIEW V_TEST_02;