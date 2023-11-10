
/*
        <DDL(Date Definition Language)>
            데이터 정의 언어로 오라클에서 제공하는 객체 (OBJECT)를 생성(CREATE)하고
            수정(ALTER)하고, 삭제(DROP)하는 구문이다.
            
        <CREATE>
            오라클 데이터베이스 객체(테이블, 뷰, 인덱스 등)를 생성하는 구문이다.
            
        <테이블 생성>
            CREATE TABLE 테이블명 (
            컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
            컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
            ...  
            );
*/
-- 회원에 대한 데이터를 담을 수 있는 MEMBER 테이블 생성
CREATE TABLE MEMBER(
    NO NUMBER,
    ID VARCHAR2(20),
    PASSWORD VARCHAR2(20),
    NAME VARCHAR2(15),
    ENROLL_DATE DATE DEFAULT SYSDATE
);

-- 테이블 삭제
DROP TABLE MEMBER;

-- 테이블의 구조를 표시해 주는 구문이다.
DESC MEMBER;

/*
    데이터 딕셔너리
        자원을 효율적으로 관리하기 위해 다양한 객체들의 정보를 저장하는
        시스템 테이블이다.
        데이터에 관한 데이터가 저장되어 있다고 해서 메타 데이터라고도 한다.
*/

-- USER_TABLES : 사용자가 가지고 있는 테이블들의 구조를 확인하는 뷰 테이블이다.
SELECT *
FROM USER_TABLES
WHERE TABLE_NAME = 'MEMBER'
;

-- USER_TAB_COLUMNS : 사용자가 가지고 있는 테이블, 컬럼과 관련되
--                                 정보를 조회하는 뷰 테이블이다.
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'MEMBER'
;

/*
        <컬럼 주석>
            테이블의 컬럼에 대한 설명을 작성할 수 있는 구문이다.
*/
COMMENT ON COLUMN MEMBER.NO IS '회원 번호';
COMMENT ON COLUMN MEMBER.ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.PASSWORD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원 가입일';

-- 테이블에 샘플 데이터 추가(INSERT)
-- INSERT INTO 테이블명[(컬럼명, ... ,컬럼명)] VALUES (값, ... , 값);
INSERT INTO MEMBER VALUES (1,'USER1','1234','홍길동','2023-11-09');

SELECT *
FROM MEMBER;

INSERT INTO MEMBER VALUES (2,'USER2','1234','이몽룡',SYSDATE);

INSERT INTO MEMBER (NO,ID,PASSWORD,NAME,ENROLL_DATE) VALUES (3,'USER3','1234','성춘향',DEFAULT);

INSERT INTO MEMBER (ID,PASSWORD) VALUES ('USER4','1234');

INSERT INTO MEMBER (ID,PASSWORD) VALUES ('USER4USER4USER4USER4USER4USER4USER4USER4USER4','1234');
-- 메모리 버퍼에 임시 저장된 데이터를 실제 테이블에 반영한다.
COMMIT; 
ROLLBACK;

SHOW AUTOCOMMIT;
SET AUTOCOMMIT ON;
SET AUTOCOMMIT OFF;

/*
        <제약 조건>
            테이블 작성 시 컬럼에 대해 저장될 데이터에 대한 제약조건을 설정할 수 있다.
            제약 조건은 데이터 무결성을 보장을 목적으로 한다.
            (데이터의 정확성과 일관성을 유지시키는 것)
            
           * 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
           
           [표현법]
            -- 1) 컬럼 레벨
                CREATE TABLE 테이블명 (
                    컬럼명 자료형(크기) [CONSTRAINT 제약조건명] 제약조건,
                ...
                );
    
            -- 2) 테이블 레벨
               CREATE TABLE 테이블명 (
                    컬럼명 자료형(크기),
                    ...
                    [CONSTRAINT 제약조건명] 제약조건 (컬럼명)
                );
*/

/*
        1. NOT NULL 제약 조건
            해당 컬럼에 반드시 값이 있어야만 하는 경우에 사용한다.
            NOT NULL 제약조건은 컬럼 레벨에서만 설정이 가능하다.
*/
-- 기존 MEMBER 테이블은 값에 NULL이 있어도 행의 삽입이 가능하다.
INSERT INTO MEMBER VALUES (NULL, NULL, NULL, NULL, NULL);

-- NOT NULL 제약조건을 설정한 테이블 생성
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER NOT NULL,
    ID VARCHAR2(20) NOT NULL,
    PASSWORE VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

-- NOT NULL 제약조건에 위배되어 오류 발생
INSERT INTO MEMBER VALUES (NULL, NULL, NULL, NULL, NULL);

-- NOT NULL 제약조건이 걸려있는 컬럼에는 반드시 값이 있어야 한다.
INSERT INTO MEMBER VALUES (1, 'USER1', '1234', '홍길동', NULL);
INSERT INTO MEMBER VALUES (2, 'USER2', '1234', '이몽룡', DEFAULT);
INSERT INTO MEMBER(NO,ID, PASSWORD,NAME)  VALUES(3,'USER3', '5678','성춘향');

-- 테이블의 데이터를 수정하는 구문
UPDATE MEMBER
SET ID = NULL
WHERE NAME = '홍길동';

SELECT * FROM MEMBER;

-- 사용자가 작성한 제약조건을 확인하는 뷰 테이블이다.
SELECT *
FROM USER_CONSTRAINTS;

-- 사용자가 작성한 제약조건이 걸려있는 컬럼을 확인하는 뷰 테이블이다.
SELECT *
FROM USER_CONS_COLUMNS;

/*
        2. UNIQUE 제약조건
            컬럼에 중복된 값을 저장하거나 중복된 값으로 수정할 수 없도록 한다.
            UNIQUE 제약조건은 컬럼 레벨, 테이블 레벨 방식 모두 사용 가능하다.
*/

