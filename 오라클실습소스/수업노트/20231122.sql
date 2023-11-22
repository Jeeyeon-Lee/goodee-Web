/* Formatted on 2023/11/22 오전 11:04:11 (QP5 v5.215.12089.38647) */
--정렬이 된 이유
--둘의 실행계획 차이를 확인할 줄 알아야 한다.

SELECT empno FROM emp;

--empno의 경우, PK키이며 인덱스 값을 가진다.
--INDEX란? SQL 검색 속도를 높이기 위해 사용하는 기술 중 하나이다.
--https://m.blog.naver.com/dnjswls23/222026710074

SELECT empno, ename FROM emp;

SELECT /*+ALL ROWS */
       empno FROM emp;

SELECT /*+ index_desc(emp pk_emp) */
       empno FROM emp;

--카타시안의 곱 발생 쓰레기값 발생

SELECT empno, ename, dept.dname
  FROM emp, dept;

--조건을 넣어 해당하는 값만 조회 가능

SELECT empno, ename, dept.dname
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;



--rule base 비용에 따른 실행계획 설정(Nested Loop사용)-> 8밀리초

SELECT /*+ rule */
      *
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;

--구문입력한대로 Hash Join 사용 -> 13밀리초

SELECT *
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;

--rowid 각 행별 id값 조회, 확인 가능

SELECT ROWID rid, ename FROM emp;

SELECT ROWNUM rno, ename FROM emp;

--rownum 가상의 순서대로의 번호 생성

SELECT ROWNUM rno, empno, ename
  FROM (  SELECT empno, ename
            FROM emp
        ORDER BY hiredate);

SELECT MAX (sal),
       MIN (sal),
       COUNT (sal),
       SUM (sal),
       AVG (sal)
  FROM emp;

--단일그룹의 그룹함수가 아니어서 값 x

SELECT MAX (sal), ename FROM emp;

--1번 해결방법. max는 단지 문법적 문제를 피하기 위함 or Group By로 해결???
--유효하지 않은 값이기 때문에 사용시 유의

SELECT MAX (sal), MAX (ename) FROM emp;

--2번 해결방법.

  SELECT MAX (sal), ename
    FROM emp
GROUP BY ename;

SELECT DISTINCT (deptno) FROM emp;

  SELECT deptno
    FROM emp
GROUP BY deptno;

SELECT DECODE (MOD (seq_vc, 2), 1, words_vc, '0') eng_words FROM t_letitbe;

SELECT dname FROM emp;

SELECT DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words
  FROM t_letitbe
 WHERE eng_words = 1;

--별칭을 굳이 조건절에서 사용하고 싶다면 인라인뷰를 사용하시오.

SELECT eng_words
  FROM (SELECT DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words FROM t_letitbe);

SELECT num, eng_words
  FROM (SELECT MOD (seq_vc, 2) num,
               DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words
          FROM t_letitbe)
 WHERE num = 1;

 
 SELECT *
  FROM (SELECT 
                     seq_vc
                     ,DECODE (MOD (seq_vc, 2), 1, words_vc) A
          FROM t_letitbe
           UNION ALL
           SELECT 
                     seq_vc
                     ,DECODE (MOD (seq_vc, 2), 0, words_vc) A
          FROM t_letitbe
          )
GROUP BY seq_vc;

SELECT loc FROM dept
UNION ALL
SELECT dname FROM dept;


SELECT decode(JOB,'CLERK',sal,NULL) FROM emp;

SELECT decode(JOB,'CLERK',sal,NULL) AS "CLERK" FROM emp GROUP BY decode(JOB,'CLERK',sal,NULL);

--decode sum과 함께 많이 쓰임(소계, 총계 등) 
SELECT 
        sum(decode(JOB,'CLERK',sal,NULL)) AS "CLERK" 
        ,sum(decode(JOB,'SALESMAN',sal,NULL)) AS "SALESMAN" 
        ,sum(decode(JOB,'CLERK',NULL,'SALESMAN',NULL,sal)) AS "ETC" 
FROM emp;

SELECT dname
        ,sum(decode(JOB,'CLERK',sal,NULL)) AS "CLERK" 
        ,sum(decode(JOB,'SALESMAN',sal,NULL)) AS "SALESMAN" 
        ,sum(decode(JOB,'CLERK',NULL,'SALESMAN',NULL,sal)) AS "ETC" 
