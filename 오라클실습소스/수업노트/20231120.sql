/* Formatted on 2023/11/20 오후 2:01:39 (QP5 v5.215.12089.38647) */
CREATE TABLE TEMP (
 EMP_ID      NUMBER NOT NULL PRIMARY KEY,
 EMP_NAME    VARCHAR2(10) NOT NULL,
 BIRTH_DATE  DATE,
 DEPT_CODE   VARCHAR2(06) NOT NULL,
 EMP_TYPE    VARCHAR2(04),
 USE_YN      VARCHAR2(01) NOT NULL,
 TEL         VARCHAR2(15),
 HOBBY       VARCHAR2(30),
 SALARY      NUMBER,
 LEV         VARCHAR2(04)
);

CREATE TABLE TDEPT (
 DEPT_CODE   VARCHAR2(06) NOT NULL PRIMARY KEY,
 DEPT_NAME   VARCHAR2(20) NOT NULL,
 PARENT_DEPT VARCHAR2(06) NOT NULL,
 USE_YN      VARCHAR2(01) NOT NULL,
 AREA        VARCHAR2(10),
 BOSS_ID     NUMBER
);


SELECT * FROM temp;

SELECT * FROM tdept;

--테이블 acess하지 않고도 조회가 된다.
--empno는 pk이기 때문에 인덱스를 기본제공 -> 빠르게 조회
--옵티마이저는 조건 만족 정보 직접 찾아옴.

SELECT empno FROM emp;

  SELECT ename
    FROM emp
ORDER BY ename DESC;

SELECT empno, ROWID rid FROM emp;

SELECT ename
  FROM emp
 WHERE ROWID = 'AAARE8AAEAAAACTAAA';

  SELECT *
    FROM emp
ORDER BY ename DESC;

SELECT dname
FROM emp, dept;

DELETE FROM dept WHERE deptno IN(60);
COMMIT;

SELECT * FROM dept;

ROLLBACK;

--조인의 예시(cross join - 카타시안의 곱 - 총합, 소계 구할 때 사용)
--emp 14row, dept 4row -> 56개의 값이 나옴. 
--왜 복제하나?? 하나의 같은 값이 총계, 소계, 중계 등 여러번 사용되어야 하기 때문이다. .
SELECT 
            dept.dname, emp.deptno, dept.deptno
FROM emp, dept;

--쓰레기값도 포함되어 있다.  이걸 제거하려면??  natural join 
--where를 통해  1:n의 관계에서 deptno가 외래키로 들어가 있을 때 그 두개의 값이 같은 유의미한 값만 가져오도록
--유의미한 14개의 값이 나옴. 
SELECT 
            dept.dname, emp.deptno, dept.deptno
FROM emp, dept
WHERE emp. deptno = dept.deptno;

SELECT max(sal), min(sal), avg(sal), round((avg(sal)),1) FROM emp;

SELECT ename FROM emp;

--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
SELECT max(sal), min(sal), avg(sal), round((avg(sal)),1), ename FROM emp;


SELECT floor(-4.6) FROM dual;
INSERT INTO TEMP VALUES (19970101,'김길동',TO_DATE('19740125','YYYYMMDD'),'AA0001','정규','Y','','등산',100000000,'부장');
INSERT INTO TEMP VALUES (19960101,'홍길동',TO_DATE('19730322','YYYYMMDD'),'AB0001','정규','Y','','낚시',72000000,'과장');
INSERT INTO TEMP VALUES (19970201,'박문수',TO_DATE('19750415','YYYYMMDD'),'AC0001','정규','Y','','바둑',50000000,'과장');
INSERT INTO TEMP VALUES (19930331,'정도령',TO_DATE('19760525','YYYYMMDD'),'BA0001','정규','Y','','노래',70000000,'차장');
INSERT INTO TEMP VALUES (19950303,'이순신',TO_DATE('19730615','YYYYMMDD'),'BB0001','정규','Y','','',56000000,'대리');
INSERT INTO TEMP VALUES (19966102,'지문덕',TO_DATE('19720705','YYYYMMDD'),'BC0001','정규','Y','','',45000000,'과장');
INSERT INTO TEMP VALUES (19930402,'강감찬',TO_DATE('19720815','YYYYMMDD'),'CA0001','정규','Y','','',64000000,'차장');
INSERT INTO TEMP VALUES (19960303,'설까치',TO_DATE('19710925','YYYYMMDD'),'CB0001','정규','Y','','',35000000,'사원');
INSERT INTO TEMP VALUES (19970112,'연흥부',TO_DATE('19761105','YYYYMMDD'),'CC0001','정규','Y','','',45000000,'대리');
INSERT INTO TEMP VALUES (19960212,'배뱅이',TO_DATE('19721215','YYYYMMDD'),'CD0001','정규','Y','','',39000000,'과장');
--
INSERT INTO TDEPT VALUES ('AA0001','경영지원','AA0001','Y','서울',19940101);
INSERT INTO TDEPT VALUES ('AB0001','재무','AA0001','Y','서울',19960101);
INSERT INTO TDEPT VALUES ('AC0001','총무','AA0001','Y','서울',19970201);
INSERT INTO TDEPT VALUES ('BA0001','기술지원','BA0001','Y','인천',19930301);
INSERT INTO TDEPT VALUES ('BB0001','H/W지원','BA0001','Y','인천',19950303);
INSERT INTO TDEPT VALUES ('BC0001','S/W지원','BA0001','Y','인천',19966102);
INSERT INTO TDEPT VALUES ('CA0001','영업','CA0001','Y','본사',19930402);
INSERT INTO TDEPT VALUES ('CB0001','영업기획','CA0001','Y','본사',19950103);
INSERT INTO TDEPT VALUES ('CC0001','영업1','CA0001','Y','본사',19970112);
INSERT INTO TDEPT VALUES ('CD0001','영업2','CA0001','Y','본사',19960212);

