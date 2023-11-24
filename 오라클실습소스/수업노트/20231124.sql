/* Formatted on 2023/11/24 오전 9:09:33 (QP5 v5.215.12089.38647) */
SELECT 컬럼명 ...함수명(컬럼명)
FROM  집합...(SELECT 문-인라인뷰)
WHERE 컬럼명 = 값(상수,SELECT 문-서브쿼리)
NOT    컬럼명=값
AND    컬럼명=값 (SELECT 문)
*[OR     컬럼명=값(합집합 -> 경우의 수, 일 양 증가->사용 지양)]
GROUP BY
[[HAVING]]
ORDER BY

*데이터타입에서 고정형 char타입(hello___) 대신 varchar2(hello) 사용을 많이하는 이유와 동일(일의 양)

SELECT count(ename),max(empno),sum(sal)
FROM emp;

SELECT ename, sum(sal)
FROM emp
GROUP BY ename;

SELECT deptno, count(deptno), sum(sal)
FROM emp
WHERE to_char(hiredate,'YYYY') =: xxxx 
GROUP BY deptno
ORDER BY deptno;

--부서, 직책별 그룹
SELECT deptno AS "부서", JOB, count(JOB) AS "부서|직책 인원", sum(sal) AS "급여 합계"
FROM emp
GROUP BY deptno, JOB
ORDER BY deptno;

SELECT decode(JOB,'CLERK', sal, NULL)
FROM emp;

SELECT sum(decode(JOB,'CLERK', sal, NULL)) clerk_sal
         ,count(decode(JOB,'CLERK', sal, NULL)) clerk_count
FROM emp;

--한 행에 세 명씩 20명
SELECT *
FROM temp;

--1)줄 세우기
SELECT ROWNUM rno
FROM temp;

--2)이름 넣기
SELECT ROWNUM rno, emp_name
FROM temp;

--3-1)1,2,3이 모두 출력되도록 한다 왜?? 이름 3개씩 한 줄에 출력할거니까
--y축 만들기 ceil로 3으로 나눠서 높은수로 가게 함-> 3개로 나눠줌 
SELECT
        RNO, CEIL(rno/3) cno
FROM (
         SELECT ROWNUM rno FROM temp
        );
        
--3-1)
--mod로 나머지 숫자들을 찍히게 하여 두번째 좌표 만들기         
SELECT
        RNO, CEIL(rno/3) cno, mod(rno,3) mno
FROM (
         SELECT ROWNUM rno FROM temp
        );
        
--4)emp_name 넣어보기
SELECT
        RNO, CEIL(rno/3) cno, mod(rno,3) mno, emp_name
FROM (
         SELECT ROWNUM rno, emp_name FROM temp
        );
        
--5)그룹핑  1       
SELECT
        CEIL(rno/3) cno
FROM (
         SELECT ROWNUM rno, emp_name FROM temp
        )
GROUP BY ceil(rno/3)
ORDER BY cno;

--6)무작정 이름 넣어보기
SELECT '김길동','홍길동','박문수' FROM dual
UNION ALL
SELECT '정도령','이순신','지문덕' FROM dual

decode(mod(rno,3),1,'김길동')

--7)decode 넣어보기(단, 그룹해서)
SELECT
        CEIL(rno/3) cno
        ,max(decode(mod(rno,3),1,mod(rno,3)))
        ,max(decode(mod(rno,3),2,mod(rno,3)))
        ,max(decode(mod(rno,3),0,mod(rno,3)))
FROM (
         SELECT ROWNUM rno, emp_name FROM temp
        )
GROUP BY  CEIL(rno/3)
ORDER BY cno;

--8)계단식으로 만들어보기(이해했는지 확인용)
SELECT
        CEIL(rno/3) cno
        ,decode(mod(rno,3),1,emp_name) A
        ,decode(mod(rno,3),2,emp_name) b
        ,decode(mod(rno,3),0,emp_name) c
FROM (
         SELECT ROWNUM rno, emp_name FROM temp
        );

--9)그룹바이 -> 빈 값이 합쳐지며 하나의 테이블로 완성됨 (앞 단계에 대한 이해 바탕 필요)
SELECT
        CEIL(rno/3) cno
        ,max(decode(mod(rno,3),1,emp_id))||'-'||max(decode(mod(rno,3),1,emp_name)) A
        ,max(decode(mod(rno,3),2,emp_id))||'-'||max(decode(mod(rno,3),2,emp_name)) b
        ,max(decode(mod(rno,3),0,emp_id))||'-'||max(decode(mod(rno,3),0,emp_name)) c
