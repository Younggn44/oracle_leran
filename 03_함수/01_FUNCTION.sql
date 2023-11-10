/*
        <함수>
           단일행 함수
                - N 개의 값을 읽어서 N개의 값을 반환 한다.
                - 매 행 함수 실행 결과를 반환한다.
            그룹 함수
                - N 개의 값을 읽어서 1 개의 값을 반환 한다.
                - 하나의 그룹별로 함수 실행 결과를 반환한다.
                
        <단일행 함수>
        <문자 처리 함수>
            1) LENGTH / LENGTHB
                LENGTH (CHARACTHER) : 글자 수 반환
                LENGTHB (CHARACTHER) : 글자의 바이트 수 반환
                
                영문자, 숫자,  특수문자 한 글자 -> 1BYTE
                한글 한 글자 -> 3BYTE
*/

SELECT LENGTH ('오라클'), LENGTHB('오라클') FROM DUAL;
SELECT LENGTH ('ORACLE'), LENGTHB('ORACLE') FROM DUAL;
SELECT LENGTH ('ORA클'), LENGTHB('ORA클') FROM DUAL;
SELECT LENGTH ('오 라 클'), LENGTHB('오 라 클') FROM DUAL;



SELECT EMP_NAME,
            LENGTH(EMP_NAME) AS "이름 바이트수",
            EMAIL,
            LENGTH(EMAIL) AS "이메일 바이트수",
            LENGTHB(EMAIL) AS "이메일 바이트수B"
FROM EMPLOYEE;

/*
        2) INSTR
            INSTR (CHARACTER, CHARACTER[ ,POSITION, OCCURRENCE ])
            
*/ 
-- 오라클에서 인덱스 시작점은 0이 아닌 1부터 시작이다.
SELECT INSTR('AABAACAABBAA' , 'B')      
FROM DUAL;
-- 3번쨰 자리 B

SELECT INSTR('AABAACAABBAA' , 'D')      
FROM DUAL;      
-- 0

SELECT INSTR('AABAACAABBAA' , 'B' , 1)      
FROM DUAL;      
-- 3번쨰 자리 B

SELECT INSTR('AABAACAABBAA' , 'B' , 4)
FROM DUAL;      
-- 9번쨰 자리 B

-- -를 줄경우 뒤에서 부터 확인
SELECT INSTR('AABAACAABBAA' , 'B' , -1)
FROM DUAL;      
-- 10번쨰 자리 B

SELECT INSTR('AABAACAABBAA' , 'B' , -5)
FROM DUAL;      
-- 3번쨰 자리 B

SELECT INSTR('AABAACAABBAA' , 'B' , 1 , 2)
FROM DUAL;      
-- ODCUURRENCE
-- 첫번쨰 B를 넘기고 두번째로 보이는 B를 보여줌

SELECT INSTR('AABAACAABBAA' , 'B' , 1 , 4)
FROM DUAL;
-- 0


SELECT INSTR('AABAACAABBAA' , 'B' , -1 , 3)
FROM DUAL;      
-- 3번쨰 자리 B

SELECT EMAIL AS 이메일,
            INSTR (EMAIL, '@') AS "@ 위치",
            INSTR(EMAIL, 's' , 1 ,2 ) AS "두 번쨰 s 위치"
FROM EMPLOYEE;

/*
        3) LPAD / RPAD
            LPAD/RPAD (CHARACTER, NUMBER[, CHARACTER] )
*/

SELECT LPAD('HELLO', 10)
FROM DUAL;
-- 10만큼의 길이중 HELLO 값은 오른쪽으로 정렬하고 공백을 왼쪽에 채운다
SELECT LPAD('HELLO', 10 , '*')
FROM DUAL;
-- 10만큼의 길이중 HELLO 값은 오른쪽으로 정렬하고 공백에 '*'을 채운다

SELECT RPAD('HELLO', 10)
FROM DUAL;
-- 10만큼의 길이중 HELLO 값은 왼쪽으로 정렬하고 공백을 왼쪽에 채운다

SELECT RPAD('HELLO', 10 , '#')
FROM DUAL;
-- 10만큼의 길이중 HELLO 값은 오른쪽으로 정렬하고 공백에 '#'을 채운다

