--문제1:사원번호가 7500번 이상인 사원들의 이름과 입사일자 급여를 출력하시오.
SELECT ename, hiredate
FROM emp
WHERE empno >= 7500
ORDER BY hiredate;;


--문제2:입사한 년도가 1981년인 사원들의 사번을 출력하시오.
SELECT empno, hiredate
FROM emp
WHERE to_char(hiredate, 'YYYY') = 1981;

--실패1
SELECT empno, hiredate
FROM emp
WHERE hiredate = to_date(1981, 'YYYY');

--확인1
SELECT hiredate, to_date(1981, 'YYYY')
FROM emp;

--문제3:사원의 이름이 A로 시작되는 사원들의 사원번호를 출력하시오.
SELECT ename,empno
FROM emp
WHERE ename LIKE 'A%';

SELECT ename,empno
FROM emp
WHERE ename LIKE :x||'%';
 
--문제4:입사일자가 1981년 2월1일 에서 1981년 6월30일사이에  있는 사원들의 사번과 명단을 출력하시오  
SELECT empno, ename,hiredate
 FROM emp
WHERE hiredate BETWEEN '1981-02-01' AND '1981-06-30'
ORDER BY hiredate;


 --문제5:급여가 1000불보다 크거나 같고 3000불보다 작거나 같은 직원들의 이름과 급여를 출력하시오.
SELECT ename, sal
 FROM emp
 WHERE sal<=3000 
 AND sal>=1000;
 
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 2000;
 

--문제6:급여가 3000불이 아닌 사원들의 사번과 이름을 출력하시오.  (empno : PK) 
SELECT empno, ename
 FROM emp
WHERE sal <> 3000;

SELECT empno, ename, sal 
FROM emp
WHERE sal != 3000;

SELECT empno, ename
 FROM emp
WHERE sal != 3000;

SELECT /*+ rule*/ empno, ename
 FROM emp
WHERE sal != 3000;

--인덱스값에 대한 조회는 기본이 오름차순
SELECT empno
 FROM emp
WHERE sal <> 3000
ORDER BY empno;

--내림차순으로 조회를 하고 싶다면?? 
SELECT /*+ index_desc(emp pk_emp) */ 
    empno, ename
 FROM emp;

SELECT  
    empno, ename
 FROM emp
ORDER BY empno;

SELECT  
    empno, ename
 FROM emp;
 
SELECT  
    empno
 FROM emp;

--조회 조건 대상이 인덱스가 있을때
SELECT  
    empno, ename
FROM emp
WHERE empno = 7566 ;

--조회 조건 대상이 인덱스가 없을때
SELECT  
    empno, ename
FROM emp
WHERE ename = 'SMITH';

SELECT ename, hiredate
FROM emp
WHERE ename != 'SMITH';

SELECT /*+rule*/ ename, empno
FROM emp
WHERE ename != 'SMITH';

--인덱스 생성
CREATE INDEX i_ename ON emp(ename ASC);

--왜 인덱스 사용 안하지?? 
SELECT ename
 FROM emp;

--생성된 인덱스 사용함. 
SELECT ename
 FROM emp
 WHERE ename = ' ';
 

--문제7:사원들의 부서별 급여평균을 구하시오. 
SELECT deptno AS "부서번호",round(avg(sal))||'원' AS "부서별 급여평균"
FROM emp
GROUP BY deptno
ORDER BY deptno;

SELECT sum(sal), count(sal), count(comm), avg(sal)
FROM emp;

SELECT /*+ rule*/
        deptno, sum(sal), count(sal), count(comm), avg(sal)
FROM emp
GROUP BY deptno;

SELECT JOB, sum(sal), count(sal), count(comm), avg(sal)
FROM emp
GROUP BY JOB;


SELECT A
FROM (
            SELECT decode(mod(seq_vc,2),1,words_vc) A
            FROM t_letitbe
        )
