
/*
        <ALTER>
            오라클 데이터 베이스 객체(테이블, 인덱스, 뷰 등)를 수정하는 구문이다.
            
*/
-- 실습에 사용할 테이블 생성
CREATE TABLE DEPT_COPY
AS SELECT *
    FROM DEPARTMENT;



/*
        1. 컬럼 추가 / 수정 / 삭제 / 이름 변경
            1) 컬럼 추가
                ALTER TABLE 테이블명 ADD 컬럼명 데이터타입 [DEFAULT 기본값];
*/
-- DEPT_COPY 테이블에 CNAME 칼럼을 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);

-- DEPT_COPY 테이블에 LNAME 컬럼을 추가 (기본값 : 대한민국)
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '대한민국';

SELECT * FROM DEPT_COPY;

/*
          2) 컬럼 수정
            데이터 타입 변경
                ALTER TABLE 테이블명 MODIFY 컬럼명 변경할 데이터 타입;
            기본값 변경
                ALTER TABLE 테이블명 MODIFY 컬럼명 DEFALUT 변경할 기본값;
*/
-- DEPT_COPY 테이블에 DEPT_ID 컬럼의 데이터 타입을 CHAR(3)로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
-- 변경하려는 자료형의 크기보다 이미 큰 값이 존재하면 에러 발생
-- ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(2);
-- ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR(10);

-- DEPT_COPY 테이블에 CNAME 컬럼의 데이터 타입을 NUMBER로 변경


ALTER TABLE DEPT_COPY MODIFY CNAME NUMBER;
-- ALTER TABLE DEPT_COPY MODIFY LNAME NUMBER; -- 에러 발생

-- DEPT_COPY 테이블에 LNAME 칼럼의 기본값을 미국으로 변경
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '미국';
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT NULL; -- DEFALUT 삭제

SELECT * FROM DEPT_COPY;

-- DEPT_COPY 테이블에 
-- DEPT_TITLE 컬럼의 데이터 타입을 VARCHAR2(40)로 변경
-- LOCATION_ID 컬럼의 데이터 타입을 VARCHAR2(2)로
-- LNAME 컬럼의 기본값을 한국으로 변경하기
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(40);
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(2);
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '한국';

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '한국'
;


/*
            2) 컬럼 삭제
                ALTER TABLE 테이블명 DROP COLUMN  컬럼명;
*/
-- DEPT_COPY 테이블에서 DEPT_ID 컬럼 삭제
ALTER TABLE DEPT_COPY
DROP COLUMN DEPT_ID;

SELECT * FROM DEPT_COPY;
ROLLBACK;       -- DDL 구문은 ROLLBACK으로 복구 불가능

-- 테이블에 최소 한 개의 컬럼은 존재해야한다.
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP COLUMN LANME; -- 에러 발생
;
-- 참조되고 있는 컬럼이 있다면 삭제가 불가능하다.
ALTER TABLE MEMBER_GRADE DROP COLUMN GRADE_CODE;

-- 아래와 같이 옵션을 지정하면 참조되고 있는 칼럼도 삭제가 가능하다.
-- 단, 참조하고 있는 컬럼의 제약조건도 삭제된다.
ALTER TABLE MEMBER_GRADE DROP COLUMN GRADE_CODE CASCADE CONSTRAINTS;

/*
            4) 컬럼명 변경
                ALTER TABLE 테이블명 RENAME COLUMN 기존컬럼명 TO 변경할 컬럼명;
*/
-- DEPT_COPY 테이블의 LNAME 컬럼명을 LOCATION_NAME 으로 변경
ALTER TABLE DEPT_COPY RENAME COLUMN LNAME TO LOCATION_NAME;
SELECT * FROM DEPT_COPY;

DROP TABLE DEPT_COPY;



















































































































































































































































































































































































