-- 991231 - 1******를 출력
SELECT RPAD ('991231 - 1', 16 ,'*')
FROM DUAL;

SELECT EMP_NAME,
            RPAD (LPAD (EMP_NAME,3),5,'*'),
            EMP_NO 주민번호,
            RPAD (LPAD (EMP_NO , 8) ,14, '*')
FROM EMPLOYEE;

/*
      4) LTRIM / RTRIM
         LTRIM/RTRIM(CHARACTER[, CHARACTER])
*/
SELECT LTRIM('    KH') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123456', '123') FROM DUAL;
SELECT LTRIM('123123456123', '123') FROM DUAL;
SELECT LTRIM('123123456', '321') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL;
SELECT RTRIM('KH   ', ' ') FROM DUAL;
SELECT RTRIM('0012340056000', '0') FROM DUAL;

-- 양쪽 공백 제거
SELECT LTRIM(RTRIM('   KH   ')) FROM DUAL;

-- 양쪽 문자 제거
SELECT LTRIM(RTRIM('000123456000', '0'), '0') FROM DUAL;

/*
      5) TRIM
         TRIM([[LEADING|TRAILING|BOTH] CHARACTER FROM] CHARACTER)
*/
-- 양쪽에 있는 공백을 제거한다.
SELECT TRIM('   KH   ') FROM DUAL;
SELECT TRIM(' ' FROM '   KH   ') FROM DUAL;
SELECT TRIM(BOTH ' ' FROM '   KH   ') FROM DUAL;
-- 앞쪽에 있는 공백을 제거한다.
SELECT TRIM(LEADING ' ' FROM '   KH   ') FROM DUAL;
-- 뒤쪽에 있는 공백을 제거한다.
SELECT TRIM(TRAILING ' ' FROM '   KH   ') FROM DUAL;
-- 양쪽에 있는 문자를 제거한다.

SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM('ZZ' FROM 'ZZZKHZZZ') FROM DUAL; -- 에러 발생 하나의 글자만 사용하기떄문에
-- 앞쪽에 있는 문자를 제거한다.
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;
-- 뒤쪽에 있는 문자를 제거한다.
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;

/*
        6) SUBSTR
            SUBSTR(CHARACTER, POSITION[, LENGTH])
*/
SELECT SUBSTR('SHOWMETHEMONEY', 7)
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 7 ,3)
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', 1, 6)
FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY', -8, 3)
FROM DUAL;

SELECT SUBSTR('SHOW ME THE MONEY', 1, 6)
FROM DUAL;
-- 빈칸도 문자로 취급한다

-- EMPLOYEE 테이블에서 주민번호에 성별을 나타내는 부분만 잘라서 조회
SELECT EMP_NAME 직원명,
            SUBSTR(EMP_NO,8,1) AS "성별 코드"
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = 1 OR SUBSTR(EMP_NO,8,1) = 3;
WHERE SUBSTR(EMP_NO,8,1) IN (2 ,4);

-- EMPLOYEE 테이블에서 주민번호 첫 번쨰 자리부터 성별코드 까지 추출한
-- 결과값에 오른쪽에 * 문자를 채워서 14글자로 조회
-- EX) 991212-1******
SELECT EMP_NAME 직원명,
            SUBSTR(EMP_NO,1,8) AS "성별 코드",
--            RPAD(RPAD(EMP_NO,8),14,'*')
               RPAD(SUBSTR (EMP_NO, 1, 8), 14, '*') AS "주민번호"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 직원명, 이메일, 아이디(이메일에서 '@' 앞에 문자 값만 출력) 조회
SELECT EMP_NAME 직원명,
            EMAIL AS 이메일,
            RTRIM(EMAIL , '@kh.or.kr') AS 아이디
--            SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1) AS 아이디
FROM EMPLOYEE;


SELECT INSTR( 'sun_di@kh.or.kr', '@') FROM DUAL;

SELECT SUBSTR ('sun_di@kh.or.kr',  INSTR( 'sun_di@kh.or.kr', '@')-1) 
FROM DUAL;

