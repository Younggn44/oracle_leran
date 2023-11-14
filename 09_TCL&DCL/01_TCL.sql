
/*
        <TCL>(TRANSACTION CONTROL LANGUAGE)
            트랜잭션을 제어하는 언어이다.
            하나의 논리적인 작업 단위를 트랜잭션이라고 한다.
            예) ATM에서 현금 출금
                1. 카드 삽입
                2. 메뉴 선택
                3. 금액 확인 및 인증
                4. 실제 계좌에서 금액만금 인출
                5. 현금 인출
                6. 완료
            각각의 업무들을 묶어서 하나의 작업 단위로 만드는 것을 트랜잭션이라고 한다.
            하나의 트랜잭션으로 묶인 작업들은 반드시 모두 완료가 되어야 하며, 그렇지 않은 경우에는 모두 취소되어야 한다.
            데이터베이스는 데이터의 변경 사항(INSERT, UPDATE, DELETE)들을 묶어서 하나의 트랜잭션에 담아서 처리한다.
*/
-- 테스트용 테이블 생성
CREATE TABLE EMP_TEST
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE
    FROM EMPLOYEE;

-- EMP_TEST 테이블에서 EMP_ID 가 213, 218인 사원을 삭제
DELETE 
FROM EMP_TEST
WHERE EMP_ID IN ('213', '218');

-- 두 개의 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT SP1;

-- EMP_TEST 테이블에서 EMP_ID가 200인 사원 삭제
--SELECT *
DELETE
FROM EMP_TEST
WHERE EMP_ID = 200;

ROLLBACK TO SP1;
ROLLBACK;

-- EMP_TEST 테이블의 EMP_ID가 215인 사원을 삭제
DELETE 
FROM EMP_TEST
WHERE EMP_ID = 215;

-- DDL 구문을 실행하는 순간 기존에 메모리 버퍼에 임시 저장된 변경 사항들이
-- 무조건 DB에 반영(COMMIT)된다.
CREATE TABLE TEST(
    TID NUMBER
);

SELECT * FROM TEST;
ROLLBACK;

SELECT * FROM EMP_TEST;
DROP TABLE EMP_TEST;