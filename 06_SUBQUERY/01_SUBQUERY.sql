/*
        <SUBQUERY>
            하나의 SQL 문 안에 포합된 또 다른 SQL 문을 SUBQUERY라고 한다.
*/

-- SUBQUERY 예시
-- 1. 노옹철 사원과 같은 부서원들을 조회
-- 1) 노옹철 사원의 부서 코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'
;

--  2) 부서 코드가 노옹철 사원의 부서 코드와 동일한 사원들을 조회
SELECT EMP_NAME,
             DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'
;

--  3) SUBQUERY를 사용 하여 하나의 쿼리문으로 작성
SELECT EMP_NAME,
             DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철'
    )
;

-- 2. 전 직원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의
--      사번, 직원명, 직급 코드, 급여를 조회
--      1) 전 직원의 평균 급여 조회
SELECT AVG(SALARY)
FROM EMPLOYEE
;

--      2) 평균 급여보다 더 많은 급여를 받고 있는 직원들을 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047662.60869565217391304347826086956522
;

--      3) SUBQUERY를 사용하여 하나의 쿼리문으로 작성
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (
    SELECT AVG(SALARY)
    FROM EMPLOYEE
    )
;

/*
        <SUBQUERY 구분>
            SUBQUERY는 SUBQUERY를 수행한 결과값의 행과 열의 개수에 따라서
            분류할 수 있다.
        
            1. 단일행 SUBQUERY
                SUBQUERY의 조회 결과 값의 개수가 1개일 떄
*/
--  최저 급여를 받는 직원의 사번, 직원명, 직급 코드, 급여, 입사일 조회
--      1) 최저 급여 조회
SELECT MIN(SALARY)
FROM EMPLOYEE
;

--      2) 최저 급여를 받는 직원을 조회
SELECT EMP_ID,
             EMP_NAME,
             JOB_CODE,
             HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = 1380000
;

--  3) SUBQUERY를 사용 하여 하나의 쿼리문으로 작성
SELECT EMP_ID,
             EMP_NAME,
             JOB_CODE,
             HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (
    SELECT MIN(SALARY)
    FROM EMPLOYEE
    )
;

--  노옹철 사원의 급여보다 더 많이 받는 사원의
--  사번, 직원명, 부서명, 급여 조회
SELECT EMP_ID,
             EMP_NAME,
             DEPT_TITLE,
             SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (
    SELECT SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철'
    )
ORDER BY SALARY
;

-- 오라클 구문
SELECT EMP_ID,
             EMP_NAME,
             DEPT_TITLE,
             SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND  SALARY > (
    SELECT SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철'
    )
ORDER BY SALARY
;

--  전지연 사원이 속해있는 부서의 부서원들의 
--  사번, 직원명, 전화 번호, 직급명, 부서 명, 입사일 조회 (단, 전지연 사원 제외)
--  ANSI
SELECT E.EMP_ID,
             E.EMP_NAME,
             J.JOB_NAME,
             D.DEPT_TITLE,
             E.HIRE_DATE,
             E.DEPT_CODE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (J.JOB_CODE = E.JOB_CODE)
WHERE E.DEPT_CODE = (
    SELECT E.DEPT_CODE
    FROM EMPLOYEE E
    WHERE E.EMP_NAME = '전지연'
    )
    AND E.EMP_NAME ^= '전지연'
;    

--  오라클
SELECT E.EMP_ID,
             E.EMP_NAME,
             J.JOB_NAME,
             D.DEPT_TITLE,
             E.HIRE_DATE,
             E.DEPT_CODE
FROM EMPLOYEE E ,DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
    AND  J.JOB_CODE = E.JOB_CODE
    AND  E.DEPT_CODE = (
    SELECT E.DEPT_CODE
    FROM EMPLOYEE E
    WHERE E.EMP_NAME = '전지연'
    )
    AND E.EMP_NAME ^= '전지연'
;    

-- 부서별 급여의 합이 가장 큰 부서의 부서 코드 급여의 합 조회
--  1)
SELECT E.DEPT_CODE,
    SUM  (E.SALARY)
FROM EMPLOYEE E
GROUP BY E.DEPT_CODE
;

--  2)

SELECT MAX(SUM  (E.SALARY))
FROM EMPLOYEE E
GROUP BY E.DEPT_CODE
;

--  3) 부서별 급여의 합이 가장 큰 부서의 부서 코드, 급여의 합 조회
SELECT E.DEPT_CODE,
    SUM  (E.SALARY)