SELECT LPAD ('sun_di@kh.or.kr',  INSTR( 'sun_di@kh.or.kr', '@')-1) 
FROM DUAL;

/*
        7) LOWER / UPPER / INITCAP
            LOWER / UPPER / INITCAP(CHARACTER)
*/
SELECT 'show me the money' 
FROM DUAL;
SELECT UPPER ('show me the money') 
FROM DUAL; -- 대문자로 변경
SELECT LOWER ('SHOW ME THE MONEY' )
FROM DUAL; -- 소문자로 변경
SELECT INITCAP('show me the money')
FROM DUAL; -- 단어 앞 글자 대문자로 변경

/*
        8) CONCAT
            CONCAT(CHARACTER, CHARACTER)
            두 문자열을 하나로 합쳐줌
*/

SELECT CONCAT('가나다라' , '마바사아')
FROM DUAL;
-- CONCAT 함수는 두 개의 문자 데이터만 전달받을 수 있다.
SELECT '가나다라' || '마바사아' || '자차카타'
FROM DUAL;

SELECT CONCAT(CONCAT('가나다라' , '마바사아'), '자차카타')
FROM DUAL;

-- SELECT EMP_NAME || '님의 급여는' || SALARY || '입니다.'
SELECT CONCAT(CONCAT(EMP_NAME, '님의 급여는'),CONCAT(SALARY,'입니다.'))
FROM EMPLOYEE;

/*
        9) REPLACE
            REPLACE(CHARACTER, CHARACTER, CHARACTER)
*/

-- EMPLOYEE 테이블에서 이메일의 kh.or.kr을 gmail.com 변경해서 조회
-- sun_di@kh.or.kr -> sim_di@gmail.com
SELECT EMP_NAME 직원명,
            EMAIL AS "변경전 이메일",
            REPLACE(EMAIL,'kh.or.kr','gmail.com') AS "변경후 이메일"
FROM EMPLOYEE;

SELECT EMAIL,
            REPLACE(EMAIL,'kh.or.kr','gmail.com'),
            REPLACE(EMAIL,'kh.or.kr',' ')
FROM EMPLOYEE;


-------------------------------------------------------------------------------------------------------------
/*
        <숫자 처리 함수>
            1)  ABS
                ABS (NUMBER)
                절대값을 구하는 함수
*/
SELECT  ABS(10) ,
             ABS (-10),
             ABS (-50)
FROM DUAL;

SELECT  ABS(10.9) ,
             ABS (-10.9),
             ABS (-50.5)
FROM DUAL;

/*
        2) MOD
            MOD (NUMBER, NUMBER)
            연산해주는 함수
*/

SELECT  10 + 3,
             10 - 3,
             10 * 7,
             10 / 3,
--             10 % 4
             MOD (10, 3)
             -- 오라클에서는 %연산자를 지원 안함으로 대신 모듈함수를 사용함
FROM DUAL;

SELECT MOD (-10 , 3) FROM DUAL;
SELECT MOD (10 , -3) FROM DUAL;
SELECT MOD (10.9 , 3) FROM DUAL;
SELECT MOD (-10.9,3) FROM DUAL;

/*
        3)  ROUND
             ROUND (NUMBER [ , POSITION] )
             반올림 해주는 함수
*/

SELECT ROUND(123.456)
FROM DUAL;

SELECT ROUND(123.556)
FROM DUAL;

SELECT ROUND(123.456, 1)
FROM DUAL;
-- ROUND(NUBER, [, POSITION])
-- 에서 POSITION은 반올림할 자리수를 뜻함

SELECT ROUND(123.456, -1)
FROM DUAL;

SELECT ROUND(125.456, -1)
FROM DUAL;


SELECT ROUND(123.456, 2)
FROM DUAL;

SELECT ROUND(123.456, -2)
FROM DUAL;

/*
        4) CEIL
            CEIL (NUMBER)
            올림 하는 함수
*/

SELECT CEIL (123.456)
FROM DUAL;

SELECT CEIL (123.756)
FROM DUAL;
--SELECT CEIL (123.456 , 2) FROM DUAL;   -- 에러 발생


