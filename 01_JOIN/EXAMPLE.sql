------------------------------- 조인 종합 실습 문제 ----------------------------
-- 1. 직급이 대리이면서 ASIA 지역에서 근무하는 직원들의 사번, 직원명, 직급명, 부서명, 근무지역, 급여를 조회하세요.
-- ANSI 구문
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             J.JOB_NAME 직급명,
             D.DEPT_TITLE 부서명,
             L.LOCAL_NAME "근무 지역",
             TO_CHAR(E.SALARY, 'FML999,999,999') 급여
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE J.JOB_NAME = '대리'
    AND  L.LOCAL_NAME LIKE 'ASIA%'
ORDER BY E.EMP_ID
;
-- 오라클 구문
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             J.JOB_NAME 직급명,
             D.DEPT_TITLE 부서명,
             L.LOCAL_NAME "근무 지역",
             TO_CHAR(E.SALARY, 'FML999,999,999') 급여
FROM EMPLOYEE E,DEPARTMENT D,JOB J, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
    AND E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND J.JOB_NAME = '대리'
    AND  L.LOCAL_NAME LIKE 'ASIA%'
ORDER BY E.EMP_ID
;
-- 2. 70년대생 이면서 여자이고, 성이 전 씨인 직원들의 직원명, 주민번호, 부서명, 직급명을 조회하세요.
-- ANSI 구문
SELECT E.EMP_NAME 직원명,
             E.EMP_NO "주민 번호",
             D.DEPT_TITLE "부서 명",
             J.JOB_NAME "직급명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE SUBSTR(EMP_NO, 1,1) = '7'
    AND  SUBSTR(EMP_NO, 8,1) IN ('2', '4')
    AND  SUBSTR(EMP_NAME,1,1) = '전'
;

-- 오라클 구문
SELECT E.EMP_NAME 직원명,
             E.EMP_NO "주민 번호",
             D.DEPT_TITLE "부서 명",
             J.JOB_NAME "직급명"
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
    AND  E.JOB_CODE = J.JOB_CODE
    AND  SUBSTR(EMP_NO, 1,1) = '7'
    AND  SUBSTR(EMP_NO, 8,1) IN ('2', '4')
    AND  SUBSTR(EMP_NAME,1,1) = '전'
;
-- 3. 보너스를 받는 직원들의 직원명, 보너스, 연봉, 부서명, 근무지역을 조회하세요.
--    단, 부서 코드가 없는 사원도 출력될 수 있게 OUTER JOIN 사용
-- ANSI 구문
SELECT E.EMP_NAME 직원명,
             E.BONUS 보너스,
             TO_CHAR(E.SALARY * 12, 'FML999,999,999') 연봉,
             D.DEPT_TITLE "부서 명",
             L.LOCAL_NAME "근무지역"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE E.BONUS IS NOT NULL
ORDER BY 보너스
;
-- 오라클 구문
SELECT E.EMP_NAME 직원명,
             E.BONUS 보너스,
             TO_CHAR(E.SALARY * 12, 'FML999,999,999') 연봉,
             D.DEPT_TITLE "부서 명",
             L.LOCAL_NAME "근무지역"             
FROM EMPLOYEE E, DEPARTMENT D,LOCATION L
WHERE BONUS IS NOT NULL
    AND E.DEPT_CODE = D.DEPT_ID(+)
    AND D.LOCATION_ID = L.LOCAL_CODE(+)
ORDER BY 보너스
;
-- 4. 한국과 일본에서 근무하는 직원들의 직원명, 부서명, 근무지역, 근무 국가를 조회하세요.
-- ANSI 구문

SELECT E.EMP_NAME 직원명,
             D.DEPT_TITLE "부서 명",
             L.LOCAL_NAME "근무 지역",
             N.NATIONAL_NAME "근무 국가"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME IN ('한국' ,'일본')
;

-- 오라클 구문
SELECT E.EMP_NAME 직원명,
             D.DEPT_TITLE "부서 명",
             L.LOCAL_NAME "근무 지역",
             N.NATIONAL_NAME "근무 국가"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND N.NATIONAL_NAME IN ('한국' ,'일본')
;
-- 5. 각 부서별 평균 급여를 조회하여 부서명, 평균 급여(정수 처리)를 조회하세요.
--    단, 부서 배치가 안된 사원들의 평균도 같이 나오게끔 해주세요^^
-- ANSI 구문
SELECT NVL(D.DEPT_TITLE,'부서 없음') AS "부서명",
            TO_CHAR(AVG(E.SALARY),'FML999,999,999') AS "평균 급여"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE
;

-- 오라클 구문
SELECT NVL(D.DEPT_TITLE,'부서 없음') AS "부서명",
            TO_CHAR(AVG(E.SALARY),'FML999,999,999') AS "평균 급여"
FROM EMPLOYEE E ,DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY D.DEPT_TITLE
;
-- 6. 각 부서별 총 급여의 합이 1000만원 이상인 부서명, 급여의 합을 조회하시오.
-- ANSI 구문

SELECT NVL(D.DEPT_TITLE,'부서 없음') AS "부서명",
            TO_CHAR(SUM(E.SALARY),'FML999,999,999') AS "급여의 합"
FROM DEPARTMENT D 
JOIN EMPLOYEE E ON (D.DEPT_ID = E.DEPT_CODE)
GROUP BY D.DEPT_TITLE
HAVING SUM(E.SALARY) >= 10000000
;

-- 오라클 구문
SELECT NVL(D.DEPT_TITLE,'부서 없음') AS "부서명",
            TO_CHAR(SUM(E.SALARY),'FML999,999,999') AS "급여의 합"