FROM (
         SELECT ROWNUM rno, emp_name, emp_id FROM temp
        )
GROUP BY  CEIL(rno/3)
ORDER BY cno;

--10)5명씩 나열하고 싶다면/? 
SELECT
        CEIL(rno/5) cno
        ,max(decode(mod(rno,5),1,emp_id))||'-'||max(decode(mod(rno,5),1,emp_name)) A
        ,max(decode(mod(rno,5),2,emp_id))||'-'||max(decode(mod(rno,5),2,emp_name)) b
        ,max(decode(mod(rno,5),3,emp_id))||'-'||max(decode(mod(rno,5),3,emp_name)) c
        ,max(decode(mod(rno,5),4,emp_id))||'-'||max(decode(mod(rno,5),4,emp_name)) d
        ,max(decode(mod(rno,5),0,emp_id))||'-'||max(decode(mod(rno,5),0,emp_name)) E
FROM (
         SELECT ROWNUM rno, emp_name, emp_id FROM temp
        )
GROUP BY  CEIL(rno/5)
ORDER BY cno;

--- NATURAL JOIN(=equal JOIN) : 양 쪽에 모두 있는 값

--from에 넣을 경우, 결과는 조회 가능 but 카타시안의 곱 (10, 1624,56)
SELECT empno, ename, dname
FROM emp, dept;

--조건넣어서 출력(hash join) (7,770,14)
SELECT empno, ename, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--조건넣어서 출력(hash join) (7,770,14)
SELECT empno, ename, dname
FROM emp A JOIN dept b
ON A.deptno = b.deptno;

--natural join 
SELECT empno, ename, dname
FROM emp NATURAL JOIN dept;

--- non-equal JOIN : 같다로 비교하는 것 외 모든 값

--3.temp와 emp_level을 이용해 emp_level의 과장 직급의 연봉 상한/하한 범위 내에
--드는 직원의 사번과, 성명, 직급, salary를 읽어보자.

--전체조회
SELECT *
FROM temp A, emp_level b;

--카타시안 100건(20 * 5) 
SELECT A.emp_id, emp_name, b.lev, salary
FROM temp A, emp_level b;

--과장만 20건
SELECT A.emp_id, emp_name, b.lev
FROM temp A, emp_level b
WHERE b.lev = '과장';

--선생님 답
SELECT A.emp_id, emp_name, b.lev
FROM temp A, emp_level b
WHERE b.lev = '과장'
AND A.salary BETWEEN from_sal AND to_sal;

--지연 해답(서브쿼리로 해결하려고 함)
SELECT emp_id, emp_name, A.lev, salary
FROM temp
        ,(
        SELECT from_sal,to_sal, lev
        FROM emp_level 
        WHERE lev = '과장'
        )A
WHERE salary BETWEEN from_sal AND to_sal;

--tcom의 work_year = '2001'인 자료와 temp를 사번으로 연결해서 join한 후
--comm을 받는 직원의 성명, salary + COMM을 조회해 보시오.


SELECT * FROM tcom;

SELECT emp_id FROM tcom WHERE work_year = '2001';

SELECT * FROM temp;

SELECT A.emp_id, A.emp_name
FROM temp A;

--카타시안
SELECT A.emp_id, A.emp_name, A.salary+b.comm
FROM temp A, tcom b
WHERE A.emp_id = b.emp_id
AND b.work_year = '2001';

--선생님 답(네츄럴조인 사용)
SELECT emp_id AS "사번", emp_name AS "사원이름", salary+comm AS "총 급여"
FROM temp NATURAL JOIN tcom
WHERE work_year = '2001';

--지연 답(또 서브쿼리로 해결함)
SELECT b.emp_id AS "사번", emp_name AS "사원이름", salary+comm AS "총 급여"
FROM temp A,
        (SELECT emp_id, comm FROM tcom WHERE work_year = '2001')b
WHERE b.emp_id = A.emp_id;


--outer join
--null
SELECT deptno FROM emp
MINUS 
SELECT deptno FROM dept;

--40
SELECT deptno FROM dept
MINUS 
SELECT deptno FROM emp;

SELECT empno, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno(+) =dept.deptno;

--수습사원도 보기(상한, 하한값이 없음) 
SELECT A.emp_id, emp_name, b.lev
FROM temp A, emp_level b
WHERE b.lev = '과장'
AND A.salary BETWEEN from_sal AND to_sal;