/*
        5) FLOOR
            FLOOR (NUMBER)            
            내림 하는 함수
*/

SELECT FLOOR (123.456)
FROM DUAL;

SELECT FLOOR (456.789)
FROM DUAL;

--SELECT CEIL (423.456 , 1) FROM DUAL; -- 에러 발생

/*
        6) TRUNC
            TRUNC (NUMBER[ , POSITION ] )
            지정한 위치에서 버림하여 값을 반환함
*/
SELECT TRUNC (123.456)
FROM DUAL;

SELECT TRUNC (456.789)
FROM DUAL;

SELECT TRUNC (123.456 , 1)
FROM DUAL;

SELECT TRUNC (456.789 , 1)
FROM DUAL;

SELECT TRUNC (456.789 , - 1)
FROM DUAL;

/*
        <날짜 처리 함수>
            1) SYSDATE
            시스템의 저장되어 있는 시간을 가져옴
            
            기본 세팅은 YY/MM/DD
            ALTER SESSION SET NLS_DATE_FORMAT = 'YY/MM/DD';
*/

SELECT SYSDATE
FROM DUAL;

-- 날짜 출력 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';

/*
        2) MONTHS_BETWEEN
            MONTHS_BETWEEN (DATE, DATE)
            두 날짜 사이의 개월수를 반환함
*/
SELECT MONTHS_BETWEEN(SYSDATE, '20230525')
FROM DUAL;

SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, '20230525'))
FROM DUAL;

-- 소수점 뒷자리 정리
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, '20230525'))
FROM DUAL;

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무 개월 수 조회
SELECT EMP_NAME 직원명,
            HIRE_DATE 입사일,
            FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "근무 개월"
FROM EMPLOYEE;            


/*
        3) ADD_MONTHS
            ADD_MONTHS (DATE, NUMBER)
            
*/
SELECT ADD_MONTHS(SYSDATE, 6)
FROM DUAL;

-- EMPLOYEE 테이블에서 직원명, 입사일, 입사 후 3개월이 된 날짜를 조회

SELECT EMP_NAME 직원명,
            HIRE_DATE 입사일,
            ADD_MONTHS(HIRE_DATE, 3) AS "정사원 전환일"
FROM EMPLOYEE;    

/*
        4) NEXT_DAY
            NEXT_DAY (DATE, CHARACTER | NUMBER)
            조건을 준 다음 날짜를 표시해줌
*/
-- 현재 날짜에서 제일 가까운 일요일 조회
SELECT SYSDATE, NEXT_DAY(SYSDATE, '일요일')
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, '일')
FROM DUAL;

-- NUMBER이 뜻하는 거는 1 = 일 ~ 7 = 토 를 뜻함
SELECT SYSDATE, NEXT_DAY(SYSDATE, 7)
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY')
FROM DUAL;
-- 현재 설정된 언어가 한글이기 때문에 에러 발생

-- 언어 변경 테스트
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';

/*
        5) LAST_DAY
            LAST_DAY (DATE)
            주어진 날짜가 속한 달의 마지막 날짜를 반환한다.
*/

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

SELECT LAST_DAY('20230203')
FROM DUAL;

-- 윤달도 계산해줌
SELECT LAST_DAY('20200203')
FROM DUAL;

-- EMPLOYEE 테이블에서 직원명, 입사일, 입사월의 마지막 날짜,급여일 (매달 마지막 날) 조회
SELECT EMP_NAME 직원명,
            HIRE_DATE 입사일,
            LAST_DAY(HIRE_DATE) AS "입사월의 마지막 날짜",
            LAST_DAY(SYSDATE) 급여일
FROM EMPLOYEE;

/*
        6) EXTRACT
            EXTRACT(YEAR|MONTH|DAY FROM DATE)
            주어진 날짜에서 년, 월, 일 정보를 추출하여 반환한다.
*/

SELECT EXTRACT (YEAR FROM SYSDATE),
            EXTRACT (MONTH FROM SYSDATE),
            EXTRACT (DAY FROM SYSDATE)
            
FROM DUAL;

