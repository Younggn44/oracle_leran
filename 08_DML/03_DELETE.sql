
/*
        <DELETE>
            테이블의 행을 삭제하는 구문이다.
*/
ROLLBACK;
COMMIT;
ROLLBACK;

-- EMPLOYEE 테이블에서 사번이 200인 사원의 데이터를 지우기
DELETE 
FROM EMPLOYEE
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 DEPT_CODE가 'D5'인 직원들을 삭제
DELETE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
;
-- DEPARTMENT 테이블에서 DEPT_ID 가 'D1'인 부서를 삭제
DELETE
FROM DEPARTMENT
WHERE DEPT_ID = 'D1'; -- D1 의 값을 참조하는 데이터가 있기 때문에 삭제 불가능

-- DEPARTMENT 테이블에서 DEPT_ID가 D3인 부서를 삭제
DELETE
FROM DEPARTMENT
WHERE DEPT_ID = 'D3'; -- D3 의 값을 참조하는 데이터가 없기 때문에 삭제 가능

SELECT * FROM  DEPARTMENT;

ROLLBACK;

/*
        <TRUNCATE>
            테이블의 전체 행을 삭제하는 구문이다.
            DELETE보다 수행 속도가 빠르고 ROLLBACK을 통해 복구 불가능하다
*/
CREATE TABLE DEPT_COPY
AS SELECT *
    FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

DELETE FROM DEPT_COPY;

ROLLBACK;

TRUNCATE TABLE DEPT_COPY;

DROP TABLE DEPT_COPY;