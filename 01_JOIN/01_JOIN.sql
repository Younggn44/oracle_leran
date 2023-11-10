/*
        <JOIN>
            1.  INNER JOIN
                INNER JOIN은 조인하려는 테이블들에서 공통된 컬럼의 값이 일치되는 행들을 하나의 행으로 연결하여 결과(Result Set)를 조회한다.
                INNER JOIN은 공통된 컬럼에서 공통된 값이 없거나 컬럼에 값이 없는 행은 조회되지 않는다.
                1) 오라클 전용 구문
                    SELECT 컬럼, ...
                    FROM 테이블1, 테이블2
                    WHERE 테이블1.컬럼 = 테이블2.컬럼;
                    FROM 절에 ","로 구분하여 조인에 사용할 테이블들을 기술하고 WHERE 절에 공통된 값을 가진 컬럼에 대한 조건을 작성한다.
                
*/
-- 1-1) 연결한 두 컬럼명이 다른 경우
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 JOIN하여
-- 사원들의 사번, 직원명, 부서 코드, 부서명을 조회
-- 일치하는 값이 없는 행은 조회에서 제외된다.
--      DEPT_CODE가 NULL인 사원
--      DEPT_ID가 D3, D4, D7인 부서
SELECT EMP_ID,
             EMP_NAME,
             DEPT_CODE,
             DEPT_ID,
             DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
ORDER BY DEPT_ID ;

-- 1-2) 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 사번, 직원명, 직급 코드
-- 방법 1) 테이블명을 이용하는 방법
SELECT EMPLOYEE.EMP_ID,
             EMPLOYEE.EMP_NAME,
             EMPLOYEE.JOB_CODE,
             JOB.JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- 같은 컬럼명이 같은 부분을 테이블을 명칭 해서 작성한다

-- 방법 2) 테이블에 별칭을 이용하는 방법
SELECT E.EMP_ID,
             E.EMP_NAME,
             J.JOB_CODE,
             J.JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;



SELECT E.EMP_ID,
             E.EMP_NAME,
             J.*
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

/*
        2)  ANSI 표준 구문
        FROM 절 다음에 JOIN 구문을 통해 조인에 사용할 테이블을 기술하고 ON 또는 USING 절에 공통된 값을 가진 컬럼에 대한 조건을 작성한다.
             SELECT 컬럼, ..
             FROM 테이블 1
             [INNER | OUTER]JOIN 테이블 2 ON (테이블1.컬럼 = 테이블2.컬럼)
*/

-- 2-1) 연결할 두 컬럼명이 다른 경우
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여 사번, 직원명, 부서 코드, 부서명을 조회
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             D.DEPT_ID "부서 코드",
             D.DEPT_TITLE 부서명
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
ORDER BY E.DEPT_CODE
;

-- 2-2) 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 사번, 직원명, 직급 코드, 직급명을 조회
-- 방법 1) 테이블명을 이용하는 방법
SELECT EMPLOYEE.EMP_ID 사번,
             EMPLOYEE.EMP_NAME 직원명,
             JOB.JOB_CODE 직급코드,
             JOB.JOB_NAME 직급명
FROM EMPLOYEE
JOIN JOB ON (EMPLOYEE.JOB_CODE = JOB.JOB_CODE)
ORDER BY JOB_CODE
;

-- 방법 2)
-- 테이블 별칭을 이용하는 방법
-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 사번, 직원명, 직급 코드, 직급명을 조회
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             J.JOB_CODE 직급코드,
             J.JOB_NAME 직급명
FROM EMPLOYEE E
INNER JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
ORDER BY E.JOB_CODE
;

-- 방법 3) USING 구문을 이용하는 방법
SELECT EMP_ID,
             EMP_NAME,
             JOB_CODE,
             JOB_NAME
FROM EMPLOYEE
-- USING 구문을 이용하면 같은 컬럼으로 인식해서 에러가 발생하지 않는다.
INNER JOIN JOB USING (JOB_CODE)
;

-- 방법 4) NATURAL JOIN 이용하는 방법(참고)
-- 단점으로는 테이블에 같은 이름의 컬럼이 많을경우 내가 원하는 방향으로 진행될 가능성이 낮음
SELECT EMP_ID,
             EMP_NAME,
             JOB_CODE,
             JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB
;


