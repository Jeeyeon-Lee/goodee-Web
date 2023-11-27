--각 사번의 성명, 이름, salary, 연봉하한금액, 연봉상한금액을 보고자 한다.
--temp와 emp_level을 조인하여 결과를 보여주되, 연봉의 상하한이 등록되어 있지 않은
--'수습' 사원은 성명, 이름, salary 까지만이라도 나올 수 있도록 쿼리를 작성하시오.

SELECT emp_name, salary, to_sal, from_sal
FROM temp, emp_level;


SELECT emp_name, temp.lev, salary, to_sal, from_sal
FROM temp, emp_level
WHERE temp.lev = emp_level.lev(+);

--사번이 없는 사람의 경우 빼고 사번, 사원이름, 부서이름 가져오기
SELECT empno, ename, dname
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno;

SELECT empno, ename, dname
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno = dept.deptno;


--상품과 회원의 관계 형태?? (n:n) 

SELECT * FROM t_giftmem;

SELECT * FROM t_giftpoint;

--영화티켓 사용할 수 있는 집합은 ?? 
SELECT  *
FROM t_giftmem, t_giftpoint;

SELECT  *
FROM t_giftmem mem, t_giftpoint poi
WHERE poi.name_vc = '과자종합'
AND poi.point_nu <= mem.point_nu;

COMMIT;

SELECT * FROM emp;

SELECT A.ename AS "매니저", b.ename AS "사원"
FROM emp A, emp b
WHERE A.empno = b.mgr
ORDER BY A.ename;

--temp와 tdept를 이용하여 다음 컬럼을 보여주는 SQL을 만들어 보자.
--상위부서가 'CA0001'인 부서에 소속된 직원을 1.사번, 2.성명, 3.부서코드
--4.부서명, 5.상위부서코드, 6.상위부서명, 7.상위부서장코드, 8.상위부서장성명
--순서로 보여주면 된다.(temp(20) 2, tdept(10) 2번) , 
SELECT *
FROM temp, tdept;

--1~4까지 출력
--옛날방식(natural join)
SELECT A.emp_id, A.emp_name, b.dept_code, b.dept_name
FROM temp A, tdept b
WHERE A.dept_code = b.dept_code;

--natural join으로 명시(AS 사용x, 조건이 눈에 보이지 않음) 
SELECT emp_id, emp_name, dept_code, dept_name
FROM temp NATURAL JOIN tdept;

--테이블 갯수에서 n-1한 숫자가 조인조건의 숫자와 같음. 
SELECT A.emp_id AS "사번", A.emp_name AS "성명"
        , b.dept_code AS "부서코드", b.dept_name AS "부서명"
        , C.DEPT_code AS "상위부서코드", c.dept_name AS "상위부서명"
FROM temp A, tdept b, tdept c
WHERE A.dept_code = b.dept_code
AND b.parent_dept = c.dept_code
AND c.dept_code = 'CA0001';


--테이블 갯수에서 n-1한 숫자가 조인조건의 숫자와 같음. 
SELECT A.emp_id AS "사번", A.emp_name AS "성명"
        , b.dept_code AS "부서코드", b.dept_name AS "부서명"
        , C.DEPT_code AS "상위부서코드", c.dept_name AS "상위부서명"
        , c.boss_id AS "상위부서장 아이디"
        , d.emp_name AS "상위부서장 이름"
FROM temp A, tdept b, tdept c, temp d
WHERE A.dept_code = b.dept_code
AND b.parent_dept = c.dept_code
AND c.boss_id = d.emp_id
AND c.dept_code = 'CA0001';

BEGIN
    proc_dept(); 
END;

SELECT deptno, avg(sal)
FROM emp
GROUP BY deptno;

edit emp;

COMMIT;

SELECT m_id FROM member1 WHERE m_id=: p_id;

BEGIN
    proc_login1('kiwi','123',:r_name,:r_status);
END;