WHERE A LIKE 'Let%';

--1.temp에서 연봉이 가장 많은 직원의 row를 찾아서 이 금액과 동일한 금액을
--받는 직원의 사번과 성명을 출력하시오.(by 서브쿼리)

SELECT max(salary) FROM temp;

SELECT emp_id, emp_name, salary
FROM temp
WHERE salary = 100000000;

SELECT emp_id, emp_name, salary
FROM temp
WHERE salary = 
        (
        SELECT max(salary)
        FROM temp
        );
        
SELECT emp_id, emp_name, salary
FROM temp
WHERE salary = 
        (
        SELECT min(salary)
        FROM temp
        );
        
SELECT emp_id, emp_name, salary
FROM temp
ORDER BY salary;

--2.temp의 자료를 이용하여 salary의 평균을 구하고 이보다 큰 금액을 salary로 
--받는 직원의 사번과 성명, 연봉을 보여주시오.

SELECT avg(salary) FROM temp;
--43,800,000

SELECT emp_id AS "사번", emp_name AS "성명",to_char(salary,'999,999,999')||'원' AS "연봉" 
FROM temp 
WHERE salary >
                    (
                    SELECT avg(salary)
                    FROM temp
                    )
ORDER BY salary desc; 

--3.temp의 직원 중 인천에 근무하는 직원의 사번과 성명을 읽어오는 SQL을 서브
--쿼리를 이용해 만들어보시오.
--emp - ename, deptno
--tdept - dept_code
SELECT dept_code FROM tdept WHERE AREA = '인천';

SELECT ename, deptno 
FROM emp 
WHERE deptno IN(10,20);

SELECT emp_id, emp_name FROM temp
WHERE dept_code IN(SELECT dept_code FROM tdept WHERE AREA = '인천');

--4.tcom테이블 참고
--tcom에 연봉 외에 커미션을 받는 직원의 사번이 보관되어 있다.
--이 정보를 서브쿼리로 select하여 부서 명칭별로 커미션을 받는
--인원수를 세는 문장을 만들어 보시오. -> 교집합 구하기??

--temp, tcom 두 테이블의 교집합
SELECT emp_id FROM temp
INTERSECT
SELECT emp_id FROM tcom;

--20명의 정보
SELECT b.dept_name
FROM temp A, tdept b
WHERE A.dept_code = b.dept_code;

--tcom에 있는 사람만 뽑으면? 
SELECT b.dept_name
FROM temp A, tdept b
WHERE A.dept_code = b.dept_code
AND A.emp_id IN(SELECT emp_id FROM tcom);

--인원수를 세면? 그룹으로? 
SELECT b.dept_name, count(A.emp_id)
FROM temp A, tdept b
WHERE A.dept_code = b.dept_code
AND A.emp_id IN(SELECT emp_id FROM tcom)
GROUP BY b.dept_name;

--이전레코드 참조하기(현재가 아닌 하루 전 금액으로 계산하기)
--날짜별로 AMT(달러금액) , CRATE(환율), 환율*달러 = 한화금액
--오늘 결제해야할 한화금액 계산하기  
--무슨방법 있을까?? LIKE?? date -1 ?? lag ?? ROWNUM ?? 

SELECT * FROM test02;

SELECT cdate AS "일자", amt AS "금액", crate AS "환율" ,amt*crate AS "오늘 결제할 금액"
FROM test02;

--시도1. LAG 사용
SELECT cdate AS "일자", amt AS "금액", crate AS "환율" 
        ,(amt)*(lag(crate) OVER(ORDER BY cdate)) AS "오늘 결제할 금액"
FROM test02
ORDER BY cdate;

--시도2. rownum 사용
--1)테이블 두 개 생성
SELECT ROWNUM org_no, cdate, crate, amt FROM test02;

SELECT ROWNUM org_no, cdate, crate, amt FROM test02;

