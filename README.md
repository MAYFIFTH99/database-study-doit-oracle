### 키

1. 기본 키
    1. 테이블에서 한 행을 고유하게 식별할 수 있는 키
2. 대체 키(보조 키)
    1. 후보 키 중 기본 키로 선택되지 않은 나머지 키
3. 후보 키
    1. 기본 키가 될 수 있는 키들
    2. 기본 키도 후보 키 중 하나다.
4. 슈퍼 키
    1. 행 식별이 가능한 키의 모든 조합
    2. 기본키, 후보 키에서 불필요한 열도 포함한 키
5. 복합 키
    1. 여러 열을 조합하여 기본 키 역할을 할 수 있게 만든 키
6. 외래 키
    1. 특정 테이블에 포함되어 있으면서 다른 테이블의 기본 키가 되는 키

---

### 자료형

1. VARCHAR2(길이)
    1. 4000byte 가변 길이
2. NUMBER(전체 자릿수, 소수점 이하 자릿수)
    1. NUMER(p,s)  : p자리 s점 반올림
3. DATE
4. CHAR
    1. 4000byte 고정 길이
5. NVARCHAR2
6. BLOB
7. CLOB
8. BFILE

---

### 객체

1. 테이블 : 데이터를 저장하는 장소
2. 인덱스 : 검색 효율을 높이는 기능
3. 뷰 : 하나 또는 여러 개의 테이블에서 선별한 데이터를 하나로 연결해 테이블로 제공
4. 시퀀스 : 일련 번호 생성
5. 시노님(synonym) : 오라클 객체의 별칭 지정
6. 프로시저 : 프로그래밍 연산 및 기능 수행
7. 함수 : 프로그래밍 연산 및 기능 수행
8. 패키지 : 관련 있는 프로시저와 함수 보관
9. 트리거 : 데이터 관련 작업의 연결 및 방지 관련 기능 제공

---

### 오라클 삭제 방법(순서)