-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 직급이 대리인 사원의 
-- 사번, 직원명, 직급 코드, 직급명을 조회
-- 오라클
SELECT E.EMP_ID,
             E.EMP_NAME,
             J.JOB_CODE,
             J.JOB_NAME
FROM EMPLOYEE E, JOB  J
WHERE E.JOB_CODE = J.JOB_CODE
    AND J.JOB_NAME = '대리'
ORDER BY E.EMP_NAME
;

--ANSI
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             J.JOB_CODE AS "직급 코드",
             J.JOB_NAME 직급명
FROM EMPLOYEE E
--INNER JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE AND J.JOB_NAME = '대리')
INNER JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '대리'
ORDER BY E.EMP_NAME
;




-- EX 1)
-- DEPARTMENT 테이블과 LOCATION 테이블을 조인하여
-- 부서 코드, 부서명, 지역 코드, 지역명을 조회
-- 오라클
SELECT D.DEPT_ID AS "부서 코드",
             D.DEPT_TITLE 부서명,
             L.LOCAL_CODE AS "지역 코드",
             L.LOCAL_NAME 지역명
FROM DEPARTMENT D,LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE
ORDER BY L.LOCAL_CODE
;

-- ANSI
SELECT D.DEPT_ID AS "부서 코드",
             D.DEPT_TITLE 부서명,
             L.LOCAL_CODE AS "지역 코드",
             L.LOCAL_NAME 지역명
FROM DEPARTMENT D           
INNER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
ORDER BY L.LOCAL_CODE
;

-- EX 2)
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여 보너스를 받는 사원들의
-- 사번, 직원명, 보너스, 부서명을 조회
-- 오라클
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             E.BONUS 보너스,
             D.DEPT_TITLE 부서명
FROM EMPLOYEE E ,DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
     AND E.BONUS IS NOT NULL
ORDER BY 부서명, E.BONUS
;

-- ANSI
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             E.BONUS 보너스,
             D.DEPT_TITLE 부서명
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE E.BONUS IS NOT NULL
ORDER BY 부서명 , E.BONUS
;

-- EX 3)
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여 인사관리부가 아닌 사원들의
-- 직원명, 부서명, 급여를 조회
-- 오라클
SELECT E.EMP_NAME "직원명",
             D.DEPT_TITLE "부서명",
             TO_CHAR(E.SALARY, 'FML999,999,999') "급여"
FROM EMPLOYEE E , DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
    AND D.DEPT_TITLE ^= '인사관리부'
ORDER BY D.DEPT_TITLE , E.SALARY
;

-- ANSI
SELECT E.EMP_NAME "직원명",
             D.DEPT_TITLE "부서명",
             TO_CHAR(E.SALARY, 'FML999,999,999') "급여"
FROM EMPLOYEE E 
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE ^= '인사관리부'
ORDER BY D.DEPT_TITLE, E.SALARY
;


-- EX 4)
-- EMPLOYEE 테이블, DEPARTMENT 테이블, JOB테이블을 조인하여
-- 사번, 직원명, 부서명, 직급명 조회
-- 오라클
SELECT E.EMP_ID 사번,
            E.EMP_NAME 직원명,
            D.DEPT_TITLE 부서명,
            J.JOB_NAME 직급명
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
ORDER BY E.JOB_CODE, E.EMP_NAME
;

-- ANSI
SELECT E.EMP_ID 사번,
            E.EMP_NAME 직원명,
            D.DEPT_TITLE 부서명,
            J.JOB_NAME 직급명
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
ORDER BY E.JOB_CODE, E.EMP_NAME    
;


/*
        2. OUTER JOIN
        JOIN 조건을 만족하지 않는 행들을 조회하기 위한 구문이다.
        단, 반드시 기준이 되는 테이블(컬럼)을 지정해야 한다.
        (LEFT, RIGHT, FULL, (+))
        OUTER JOIN은 INNER JOIN과 다르게 공통된 컬럼에서 공통된 값이 없거나 컬럼에 값이 없는 행들도 함께 조회하기 위해서 사용되는 구문이다.
        
*/
-- OUTER JOIN과 비교할 INNER JOIN 구문
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 사원들의
-- 사원명, 부서명, 급여, 연봉 조회

-- 부서가 지정되지 않은 사원 2명에 대한 정보가 조회되지 않는다.
-- 부서가 지정되어 있어도 DEPARTMENT에 부서에 대한 정보가 없으면 조회되지 않는다.
SELECT E.EMP_NAME 사원명,
             D.DEPT_TITLE 부서명,
             TO_CHAR(E.SALARY,'FM999,999,999') 급여,
             TO_CHAR(E.SALARY *12,'FM999,999,999') AS"연봉"
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID)
;