--2)로우넘 뺀 값으로 카타시안 곱 만들기(한 행씩 빼서)
SELECT *
FROM (
        SELECT ROWNUM org_no, cdate, crate, amt FROM test02
        )A,
        (
        SELECT ROWNUM org_no, cdate, crate, amt FROM test02
        )b
WHERE A.org_no-1 = b.org_no;

--3)조인된 테이블에서 원하는 값을 셀렉트 
SELECT 
        A.cdate AS "일자"
        ,to_char(A.amt,'999,999')||' $' AS "금액"
        , b.crate AS "환율"
        ,to_char(A.amt*b.crate,'999,999,999')||' 원' AS "한화금액"
FROM (
        SELECT ROWNUM org_no, cdate, crate, amt FROM test02
        )A,
        (
        SELECT ROWNUM org_no, cdate, crate, amt FROM test02
        )b
WHERE A.org_no-1 = b.org_no;

SELECT mod(5,2) FROM dual;

SELECT func_crate('20010903') FROM dual;

--소계, 총계 구하기 
--총계라는 셀을 추가한다. 
--어떻게? 데이터를 2배수로 복제하자! 
--왜? 한 번(숫자 1)은 날짜로 계산, 다른 한 번(숫자 2)은 총계를 구하는 것으로 쓰자 
--rownum은 순차적 번호를 매겨주며 작거나 같은것만 된다(크다 x)
--1과 같다 조건 붙이면 읽어서 하나만 출력, 부분 범위 처리 가능
--단, 2는 비교 불가능, 1만 가능

SELECT ROWNUM rno FROM dept
WHERE ROWNUM >3;

SELECT indate_vc FROM t_orderbasket;


SELECT 1 rno FROM dual
UNION ALL
SELECT 2 FROM deual;

--테이블 t_orderbasket
--인라인뷰, 그룹바이, 데이터 복제시 더미테이블 사용(3건이상)
SELECT * FROM t_orderbasket;

SELECT deptno
 FROM 
 t_orderbasket;

SELECT indate_vc, gubun_vc,qty_nu, qty_nu*price_nu
FROM t_orderbasket;

SELECT ROWNUM rno FROM dept WHERE ROWNUM<3;

--------------------------------------------------------------------------------------------------------
SELECT decode(b.rno,1,indate_vc, 2, '총계') 
          ,sum(qty_nu) 
          ,sum(qty_nu*price_nu)
FROM t_orderbasket,
          (
          SELECT ROWNUM rno FROM dept WHERE ROWNUM<3
          )b
GROUP BY decode(b.rno,1,indate_vc, 2, '총계')
ORDER BY decode(b.rno,1,indate_vc, 2, '총계');

--------------------------------------------------------------------------------------------------------
SELECT decode(b.rno,1,indate_vc, 2, '총계',3,'소계') AS " 판매날짜"
         ,decode(b.rno,3,gubun_vc||'계',1,gubun_vc) AS "물품구분"
         ,sum(qty_nu)  AS "판매수량"
         ,sum(qty_nu*price_nu)  AS "판매가격"
FROM t_orderbasket,
             (SELECT ROWNUM rno FROM dept WHERE ROWNUM<4)b
GROUP BY decode(b.rno,1,indate_vc, 2, '총계',3,'소계')
             ,decode(b.rno,3,gubun_vc||'계',1,gubun_vc)
ORDER BY decode(b.rno,1,indate_vc, 2, '총계',3,'소계')
             ,decode(b.rno,3,gubun_vc||'계',1,gubun_vc);

-----------------------------------------------------------------------------------------------------------
--어제 거 풀어보기 
SELECT * FROM emp;

--1)부서번호로 가져와보기
SELECT deptno
         ,sum(decode(JOB,'CLERK',sal)) clerk
                  ,sum(decode(JOB,'SALESMAN',sal)) salesman
         ,sum(decode(JOB,'CLERK',NULL,'MANAGER',NULL,sal)) etc
         ,sum(sal) dept_sal