-- EMPLOYEE 테이블에서 직원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME 직원명,
            EXTRACT(YEAR FROM HIRE_DATE) || '년' AS " 입사 년도",
            EXTRACT(MONTH FROM HIRE_DATE) || '월'입사월,
            EXTRACT(DAY FROM HIRE_DATE) || '일' AS 입사일
,            HIRE_DATE AS "원본"
FROM EMPLOYEE
ORDER BY HIRE_DATE;

/*
        <형 변환 함수>
            1)  TO_CHAR
                TO_CHAR(NUMBER| DATE [, FROMAT]) 
                
                --포맷 문자에 대해 설명한 URL
                https://docs.oracle.com/cd/B19306_01/server.102/b14200/sql_elements004.htm
*/

-- 숫자 -> 문자
SELECT TO_CHAR(1234)
FROM DUAL;

-- 6칸의 공간을 확보, 오른쪽 정렬, 빈칸 공백으로 채운다.
SELECT TO_CHAR(1234 , '999999')
FROM DUAL;

-- 포맷 자리수에 안 맞으면 ###으로 출력 됨
SELECT TO_CHAR(1234 , '99')
FROM DUAL;

-- 6칸의 공간을 확보, 오른쪽 정렬, 빈칸을  '0'으로 채운다.
SELECT TO_CHAR(1234 , '000000')
FROM DUAL;

-- 포맷 자리수에 안 맞으면 ###으로 출력 됨
SELECT TO_CHAR(1234 , '00')
FROM DUAL;

-- 자리수를 구분하는 방법
SELECT TO_CHAR(2000000 , '99,999,999')
FROM DUAL;

-- L은 현재 시스템에서의 통화 기호를 자동 추가
SELECT TO_CHAR(2000000 , 'L99,999,999')
FROM DUAL;

-- FM은 앞의 공백을 제거함
SELECT TO_CHAR(2000000 , 'FML99,999,999')
FROM DUAL;

-- 단위를 직접 기입 가능
SELECT TO_CHAR(2000000 , '$9,999,999')
FROM DUAL;

-- EMPLOYEE 테이블에서 직원명 , 급여, 연봉 조회

SELECT EMP_NAME 직원명,
            TO_CHAR(SALARY, 'FML999,999,999') 급여,
            TO_CHAR(SALARY *12, 'FML999,999,999') AS "연봉"
FROM EMPLOYEE
ORDER BY 연봉 DESC;

-- 날짜 출력 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';

-- 날짜 -> 문자
SELECT TO_CHAR(SYSDATE)
FROM DUAL;

-- 출력하는 것만 조건 변경하기
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS')
FROM DUAL;

--24시간  표기
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'MON DAY, YYYY')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD(DY)')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'FMYYYY/MM/DD(DAY)')
FROM DUAL;

-- 언어 출력 포맷 변경
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';

-- EMPLOYEE 테이블에서 직원명, 입사일(2023-05-25)
SELECT EMP_NAME 직원명,
           TO_CHAR(HIRE_DATE, 'YYYY-MM-DD(DAY)') AS "입사일"
FROM EMPLOYEE
ORDER BY 입사일;

-- 연도에 대한 포맷 문자
SELECT TO_CHAR(SYSDATE, 'YYYY'),
            TO_CHAR(SYSDATE, 'YY'),
            TO_CHAR(SYSDATE, 'Y'),
            TO_CHAR(SYSDATE, 'RRRR'),
            TO_CHAR(SYSDATE, 'RR'),
--            TO_CHAR(SYSDATE, 'RRR') R을 사용시 2자리나 4자리만 사용가능
            TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 월에 대한 포맷 문자
SELECT TO_CHAR(SYSDATE, 'MONTH'),
            TO_CHAR(SYSDATE, 'MM'),
            TO_CHAR(SYSDATE, 'MON'),
            TO_CHAR(SYSDATE, 'RM')
            --로마 숫자로 표현
FROM DUAL;

-- 일에 대한 포맷 문자
SELECT TO_CHAR(SYSDATE, 'D'),           -- 1주를 기준으로 며칠째
            TO_CHAR(SYSDATE, 'DD'),         -- 1달을 기준으로 며칠째
            TO_CHAR(SYSDATE, 'DDD')       -- 1년을 기준으로 며칠째
