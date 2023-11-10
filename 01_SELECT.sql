/*
    <SELECT>
        [표현법]
            SELECT 컬럼[, 컬럼, ...] 
            FROM 테이블명;
            
            - 테이블에서 데이터를 조회할 떄 사용하는 SQL 구문이다.
            - SELECT를 통해서 조회된 결과를 RESULT SET이라고 한다.
            - 조회하고자 하는 컬럼들은 반드시 FROM 절에 기술한 테이블에
              존재하는 컬럼이어야 한다.
            - 모든 컬럼의 데이터를 조회할 경우에는 컬럼명 대신 * 를 사용한다.
              
*/

    -- EMPLOYEE 테이블에서 전체 사원의 사번, 이름, 급여만 조회    
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 쿼리는 대소문자를 가리지 않지만 관례상 대문자로 작성한다.
select emp_id, emp_name, salary
from employee;

-- EMPLOYEE 테이블에서 전체 사원의 모든 컬럼 정보 조회
SELECT * FROM EMPLOYEE;

---------------------    실습 문제    --------------------------------------------
-- 1. JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME
FROM JOB;

-- 2. JOB 테이블의 모든 컬럼 정보 조회
SELECT * FROM JOB;

-- 3. DEPARTMENT 테이블의 모든 컬럼 정보 조회
SELECT * FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 입사일 정보만 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

--------------------------------------------------------------------------------------

/*
        <컬럼의 산술 연산>
        SELECT 절에 컬럼명 입력 부분에서 산술 연산자를 사용하여
        결과를 조회할 수 있다.

*/
-- EMPLOYEE 테이블에서 직원명, 급여, 연봉(급여 * 12) 조회
SELECT EMP_NAME, SALARY,  SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 급여, 연봉(급여 * 12).
-- 보너스가 포함된 연봉 (급여 + (급여 * 보너스율) * 12) 조회
-- 산술 연산시 NULL 값이 존재할 경우 산술 연산의 결과는 무조건 NULL이다.
SELECT EMP_NAME, 
            SALARY,
            SALARY *12, 
            BONUS,
--            (SALARY + ( SALARY * BONUS)) * 12
            (SALARY + ( SALARY * NVL(BONUS, 0))) * 12
FROM EMPLOYEE;

-- NVL 는 NULL값을 있을떄 NULL 값을 조정해주는 함수
SELECT NVL(3000000, 0), NVL (NULL , 0) FROM DUAL;

-- SYSDATE는 현재 날짜를 출력한다.
SELECT SYSDATE FROM DUAL;

-- DATE 타입도 연산이 가능하다.
-- EMPLOYEE 테이블에서 직원명, 입사일, 근무일수(오늘 날짜 - 입사일)
SELECT EMP_NAME,
            HIRE_DATE,
            FLOOR(SYSDATE - HIRE_DATE)
FROM EMPLOYEE;

SELECT FLOOR(123.456) FROM DUAL;
-- CEIL은 숫자를 올림처리 하는 함수
-- ROUND는 숫자를 반올림 하는 함수
-- FLOOR는 숫자를 소수점을 버리는 함수
/*
        <컬럼 별칭>
            [표현식]
                컬럼 AS 별칭    / 컬럼  AS "별칭" / 컬럼 별칭 / 컬럼 "별칭"
*/
-- 별칭에 특수문자나 공백이 포함시 ""포함해야함 AS는 생략 가능
-- EMPLOYEE 테이블에서 직원명, 급여, 연봉, 보너스가 포함된 연봉 조회
SELECT EMP_NAME AS "직 원 명~", 
            SALARY AS 급여,
            SALARY *12 연봉,
            (SALARY + ( SALARY * NVL(BONUS, 0))) * 12 "총 소득"
FROM EMPLOYEE;

 /*
            <리터널>
            쿼리문에서 직접 데이터를 표기하는 방법을 리터럴이라 한다.
            리터럴은 정해진 표기법대로 작성해야 하는데 문자나 날짜 리터럴은 ' ' 기호를 사용한다.
            리터럴을 SELECT 절에 사용하면 테이블에 존재하는 데이터처럼 조회가 가능하다.
 */
-- EMPLOYEE 테이블에서 사번, 직원명, 급여, 단위(원) 조회
SELECT EMP_ID AS "사번",
            EMP_NAME AS "직원명",
            SALARY AS "급여",
            '원' AS "단위(\)"
FROM EMPLOYEE;

/*
            <DISTINCT>
            - 컬럼에 포함된 데이터 중 중복 값을 제외하고 한 번씩만 표시하고자 할 때 사용한다.
            - SELECT 절에 한 번만 기술할 수 있다.
            - 조회하는 컬럼이 여러 개이면 컬럼 값들이 모두 동일해야 중복으로 판단되어
            - 중복이 제거 된다.
*/
-- EMPLOYEE 테이블에서 직급 코드 조회
SELECT DISTINCT JOB_CODE AS "직급 코드"
FROM EMPLOYEE
ORDER BY JOB_CODE DESC;
-- ORDER BY 정렬할 코드 오르차순 정리
-- ORDER BY 정렬할 코드 DESC 내림차순 정리