FROM emp
GROUP BY deptno;

--2)dname 갖고 오기 위해 1차 조인하기 & dname 같은 것만 출력(4개->3개로 줄음) 

SELECT dname, clerk, salesman, etc, dept_sal 
FROM dept d
        ,(SELECT deptno
                   ,sum(decode(JOB,'CLERK',sal)) clerk
                   ,sum(decode(JOB,'SALESMAN',sal)) salesman
                   ,sum(decode(JOB,'CLERK',NULL,'MANAGER',NULL,sal)) etc
                   ,sum(sal) dept_sal
        FROM emp
        GROUP BY deptno)A
WHERE A.DEPTNO = d.deptno;

--3)총계 부분을 넣기 위한 가상의 데이터와 join하기
--(부서명, 총계로 나눠야 하니 2개 로우넘과 조인 필요)        

SELECT decode(rno,1,dname,2,'총계'), sum(clerk), sum(salesman), sum(etc), sum(dept_sal)
FROM (
        SELECT dname, clerk, salesman, etc, dept_sal 
        FROM dept b
                ,(SELECT deptno
                           ,sum(decode(JOB,'CLERK',sal)) clerk
                           ,sum(decode(JOB,'SALESMAN',sal)) salesman
                           ,sum(decode(JOB,'CLERK',NULL,'MANAGER',NULL,sal)) etc
                           ,sum(sal) dept_sal
                FROM emp
                GROUP BY deptno)A
        WHERE A.DEPTNO = b.deptno
        )c,
        (SELECT ROWNUM rno FROM dept WHERE ROWNUM<3)d
GROUP BY decode(rno,1,dname,2,'총계') 
ORDER BY decode(rno,1,dname,2,'총계'); 



-------------------확인해보기--------------------------------------------------

SELECT 
     dname
     ,clerk
     ,manager
     ,etc
     ,dept_sal
  FROM (
        SELECT bb.dname, clerk, manager, etc, dept_sal
          FROM (
                SELECT deptno
                      ,sum(decode(JOB, 'CLERK', sal)) clerk
                      ,sum(decode(JOB, 'MANAGER', sal)) manager
                      ,sum(decode(JOB, 'CLERK', NULL, 'MANAGER', NULL, sal)) etc
                      ,sum(sal) dept_sal 
                 FROM emp A
                GROUP BY deptno
               )aa, dept bb
         WHERE aa.deptno = bb.deptno  
       )A,
       (SELECT '1' NO FROM dual
        UNION ALL
        SELECT '2' FROM dual 
       )b;     
       
--------------------------------------------------------------       
 SELECT 
     decode(b.NO,1,A.dname,2,'총계')
     ,clerk
     ,manager
     ,etc
     ,dept_sal
  FROM (
        SELECT bb.dname, clerk, manager, etc, dept_sal
          FROM (
                SELECT deptno
                      ,sum(decode(JOB, 'CLERK', sal)) clerk
                      ,sum(decode(JOB, 'MANAGER', sal)) manager
                      ,sum(decode(JOB, 'CLERK', NULL, 'MANAGER', NULL, sal)) etc
                      ,sum(sal) dept_sal 
                 FROM emp A
                GROUP BY deptno
               )aa, dept bb
         WHERE aa.deptno = bb.deptno  
       )A,
       (SELECT '1' NO FROM dual
        UNION ALL
        SELECT '2' FROM dual 
       )b;     
       