/*
        1) LEFT OUTER JOIN
            조인에 사용한 두 테이블 중 왼쪽에 기술된 테이블의 컬럼을 기준으로 조회하려고 할 때 사용한다.
            즉, 오른쪽 테이블과 매칭되는 데이터가 없어도 조회된다.
*/
-- ANSI
-- 부서 코드가 없던 사원(이오리, 하동운)의 정보가 출력된다
SELECT E.EMP_NAME 사원명,
             D.DEPT_TITLE 부서명,
             TO_CHAR(E.SALARY,'FM999,999,999') 급여,
             TO_CHAR(E.SALARY *12,'FM999,999,999') AS"연봉"
FROM EMPLOYEE E
LEFT /* OUTER */ JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID)
ORDER BY D.DEPT_TITLE DESC
;

-- 오라클
SELECT E.EMP_NAME 사원명,
             D.DEPT_TITLE 부서명,
             TO_CHAR(E.SALARY,'FM999,999,999') 급여,
             TO_CHAR(E.SALARY *12,'FM999,999,999') AS"연봉"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)    -- 오른쪽 테이블 컬럼에 (+) 표시
ORDER BY E.DEPT_CODE DESC, D.DEPT_TITLE
;

/*
        2) RIGHT OUTER JOIN
            조인에 사용한 두 테이블 중 오쪽에 기술된 테이블의 컬럼을 기준으로 조회하려고 할 때 사용한다.
            즉, 왼쪽 테이블과 매칭되는 데이터가 없어도 조회된다.
*/
-- ANSI
SELECT E.EMP_NAME 사원명,
             D.DEPT_TITLE 부서명,
             TO_CHAR(E.SALARY,'FM999,999,999') 급여,
             TO_CHAR(E.SALARY *12,'FM999,999,999') AS"연봉"
FROM EMPLOYEE E
RIGHT /* OUTER */ JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID)
ORDER BY E.DEPT_CODE DESC, D.DEPT_TITLE
;

-- 오라클
SELECT E.EMP_NAME 사원명,
             D.DEPT_TITLE 부서명,
             TO_CHAR(E.SALARY,'FM999,999,999') 급여,
             TO_CHAR(E.SALARY *12,'FM999,999,999') AS"연봉"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID    -- 왼쪽 테이블 컬럼에 (+) 표시
ORDER BY E.DEPT_CODE DESC, D.DEPT_TITLE
;

/*
        3) FULL OUTTER JOIN
            두 테이블이 가진 모든 행을 조회할 떄 사용한다.
            단, 오라클 구문은 지원하지 않는다.
            조인에 사용한 두 테이블이 가진 모든 테이블의 컬럼을 기준으로 조회하려고 할 때 사용한다.
            즉, 왼쪽과 오른쪽 테이블 모두 매칭되는 데이터가 없어도 조회된다.
*/

-- ANSI
SELECT E.EMP_NAME 사원명,
             D.DEPT_TITLE 부서명,
             TO_CHAR(E.SALARY,'FM999,999,999') 급여,
             TO_CHAR(E.SALARY *12,'FM999,999,999') AS"연봉"
FROM EMPLOYEE E
FULL /* OUTER */ JOIN DEPARTMENT D ON ( E.DEPT_CODE = D.DEPT_ID)
ORDER BY E.DEPT_CODE DESC, D.DEPT_TITLE
;

-- 오라클
-- 오라클은 FULL OUTER JOIN은 지원 안함
SELECT *
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID(+)    -- 양쪽 테이블 컬럼에 (+) 표시
ORDER BY E.DEPT_CODE DESC, D.DEPT_TITLE
;


/*
        4) CROSS JOIN
            JOIN되는 모든 테이블의 행들이 서로 서로 매핑된 데이터가 검색된다.
            CROSS JOIN은 카테시안 곱(Cartesian Product)라고도 하며 조인되는 테이블의 모든 행들이 매핑된 데이터를 조회하기 위해 사용되는 구문이다.
*/
-- ANSI
SELECT E.EMP_NAME,
             D.DEPT_TITLE
