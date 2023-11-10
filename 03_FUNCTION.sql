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

SELECT EMAIL AS "원본 이메일",
            REPLACE(EMAIL,'kh.or.kr','gmail.com') "GOOGLE 이메일",
            REPLACE(EMAIL,'kh.or.kr',' ') AS "공란 이메일"
FROM EMPLOYEE;