FROM EMPLOYEE E
GROUP BY E.DEPT_CODE
HAVING SUM(SALARY) = 17700000
;

-- SUBQUERY
SELECT E.DEPT_CODE,
    SUM  (E.SALARY)
FROM EMPLOYEE E
GROUP BY E.DEPT_CODE
HAVING SUM(SALARY) = (
    SELECT MAX(SUM  (E.SALARY))
        FROM EMPLOYEE E
        GROUP BY E.DEPT_CODE
    )
;

/*
    2. 다중행 서브쿼리
       서브 쿼리의 조회 결과 값의 개수가 여러 행 일 때
       
       ANY : 여러 개의 값들 중에서 조건을 한 개라도 만족하면 TRUE 리턴한다.
                SALARY > ANY ( ... ) : 최소값보다 크면 TRUE 리턴한다.
                SALARY < ANY ( ... ) : 최댓값보다 작으면 TRUE 리턴한다.
                
       ALL : 여러 개의 값들 중에서 조건을 모두 만족해야만 TRUE를 리턴한다.
                SALARY > ALL ( ... ) : 최대값보다 크면 TRUE 리턴한다.
                SALARY < ALL ( ... ) : 최소값보다 작으면 TRUE 리턴한다.
*/

-- 각 부서별 최고 급여를 받는 직원의 사원명, 직급 코드, 부서 코드, 급여 조회
--  1) 각 부서별 최고 급여 조회 (8000000, 3900000, 3760000, 2550000, 2890000, 3660000, 2490000)
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--  2) 위 급여를 받는 사원들을 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN (
    SELECT MAX(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
)
ORDER BY DEPT_CODE;

-- 전체 직원에 대해 사번, 이름, 부서 코드, 구분(사수/사원) 조회
-- 사수에 해당하는 사번을 조회 (200, 201, 204, 207, 211, 214, 100)
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 사번이 위와 같은 사원들의 사번, 이름, 부서 코드, 구분(사수)
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       DEPT_CODE AS "부서 코드",
       '사수' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID IN (
    SELECT DISTINCT MANAGER_ID
    FROM EMPLOYEE
    WHERE MANAGER_ID IS NOT NULL
);

-- 일반 사원에 해당하는 직원들의 사번, 이름, 부서 코드, 구분(사원)
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       DEPT_CODE AS "부서 코드",
       '사원' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID NOT IN (
    SELECT DISTINCT MANAGER_ID
    FROM EMPLOYEE
    WHERE MANAGER_ID IS NOT NULL
);

-- 위의 결과들을 하나의 결과로 확인하기 (UNION)
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       DEPT_CODE AS "부서 코드",
       '사수' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID IN (
    SELECT DISTINCT MANAGER_ID
    FROM EMPLOYEE
    WHERE MANAGER_ID IS NOT NULL
)

UNION

SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       DEPT_CODE AS "부서 코드",
       '사원' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID NOT IN (
    SELECT DISTINCT MANAGER_ID
    FROM EMPLOYEE
    WHERE MANAGER_ID IS NOT NULL
);

-- SELECT 절에 서브 쿼리 사용하는 방법
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       DEPT_CODE AS "부서 코드",
       CASE WHEN EMP_ID IN (
                SELECT DISTINCT MANAGER_ID
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL
            ) 
            THEN '사수'
            ELSE '사원'
       END AS "구분"
FROM EMPLOYEE;

-- 대리 직급임에도 과장 직급들의 최소 급여보다 많이 받는 직원의
-- 사번, 직원명, 직급 코드, 급여 조회

--  1) 과장 직급들의 최소 급여 조회 (2200000, 2500000, 3760000)
SELECT SALARY
FROM EMPLOYEE E
WHERE JOB_CODE = 'J5'
;

--  2) 직급이 대리인 직원들 중에서 위의 목록 값 중에 하나라도 큰 경우
SELECT EMP_ID,
            EMP_NAME,
            JOB_CODE,
            SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
    AND SALARY > ANY (2200000, 2500000, 3760000)
    -- SALARY >2200000 OR SALARY > 2500000 OR SALARY > 3760000
;

-- 위의 쿼리문을 합쳐서 하나의 쿼리문으로 작성
SELECT EMP_ID,
            EMP_NAME,
            JOB_CODE,
            SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
    AND SALARY > ANY (
        SELECT SALARY
        FROM EMPLOYEE E
        WHERE JOB_CODE = 'J5'
)
;


