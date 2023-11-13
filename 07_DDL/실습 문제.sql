---------------------------------------------------------------------
-- 실습 문제
-- 도서관리 프로그램을 만들기 위한 테이블 만들기
-- 이때, 제약조건에 이름을 부여하고, 각 컬럼에 주석 달기

-- 1. 출판사들에 대한 데이터를 담기 위한 출판사 테이블(TB_PUBLISHER) 
--  1) 컬럼 : PUB_NO(출판사 번호) -- 기본 키
--           PUB_NAME(출판사명) -- NOT NULL
--           PHONE(출판사 전화번호)
CREATE TABLE TB_PUBLISHER (
    PUB_NO NUMBER,
    PUB_NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20),
    CONSTRAINT PUB_NO_PK PRIMARY KEY(PUB_NO)
);
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '출판사 번호';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '출판사명';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '출판사 전화번호';

--  2) 3개 정도의 샘플 데이터 추가하기
INSERT INTO TB_PUBLISHER VALUES (1,'서울','010-1111-1111');
INSERT INTO TB_PUBLISHER VALUES (2,'부산','010-2222-2222');
INSERT INTO TB_PUBLISHER VALUES (3,'제주','010-4444-3333');

SELECT * FROM TB_PUBLISHER;
DROP TABLE TB_PUBLISHER;
-- 2. 도서들에 대한 데이터를 담기 위한 도서 테이블 (TB_BOOK)
--  1) 컬럼 : BK_NO (도서번호) -- 기본 키
--           BK_TITLE (도서명) -- NOT NULL
--           BK_AUTHOR(저자명) -- NOT NULL
--           BK_PRICE(가격)
--           BK_PUB_NO(출판사 번호) -- 외래 키(TB_PUBLISHER 테이블을 참조하도록)
--                                    이때 참조하고 있는 부모 데이터 삭제 시 자식 데이터도 삭제 되도록 옵션 지정
CREATE TABLE TB_BOOK(
    BK_NO NUMBER,
    BK_TITLE VARCHAR2(200) NOT NULL,
    BK_AUTHOR VARCHAR2(200) NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER,
    CONSTRAINT BK_NO_PK PRIMARY KEY(BK_NO),
    CONSTRAINT BK_PUB_NO_FK FOREIGN KEY(BK_PUB_NO) REFERENCES TB_PUBLISHER(PUB_NO) ON DELETE CASCADE
    
);
COMMENT ON COLUMN TB_BOOK.BK_NO IS '도서 번호';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '도서명';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '저자명';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '가격';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '출판사 번호';

--  2) 5개 정도의 샘플 데이터 추가하기
INSERT INTO TB_BOOK VALUES(1, '도서1', '저자1', 10000, 1);
INSERT INTO TB_BOOK VALUES(2, '도서2', '저자2', 20000, 2);
INSERT INTO TB_BOOK VALUES(3, '도서3', '저자3', 30000, 3);
INSERT INTO TB_BOOK VALUES(4, '도서4', '저자4', 40000, 2);
INSERT INTO TB_BOOK VALUES(5, '도서5', '저자5', 45000, 1);

SELECT * FROM TB_BOOK;
-- 3. 회원에 대한 데이터를 담기 위한 회원 테이블 (TB_MEMBER)
--  1) 컬럼 : MEMBER_NO(회원번호) -- 기본 키
--           MEMBER_ID(아이디)   -- 중복 금지
--           MEMBER_PWD(비밀번호) -- NOT NULL
--           MEMBER_NAME(회원명) -- NOT NULL
--           GENDER(성별)        -- 'M' 또는 'F'로 입력되도록 제한
--           ADDRESS(주소)       
--           PHONE(연락처)       
--           STATUS(탈퇴 여부)     -- 기본값으로 'N' 그리고 'Y' 혹은 'N'으로 입력되도록 제약조건
--           ENROLL_DATE(가입일)  -- 기본값으로 SYSDATE, NOT NULL
CREATE TABLE TB_MEMBER (
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(20) NOT NULL,
    GENDER VARCHAR2(3),
    ADDRESS VARCHAR2(100),
    PHONE VARCHAR2(20),
    STATUS CHAR(1) DEFAULT 'N',
    ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY(MEMBER_NO),
    CONSTRAINT MEMBER_ID_UQ UNIQUE (MEMBER_ID),
    CONSTRAINT GENDER_CK CHECK(GENDER IN ('M','F')),
    CONSTRAINT STATUS_CK  CHECK(STATUS IN ('Y','N'))
    )
