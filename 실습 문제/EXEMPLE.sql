--1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열"
--으로 표시하도록 한다.

SELECT DEPARTMENT_NAME AS 학과명,
            CATEGORY AS 계열
FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NAME  || '의 정원은 ' || CAPACITY || ' 명 입니다.'
FROM TB_DEPARTMENT;

SELECT STUDENT_NAME,
            STUDENT_NO
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 001 AND ABSENCE_YN = 'Y';

SELECT *
--FROM TB_STUDENT
 FROM TB_GRADE
WHERE STUDENT_NO IN ('A513079','A513090','A513091','A513110','A513119') AND POINT = '4.5'