-- 과장(J5) 직급임에도 차장(J4) 직급의 최대 급여보다 더 많이 받는 사원들의
-- 사번, 직원명, 직급 코드, 급여 조회

-- 차장 직급들의 급여 조회 (2800000,1550000,2490000,2480000)
SELECT SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J4'
;

-- 과장 직급임에도 차장 직급들의 최대 급여보다 더 많이 받는 직원
SELECT EMP_ID,
            EMP_NAME,
            SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J5'
    AND SALARY > ALL (2800000, 1550000, 2490000, 2480000    
    -- SALARY > 280만 AND SALARY > 155만 AND SALARY > 249만 AND SALARY > 248만 AND 
    )
;

--  위의 쿼리문을 합쳐서 하나의 쿼리문으로 작성
SELECT EMP_ID,
            EMP_NAME,
            SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J5'
    AND SALARY > ALL (
        SELECT SALARY
        FROM EMPLOYEE
        WHERE JOB_CODE = 'J4'
    )
;
-- 단일 행 쿼리문으로 변환

SELECT EMP_ID,
            EMP_NAME,
            SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J5'
    AND SALARY > ALL (
        SELECT MAX(SALARY)
        FROM EMPLOYEE
        WHERE JOB_CODE = 'J4'
    )
;

/*
        3. 다중열 서브 쿼리
            서브  쿼리의 조회 결과 값은 한 행이지만 컬럼의 수가 여러 개일 떄
*/
-- 하이유 사원과 같은 부서 코드, 같은 직급 코드에 해당하는 사원들을 조회
-- 하이유 사원의 부서 코드와 직급 코드 조회 (D5,J5)
SELECT DEPT_CODE,
            JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유'
;

-- 부서 코드가 D5 이면서 직급 코드가 J5인 사원들을 조회
SELECT EMP_NAME,
            DEPT_CODE,
            JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
    AND JOB_CODE = 'J5'
;
-- 다중열 서브 쿼리를 사용해서 작성하는 방법
SELECT EMP_NAME,
            DEPT_CODE,
            JOB_CODE
FROM EMPLOYEE
--WHERE (DEPT_CODE, JOB_CODE) = (('D5','J5'))
WHERE (DEPT_CODE, JOB_CODE) IN (('D5','J5'))
;

SELECT EMP_NAME,
            DEPT_CODE,
            JOB_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (('D5','J5'), ('D3','J3'))
;

SELECT EMP_NAME,
            DEPT_CODE,
            JOB_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (
    SELECT DEPT_CODE,
                JOB_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '하이유'
    )
;


-- 박나라 사원과 직급 코드가 일치하면서 같은 사수를 가지고 있는 사원의
-- 사번, 직원명, 직급 코드, 사수 사번조회
-- 박나라 사원의 직급 코드, 사수 사번을 조회
SELECT JOB_CODE,
            MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '박나라'
;

-- 박나라 사원과 직급 코드가 일치하면서 같은 사수를 가지고 있는 사원 조회
SELECT EMP_ID,
            EMP_NAME,
            JOB_CODE,
            MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE , MANAGER_ID) IN (
    SELECT JOB_CODE,
                MANAGER_ID
    FROM EMPLOYEE
    WHERE EMP_NAME = '박나라'
    )
    AND EMP_NAME != '박나라'
;

/*
        4.  다중행 다중열 서브 쿼리
            서브 쿼리의 조회 결과값이 여러 행, 여러 열일 경우
*/
--  각 직급별로 최소 급여를 받는 사원들의 사번, 직원명, 직급 코드, 급여 조회
--  각 직급별 최소 급여 조회 (('JI','8000000'),('J2','3700000'),('J4','1550000'),...)
SELECT JOB_CODE,
            MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
;

-- 각 직급별로 최소 급여를 받는 사원 조회
SELECT EMP_ID,
            EMP_NAME,
            JOB_CODE,
            SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (('JI','8000000'), ('J2','3700000'), ('J4','1550000'))
;

-- 다중행 다중열 서브 쿼리를 사용해서 조회
SELECT EMP_ID,
            EMP_NAME,
            JOB_CODE,
            SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (
    SELECT JOB_CODE,
                MIN(SALARY)
    FROM EMPLOYEE
    GROUP BY JOB_CODE
    )
;