SELECT 
     decode(b.NO,1,A.dname,2,'총계')
     ,sum(clerk)
     ,sum(manager)
     ,sum(etc)
     ,sum(dept_sal)
  FROM (
        SELECT bb.dname, clerk, manager, etc, dept_sal
          FROM (
                SELECT deptno
                      ,sum(decode(JOB, 'CLERK', sal)) clerk
                      ,sum(decode(JOB, 'MANAGER', sal)) manager
                      ,sum(decode(JOB, 'CLERK', NULL, 'MANAGER', NULL, sal)) etc
                      ,sum(sal) dept_sal 
                 FROM emp A
                GROUP BY deptno
               )aa, dept bb
         WHERE aa.deptno = bb.deptno  
       )A,
       (SELECT '1' NO FROM dual
        UNION ALL
        SELECT '2' FROM dual 
       )b    
 GROUP BY  decode(b.NO,1,A.dname,2,'총계')
 ORDER BY  decode(b.NO,1,A.dname,2,'총계');


-----------------------------------------------------------------------------------------

SELECT decode(b.rno,1,indate_vc, 2, '총계',3,'소계') AS " 판매날짜"
         ,decode(b.rno,3,gubun_vc||'계',1,gubun_vc) AS "물품구분"
         ,sum(qty_nu)  AS "판매수량"
         ,sum(qty_nu*price_nu)  AS "판매가격"
FROM t_orderbasket,
             (SELECT ROWNUM rno FROM dept WHERE ROWNUM<4)b
GROUP BY decode(b.rno,1,indate_vc, 2, '총계',3,'소계')
             ,decode(b.rno,3,gubun_vc||'계',1,gubun_vc)
ORDER BY decode(b.rno,1,indate_vc, 2, '총계',3,'소계')
             ,decode(b.rno,3,gubun_vc||'계',1,gubun_vc);

--오늘거 복습

--(조건)날짜별, (조건)물품구분별 (그룹)판매개수와 (그룹)판매가격!!
-- +전체 총계, 물품별 소계  

--그룹함수 계산이 안되는 것 -> 날짜, 물품구분
--그룹함수 되는 것->판매개수, 판매가격

--1)전체 조회
SELECT *
FROM T_ORDERBASKET;

--2)조회 시 참고해야하는 값 조회
SELECT indate_vc, gubun_vc,qty_nu, qty_nu*price_nu
FROM T_ORDERBASKET;

--3)조인할 더미테이블 조회
--왜 3개의 로우가 있는 테이블과 조인하는가?
--롤업을 사용하지 않고, 추가하기 위해서 
--현재 조회테이블 아래에 소계, 총계까지 추가하여 세 종류의 로우가 필요하기에!
SELECT '1' NO FROM dual
UNION ALL
SELECT '2' FROM dual 
UNION ALL
SELECT '3' FROM dual;

--4)조인해보기
SELECT qty_nu, qty_nu*price_nu
FROM T_ORDERBASKET,
           (SELECT '1' NO FROM dual
            UNION ALL
            SELECT '2' FROM dual 
            UNION ALL
            SELECT '3' FROM dual
           )b;
 
--5)조인 후 decode 조건으로 rownum 별 설정하기
--1은 판매날짜, 물품구분, 판매개수, 판매가격 다 출력
--2는 판매날짜(소계)물품구분, 판매개수, 판매가격 출력 
--3은 판매날짜(총계),판매개수,판매가격 출력           
SELECT decode(b.NO,'1',indate_vc,'2','소계','3','총계') AS "판매날짜"
           ,decode(b.NO,'1',gubun_vc,'2',gubun_vc) AS "물품구분"
           ,sum(qty_nu)||'개' AS "판매개수"
           ,to_char(sum(qty_nu*price_nu),'999,999')||'원' AS "판매가격"
FROM T_ORDERBASKET,
           (SELECT '1' NO FROM dual
            UNION ALL
            SELECT '2' FROM dual 
            UNION ALL
            SELECT '3' FROM dual
           )b
GROUP BY decode(b.NO,'1',indate_vc,'2','소계','3','총계')
                ,decode(b.NO,'1',gubun_vc,'2',gubun_vc)
ORDER BY decode(b.NO,'1',indate_vc,'2','소계','3','총계')
               ,decode(b.NO,'1',gubun_vc,'2',gubun_vc);