;

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '아이디';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원명';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '성별';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN TB_MEMBER.STATUS IS '탈퇴 여부';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '가입일';


--  2) 3개 정도의 샘플 데이터 추가하기
INSERT INTO TB_MEMBER VALUES (1,'AAA','A111','가가가','M','종로구','010-3333-2222','N',DEFAULT);
INSERT INTO TB_MEMBER VALUES (2,'BBB','A222','나나나','F','김포시','010-2222-4444','N',DEFAULT);
INSERT INTO TB_MEMBER VALUES (3,'CCC','A333','다다다','F','중구','010-5555-5555','',DEFAULT);

SELECT * FROM TB_MEMBER;
DROP TABLE TB_MEMBER;
-- 4. 도서를 대여한 회원에 대한 데이터를 담기 위한 대여 목록 테이블(TB_RENT)
--  1) 컬럼 : RENT_NO(대여번호) -- 기본 키
--           RENT_MEM_NO(대여 회원번호) -- 외래 키(TB_MEMBER와 참조)
--                                      이때 부모 데이터 삭제 시 NULL 값이 되도록 옵션 설정
--           RENT_BOOK_NO(대여 도서번호) -- 외래 키(TB_BOOK와 참조)
--                                      이때 부모 데이터 삭제 시 NULL 값이 되도록 옵션 설정
--           RENT_DATE(대여일) -- 기본값 SYSDATE
CREATE TABLE TB_RENT (
    RENT_NO NUMBER,
    RENT_MEM_NO NUMBER,
    RENT_BOOK_NO NUMBER,
    RENT_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT RENT_NO_PK PRIMARY KEY (RENT_NO),
    CONSTRAINT RENT_MEM_NO_CK FOREIGN KEY (RENT_MEM_NO) REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE SET NULL,
    CONSTRAINT RENT_BOOK_NO_CK FOREIGN KEY (RENT_BOOK_NO) REFERENCES TB_BOOK(BK_NO) ON DELETE SET NULL
);
COMMENT ON COLUMN TB_RENT.RENT_NO IS '대여번호';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '대여 회원번호';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '대여 도서번호';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '대여일';

DROP TABLE TB_RENT;
SELECT * FROM TB_RENT;
--  2) 샘플 데이터 3개 정도 
INSERT INTO TB_RENT VALUES (1,1,2,DEFAULT);
INSERT INTO TB_RENT VALUES (2,1,3,DEFAULT);
INSERT INTO TB_RENT VALUES (3,2,1,DEFAULT);
INSERT INTO TB_RENT VALUES (4,2,2,DEFAULT);
INSERT INTO TB_RENT VALUES (5,1,5,DEFAULT);

-- 5. 2번 도서를 대여한 회원의 이름, 아이디, 대여일, 반납 예정일(대여일 + 7일)을 조회하시오.
SELECT TM.MEMBER_NAME,
             TM.MEMBER_ID,
             TR.RENT_DATE,
             TR.RENT_DATE + 7
FROM TB_MEMBER TM
JOIN TB_RENT TR ON (TR.RENT_MEM_NO = TM.MEMBER_ID)
WHERE TR.RENT_BOOK_NO = '2';

-- 6. 회원번호가 1번인 회원이 대여한 도서들의 도서명, 출판사명, 대여일, 반납 예정일(대여일 + 7일)을 조회하시오.
SELECT TB.BK_TITLE,
            TP.PUB_NAME,
             TR.RENT_DATE,
             TR.RENT_DATE + 7
FROM TB_RENT TR
JOIN TB_BOOK TB ON (TR.RENT_BOOK_NO = TB.BK_NO)
JOIN TB_PUBLISHER TP ON (TB.BK_NO = TP.PUB_NO)
WHERE TR.RENT_MEM_NO = '1'
;

----------------------------------------------------------------------------------------------------------------






