![](https://velog.velcdn.com/images/alstjr971/post/771f0a53-9ccc-4733-9251-ce60a9d07665/image.png)

---

### 셀렉션 VS 프로젝션 VS  조인

- 셀렉션 : 행 단위 조회
- 프로젝션 : 열 단위 조회
- 조인 : 두 개 이상의 테이블을 사용하여 조회

---

# 함수

- 빌트인 함수
    - 문자열 관련
        - CONCAT, SUBSTR, TRIM, LENGTH(B), UPPER, LOWER, INITCAP, REPLACE, LPAD, RPAD,
    - 숫자 관련
        - ROUND, TRUNC, CEIL, FLOOR, MODD,
    - 날짜 관련
        - ADD_MONTHS : 몇 개월 뒤 계산
        - SYSDATE : 현재 시간 출력
        - MONTHS_BETWEEN : 두 날짜 간의 개월 수 차이
        - NEXT_DAY : 입력 날짜에서 돌아오는 요일의 날짜 반환
        - ROUND, TRUNC
    - 자료형(형 변환) 관련
        - TO_CHAR, TO_NUMBER, TO_DATE
    - NULL 관련
        - NVL : NULL이 아닌 경우 반환, NULL인 경우 지정한 데이터로 반환
        - NVL2 : NVL(’COL’, ‘REPL’) 에서 REPL이 NULL일 경우 추가적인 반환 데이터 혹은 계산식
    - 조건/선택
        - DECODE :
            
            ```sql
            SELECT EMPNO, NAME, JOB, SAL,
            	DECODE(JOB, // 검사 대상
            				'MANAGER', SAL*1.1, // COND1
            				'SALESMAN', SAL*1.5, // COND2
            				'ANALYST', SAL, // COND3
            				SAL*1.03) AS UPSAL // DEFAULT
            	FROM EMP;
            ```
            
        - CASE :
            
            ```sql
            SELECT EMPNO, ENAME, JOB, SAL
            	CASE JOB
            		WHEN 'MANAGER' THEN SAL * 1.1
            		WHEN 'SALESMAN' THEN SAL * 1.05
            		WHEN 'ANALYST' THEN SAL
            		ELSE SAL * 1.03
            	END AS UPSAL
            FROM EMP;
            ```
            
        - 모든 DECODE 함수는 CASE 문으로 변환 가능
        - CASE문은 DECODE와 달리 각 조건에 사용하는 데이터가 서로 달라도 상관 X
    
    ---
    
    # 그룹
    
    - GROUP BY 관련
        - ROLLUP, CUBE, GROUPINB SETS
        - ROLLUP
            
![](https://velog.velcdn.com/images/alstjr971/post/005e816f-5a70-4e01-a802-4db9761770a2/image.png)
            
            1. DEPTNO + JOB 별 집계
            2. DEPTNO 별 집계
            3. 전체 총합 집계
            
```sql
            /*
            ROLLUP을 사용하지 않는 경우
            */
            -- 1. DEPTNO + JOB 별 집계
            SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
            FROM EMP
            GROUP BY DEPTNO, JOB
            
            UNION ALL
            
            -- 2. DEPTNO 별 집계 (JOB 없이)
            SELECT DEPTNO, NULL AS JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
            FROM EMP
            GROUP BY DEPTNO
            
            UNION ALL
            
            -- 3. 전체 총합 집계
            SELECT NULL AS DEPTNO, NULL AS JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
            FROM EMP;
            
            /*
            ROLLUP을 사용하는 경우
            */
            
            SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
            FROM EMP
            GROUP BY ROLLUP(DEPTNO, JOB);
```
            
![](https://velog.velcdn.com/images/alstjr971/post/073f0d0e-2743-40b0-9489-9d0e574a9014/image.png)

            
- CUBE
            
![](https://velog.velcdn.com/images/alstjr971/post/442d8126-d210-4ca7-bcd8-289b1464d735/image.png)
            
- CUBE 함수는 지정한 모든 열에서 가능한 조합의 결과를 모두 출력
            
```sql
            SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
            FROM EMP
            GROUP BY CUBE(DEPTNO, JOB)
            ORDER BY DEPTNO, JOB;
```
            
![](https://velog.velcdn.com/images/alstjr971/post/072e1f9d-832a-477b-96cb-d412f2307c84/image.png)

            
        
CUBE 함수의 경우 2^N 개 조합을 출력하므로 지정한 열이 많을 수록 그 결과가 기하학적으로 증가한다.
- 이를 방지하기 위해 필요한 출력만 볼 수 있는 기능을 지원하는데, 이를 Partial Rollup/Cube 라고 한다.
        
```sql
        SELECT DEPTNO, JOB, COUNT(*(
        FROM EMP
        GROUP BY JOB, ROLLUP(DEPTNO);
```
        
- GROPUING SETS 함수
- 같은 수준의 그룹화 열이 여러 개일 때 각 열별 그룹화를 통해 결과 값을 출력하는 데 사용
        
```sql
        SELECT DEPTNO, JOB, COUNT(*)
        FROM EMP
        GROUP BY GROUPING SETS(DEPTNO, JOB)
        ORDER BY DEPTNO, JOB;
```
        
![](https://velog.velcdn.com/images/alstjr971/post/2cd59087-acfb-49ff-af70-589232bfb8f6/image.png)
        
- GROUPING
        
```sql
        SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL),
        GROUPING(DEPTNO),
        GROUPING(JOB)
        FROM EMP
        GROUP BY CUBE(DEPTNO, JOB)
        ORDER BY DEPTNO, JOB
```
        
![](https://velog.velcdn.com/images/alstjr971/post/3f3717e6-3095-4997-bbe7-5b93323d9996/image.png)

        
- `0` : GROUPING 한 함수에 지정한 열이 그룹화 되었음을 의미
- `1` : 그룹화되지 않은 데이터를 의미

- GROUPING_ID
    - 검사할 열을 하나씩 지정하는 GROUPING과 달리 한 번에 여러 열을 지정 가능
    
```sql
    SELECT DEPTNO, JOB, COUNT(*), SUM(SAL),
    	GROUPING(DEPTNO),
    	GROUPING(JOB),
    	GROUPING_ID(DEPTNO, JOB)
    FROM EMP
    GROUP BY CUBE(DEPTNO, JOB)
    ORDER BY DEPTNO, JOB;
```
    
![](https://velog.velcdn.com/images/alstjr971/post/139d2068-a8f0-4deb-b9a9-70b078f90ab4/image.png)

    
- LISTAGG
- 그룹에 속해 있는 데이터를 가로로 나열할 때 사용
    
```sql
    /*
    ENAME은 GROUP BY 절에 명시되어 있지 않아 문법 에러 발생
    */SELECT DEPTNO, ENAME
    FROM EMP
    GROUP BY DEPTNO;
    
    /*
    따라서 행을 너무 소모하지 않고 
    가로로 데이터를 출력하고 싶은 경우,
    LISTAGG WITHIN GROUP 을 사용한다.
    
    (GROUP BY DEPTNO, ENAME 은 행을 많이 소비함)
    */
    SELECT DEPTNO,
    	LISTAGG(ENAME, ', ')
    	WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
    FROM EMP
    GROUP BY DEPTNO;
```
    
- PIVOT/UNPIVOT
- 기존 테이블 행을 열(PIVOT)로 바꾸고, 열을 행으로(UNPIVOT) 바꾸는 기능
        
```sql
        SELECT DEPTNO, JOB, MAX(SAL)
        FROM EMP
        GROUP BY DEPTNO, JOB
        ORDER BY DEPTNO, JOB;
        
        SELECT *
            FROM(SELECT DEPTNO, JOB, SAL
                 FROM EMP)
            PIVOT (MAX(SAL)
                FOR DEPTNO IN (10,20,30)
                )
        ORDER BY JOB;
```
        

![](https://velog.velcdn.com/images/alstjr971/post/07de7883-9c79-483c-aa31-d66116d617b1/image.png)

![](https://velog.velcdn.com/images/alstjr971/post/d7335755-93b4-4c13-b6e4-572d49118977/image.png)

---

# 조인

- 등가 조인(내부 조인)
- 비등가 조인
    
```sql
    SELECT *
    	FROM EMP E, SALGRADE S
    	WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
```
    
- 열의 일치 여부를 기준으로 테이블을 조인할 수 없는 경우 사용

---

# 서브쿼리

1. 서브 쿼리 - WHERE 절 안에
2. 인라인 뷰 - FROM 절 안에
3. 스칼라 서브 쿼리 - SELECT 문 안에

- WITH
    - 복잡한 쿼리를 가독성 좋게 만들어줄 수 있는 도구
    - 공통 테이블 표현식(CTE, Common Table Expression) 이라고 함
    - SQL 쿼리 안에서 `가상 테이블`을 정의해놓고, 그걸 메인 쿼리에서 마치 테이블처럼 사용하는 기능
    
    ```sql
    -- WITH 없이 작성한 경우
    SELECT deptno, COUNT(*)
    FROM emp
    WHERE sal > (
        SELECT AVG(sal)
        FROM emp
    )
    GROUP BY deptno;
    
    -- WITH 사용
    WITH avg_sal AS (
        SELECT AVG(sal) AS avg_salary
        FROM emp
    )
    SELECT deptno, COUNT(*)
    FROM emp, avg_sal
    WHERE emp.sal > avg_sal.avg_salary
    GROUP BY deptno;
    ```
    
    - 다음처럼 사용할 수도 있다. SELECT 결과에 별칭 주기
    
    ```sql
    WITH
    E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
    D AS (SELECT * FROM DEPT)
    --
    SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
    FROM E10, D
    WHERE E10.DEPTNO = D.DEPTNO;
    ```
    
    ---
    

# DML

- INSERT, UPDATE, DELETE, SELECT

# DDL

- ALTER
    - ALTER TABLE EMP_ALTER `RENAME COLUMN` ‘COL1’ `TO` ‘COL2’ : 컬럼명 변경
    - ALTER TABLE EMP_ALTER `MODIFY` EMPNO NUMBER(5) : 열 자료형 변경
    - ALTER TABLE EMP_ALTER `DROP COLUMN` TEL : 특정 열 삭제
- TRUNCATE
    - 테이블의 모든 데이터 삭제
    - WHERE 절을 명시하지 않은 DELETE와 결과는 같지만, DDL 이기 때문에 롤백이 안된다는 차이점이 있고, 성능적으로 모든 데이터를 비울 때는 TRUNCATE 가 압도적으로 빠르다.

---

# 객체 종류

> 데이터 사전

오라클 데이터베이스 테이블은 `사용자 테이블`과 `데이터 사전`으로 나뉜다.

- 사용자 테이블 : 데이터베이스를 통해 관리할 데이터를 저장하는 테이블
- 데이터 사전 : 데이터베이스를 구성하고 운영하는 데 필요한 모든 정보를 저장하는 특수한 테이블

> 💡 사용자 테이블은 `Normal Table`, 데이터 사전은 `Base Table`이라고 부른다.


데이터 사전에는 데이터베이스의 메모리, 성능, 사용자 권한, 객체 등 오라클 DB 운영에 중요한 데이터들이 보관된다.

따라서 Oracle은 사용자가 데이터 사전을 직접 다룰 수 있도록 접근 권한을 허용하지 않고, `사전 뷰`를 제공해 SELECT로 조회만 가능하도록 한다.

> 데이터 사전 뷰

![](https://velog.velcdn.com/images/alstjr971/post/73522a41-3b38-438d-8977-61b9a131aa03/image.png)

> 인덱스

![](https://velog.velcdn.com/images/alstjr971/post/a02b88c1-cee3-4031-887a-ce2889322820/image.png)

```sql
// 인덱스 생성
CREATE INDEX IDX_EMP_SAL
ON EMP (SAL ASC)

// 인덱스 삭제
DROP INDEX IDX_EMP_SAL
```

> 뷰(가상 테이블)
- 하나 이상의 테이블을 조회하는 SELECT 문을 저장한 객체

목적

1. 편리성
2. 보안성

![](https://velog.velcdn.com/images/alstjr971/post/d63b9567-0b3d-4fde-bcd9-bbb094dde23e/image.png)

> 💡 SCOTT 계정은 VIEW를 생성할 권한이 없기 때문에, SYSTEM 계정으로 로그인 한 후 `GRANT CREATE VIEW TO SCOTT` 명령어로 권한을 준 뒤 작업


`ROWNUM - TOP N `
- 의사 열
- 실제 테이블에 존재하지는 않지만 특정 목적을 위해 테이블에 저장되어 있는 열처럼 사용 가능한 열

```sql
WITH E AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, E.* FROM EMP
WHERE ROWNUM >= 3;
```

> 💡 인라인 뷰를 사용한 TOP-N 추출은 활용 빈도가 높다.

`시퀀스`

![](https://velog.velcdn.com/images/alstjr971/post/f5c7bd11-0c9a-4fc2-bde3-eea4b17542dc/image.png)

`동의어(synonym)`
- 테이블, 뷰, 시퀀스 등 객체 이름 대신 사용할 수 있는 별칭 객체
- 주로 테이블 이름이 너무 길어 사용이 불편할 때 이름을 하나 더 만들어 주기 위해 사용

```sql
CREATE [PUBLIC] SYNONYM '동의어 이름'
FOR [사용자.][객체 이름];

// 예제
CREATE SYNONYM E FOR EMP;

SELECT * FROM E;
```

> 💡 동의어 생성도 권한이 필요하므로 SYSTEM 계정에 들어가서 `GRANT CREATE SYNONYM TO SCOTT` 필요


---

# 제약 조건

---

# 권한

![](https://velog.velcdn.com/images/alstjr971/post/539fa628-1a67-49e3-9063-e99e6dbeec88/image.png)

```sql
// 시스템 권한 부여 방법
GRANT [SYSTEM AUTHORITY] TO [USER_NAME] [WITH ADMIN OPTION];
 
```

- 시스템 권한 회수(취소)

```sql
REVOKE [시스템 권한] FROM [사용자 이름/롤 이름/PUBLIC];
```

`롤(ROLE)`

오라클 데이터베이스에서 어떤 작업을 수행하기 위해서는 해당 작업과 관련된 권한을 모두 부여 받아야 한다. 하지만 신규 사용자가 생길 때마다 일일이 권한을 부여하는 것은 번거롭고, 에러가 발생할 가능성이 있다.

> 💡 이러한 불편을 해결하기 위해 `ROLE` 을 사용한다. 
롤은 여러 종류의 권한을 묶어 놓은 그룹을 의미한다.


- 롤은 `사전 정의된롤`과 `사용자 정의 롤`로 나뉜다.

`사전 정의된 롤`

1. CONNECT 롤
    1. CREATE SESSION 권한만 존재(10g 부터)
2. RESOURCE 롤
    1. 사용자가 테이블, 시퀀스를 비롯한 여러 객체를 생성할 수 있는 기본 시스템 권한
    2. CREATE TRIGGER, CREATE SEQUENCE, CREATE TYPE, CREATE PROCEDURE, CREATE CLUSTER, CREATE OPERATOR, CREATE INDEXTYPE, CREATE TABLE
3. DBA롤

`사용자 정의 롤`
- 사용자 필요에 의해 직접 권한을 포함시킨 롤
- 다음 절차로 생성 후 사용 가능
    1. CREATE ROLE
    2. GRANT - 롤에 권한 포함
    3. GARNT TO - 특정 사용자에게 부여
    4. REVOKE 회수

---

# PL/SQL

> 블록
> 
- PL/SQL 프로그램의 기본 단위

구성 요소

- DECLARE (선택)
- BEGIN (필수)
- EXCEPTION (선택)
- END (필수)

```sql
DECLARE
	[변수, 상수, 커서 선언];
BEGIN
	[작업을 위해 실제 실행하는 명령어];
EXCEPTION
	[PL/SQL 수행 도중 발생하는 오류 처리];
END
```

> IF ELSE, IF-ELSIF, CASE
> 

> LOOP, WHIE LOOP, FOR LOOP, Cursor FOR LOOP
> 

![](https://velog.velcdn.com/images/alstjr971/post/77e17c3a-894a-4865-9c49-9024f9fe319e/image.png)

- EXIT, EXIT-WHEN, CONTINUE, CONTINUE-WHEN

![](https://velog.velcdn.com/images/alstjr971/post/a55e12d5-155c-4628-a32f-aae4720d5f1c/image.png)

```sql
DECLARE
	V_NUM NUMBER := 0;
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE('현재 V_NUM =' || V_NUM);
		V_NUM := V_NUM + 1;
		EXIT WHEN V_NUM > 4;
	END LOOP;
END;
/
```

---

# 레코드와 컬렉션

`코드`
- `자료형이 각기 다른` 데이터를 하나의 변수에 저장하는 데 사용

```sql
TYPE 레코드 이름 IS RECORED(
	변수 이름 자료형 NOT NULL := (또는 DEFAULT) 값 또는 값이 도출되는 여러 표현식
)
```

> 💡 C, C++의 구조체, JAVA의 클래스 개념과 유사


```sql
DECLARE
	TYPE **REC_DEPT IS RECORD(**
		deptno NUMBER(2) NOT NULL := 99,
		dname DEPT.DNAME%TYPE,
		loc DEPT.LOC%TYPE
	);
	**dept_rec REC_DEPT;**
BEGIN
	dept_rec.deptno := 99;
	dept_rec.dname := 'DATABASE';
	dept_rec.loc := 'SEOUL';
	DBMS_OUTPUT.PUT_LINE('DEPTNO: ' || dept_rec.deptno);
	DBMS_OUTPUT.PUT_LINE('DNAME: ' || dept_rec.dname);
	DBMS_OUTPUT.PUT_LINE('LOC: ' || dept_rec.loc);
END;
/
```

`컬렉션`
- 특정(동일한) 자료형의 데이터를 여러 개 저장하는 복합 자료형

- PL/SQL 에서 사용할 수 있는 컬렉션
    1. **연관 배열**
    2. 중첩 테이블
    3. VARRAY

`연관 배열 사용하기`

- 연관 배열은 인덱스라고 불리는 `key : value` 로 구성되는 컬렉션

```sql
DECLARE
	**TYPE ITAB_EX IS TABLE OF VARCHAR2(20)**
**INDEX BY PLS_INTEGER;**

	text_arr ITAB_EX;
	
BEGIN
	text_arr(1) := '1st data';
	text_arr(2) := '2nd data';
	text_arr(3) := '3rd data';
	text_arr(4) := '4th data';
	
	DBMS_OUTPUT.PUT_LINE('text_arr(1) : ' || text_arr(1));
	DBMS_OUTPUT.PUT_LINE('text_arr(2) : ' || text_arr(2));
	DBMS_OUTPUT.PUT_LINE('text_arr(3) : ' || text_arr(3));
	DBMS_OUTPUT.PUT_LINE('text_arr(4) : ' || text_arr(4));
END;
/
```

`컬렉션 메서드`
- EXISTS(n), COUNT, LIMIT, FIRST, LAST, PRIOR(n), NEXT(n), DELETE, EXTEND, TRIM

---

# 커서와 예외 처리

```sql
DECLARE
	V_DEPT_ROW DEPT_ROWTYPE;
BEGIN
	SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
		FROM DEPT
	WHERE DEPTNO = 40;
DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
DBMS_OUTPUT.PUT_LINE('DNAME: ' || V_DEPT_ROW.DNAME);
DBMS_OUTPUT.PUT_LINE('LOC: ' || V_DEPT_ROW.LOC);
END;
/
```

- SELECT INTO 문은 조회되는 데이터가 단 하나의 행일 때만 사용 가능한 방식이다.
- 조회되는 데이터가 하나일지, N개 일지 알 수 없을 때 커서를 사용한다.
    - 커서는 단일 행이든, 다중 행이든 모두 사용 가능하다.

커서는 명시적 커서와 묵시적 커서가 있다.

`명시적 커서`

```sql
DECLARE 
	CURSOR 커서 이름 IS SQL문; -- 커서 선언;
BEGIN
	OPEN 커서 이름;
	FETCH 커서 이름 INTO 변수;
	CLOSE 커서 이름;
END;
```

![](https://velog.velcdn.com/images/alstjr971/post/0aa4d1eb-4de1-4cb5-8372-8cf0f5b9698e/image.png)

단일행 데이터를 저장하는 커서 사용하기

```sql
DECLARE
-- 커서 데이터를 입력할 변수 선언
V_DEPT_ROW DEPT%ROWTYPE;

-- 명시적 커서 선언
CURSOR c1 IS
	SELECT DEPTNO, DNAME, LOC
		FROM DEPT
	WHERE DEPTNO = 40;

BEGIN
-- 커서 열기
OPEN c1;

-- 커서로부터 읽어온 데이터 사용
FETCH c1 INTO V_DEPT_ROW;

DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
DBMS_OUTPUT.PUT_LINE('DNAME: ' || V_DEPT_ROW.DNAME);
DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);

-- 커서 닫기
CLOSE c1;

END;
/
```

여러 행이 조회되는 경우 사용하는 LOOP문

```sql
DECLARE
V_DEPT_ROW DEPT%ROWTYPE;

CURSOR c1 IS
	SELECT DEPTNO, DNAME, LOC
		FROM DEPT;
BEGIN

OPEN c1;

LOOP
	FETCH c1 INTO V_DEPT_ROW;
	
	**EXIT WHEN c1%NOTFOUND;**
	
DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO
																 || ', DNAME : ' || V_DEPT_ROW.DNAME
																 || ', LOC : ' || V_DEPT_ROW.LOC);
END LOOP;

CLOSE c1;

END;
/
```

`묵시적 커서`
- 별다른 선언 없이 SQL 문을 사용했을 때 오라클에서 자동으로 선언되는 커서
- OPEN, FETCH, CLOSE를 지정하지 않음
- PL/SQL문 내부에서 DML 이나 SELECTINTO 문 등이 실행될때 자동으로 생성/처리 된다.

![](https://velog.velcdn.com/images/alstjr971/post/ebbed6c2-0f75-4957-b4c8-4c254743b540/image.png)

---

# 예외

![](https://velog.velcdn.com/images/alstjr971/post/345f10d0-25ed-4e84-ae10-6ed000b9620b/image.png)

```sql
DECLARE
	v_wrong NUMBER;
BEGIN
	SELECT DNAME INTO v_wrong
		FROM DEPT
	WHERE DEPTNO = 10;
	
	DBMS_OUTPUT.PUT_LINE('예외 발생 시 아래 문장 실행 X');
	
EXCEPTION
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('예외 처리 : 요구보다 많은 행 추출 오류 발생');
	WHEN VALUE_ERROR THEN
		DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생');
END;
/
		
```

사용자 정의 예외 사용

```sql
DECLARE
	사용자 예외 이름 EXCEPTION;
	
BEGIN
	IF 조건 THEN
		***RAISE*** 사용자 예외 이름
	END IF;
EXCEPTION
	WHEN 사용자 예외 이름 THEN
		예외 처리 명령어 ..;
END;
```

---

# 저장 서브프로그램

`프로시저, 함수, 패키지, 트리거`
1. 프로시저
    1. 일반적으로 특정 처리 작업 수행을 위한 서브프로그램으로, SQL문에서 사용 불가
2. 함수
    1. 일반적으로 특정 연산을 거친 결과 값을 반환하는 서브프로그램으로 SQL문에서 사용 가능
3. 패키지
    1. 프로시저, 함수, 트리거 등 서브프로그램을 그룹화한 것
4. 트리거
    1. 특정 이벤트가 발생했을 때 자동으로 연달아 수행할 기능을 정의(구현)한 것

`프로시저 생성`

```sql
CREATE [OR REPLACE] PROCEDURE 프로시저 이름
IS | AS
	선언부
BEGIN
	실행부
EXCEPTION
	예외 처리부
END [프로시저 이름];
```

```sql
CREATE OR REPLACE PROCEDURE pro_noparam
IS
	V_EMPNO NUMBER(4) := 7788;
	V_ENAME VARCHAR2(10);
BEGIN
	V_ENAME := 'SCOTT';
	DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
	DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);
END;
/
```

- 파라미터가 있는 프로시저 (IN)

```sql
CREATE OR REPLACE PROCEDURE pro_param_in
(
	param1 IN NUMBER,
	param2 IN NUMBER,
	param3 NUMBER := 3,
	param4 NUMBER DEFAULT 4
)
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE('param1: ' || param1);
	DBMS_OUTPUT.PUT_LINE('param2: ' || param2);
	DBMS_OUTPUT.PUT_LINE('param3: ' || param3);
	DBMS_OUTPUT.PUT_LINE('param4: ' || param4);
END;
/
```

- 파라미터가 있는 프로시저 (OUT)

```sql
CREATE OR REPLACE PROCEDURE pro_param_out
(
	in_empno IN EMP.EMPNO%TYPE,
	out_ename OUT EMP.ENAME%TYPE,
	out_sal OUT EMP.SAL%TYPE
)
IS
BEGIN
	SELECT ENAME, SAL INTO out_ename, out_sal
	FROM EMP
	WHERE EMPNO = in_empno;
END pro_param_out;
/
```

OUT 모드 파라미터 전달 받기

```sql
DECLARE
	v_ename EMP.ENAME%TYPE;
	v_sal EMP.SAL%TYPE;
	
BEGIN
	pro_param_out(7788, v_ename, v_sal);
	DBMS_OUTPUT.PUT_LINE('ENAME : ' || v_ename);
	DBMS_OUTPUT.PUT_LINE('SAL : ' || v_sal);
END;
/
	
```

- 파라미터가 있는 프로시저 (IN-OUT)

```sql
CREATE OR REPLACE PROCEDURE pro_param_inout
(
	inout_no IN OUT NUMBER
)
IS

BEGIN
	inout_no := inout_no * 2;
END pro_param_inout;
/
```

```sql
DECLARE
	no NUMBER;
BEGIN
	no := 5;
	pro_param_inout(no);
	DBMS_OUTPUT.PUT_LINE('no : ' || no);
END;
/

// 결과 화면
no : 10
```

> 함수
> 

- 프로시저와 함수의 차이점

| 특징 | 프로시저 | 함수 |
| --- | --- | --- |
| 실행 | EXECUTE 명령어 또는 다른 PL/SQL 서브프로그램 내에서 호출하여 실행 | 변수를 사용한 EXECUTE 명령어 또는 다른 PL/SQL 서브프로그램에서 호출하여 실행하거나 SQL문에서 직접 실행 가능 |
| 파라미터 지정 | IN, OUT, IN OUT 세 가지 모드 | IN |
| 값이 반환 | OUT, IN OUT | RETURN |

```sql
CREATE OR REPLACE FUNCTION func_aftertax(
       sal IN NUMBER
)
RETURN NUMBER
IS
       tax NUMBER := 0.05;
BEGIN
    RETURN (ROUND(sal - (sal * tax)));
END func_aftertax;
/
```

- 이를 PL/SQL 에서 사용하기

```sql
// PL
DECLARE
	aftertax NUMBER;
BEGIN
	aftertax := func_aftertax(3000);
	DBMS_OUTPUT.PUT_LINE('after-tax income : ' || aftertax);
END;
/

// SQL
SELECT func_aftertax(3000) FROM DUAL;
```

> 패키지
> 
- 패키지는 프로시저, 함수와 달리 두 부분으로 나누어 제작한다.
- 하나는 `명세`, 다른 하나는 `본문` 이라고 부른다.

1. 패키지 명세

```sql
CREATE OR REPLACE PACKAGE pkg_example
IS
	spec_no NUMBER := 10
	FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER;
	PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
	PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE);
END;
	/
```

1. 패키지 본문

```sql
CREATE OR REPLACE PACKAGE BODY pkg_example
IS
   body_no NUMBER := 10;

   FUNCTION func_aftertax(sal NUMBER) RETURN NUMBER
      IS
         tax NUMBER := 0.05;
      BEGIN
         RETURN (ROUND(sal - (sal * tax)));
   END func_aftertax;

   PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE)
      IS
         out_ename EMP.ENAME%TYPE;
         out_sal EMP.SAL%TYPE;
      BEGIN
         SELECT ENAME, SAL INTO out_ename, out_sal
           FROM EMP
          WHERE EMPNO = in_empno;

         DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
         DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
   END pro_emp;

PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE)
   IS
      out_dname DEPT.DNAME%TYPE;
      out_loc DEPT.LOC%TYPE;
   BEGIN
      SELECT DNAME, LOC INTO out_dname, out_loc
        FROM DEPT
       WHERE DEPTNO = in_deptno;

      DBMS_OUTPUT.PUT_LINE('DNAME : ' || out_dname);
      DBMS_OUTPUT.PUT_LINE('LOC : ' || out_loc);
   END pro_dept;
END;
/
```

- 패키지 본문에는 패키지 명세에 선언한 서브프로그램 코드를 작성한다.
- 패키지 명세에 선언하지 않은 객체나 서브프로그램을 정의/사용 할 수도 있다.
- 이때 패키지 본문에만 존재하는 프로그램은 패키지 내부에서만 사용 가능하다.
    - 즉, 지역 변수처럼 사용됨
- 패키지 본문 이름은 패키지 명세 이름과 같게 해야한다.

> 서브프로그램 오버로드
> 

입력 데이터를 각각 다르게 정의해야 할 때, 서브프로그램(프로시저)를 오버로딩할 수 있다.

---

# 트리거

- DML BEFORE

```sql
CREATE OR REPLACE TRIGGER trg_emp_nodml_weekend
BEFORE
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
	IF TO_CHAR(sysdate, 'DY') IN ('토', '일') THEN
		IF INSERTING THEN
			raise_application_error(-20000, '주말 사원정보 추가 불가');
		ELSIF UPDATING THEN
			raise_application_error(-20001, '주말 사원정보 수정 불가');
		ELSIF DELETING THEN
			raise_application-error(-20002, '주말 사원정보 삭제 불가');
		ELSE
			raise_application-error(-20003, '주말 사원정보 변경 불가');
		 END IF;
	 END IF;
END;
/
```

- DML AFTER

```sql
CREATE OR REPLACE TRIGGER trg_emp_log
AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW

BEGIN

   IF INSERTING THEN
      INSERT INTO emp_trg_log
      VALUES ('EMP_TRG', 'INSERT', :new.empno,
               SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);

   ELSIF UPDATING THEN
      INSERT INTO emp_trg_log
      VALUES ('EMP_TRG', 'UPDATE', :old.empno,
               SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);

   ELSIF DELETING THEN
      INSERT INTO emp_trg_log
      VALUES ('EMP_TRG', 'DELETE', :old.empno,
               SYS_CONTEXT('USERENV', 'SESSION_USER'), sysdate);
   END IF;
END;
/
```
