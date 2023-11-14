
/*
        <INSERT>
            테이블에 새로운 행을 추가하는 구문이다.
            -- 모든 컬럼에 값을 INSERT 한다.
                INSERT INTO 테이블명 VALUES(값, 값, 값, ..., 값);
                
            -- 선택한 컬럼에 값을 INSERT 한다.
                INSERT INTO 테이블명(컬럼명, 컬럼명, ..., 컬럼명) VALUES(값, 값, ..., 값);
                
            -- 서브 쿼리로 조회한 결과값을 통째로 INSERT 한다.
                INSERT INTO 테이블명 (서브 쿼리);
*/

-- 테스트에 사용할 테이블 생성
CREATE TABLE EMP_TEST (
    EMP_ID NUMBER  PRIMARY KEY,
    EMP_NAME VARCHAR2(20) NOT NULL,
    DEPT_TITLE VARCHAR2(30),
    HIRE_DATE DATE DEFAULT SYSDATE
);

-- 표현법 1)
INSERT INTO EMP_TEST VALUES (100,'홍길동','서비스 개발팀',DEFAULT);
-- 모든 컬럼에 값을 지정하지 않아서 에러 발생
INSERT INTO EMP_TEST VALUES (200,'이몽룡','개발 지원팀');
-- 에러 발생은 하지 않지만  데이터가 잘못 저장되었다.
INSERT INTO EMP_TEST VALUES (200,'개발 지원팀','이몽룡',DEFAULT);
-- 컬럼 순서와 데이터 타입이 맞지 않아서 에러 발생
INSERT INTO EMP_TEST VALUES (DEFAULT,200,'개발 지원팀','이몽룡');

-- 표현법 2)
INSERT INTO EMP_TEST (EMP_ID, EMP_NAME, DEPT_TITLE, HIRE_DATE)
VALUES (300, '성춘향', '인사팀', NULL);

INSERT INTO EMP_TEST (EMP_ID, EMP_NAME)
VALUES (400, '임꺽정');

-- EMP_NAME 컬럼에 NOT NULL 제약조건으로 인해 에러 발생
INSERT INTO EMP_TEST (EMP_ID, DEPT_TITLE)
VALUES (500, '보안팀');

INSERT INTO EMP_TEST (EMP_ID, EMP_NAME, DEPT_TITLE)
VALUES (500, '김철수','보안팀');

-- 표현법 3) 
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여
-- 사원들의 사번, 직원명, 부서명, 입사일을 조회해서 EMP_TEST 테이블에 INSERT 하시오
INSERT INTO EMP_TEST (
    SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.HIRE_DATE
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
);

-- 테이블 컬럼의 순서와 서브쿼리 조회 결과의 순서가 일치 하지 않아서 에러 발생
INSERT INTO EMP_TEST (
    SELECT E.EMP_NAME, E.EMP_ID, D.DEPT_TITLE, E.HIRE_DATE
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
);

-- 서브쿼리로 조회한 데이터의 컬럼의 개수가 테이블의 컬럼 개수보다 많아서 에러발생
INSERT INTO EMP_TEST (
    SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.HIRE_DATE, D.DEPT_ID
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
);

-- EMPLOYEE 테이블에서 사원들의 사번, 직원명을 EMP_TEST 테이블에 INSERT 하시오
INSERT INTO EMP_TEST (EMP_ID, EMP_NAME) (
    SELECT EMP_ID,
                EMP_NAME
    FROM EMPLOYEE            
);

DELETE FROM EMP_TEST;

SELECT * FROM EMP_TEST;

DROP TABLE EMP_TEST;

/*
        <INSERT ALL>
            두 개 이상의 테이블에 각각 INSERT 하는데 
            동일한 서브 쿼리가 사용되는 경우 INSERT ALL을 이용해서 
            여러 테이블에 한 번에 데이터 삽입이 가능하다
*/

-- 표현법 1)
-- 테스트할 테이블 만들기 (테이블 구조만 복사)
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID,
                 EMP_NAME,
                 DEPT_CODE,
                 HIRE_DATE
    FROM EMPLOYEE
    WHERE 1 = 0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID,
                 EMP_NAME,
                 MANAGER_ID
    FROM EMPLOYEE
    WHERE 1 = 0;

-- EMP_DEPT 테이블에서 부서 코드가 D1인 직원들의
-- 사번, 직원명, 부서 코드, 입사일 삽입하고
-- EMP_MANAGER 테이블에 부서 코드가 D1인 직원들의
-- 사번, 직원명, 관리자 사번을 조회하여 삽입한다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';



SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;
















































































































