FROM DUAL;

-- 요일에 대한 포맷 문자
SELECT TO_CHAR(SYSDATE, 'DAY'),
            TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- EMPLOYEE 테이블에서 직원명, 입사일(2023년05월25일)
SELECT EMP_NAME "직원명",
            TO_CHAR(HIRE_DATE, 'YYYY"년 "MM"월 "DD"일"(DY)') AS "입사일"
FROM EMPLOYEE
ORDER BY HIRE_DATE;

/*
        2) TO_DATE
            TO_DATE (NUMBER|CHARACTER [, FORMAT])
*/

-- 숫자 -> 날짜

SELECT TO_DATE(20231106)
FROM DUAL;

SELECT TO_DATE(20231106124130)
FROM DUAL;

SELECT TO_DATE(20231106124130, 'YYYY/MM/DD/ HH:MI:SS')
FROM DUAL;

-- 문자 -> 날짜
SELECT TO_DATE('20231106')
FROM DUAL;
SELECT TO_DATE('20231106140630')
FROM DUAL;
SELECT TO_DATE('20231106140630' , 'YYYYMMDDHH24MISS')
FROM DUAL;

-- YY와 RR 비교

--YY는 무조건 현재 세기를 반영하고
SELECT TO_DATE('231106' , 'YYMMDD')
FROM DUAL;
SELECT TO_DATE('991106' , 'YYMMDD')
FROM DUAL;

--RR은 50미만이면 현재 세기를 반영하고,50이상이면 이전 세기를 반영한다.
SELECT TO_DATE('231106' , 'RRMMDD')
FROM DUAL;
SELECT TO_DATE('991106' , 'RRMMDD')
FROM DUAL;
/*
             23          99
    YY     2023    2099
    RR     2023    1999

*/
-- 날짜 출력 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

-- EMPLOYEE 테이블에서 1998 년 1월 1일 이후에 입사한 사원의 사번, 직원명, 입사일 조회
SELECT EMP_ID 사번,
            EMP_NAME 직원명,
            HIRE_DATE "입사일"
FROM EMPLOYEE
--WHERE HIRE_DATE >= TO_DATE('19980101' , 'RRRRMMDD')
--WHERE HIRE_DATE >= TO_DATE('19980101' , 'YYYYMMDD')
--WHERE HIRE_DATE >= TO_DATE('980101' , 'YYMMDD') -- 20980101
--WHERE HIRE_DATE >= TO_DATE('980101' , 'RRMMDD')
--WHERE HIRE_DATE >= '19980101'
WHERE HIRE_DATE >= '980101'
ORDER BY HIRE_DATE , EMP_ID;

-- 날짜 출력 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

/*
        3)  TO_NUMBER
            TO_NUMBER (CHARACTER [, FORMAT])
*/

SELECT TO_NUMBER('01232456789')
FROM DUAL;

SELECT TO_NUMBER('6,000,000' , '999,999,999')
FROM DUAL;

-- 자동으로 숫자 타입으로 형 변환 뒤 연산 처리를 한다
SELECT '123' + '456'
FROM DUAL;

-- 에러 발생
SELECT '123' + '456A'
FROM DUAL;

SELECT TO_CHAR(TO_NUMBER('10,000,000','99,999,999')
            -    TO_NUMBER('500,000', '99,999,999'), '999,999,999')
FROM DUAL;
-- EMPLOYEE 테이블에서 사원번호가 210보다 큰 사원의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE EMP_ID > 210;
--WHERE EMP_ID > '210';

/*
        <NULL 처리함수>
            1)  NVL
                NVL (P1, P2)
                P1이 NULL일 경우 P2를 반환한다.
*/

-- EMPLOYEE 테이블에서 직원명, 보너스 조회
SELECT EMP_NAME "직원명",
            NVL(BONUS, 0)  AS "보너스"
FROM EMPLOYEE
ORDER BY BONUS DESC;