-- 각 부서별 최소 급여를 받는 사원들의 사번, 사원명, 부서 코드, 급여 조회
-- 각 부서별 최소 급여 조회
SELECT NVL(DEPT_CODE, '부서 없음'),
            MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE
;
-- 각 부서별 최소 급여를 받는 사원 조회
SELECT EMP_ID,
            EMP_NAME,
            DEPT_CODE, 
            SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (('D1','1380000'),('D2','1550000'))
;

-- 다중행 다중열 서브 쿼리를 사용해서 조회
SELECT EMP_ID,
            EMP_NAME,
            NVL(DEPT_CODE,'부서 없음'),
            SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'부서 없음'), SALARY) IN (
    SELECT NVL(DEPT_CODE, '부서 없음'),
                MIN(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    )
ORDER BY DEPT_CODE
;


/*
        <인라인 뷰>
            FROM 절에 서브 쿼리를 제시하고, 서브 쿼리를 수행한 결과를 테이블
            대신에 사용한다.
*/
-- 전 직원 중 급여가 가장 높은 상위 5명 순위, 이름, 급여 조회
-- ROWNUM : 오라클에서 제공하는 컬럼, 조회된 순서대로 1부터 순번을 부여하는 컬럼
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC
;
-- 이미 순번이 정해진 다음에 정렬이 되었다.
-- FROM -> SELECT(순번이 정해진다.) -> ORDER BY
SELECT ROWNUM, E.EMP_NAME, E.SALARY
-- SELECT ROWNUM, E.*
FROM (
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC
) E
WHERE ROWNUM <= 5
;

-- 부서별 평균 급여가 높은 3개의 부서의 부서 코드, 평균 급여 조회
SELECT NVL(DEPT_CODE,'부서 없음'),
            FLOOR(AVG(NVL(SALARY, 0))) "평균 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY "평균 급여" DESC
;



-- SELECT NVL(DEPT_CODE,'부서 없음'),
--                FLOOR(AVG(NVL(SALARY, 0))) "평균 급여"    
-- 실행시 출력이 안되는 이유는 FROM절에 쿼리문은 함수로 취급하기 떄문에 내부 데이터를 이용할수 없다
-- 사용을 원할시 별칭을 지칭하여 사용

-- 인라인 뷰를 사용하는 방법
SELECT ROWNUM, "부서 코드", "평균 급여"
FROM(
    SELECT NVL(DEPT_CODE,'부서 없음') AS "부서 코드",
                FLOOR(AVG(NVL(SALARY, 0))) "평균 급여"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY "평균 급여" DESC
    )
WHERE ROWNUM <= 3
;

-- WITH를 사용하는 방법
WITH TOPN_SAL AS (
    SELECT NVL(DEPT_CODE,'부서 없음') AS "부서 코드",
                FLOOR(AVG(NVL(SALARY, 0))) "평균 급여"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY "평균 급여" DESC
)
SELECT ROWNUM AS "순위", "부서 코드", "평균 급여"
FROM TOPN_SAL
WHERE ROWNUM <= 3
;

/*
        <RANK 함수>
            RANK() OVER(정렬 기준)  /   DENSE_RANK() OVER(정렬 기준)
*/

-- 사원별 급여가 높은 순서대로 순위 매겨서 순위, 직원명, 급여 조회

-- 공동 19위 2명 귀에 순위는 21위라고 표시
SELECT RANK() OVER (ORDER BY SALARY DESC) 순위,
            EMP_NAME 사원명,
            SALARY 급여
FROM EMPLOYEE
;

-- 공동 19위 2명 귀에 순위는 20위라고 표시
SELECT DENSE_RANK() OVER (ORDER BY SALARY DESC) 순위,
            EMP_NAME 사원명,
            SALARY 급여
FROM EMPLOYEE
;

-- 상위 5명만 조회
SELECT RANK() OVER (ORDER BY SALARY DESC) 순위,
            EMP_NAME 사원명,
            SALARY 급여
FROM EMPLOYEE
-- RANK 함수는 WHERE절에 사용할 수 없다
WHERE RANK() OVER (ORDER BY SALARY DESC) <= 5
;

SELECT "순위", "사원명", 급여
FROM (
    SELECT DENSE_RANK() OVER (ORDER BY SALARY DESC) 순위,
                EMP_NAME 사원명,
                SALARY 급여
    FROM EMPLOYEE
    )
WHERE "순위" <= 5
;