FROM emp, dept
GROUP BY dname;

SELECT dname, CLERK, SALESMAN, ETC        
FROM dept,(
            SELECT
                    ,sum(decode(JOB,'CLERK',sal,NULL)) AS "CLERK" 
                    ,sum(decode(JOB,'SALESMAN',sal,NULL)) AS "SALESMAN" 
                    ,sum(decode(JOB,'CLERK',NULL,'SALESMAN',NULL,sal)) AS "ETC" 
         )
GROUP BY dname;


--having절

SELECT 
        deptno, sum(sal), count(sal), max(sal), min(sal)
FROM emp
GROUP BY deptno;

SELECT greatest(1,5,3) AS "최대", least(1,5,3) AS "최소" FROM dual;

SELECT deptno, 
       CASE deptno
         WHEN 10 THEN 'ACCOUNTING'
         WHEN 20 THEN 'RESEARCH'
         WHEN 30 THEN 'SALES'
         ELSE 'OPERATIONS'
       END AS "Dept Name"
  FROM dept;
 
DEPTNO Dept NAME

--temp의 자료를 salary로 분류하여 30,000,000이하는 'D',
--30,000,000 초과 50,000,000이하는 'C'
--50,000,000 초과 70,000,000이하는 'B'
--70,000,000 초과는 'A'라고 등급을 분류하여 등급별 인원수를 알고 싶다.

SELECT count(등급)
 FROM (
            SELECT
            CASE salary
                WHEN salary > 70000000 THEN 'A'
                WHEN salary BETWEEN 50000001 AND 70000000 THEN 'B'
                WHEN salary BETWEEN 30000001 AND 50000000 THEN 'C'
                ELSE 'D'
                END AS "등급"
             FROM temp
             );


SELECT 등급,count(등급) AS "갯수" 
FROM(SELECT
            CASE 
                WHEN salary > 70000000 THEN 'A'
                WHEN salary BETWEEN 50000001 AND 70000000 THEN 'B'
                WHEN salary BETWEEN 30000001 AND 50000000 THEN 'C'
                ELSE 'D'
            END AS "등급"
        FROM temp
        )
GROUP BY 등급
ORDER BY 등급;

SELECT  
            count(CASE WHEN salary > 70000000 THEN 'A' END) AS "A"
            ,count(CASE WHEN salary BETWEEN 50000001 AND 70000000 THEN 'B' END) AS "B"
            ,count(CASE WHEN salary BETWEEN 30000001 AND 50000000 THEN 'C' END) AS "C"
            ,count(CASE WHEN salary<=30000000 THEN 'D' END) AS "D"
FROM temp;


SELECT deptno, 
       CASE deptno
         WHEN 10 THEN 'ACCOUNTING'
         WHEN 20 THEN 'RESEARCH'
         WHEN 30 THEN 'SALES'
         ELSE 'OPERATIONS'
       END AS "Dept Name"
  FROM dept;
 
--날짜별 판매개수, 판매가격 

SELECT 판매날짜, 판매개수
FROM (SELECT indate_vc AS "판매날짜"
             CASE 
                WHEN 판매날짜='20040601' THEN sum(qty_nu)
                WHEN 판매날짜='20040602' THEN sum(qty_nu)
                WHEN 판매날짜='20040603' THEN sum(qty_nu)                
                END AS "판매개수"
                FROM t_orderbasket             
        )
GROUP BY 판매날짜;

SELECT indate_vc AS "판매날짜" FROM t_orderbasket; 

SELECT indate_vc AS "판매날짜" FROM t_orderbasket
GROUP BY indate_vc;    

SELECT indate_vc AS "판매날짜" FROM t_orderbasket,
(SELECT ROWNUM rno FROM dept WHERE ROWNUM <3);

SELECT decode(b.rno,1,indate_vc,2,'총계') AS "판매날짜" 
FROM t_orderbasket,
        (SELECT ROWNUM rno 
        FROM dept 
        WHERE ROWNUM <3)b
GROUP BY decode(b.rno,1,indate_vc,2,'총계')
ORDER BY 판매날짜;