FROM EMPLOYEE E
CROSS JOIN DEPARTMENT D -- 23 *9 = 207
ORDER BY E.EMP_NAME
;
-- 오라클
SELECT E.EMP_NAME,
             D.DEPT_TITLE
FROM EMPLOYEE E , DEPARTMENT D
ORDER BY E.EMP_NAME
;

/*
        4 . NON EQUAL JOIN
            JOIN 조건에 등호(=)를 사용하지 않는 조인문을 비등가 조인이라고 한다.
*/
-- ANSI
-- EMPLOYEE 테이블과 SAL_GRADE 테이블을 비등가 조인하여
-- 직원명, 급여, 급여 등급 조회
SELECT E.EMP_NAME,
             E.SALARY,
             S.*
FROM EMPLOYEE E
--JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL)
JOIN SAL_GRADE S ON (E.SALARY >= S.MIN_SAL AND E.SALARY <= S.MAX_SAL )
;

-- 오라클
SELECT E.EMP_NAME,
             E.SALARY,
             S.*
FROM EMPLOYEE E, SAL_GRADE S
WHERE E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL
;

-- ANSI
SELECT E.EMP_NAME,
             E.SALARY,
             S.*
FROM EMPLOYEE E
LEFT JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL)
;

-- 오라클
SELECT E.EMP_NAME,
             E.SALARY,
             S.*
FROM EMPLOYEE E, SAL_GRADE S
WHERE E.SALARY BETWEEN S.MIN_SAL(+) AND S.MAX_SAL(+)
ORDER BY E.SALARY
;

/*
        5. SELF JOIN
        동일한 테이블을 조인하는 경우에 사용한다
        SELF JOIN은 동일한 테이블을 가지고 JOIN 하여 데이터를 조회하기 위해 사용되는 구문이다
*/
SELECT EMP_ID,
             EMP_NAME,
             MANAGER_ID
FROM EMPLOYEE
;
-- EMPLOYEE 테이블을 SELF JOIN 하여 
-- 사번, 직원명, 부서 코드, 사수 사번, 사수 이름 조회
-- ANSI
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명, 
             E.DEPT_CODE AS "부서 코드",
--             M.EMP_ID AS "사수 사번",
             E.EMP_ID AS "사수 사번",
             M.EMP_NAME AS "사수 이름"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID)
;

-- 오라클 
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명, 
             E.DEPT_CODE AS "부서 코드",
--             M.EMP_ID AS "사수 사번",
             E.EMP_ID AS "사수 사번",
             M.EMP_NAME AS "사수 이름"
FROM EMPLOYEE E , EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+)
ORDER BY E.MANAGER_ID
;

/*
        6. 다중 JOIN
        여러 개의 테이블을 조인
        다중 JOIN은 여러 개의 테이블을 JOIN 하여 데이터를 조회하기 위해 사용되는 구문이다.
*/

-- EMPLOYEE, DEPARTMENT, LOCAITION 테이블을 다중 JOIN 하여
-- 1. 사번(EMP_ID), 직원명(EMP_NAME), 부서명(DEPT_TITLE), 지역명(LOCAL_NAME), 국가명(NATIONAL_NAME), 조회

SELECT * FROM EMPLOYEE;  -- DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID        LOCATION_ID
SELECT * FROM LOCATION; --                        LOCAT_CODE

SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             D.DEPT_TITLE 부서명,
             L.LOCAL_NAME 지역명,
             N.NATIONAL_NAME 국가명
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
ORDER BY D.DEPT_ID DESC
;

-- 오라클
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             D.DEPT_TITLE 부서명,
             L.LOCAL_NAME 지역명
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+)
            AND D.LOCATION_ID = L.LOCAL_CODE(+)
ORDER BY D.DEPT_ID DESC
;

-- 2. 사번(EMP_ID), 직원명(EMP_NAME), 부서명(DEPT_TITLE), 지역명(LOCAL_NAME), 국가명(NATIONAL_NAME), 급여 등급(SAL_LEVEL) 조회
-- ANSI
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             DEPT_TITLE 부서명,
             L.LOCAL_NAME 지역명,
             N.NATIONAL_NAME 국가명,
             S.SAL_LEVEL "급여 등급"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL)
;

-- 오라클
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             DEPT_TITLE 부서명,
             L.LOCAL_NAME 지역명,
             N.NATIONAL_NAME 국가명,
             S.SAL_LEVEL "급여 등급"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID
AND D.LOCATION_ID = L.LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL
;