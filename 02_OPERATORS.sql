/*
        <연결 연산자>
        ||를 사용하여 여러 컬럼을 하나의 컬럼인 것처럼 연결하거나 컬럼과 리터럴을 연결할 수 있다.
         여러 컬럼 값들을 하나의 컬럼인 것처럼 연결하거나,
         컬럼과 리터럴을 연결할 수 있는 연산자이다.
*/
-- EMPLOYEE 테이블에서 사번, 직원명, 급여를 연결해서 조회

SELECT EMP_ID  || EMP_NAME || SALARY AS "사번 직원명 급여"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 급여를 리터럴과 연결해서 조회
SELECT EMP_NAME || '의 월급은' ||   SALARY || '원 입니다.' AS " 급여 정보"
FROM EMPLOYEE
ORDER BY SALARY ;

/*
        <논리 연산자>
        여러 개의 제한 조건 결과를 하나의 논리 결과로 만들어준다.
        && -> AND , || -> OR , ! -> NOT
*/

-- EMPLOYEE 테이블에서 부서 코드가 D6이면서 급여가 300만원 이상인
-- 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID 사번,
            EMP_NAME 직원명,
            DEPT_CODE "부서 코드",
            SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY >= 3000000;

-- EMPLOYEE 테이블에서 부서 코드가 D5이거나 급여가 500만원 이상인
-- 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID 사번,
            EMP_NAME 직원명,
            DEPT_CODE "부서 코드",
            SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >= 5000000
ORDER BY DEPT_CODE, SALARY DESC;

-- EMPLOYEE 테이블에서 부서 코드가 D6이 아니고 급여가 200만원 이상인
-- 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID 사번,
            EMP_NAME 직원명,
            DEPT_CODE "부서 코드",
            SALARY 급여
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D6' AND  SALARY >= 2000000
WHERE DEPT_CODE != 'D6' AND  NOT SALARY <= 2000000
ORDER BY DEPT_CODE, 1;

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원의
-- 사번, 직원명, 부서 코드, 급여조회
SELECT EMP_ID 사번,
            EMP_NAME AS "사원 명",
            DEPT_CODE AS "부서 코드",
            SALARY 급여
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000
ORDER BY DEPT_CODE,SALARY;

/*
        <비교 연산자>
        
        값 또는 표현식 사이의 관계를 비교하기 위해 사용하는 연산자이다.
        비교하는 값 또는 표현식은 동일한 데이터 타입이어야 하고 비교 결과는 논리 결과(TRUE/FALSE/NULL) 중 하나가 된다. 
*/

/*
        <BETWEEN AND>
        비교하려는 값이 지정한 범위에 포함되는지 확인하는 연산자이다.
*/

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원의
-- 사번, 직원명, 부서 코드, 급여조회
SELECT EMP_ID 사번,
            EMP_NAME AS "사원 명",
            DEPT_CODE AS "부서 코드",
            SALARY 급여
FROM EMPLOYEE
--WHERE SALARY >= 3500000 AND SALARY <= 6000000
WHERE SALARY BETWEEN 3500000 AND 6000000
ORDER BY DEPT_CODE,SALARY;

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하가 아닌
-- 직원의 사번, 직원명 부서 코드, 급여 조회
SELECT EMP_ID 사번,
            EMP_NAME AS "사원 명",
            DEPT_CODE AS "부서 코드",
            SALARY 급여
FROM EMPLOYEE
-- NOT 연산자는 컬럼명 앞 또는 BETWEEN 앞에 사용 가능
WHERE SALARY NOT BETWEEN 3500000 AND 6000000
ORDER BY DEPT_CODE,SALARY;

-- EMPLOYEE 테이블에서 입사일이 '90/01/01' ~ '01/01/01'인
-- 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'
ORDER BY HIRE_DATE;

-- EMPLOYEE 테이블에서 입사일이 '90/01/01' ~ '01/01/01'이 아닌
-- 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE NOT BETWEEN  '90/01/01' AND '01/01/01'
WHERE NOT HIRE_DATE BETWEEN  '90/01/01' AND '01/01/01'
ORDER BY HIRE_DATE, JOB_CODE;

/*
        <LIKE>
            [표현법]
                WHERE 컬럼 LIKE '패턴'
        - 비교하려는 컬럼의 값이 지정된 패턴을 만족할 경우 검색 대상이 된다.
        - 패턴에는 '%' '_'를 와일드 카드로 사용할 수 있다.
            '%' : 0글자 이상
                EX) 컬럼 LIKE '문자%' => 컬럼 값 중에 '문자'로 시작하는 모든 행을 조회 한다.
                      컬럼 LIKE '%문자' => 컬럼 값 중에 '문자'로 끝나는 모든 행을 조회 한다.
                      컬럼 LIKE '%문자%' => 컬럼 값 중에 '문자'가 포함되어 있는 모든 행을 조회 한다.
            '_' : 1글자
                EX) 컬럼 LIKE '_문자' => 컬럼 값 중에 '문자'앞에 무조건 한 글자가 오는 모든 행을 조회한다.
                    컬럼 LIKE '__문자' =>컬럼 값 중에 '문자'앞에 무조건 두 글자가 오는 모든 행을 조회한다.
                    
*/
-- EMPLOYEE 테이블에서 성이 전 씨인 사원의 직원명, 급여, 입사일 조회
SELECT EMP_NAME AS "직원명",
            SALARY AS "급여",
            HIRE_DATE AS "입사일"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%'