-- EMPLOYEE 테이블에서 직원명, 부서 코드 조회
-- 단, 부서 코드가 NULL이면 '부서없음' 출력
SELECT EMP_NAME 직원명,
            DEPT_CODE,
            NVL(DEPT_CODE, '부서없음') AS 부서명
FROM EMPLOYEE
ORDER BY 부서명 DESC;

/*
        2) NVL2
            NVL2 (P1,P2,P3)
            P1이 NULL이 아니면 P2, NULL이면 P3를 반환한다.
*/

-- EMPLOYEE 테이블에서 보너스를 0.1로 동결하여 직원명, 보너스, 동결된 보너스, 보너스가 포함된 연봉
SELECT EMP_NAME AS 직원명,
            BONUS 보너스,
            NVL(BONUS,0) ,
            NVL2(BONUS,0.1,0) AS "동결된 보너스",
            (SALARY+ (SALARY * NVL(BONUS,0))) * 12 AS "연봉22",
           (SALARY+ (SALARY * NVL2(BONUS,BONUS,0.1))) * 12 AS 연봉
FROM EMPLOYEE
ORDER BY "보너스";

/*
        3) NULLIF(P1,P2)
        주어진 두 개의 값이 동일하면 NULL, 동일하지 않으면 P1을 반환한다.
*/

SELECT NULLIF(123,123)
FROM DUAL;

SELECT NULLIF(123, 456)
FROM DUAL;

SELECT NULLIF('123','123')
FROM DUAL;

SELECT NULLIF('123', '456')
FROM DUAL;

/*
        <선택 함수>
            1) DECODE
                DECODE(컬럼명 | 계산식, 조건값1, 결과값1, 조건값2, 결과값2, ..... , 결과값)
                DECODE 함수는 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값을 반환한다.
                
*/
-- EMPLOYEE 테이블에서 사번, 직원명, 주민번호 성별(남자, 여자) 조회
SELECT EMP_ID"사번",
            EMP_NAME 직원명,
            EMP_NO "주민 번호",
            DECODE(SUBSTR(EMP_NO,8,1),1,'남자',2,'여자','잘못된 주민번호 입니다.') AS "주민번호 성별"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 직급 코드, 기존 급여, 인상된 급여 조회
-- 직급 코드가 J7인 사원은 급여를 10%인상
-- 직급 코드가 J6인 사원은 급여를 15%인상
-- 직급 코드가 J5인 사원은 급여를 20%인상
-- 그 외 사원은 급여를 5%인상

SELECT EMP_NAME AS "직원명",
            JOB_CODE "직급 코드",
            TO_CHAR(SALARY, 'FML999,999,999') AS "기존 급여",
            TO_CHAR(SALARY*DECODE(JOB_CODE,'J7',1.1,'J6',1.15,'J5',1.2,1.05), 'FML999,999,999') AS "인상된 급여"
FROM EMPLOYEE
ORDER BY "인상된 급여" DESC;

/*
        2) CASE 문
            CASE 문은 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값을 반환한다.
            CASE WHEN 조건 1 THEN 결과 1
                     WHEN 조건 2 THEN 결과 2
                     WHEN 조건 3 THEN 결과 3
                     ...
                     ELSE 결과
            END
*/

-- EMPLOYEE 테이블에서 사번, 직원명, 주민번호 성별(남자, 여자) 조회
SELECT EMP_ID"사번",
            EMP_NAME 직원명,
            EMP_NO "주민 번호",
--            CASE WHEN SUBSTR(EMP_NO ,8 ,1) = '1' THEN '남자'
--                     WHEN SUBSTR(EMP_NO ,8 ,1) = '2' THEN '여자'
            CASE WHEN SUBSTR(EMP_NO ,8 ,1) IN ('1','3') THEN '남자'
                     WHEN SUBSTR(EMP_NO ,8 ,1) IN ('2','4') THEN '여자'
                     ELSE '잘못된 주민번호 입니다.'
            END AS "성별"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 직원명, 급여, 급여 등급(S1~ S4) 조회