SELECT 
        b.emp_id AS "사번"
        ,b.emp_name AS "성명"
        ,b.salary AS "연봉"
        ,A.from_sal AS "하한"
        ,A.to_sal AS "상한"
        ,b.lev AS "직급"
FROM emp_level A, temp b
WHERE A.lev(+) = b.lev
ORDER BY A.lev;

SELECT A.emp_id, emp_name, emp_level
FROM temp A,
        (
        SELECT A.emp_id, emp_name, b.lev
        FROM temp A, emp_level b
        WHERE b.lev = '과장'
        AND A.salary BETWEEN from_sal AND to_sal        
        )b
WHERE A.lev(+) = b.lev;


--self join
SELECT * FROM tdept;

SELECT dept_name
FROM tdept;

SELECT dept_name AS "부서명"
        , parent_Dept AS "상위부서명"
FROM tdept;


--모든 경우의 수
SELECT 
        A.dept_code AS "부서코드"
        ,A.dept_name AS "부서명"
        ,b.dept_name AS "상위부서명"
        ,b.dept_code AS "상위부서코드"
FROM tdept A, tdept b;

--원하는 결과값 
SELECT 
        A.dept_code AS "부서코드"
        ,A.dept_name AS "부서명"
        ,b.dept_name AS "상위부서명"
FROM tdept A, tdept b
WHERE A.parent_dept = b.dept_code;

--프로시저

CREATE OR REPLACE PROCEDURE proc_hello(x IN number, msg OUT varchar2)
IS
A number(5) := 0;
BEGIN
msg := '프로시저 메시지입니다.';
dbms_output.put_line('hello oracle');
dbms_output.put_line(to_char(sysdate, 'YYYY-MM-DD'));
END;


BEGIN 
    proc_hello(1);
END;

CREATE OR REPLACE PROCEDURE proc_hap2(msg OUT varchar2)
IS
    n_i number(5) :=0;
    n_hap number(5) :=0;
BEGIN
    FOR n_i IN 1..100 LOOP
        IF mod(n_i,5) = 0 THEN
            n_hap := n_hap + n_i;
        END IF;
    END LOOP;
    msg :='5의 배수 합은 '||n_hap||' 입니다.';
END;


BEGIN 
    proc_hap2;
END;

CREATE OR REPLACE FUNCTION SCOTT.func_crate(pdate varchar2)
RETURN number
IS
    tmp number;
BEGIN 
    tmp :=0;
    SELECT crate INTO tmp
        FROM test02
      WHERE cdate  = (SELECT max(cdate) FROM test02
                                     WHERE cdate < pdate);
    RETURN tmp;
END;
/

BEGIN
    proc_fizzbuzz('');
END;

BEGIN
    proc_dept(20);
END; 

CREATE OR REPLACE PROCEDURE proc_gugudan(dan IN number)
IS
     n_i number(2);
BEGIN
    n_i :=0;
    dbms_output.put_line(dan||'단을 출력합니다.');
    FOR n_i IN 1..9 LOOP
       dbms_output.put_line(dan||'*'||n_i||'='||(dan*n_i));
    END LOOP; 
END;

BEGIN
    proc_gugudan(3);
END; 

--이들 데이터의 작업시간이 짧게 걸리는 시간 순서대로 1부터 15까지의 순위를 
--매겨서 출력하시오.
--(단, 랭크 함수 쓰지 않고
--나보다 잘 본 사람 숫자 + 1이 나의 등수 (rno +1?)
--나보다 잘 보거나 동점인 사람 

SELECT * FROM t_worktime;

--3개로만 연습해보기
SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
WHERE ROWNUM <4;

--모든 경우의 수 가져오기(비교 준비)
SELECT *
FROM(
        SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
        WHERE ROWNUM <4
        )A,
        (
        SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
        WHERE ROWNUM <4
        )b; 


--오른쪽 시간보다 많은 수 카운트하기(많을 수록 느리니까 나중에 카운트하면 순위가 낮게 나옴)
SELECT *
FROM(
        SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
        WHERE ROWNUM <4
        )A,
        (
        SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
        WHERE ROWNUM <4
        )b
WHERE A.time_nu>=b.time_nu; 

--답 : 앞의 정리 후 작업코드별 작업시간에 따른 순위를 표시 
SELECT A.workcd_vc AS "작업코드", A.time_nu AS "작업시간", count(b.workcd_vc) 
FROM(
        SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
        WHERE ROWNUM <4
        )A,
        (
        SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
        WHERE ROWNUM <4
        )b
WHERE A.time_nu>=b.time_nu
GROUP BY A.workcd_vc, A.time_nu;

    