-- UNIQUE 제약조건을 설정한 테이블 생성 (컬럼 레벨 방식)
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER NOT NULL UNIQUE,
    ID VARCHAR2(20) NOT NULL UNIQUE,
    PASSWORE VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE
);


-- 아이디가 중복되어도 성공적으로 데이터가 삽입된다.
INSERT INTO MEMBER VALUES  (1,'USER1','1234','홍길동', DEFAULT);
INSERT INTO MEMBER VALUES  (1,'USER1','1234','임꺽정', DEFAULT);
INSERT INTO MEMBER VALUES  (2,'USER2','5678','임꺽정', DEFAULT);

SELECT * FROM MEMBER;

-- UNIQUE 제약조건을 설정한 테이블 생성 (테이블 레벨 방식)
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER CONSTRAINT MEMBER_NO_NN NOT NULL,
    ID VARCHAR2(20) CONSTRAINT MEMBER_ID_NN NOT NULL,
    PASSWORE VARCHAR2(20) CONSTRAINT MEMBER_PASSWORD_NN NOT NULL,
    NAME VARCHAR2(15) CONSTRAINT MEMBER_NAME_NN NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_UQ UNIQUE(NO),
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID)
);


INSERT INTO MEMBER VALUES  (1,'USER1','1234','홍길동', DEFAULT);
INSERT INTO MEMBER VALUES  (1,'USER1','1234','임꺽정', DEFAULT);
INSERT INTO MEMBER VALUES  (2,'USER2','5678','임꺽정', DEFAULT);

-- 여러 개의 컬럼을 묶어서 UNIQUE 제약조건을 설정한 테이블 생성
-- 단, 반드시 테이블 레벨로만 설정이 가능하다.



CREATE TABLE MEMBER (
    NO NUMBER CONSTRAINT MEMBER_NO_NN NOT NULL,
    ID VARCHAR2(20) CONSTRAINT MEMBER_ID_NN NOT NULL,
    PASSWORE VARCHAR2(20) CONSTRAINT MEMBER_PASSWORD_NN NOT NULL,
    NAME VARCHAR2(15) CONSTRAINT MEMBER_NAME_NN NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_UQ UNIQUE(NO, ID)
    -- NO컬럼과 ID컬럼의 묶음으로 확인 한다
);

-- 여러 개의 컬럼을 묶어서 하나의 UNIQUE 제약조건이 설정되어 있으면
-- 제약조건이 설정되어 있는 컬럼 값이 모두 중복되는 경우에만 오류 발생 한다.

INSERT INTO MEMBER VALUES  (1,'USER1','1234','홍길동', DEFAULT);
INSERT INTO MEMBER VALUES  (2,'USER1','5678','임꺽정', DEFAULT);
INSERT INTO MEMBER VALUES  (2,'USER1','5678','홍길동', DEFAULT); -- 에러 발생
INSERT INTO MEMBER VALUES  (2,'USER2','5678','홍길동', DEFAULT);



/*
        <CHECK 제약조건>
        컬럼에 기록되는 값에 조건을 설정하고 조건을 만족하는 값만 저장하거나 수정하도록 한다.
        비교 연산자를 이용하여 조건을 설정하며 비교 값을 리터럴만 사용 가능하고 변하는 값이나 함수 사용할 수 없다.
        CHECK 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
        
*/
CREATE TABLE MEMBER (
    NO NUMBER  NOT NULL,
    ID VARCHAR2(20) NOT NULL,
    PASSWORE VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15)  NOT NULL,
    GENDER CHAR(3),
    AGE NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_UQ UNIQUE(NO),
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID)
);

-- 성별, 나이에 유효한 값이 아닌 값들도 INSERT 된다.
INSERT INTO MEMBER
VALUES (1,'USER1','1234','홍길동','남','25',DEFAULT);

INSERT INTO MEMBER
VALUES (2,'USER2','1234','성춘향','여','20',DEFAULT);

INSERT INTO MEMBER
VALUES (3,'USER3','1234','임꺽정','강','-30',DEFAULT);

-- CHECK 제약조건을 설정한 테이블 생성
CREATE TABLE MEMBER (
    NO NUMBER  NOT NULL,
    ID VARCHAR2(20) NOT NULL,
    PASSWORE VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15)  NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEMBER_GENDER_CK CHECK (GENDER IN ('남','여')),
    AGE NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_UQ UNIQUE(NO),
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_AGE_CK CHECK (AGE >= 0)
);

INSERT INTO MEMBER
VALUES (1,'USER1','1234','홍길동','남','25',DEFAULT);

INSERT INTO MEMBER
VALUES (2,'USER2','1234','성춘향','여','20',DEFAULT);

INSERT INTO MEMBER
VALUES (3,'USER3','1234','임꺽정','강','30',DEFAULT);
-- GENDER 컬럼에 '남' 또는 '여'만 입력 가능하도록 설정이 되었기 때문에 에러가 발생한다.
INSERT INTO MEMBER
VALUES (4,'USER4','1234','이몽룡','남','-22',DEFAULT);
-- AGE 컬럼에 0보다 크거나 같은 값만 입력 가능하도록 설정이 되었기 떄문에 에러가 발생한다.

COMMIT;
ROLLBACK;

UPDATE MEMBER
--SET PASSWORE = '5678'
--SET GENDER = '강'
SET AGE = '-100'
WHERE NO = '1'
;








SELECT * FROM MEMBER;

DROP TABLE MEMBER;

SELECT UC.CONSTRAINT_NAME,
            UC.TABLE_NAME,
            UCC.COLUMN_NAME,
            UC.CONSTRAINT_TYPE,
            UC.SEARCH_CONDITION
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';


















































