COMMIT;

SELECT salary FROM temp;

SELECT salary/18, salary*2/18 FROM temp;

SELECT salary/9 FROM temp;

--1.월 급여는 연봉을 18로 나누어 홀수 달에는 연봉의 1/18이 지급되고, 
--짝수달에는 연봉의 2/18가 지급된다고 가정했을 때 홀수 달과 짝수 달에 받을 금액을 나타내시오.

SELECT salary/18 AS "짝수 급여", salary*2/18 AS "홀수 달 급여" FROM temp;

--1-1월급여 오름, 내림차순으로 정렬
SELECT to_char((salary), '999,999,999')||'원' AS "sal(ASC)" 
FROM temp 
ORDER BY salary ASC;

SELECT to_char((salary), '999,999,999')||'원' AS "sal(DESC)" 
FROM temp 
ORDER BY salary desc;


--2.위에서 구한 월 급여에 교통비가 10만원씩 지급된다면(짝수달은 20만원)위의 문장이
--어떻게 바뀔지 작성해 보시오.

SELECT (salary/18)+100000 AS "짝수 급여", (salary*2/18)+200000 AS "홀수 달 급여" FROM temp;

SELECT to_Char( ((salary/18)+100000),'999,999,999')||'원' AS "짝수 급여", to_char(((salary*2/18)+200000),'999,999,999')||'원' AS "홀수 달 급여" FROM temp;

SELECT sysdate, To_char(sysdate,'YYYY-MM-DD')
    ,to_char(sysdate, 'YYYY-MM-DD HH24:mi:ss am')
    ,to_char(sysdate, 'YYYY-MM-DD HH:mi:ss am')
    ,to_char(sysdate, 'day')
FROM dual;

SELECT round(12345.6789,1), round(12345.6789,-1), round(12345.6789,0) FROM dual;

--3.TEMP 테이블에서 취미가 NULL 이 아닌 사람의 성명을 읽어오시오. -> 4개
SELECT emp_name, hobby 
FROM temp 
WHERE hobby IS NOT NULL;

SELECT emp_name, hobby
FROM temp
MINUS
SELECT emp_name, hobby
FROM temp
WHERE hobby IS NULL;

--3-0  -> 6개
SELECT emp_name, hobby
FROM temp
WHERE hobby IS NULL;

SELECT emp_name,hobby FROM temp WHERE hobby IS NULL
UNION ALL 
SELECT emp_name,hobby FROM temp WHERE hobby IS NOT NULL;

SELECT emp_name,hobby FROM temp WHERE hobby IS NULL
UNION 
SELECT emp_name,hobby FROM temp WHERE hobby IS NOT NULL;

SELECT emp_name,hobby FROM temp WHERE hobby IS NOT NULL
MINUS
SELECT emp_name,hobby FROM temp WHERE hobby = '등산'
ORDER BY emp_name ASC;

--3-1.등산이나 낚시 취미를 가진 직원 이름 가져오기 in 구문 사용하기 
SELECT emp_name, hobby  
FROM temp
WHERE hobby IN('등산', '낚시');

SELECT emp_name, hobby  
FROM temp
WHERE hobby ='등산'
     OR hobby = '낚시';


--3-2.hobby가 null 또는 등산인 경우, 구하시오 
SELECT emp_name, hobby  
FROM temp
WHERE hobby IS NULL 
     OR hobby = '등산';
     
--3-3.hobby가 null 또는 '낚시' 모두에 속하지 않는 경우
SELECT emp_name, hobby
FROM temp
MINUS
SELECT emp_name, hobby
FROM temp
WHERE hobby IS NULL 
     OR hobby = '낚시';

SELECT emp_name, hobby
FROM temp
WHERE hobby IS NOT NULL
MINUS
SELECT emp_name, hobby
FROM temp
WHERE hobby = '낚시';

SELECT emp_name, hobby
FROM temp
WHERE hobby IS NOT NULL
   AND hobby NOT IN('낚시');

--4.TEMP 테이블에서 취미가 NULL인 사람은 모두 HOBBY를 “없음”이라고 값을 치환하여 가져오고 
--나머지는 그대로 값을 읽어오시오.

SELECT emp_name, NVL(hobby,'없음') AS "취미" 
FROM temp;

--빈자리 0으로 치환하기
SELECT ename, comm, nvl(comm,0) FROM emp;

--5.TEMP의 자료 중 HOBBY의 값이 NULL인 사원을 ‘등산’으로 치환했을 때 
--HOBBY가 ‘등산인 사람의 성명을 가져오는 문장을 작성하시오.

SELECT emp_name, 취미
FROM (SELECT emp_name, NVL(hobby,'등산') AS 취미 FROM temp)
WHERE 취미 = '등산';

SELECT emp_name, NVL(hobby,'등산') AS hobby FROM temp;

SELECT emp_name FROM temp
WHERE nvl(hobby,'등산') = '등산';

--6.TEMP의 자료 중 EMP_ID와 EMP_NAME을 각각 ‘사번’,’성명’으로 표시되어 
--DISPLAY되도록 COLUMN ALLIAS를 부여하여 SELECT 하시오.


SELECT to_char(emp_id)||'번' AS "사번", emp_name AS "성명"
FROM temp;

--7.TEMP의 자료를 직급 명(LEV)에 ASCENDING(오름)하면서 결과내에서 다시 사번(EMP_NAME) 순으로
--DESCENDING(내림)하게 하는 ORDER BY하는 문장을 만들어 보시오.

SELECT lev, emp_name
FROM temp
ORDER BY emp_name desc;