-- EMPLOYEE 테이블에서 부서 코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 부서 코드 (중복 제거) 조회
SELECT DISTINCT NVL (DEPT_CODE , 'X') AS "부서 코드"
FROM EMPLOYEE
ORDER BY NVL (DEPT_CODE , 'X') DESC;

-- DISTINCT는 SELECT구절에 한 번만 기술할 수 있다.
-- SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
-- FROM EMPLOYEE;

SELECT DISTINCT JOB_CODE,DEPT_CODE
FROM EMPLOYEE
ORDER BY JOB_CODE;

/*
            <WHERE>
            - 테이블에서 데이터를 검색할 때 컬럼의 조건을 설정하여 조건을 만족하는 값을 가진 행을 
                조회할 수 있다.
                [ 표현법 ]
                    SELECT 컬럼 [, 컬럼, ...]
                    FROM 테이블명
                    WHERE 조건식;
                    
            <비교 연산자>
            >, >=, <, <= : 대소 비교
            =, !=, ^=, <> : 동등 비교
*/
-- EMPLOYEE 테이블에서 부서 코드가 D9와 일치하는 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 부서 코드가 D9와 일치하지 않는 사원들의 사번, 사원명, 부서 코드 조회
SELECT EMP_ID AS "사번",
            EMP_NAME AS "사원 명",
            DEPT_CODE AS "부서 코드"
FROM EMPLOYEE 
WHERE DEPT_CODE ^= 'D9' OR DEPT_CODE IS NULL
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 직급 코드가 J1과 일치하는 사원들의
-- 직원명, 부서 코드 조회
SELECT EMP_NAME AS "직원원",
            DEPT_CODE AS "부서 코드"
FROM EMPLOYEE
WHERE JOB_CODE = 'J1';

-- EMPLOYEE 테이블에서 급여가 400만원 이상인 사원들의 직원명, 부서 코드
-- 급여 조회
SELECT EMP_NAME AS "직원명",
            DEPT_CODE AS "부서 코드",
            SALARY AS 급여
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블에서 재직 중인 사원들의 사번, 직원명, 입사일 조회
SELECT EMP_ID 직원명,
            EMP_NAME "급여",
            HIRE_DATE AS "입사일"
FROM EMPLOYEE            
--WHERE ENT_YN = 'N'
WHERE ENT_DATE IS NULL
ORDER BY HIRE_DATE ;

-- EMPLOYEE 테이블에서 급여가 300만원 이상인 사원들의 직원명, 급여, 입사일 조회
SELECT EMP_NAME 직원명,
            SALARY AS 급여,
            HIRE_DATE AS "입사일"
FROM EMPLOYEE
WHERE SALARY >= 3000000
ORDER BY HIRE_DATE DESC;

-- EMPLOYEE 테이블에서 연봉이 5000만원 이상인 사원들의 직원명, 급여, 연봉, 입사일 조회
SELECT EMP_NAME AS 직원명,
            SALARY/1000 AS "급여",
            '천원' AS "\",
            ((SALARY * 12) / 10000) AS 연봉,
            '만원'  AS "단위",
            HIRE_DATE AS "입사일"
FROM EMPLOYEE
WHERE SALARY * 12 >= 50000000 
ORDER BY "연봉" ;
-- ORDER BY 구문은 SELECT 구문 다음으로 실해되므로 별칭으로 지칭 가능

/*
            <ORDER BY>
            SELECT 문으로 조회된 데이터를 정렬을 할 때 작성하는 구문이다.
            SELECT 구문의 가장 마지막에 작성하며 가장 마지막에 실행된다.
                [표현법]
                    SELECT 컬럼[, 컬럼, ...]
                    FROM 테이블명
                    WHERE 조건식
                    ORDER BY 컬럼명|별칭|컬럼순서    [ASC|DESC] [NULLS  FIRST | NULLS LAST];
                                                                        ASC 는 생략가능
                    
            <SELECT 구문이 실행(해석)되는 순서>
            1. FROM 절
            2. WHERE 절
            3. SELECT 절
            4. ORDER BY 절
*/

--  EMPLOYEE 테이블에서 BONUS로 오름차순 정렬
SELECT EMP_NAME,
            BONUS
FROM EMPLOYEE
-- ORDER BY BONUS;
-- ORDER BY BONUS ASC;
-- ORDER BY BONUS ASC NULLS FIRST;
ORDER BY BONUS NULLS FIRST;

-- EMPLOYEE 테이블에서 BONUS로 내림차순 정렬
-- 단, BONUS 값이 일치하는 경우에는 SALARY 가지고 오름차순 정렬
SELECT EMP_NAME AS 사원명,
            BONUS AS "보너스",
            SALARY "월급"
FROM EMPLOYEE
--ORDER BY BONUS DESC NULLS LAST;        -- 내림차순의 정렬은 기본적으로 NULLS FIRST
ORDER BY BONUS DESC NULLS LAST, SALARY;        -- 정렬 기준을 여러 개를 제시할 수 있다.

-- EMPLOYEE 테이블에서 연봉별 내림차순으로 정렬된 직원들의
-- 직원명, 연봉 조회

SELECT EMP_NAME "직원명",
            SALARY * 12 AS "연봉"
FROM EMPLOYEE
-- ORDER BY (SALARY*12) DESC;
-- ORDER BY 2 DESC; -- 컬럼 순번 사용
ORDER BY 연봉 DESC;









