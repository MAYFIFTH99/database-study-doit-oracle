-- 1.
SELECT *
    FROM EMP
     WHERE DEPTNO = 30;

-- 5-3
SELECT *
    FROM EMP
    WHERE EMPNO <> 399;

-- 5-4
SELECT ENAME, SAL, SAL*12+COMM AS ANNSAL, COMM
FROM EMP;

-- 5-26
SELECT *
FROM EMP
WHERE COMM IS NULL;


-- 5-30
SELECT EMPNO,
       ENAME,
       SAL,
       DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT EMPNO,
       ENAME,
       SAL,
       DEPTNO
FROM EMP
WHERE DEPTNO = 20


-- 1.

SELECT *
FROM EMP
WHERE ENAME LIKE '%S';

-- 2.
SELECT EMPNO,
       ENAME,
       JOB,
       SAL,
       DEPTNO
FROM EMP
WHERE DEPTNO=30 AND JOB='SALESMAN';

-- 5-1.
SELECT
    EMPNO, ENAME, SAL, DEPTNO
FROM
    EMP
WHERE
    DEPTNO IN (20, 30)
AND
    SAL > 2000

-- 5-2.
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20
AND SAL > 2000
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL > 2000 AND DEPTNO= 30;

-- 5-4.
SELECT *
FROM EMP
WHERE SAL < 2000 OR SAL > 3000;

-- 5-5.
SELECT ENAME, EMPNO, SAL, DEPTNO
FROM EMP
WHERE
    SAL NOT BETWEEN 1000 AND 2000
AND
    ENAME LIKE '%E%'
AND
    DEPTNO = 30;

-- 5-6.
SELECT * FROM EMP
WHERE (COMM IS NULL OR COMM =0)
AND
   ENAME NOT LIKE '_L%'
AND
    MGR IS NOT NULL
AND
    JOB IN ('MANAGER', 'CLERK');

