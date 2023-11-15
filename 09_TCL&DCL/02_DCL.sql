/*
        <DCL(DATA CONTROL LANGUAGE)>
        데이터를 제어하는 구문으로 계정에게 시스템 권한 또는 객체에 대한 접근 권한을 부여(GRANT)하거나 회수(REVOKE)하는 구문이다.
        
        <시스템 권한>
            데이터베이스에 접근하는 권한, 오라클에서 제공하는 객체를 생성/삭제
            할 수 있는 권한
*/

-- 1. SAMPLE 계정 생성
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;

-- 2. 계정에 접속하기 위해서 CRAETE SESSION 권한 부여
GRANT CREATE SESSION TO C##SAMPLE;

-- 3. SAMPLE 계정에서 테이블을 생성할 수 있도록 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO C##SAMPLE;

-- 4. SAMPLE 계정에서 테이블 스페이스 할당 (테이블, 뷰, 인덱스 등 객체들이 저장되는 공간)
ALTER USER C##SAMPLE QUOTA 2M ON USERS;

/*
        <객체 접근 권한>
        특정 객체를 조작할 수 있는 권한이다.
*/

-- 5. SAMPLE 계정에서 C##KH.EMPLOYEE 테이블을 조회할 수 있는 권한 부여
GRANT SELECT ON C##KH.EMPLOYEE TO C##SAMPLE;

-- 6. SAMPLE 계정에서 C##KH.DEPARTMENT 테이블을 조회할 수 있는 권한 부여
GRANT SELECT ON C##KH.DEPARTMENT TO C##SAMPLE;

-- 7. SAMPLE 계정에서 C##KH.DEPARTMENT 테이블에 데이터를 추가할 수 있는 권한 부여
GRANT INSERT ON C##KH.DEPARTMENT TO C##SAMPLE;

-- 8. SAMPLE 계정에서 C##KH.DEPARTMENT 테이블을 조회하는 권한, 데이터를 추가하는 권한을 회수
REVOKE SELECT, INSERT ON C##KH.DEPARTMENT FROM C##SAMPLE;

/*
        <ROLE>
           특정 권한들을 하나의 집합으로 모아놓은 것을 롤(ROLE)이라 한다.
*/

SELECT *
FROM ROLE_SYS_PRIVS
--WHERE ROLE = 'CONNECT';
--WHERE ROLE = 'RESOURCE';
WHERE ROLE = 'DBA' AND PRIVILEGE LIKE 'CREATE%';