FROM DEPARTMENT D, EMPLOYEE E
WHERE D.DEPT_ID = E.DEPT_CODE
GROUP BY D.DEPT_TITLE
HAVING SUM(E.SALARY) >= 10000000
;
-- 7. 사번, 직원명, 직급명, 급여 등급, 구분을 조회
--    이때 구분에 해당하는 값은 아래와 같이 조회 되도록 하시오.
--    급여 등급이 S1, S2인 경우 '고급'
--    급여 등급이 S3, S4인 경우 '중급'
--    급여 등급이 S5, S6인 경우 '초급'
-- ANSI 구문
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             J.JOB_NAME 직급명,
             SG.SAL_LEVEL,
             DECODE(SG.SAL_LEVEL,'S1','고급','S2','고급','S3','중급','S4','중급','S5','초급','S6','초급') AS "급여 등급"
             /*
             S.SAL_LEVEL,
             CASE 
                 WHEN SG.SAL_LEVEL IN ('S1', 'S2') THEN '고급'
                 WHEN SG.SAL_LEVEL IN ('S3', 'S4') THEN '중급'
                 WHEN SG.SAL_LEVEL IN ('S5', 'S6') THEN '초급'
             END AS "구분"
             */
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN SAL_GRADE SG ON (E.SALARY BETWEEN SG.MIN_SAL AND SG.MAX_SAL)
ORDER BY "급여 등급","사번"
;
-- 오라클 구문
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             J.JOB_NAME 직급명,
             DECODE(SG.SAL_LEVEL,'S1','고급','S2','고급','S3','중급','S4','중급','S5','초급','S6','초급') AS "급여 등급"
FROM EMPLOYEE E, JOB J, SAL_GRADE SG
WHERE E.JOB_CODE = J.JOB_CODE
    AND  E.SALARY >= SG.MIN_SAL  AND E.SALARY <=SG.MAX_SAL
ORDER BY "급여 등급","사번"
;
-- 8. 보너스를 받지 않는 직원들 중 직급 코드가 J4 또는 J7인 직원들의 직원명, 직급명, 급여를 조회하시오.
-- ANSI 구문
SELECT E.EMP_NAME 직원명,
             J.JOB_NAME 직급명,
             E.SALARY 급여
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE BONUS IS NULL
            AND E.JOB_CODE IN ('J4','J7')
ORDER BY J.JOB_CODE
;
-- 오라클 구문
SELECT E.EMP_NAME 직원명,
             J.JOB_NAME 직급명,
             E.SALARY 급여
FROM EMPLOYEE E, JOB J
WHERE BONUS IS NULL
    AND  E.JOB_CODE = J.JOB_CODE
    AND  E.JOB_CODE IN ('J4','J7')
ORDER BY J.JOB_CODE
;

-- 9. 부서가 있는 직원들의 직원명, 직급명, 부서명, 근무 지역을 조회하시오.
-- ANSI 구문
SELECT E.EMP_NAME 직원명,
             J.JOB_NAME 직급명,
             D.DEPT_TITLE 부서명,
             L.LOCAL_NAME AS "근무 지역"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE D.DEPT_ID IS NOT NULL
ORDER BY "부서명"
;
-- 오라클 구문
SELECT E.EMP_NAME 직원명,
             J.JOB_NAME 직급명,
             D.DEPT_TITLE 부서명,
             L.LOCAL_NAME AS "근무 지역"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
WHERE D.DEPT_ID IS NOT NULL
    AND  E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND D.LOCATION_ID = L.LOCAL_CODE
ORDER BY "부서명"
;
-- 10. 해외영업팀에 근무하는 직원들의 직원명, 직급명, 부서 코드, 부서명을 조회하시오.
-- ANSI 구문
SELECT E.EMP_NAME 직원명,
             J.JOB_NAME 직급명,
             D.DEPT_ID "부서 코드",
             D.DEPT_TITLE 부서명
FROM DEPARTMENT D 
JOIN EMPLOYEE E ON (D.DEPT_ID = E.DEPT_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE SUBSTR(D.DEPT_TITLE,1,4) = '해외영업'
--WHERE D.DEPT_TITLE LIKE '해외영업%'
ORDER BY "부서명"
;
-- 오라클 구문
SELECT E.EMP_NAME 직원명,
             J.JOB_NAME 직급명,
             D.DEPT_ID "부서 코드",
             D.DEPT_TITLE 부서명
FROM DEPARTMENT D,EMPLOYEE E, JOB J
WHERE D.DEPT_ID = E.DEPT_CODE
    AND  E.JOB_CODE = J.JOB_CODE
    AND  SUBSTR(D.DEPT_TITLE,1,4) = '해외영업'
ORDER BY "부서명"
;
-- 11. 이름에 '형'자가 들어있는 직원들의 사번, 직원명, 직급명을 조회하시오.
-- ANSI 구문
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             J.JOB_NAME 직급명
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE INSTR(E.EMP_NAME,'형') != 0
--WHERE E.EMP_NAME LIKE '%형%'
ORDER BY "사번"
;
-- 오라클 구문
SELECT E.EMP_ID 사번,
             E.EMP_NAME 직원명,
             J.JOB_NAME 직급명
FROM EMPLOYEE E, JOB J
WHERE INSTR(E.EMP_NAME,'형') != 0
--      E.EMP_NAME LIKE '%형%'
    AND  E.JOB_CODE = J.JOB_CODE
ORDER BY "사번"
;