-- SALARY 값이 500만원 초과일 경우 S1
-- SALARY 값이 500만원 이하 350만원 초과일 경우 S2
-- SALARY 값이 350만원 이하 200만원 초과일 경우 S3
-- 그 외에 경우 S4
SELECT EMP_NAME "직원명",
            SALARY "급여",
            CASE WHEN SALARY>5000000 THEN 'S1'
                     WHEN SALARY>3500000 THEN 'S2'
                     WHEN SALARY>2000000 THEN 'S3'
                     ELSE 'S4'
                     END "급여 등급"
FROM EMPLOYEE
ORDER BY SALARY DESC;

/*
        <그룹 함수>
        그룹 함수는 하나 이상의 행을 그룹으로 묶어 연산하며 총합, 평균 등을 하나의 컬럼으로 반환하는 함수이다.
        모든 그룹 함수는 NULL 값을 자동으로 제외하고 값이 있는 것들만 계산을 한다.
            1) SUM 함수
                SUM (NUMBER 타입의 컬럼)
            컬럼 값들의 총합을 반환하는 함수이다.
            
*/

-- EMPLOYEE 테이블에서 전 사원의 총 급여의 합계를 조회
SELECT TO_CHAR(SUM(SALARY) , 'FML999,999,999,999') AS "월급 합계"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 전 사원의 연봉의 총 합계를 조회
SELECT TO_CHAR(SUM(SALARY*12), 'FML999,999,999,999') AS "연봉 합계"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 여자 사원의 총 급여의 합계를 조회
SELECT TO_CHAR(SUM(SALARY) , 'FML999,999,999,999') AS "월급 합계"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '2' ;    

-- EMPLOYEE 테이블에서 부서 코드가 'D5'인 사원들의 총 연봉의 합계를 조회
SELECT TO_CHAR(SUM(SALARY *12) ,'FML999,999,999,999') AS "연봉 합계"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- EMPLOYEE 테이블에서 부서 코드가 'D5'인 사원들의 총 연봉의 합계를 조회(보너스 포함)
SELECT TO_CHAR(SUM(SALARY *12*(1+NVL(BONUS,0))) ,'FML999,999,999,999') AS "연봉 합계(보너스 포함)"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

/*
        2) AVG
            AVG(NUMBER 타입의 컬럼)
            컬럼 값들의 평균을 반환하는 함수이다.
*/

-- EMPLOYEE 테이블에서 전체 사원의 급여 평균

SELECT TO_CHAR(ROUND(AVG(NVL(SALARY,0))) , 'FM999,999,999') AS "급여 평균"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 전체 사원의 보너스의 평균
SELECT ROUND(AVG(NVL(BONUS,0)),2) AS "보너스의 평균"
FROM EMPLOYEE;

/*
        3) MIN / MAX
            MIN /MAX(모든 타입의 컬럼)
            NULL값은 제외함
*/

-- EMPLOYEE 테이블에서 전체 사원의 급여 중 가장 큰,작은 값
SELECT MIN(SALARY),MAX(SALARY),
             MIN (EMP_NAME),MAX(EMP_NAME),
             MIN(HIRE_DATE),MAX(HIRE_DATE),
             MIN(BONUS),MAX(BONUS)
FROM EMPLOYEE;

/*
        4) COUNT
            COUNT(* | 컬럼 | DISTINCT 컬럼명)
            조회된 행의 개수를 반환하는 함수이다
            DISTINCT 는 중복된 값을 제외한 행의 개수를 구해줌
*/

-- EMPLOYEE 테이블에서 전체 사원의 수
SELECT COUNT(*),
             COUNT(EMP_ID),
             COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 남자 사원의 수
SELECT COUNT(*) AS "남자 사원의 수"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

-- EMPLOYEE 테이블에서 보너스를 받는 직원의 수
SELECT COUNT(*) AS "보너스를 받는 직원의 수"
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

SELECT COUNT(BONUS)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 퇴사한 직원수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE  ENT_YN = 'Y';

SELECT COUNT (ENT_DATE)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM EMPLOYEE
WHERE ENT_DATE IS NOT NULL;

-- EMPLOYEE 테이블에서 현재 사원들이 속해있는 부서의 수를 조회
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 현재 사원들이 분포되어 있는 직급의 수를 조회
SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;