ORDER BY SALARY;

-- EMPLOYEE 테이블에서 김씨 성이 아닌 사원의 사번, 직원명, 입사일 조회
SELECT EMP_ID 사번,
            EMP_NAME 직원명,
            HIRE_DATE "입사일"
FROM EMPLOYEE
-- WHERE NOT EMP_NAME LIKE '김%'
WHERE EMP_NAME NOT LIKE '김%'
ORDER BY EMP_NAME;

-- EMPLOYEE 테이블에서 이름 중에서  '하'가 포함된 사원의 직원명, 주민 번호, 부서코드 조회

SELECT EMP_NAME 직원명,
            EMP_NO "주민 번호",
            DEPT_CODE AS "부서 코드"
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%'
ORDER BY EMP_NAME;
-- EMPLOYEE 테이블에서 전화번호 4번쨰 자리가 9로 시작하는 사원의
-- 사번, 직원명, 전화번호, 이메일 조회

SELECT EMP_ID 사번,
            EMP_NAME 직원명,
            PHONE AS "전화 번호",
            EMAIL AS "이메일"
FROM EMPLOYEE
WHERE PHONE LIKE '___9%'
ORDER BY EMP_NAME;

-- EMPLOYEE 테이블에서 이메일 중 _앞 글자가 3자리인
-- 이메일 주소를 가진 사원의 사번, 직원명, 이메일 조회

SELECT EMP_ID  AS 사번,
            EMP_NAME AS 직원명,
            EMAIL AS "이메일"
FROM EMPLOYEE 
WHERE EMAIL LIKE '___\_%' ESCAPE '\';

-- 와일드카드 문자를 특수문자로 사용해야 하는 경우 데이터로 
-- 처리할 와일드카드 문자 앞에 임의의 특수문자를 사용하고 ESCAPE로 등록하여 처리한다.


-- EMPLOYEE 테이블에서 이름이 '연'으로 끝나는 사원의 직원명,입사일 조회
SELECT EMP_NAME 직원명,
            HIRE_DATE 입사일
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 직원명, 전화번호 조회

SELECT EMP_NAME 직원명,
            PHONE AS "전화 번호"
FROM EMPLOYEE            
WHERE PHONE NOT LIKE '010%';

-- DEPARTMENT 테이블에서 해외영업부에 대한 모든 컬럼 조회
SELECT *
FROM DEPARTMENT
--WHERE LOCATION_ID BETWEEN 'L2' AND 'L4';
WHERE DEPT_TITLE LIKE '해외%';

/*
        <IS NULL>
        비교하려는 값의 NULL 여부를 확인하는 연산자이다.
        컬럼 값에 NULL이 있을 경우 NULL 값 비교에 사용된다.
*/

-- EMPLOYEE 테이블에서 보너스를 받지 않는 사원의 사번, 직원명, 급여, 보너스 조회
SELECT EMP_ID 사번,
            EMP_NAME 직원명,
            SALARY 급여,
            BONUS 보너스
FROM EMPLOYEE
WHERE BONUS IS NULL     -- NULL은 비교 연산자로 비교할 수 없다.
ORDER BY "급여";

-- EMPLOYEE 테이블에서 관리자가 없는 사원의 직원명, 부서 코드 조회
SELECT EMP_NAME 직원명,
            DEPT_CODE AS "부서 코드",
            MANAGER_ID "매니저 코드" 
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- EMPLOYEE 테이블에서 관리자도 없고, 부서도 배치 받지 않은 사원의
-- 직원명, 부서 코드 조회

SELECT EMP_NAME 직원명,
            DEPT_CODE AS "부서 코드",
            MANAGER_ID AS "매니저 ID"
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- EMPLOYEE 테이블에서 부서를 배치 받지 않았지만 보너스를 받는 사원의
-- 직원명, 부서 코드, 보너스 조회

SELECT EMP_NAME "직원명",
            DEPT_CODE AS "부서 코드",
            BONUS "보너스"
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

/*
        <IN>
        비교하려는 값과 일치하는 값이 목록에 있는지 확인하는 연산자이다.
*/

-- EMPLOYEE 테이블에서 부서 코드가 'D5' , 'D6' , 'D8'인 사원들의
-- 직원명, 부서 코드, 급여 조회
SELECT EMP_NAME 직원명,
            DEPT_CODE "부서 코드",
            SALARY 급여
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D6','D8')
--WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE = 'D8'
ORDER BY "부서 코드";

/*
        <연산자 우선수위>
    우선순위	연산자
                1	산술 연산자
                2	연결 연산자
                3	비교 연산자
                4	IS NULL, LIKE, IN
                5	BETWEEN AND
                6	NOT(논리 연산자)
                7	AND(논리 연산자)
                8	OR(논리 연산자)
*/

-- EMPLOYEE 테이블에서 직급 코드가 'J4' 또는 'J7' 사원들 중 급여가 200만원 이상인 사원들의
-- 직원명, 직급 코드, 급여 조회

SELECT EMP_NAME "직원명",
            JOB_CODE "직급 코드",
            SALARY AS 급여
FROM EMPLOYEE
--WHERE JOB_CODE IN ('J4' , 'J7') AND  SALARY >= 2000000
WHERE (JOB_CODE = 'J4' OR JOB_CODE = 'J7') AND SALARY >= 2000000
-- OR 보다 AND가 먼저 실행된다
ORDER BY JOB_CODE,SALARY;


