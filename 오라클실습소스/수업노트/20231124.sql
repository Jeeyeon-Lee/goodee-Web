/* Formatted on 2023/11/24 ���� 9:09:33 (QP5 v5.215.12089.38647) */
SELECT �÷��� ...�Լ���(�÷���)
FROM  ����...(SELECT ��-�ζ��κ�)
WHERE �÷��� = ��(���,SELECT ��-��������)
NOT    �÷���=��
AND    �÷���=�� (SELECT ��)
*[OR     �÷���=��(������ -> ����� ��, �� �� ����->��� ����)]
GROUP BY
[[HAVING]]
ORDER BY

*������Ÿ�Կ��� ������ charŸ��(hello___) ��� varchar2(hello) ����� �����ϴ� ������ ����(���� ��)

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

--�μ�, ��å�� �׷�
SELECT deptno AS "�μ�", JOB, count(JOB) AS "�μ�|��å �ο�", sum(sal) AS "�޿� �հ�"
FROM emp
GROUP BY deptno, JOB
ORDER BY deptno;

SELECT decode(JOB,'CLERK', sal, NULL)
FROM emp;

SELECT sum(decode(JOB,'CLERK', sal, NULL)) clerk_sal
         ,count(decode(JOB,'CLERK', sal, NULL)) clerk_count
FROM emp;

--�� �࿡ �� �� 20��
SELECT *
FROM temp;

--1)�� �����
SELECT ROWNUM rno
FROM temp;

--2)�̸� �ֱ�
SELECT ROWNUM rno, emp_name
FROM temp;

--3-1)1,2,3�� ��� ��µǵ��� �Ѵ� ��?? �̸� 3���� �� �ٿ� ����ҰŴϱ�
--y�� ����� ceil�� 3���� ������ �������� ���� ��-> 3���� ������ 
SELECT
        RNO, CEIL(rno/3) cno
FROM (
         SELECT ROWNUM rno FROM temp
        );
        
--3-1)
--mod�� ������ ���ڵ��� ������ �Ͽ� �ι�° ��ǥ �����         
SELECT
        RNO, CEIL(rno/3) cno, mod(rno,3) mno
FROM (
         SELECT ROWNUM rno FROM temp
        );
        
--4)emp_name �־��
SELECT
        RNO, CEIL(rno/3) cno, mod(rno,3) mno, emp_name
FROM (
         SELECT ROWNUM rno, emp_name FROM temp
        );
        
--5)�׷���  1       
SELECT
        CEIL(rno/3) cno
FROM (
         SELECT ROWNUM rno, emp_name FROM temp
        )
GROUP BY ceil(rno/3)
ORDER BY cno;

--6)������ �̸� �־��
SELECT '��浿','ȫ�浿','�ڹ���' FROM dual
UNION ALL
SELECT '������','�̼���','������' FROM dual

decode(mod(rno,3),1,'��浿')

--7)decode �־��(��, �׷��ؼ�)
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

--8)��ܽ����� ������(�����ߴ��� Ȯ�ο�)
SELECT
        CEIL(rno/3) cno
        ,decode(mod(rno,3),1,emp_name) A
        ,decode(mod(rno,3),2,emp_name) b
        ,decode(mod(rno,3),0,emp_name) c
FROM (
         SELECT ROWNUM rno, emp_name FROM temp
        );

--9)�׷���� -> �� ���� �������� �ϳ��� ���̺�� �ϼ��� (�� �ܰ迡 ���� ���� ���� �ʿ�)
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

--10)5�� �����ϰ� �ʹٸ�/? 
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

--- NATURAL JOIN(=equal JOIN) : �� �ʿ� ��� �ִ� ��

--from�� ���� ���, ����� ��ȸ ���� but īŸ�þ��� �� (10, 1624,56)
SELECT empno, ename, dname
FROM emp, dept;

--���ǳ־ ���(hash join) (7,770,14)
SELECT empno, ename, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--���ǳ־ ���(hash join) (7,770,14)
SELECT empno, ename, dname
FROM emp A JOIN dept b
ON A.deptno = b.deptno;

--natural join 
SELECT empno, ename, dname
FROM emp NATURAL JOIN dept;

--- non-equal JOIN : ���ٷ� ���ϴ� �� �� ��� ��

--3.temp�� emp_level�� �̿��� emp_level�� ���� ������ ���� ����/���� ���� ����
--��� ������ �����, ����, ����, salary�� �о��.

--��ü��ȸ
SELECT *
FROM temp A, emp_level b;

--īŸ�þ� 100��(20 * 5) 
SELECT A.emp_id, emp_name, b.lev, salary
FROM temp A, emp_level b;

--���常 20��
SELECT A.emp_id, emp_name, b.lev
FROM temp A, emp_level b
WHERE b.lev = '����';

--������ ��
SELECT A.emp_id, emp_name, b.lev
FROM temp A, emp_level b
WHERE b.lev = '����'
AND A.salary BETWEEN from_sal AND to_sal;

--���� �ش�(���������� �ذ��Ϸ��� ��)
SELECT emp_id, emp_name, A.lev, salary
FROM temp
        ,(
        SELECT from_sal,to_sal, lev
        FROM emp_level 
        WHERE lev = '����'
        )A
WHERE salary BETWEEN from_sal AND to_sal;

--tcom�� work_year = '2001'�� �ڷ�� temp�� ������� �����ؼ� join�� ��
--comm�� �޴� ������ ����, salary + COMM�� ��ȸ�� ���ÿ�.


SELECT * FROM tcom;

SELECT emp_id FROM tcom WHERE work_year = '2001';

SELECT * FROM temp;

SELECT A.emp_id, A.emp_name
FROM temp A;

--īŸ�þ�
SELECT A.emp_id, A.emp_name, A.salary+b.comm
FROM temp A, tcom b
WHERE A.emp_id = b.emp_id
AND b.work_year = '2001';

--������ ��(�������� ���)
SELECT emp_id AS "���", emp_name AS "����̸�", salary+comm AS "�� �޿�"
FROM temp NATURAL JOIN tcom
WHERE work_year = '2001';

--���� ��(�� ���������� �ذ���)
SELECT b.emp_id AS "���", emp_name AS "����̸�", salary+comm AS "�� �޿�"
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

--��������� ����(����, ���Ѱ��� ����) 
SELECT A.emp_id, emp_name, b.lev
FROM temp A, emp_level b
WHERE b.lev = '����'
AND A.salary BETWEEN from_sal AND to_sal;

SELECT 
        b.emp_id AS "���"
        ,b.emp_name AS "����"
        ,b.salary AS "����"
        ,A.from_sal AS "����"
        ,A.to_sal AS "����"
        ,b.lev AS "����"
FROM emp_level A, temp b
WHERE A.lev(+) = b.lev
ORDER BY A.lev;

SELECT A.emp_id, emp_name, emp_level
FROM temp A,
        (
        SELECT A.emp_id, emp_name, b.lev
        FROM temp A, emp_level b
        WHERE b.lev = '����'
        AND A.salary BETWEEN from_sal AND to_sal        
        )b
WHERE A.lev(+) = b.lev;


--self join
SELECT * FROM tdept;

SELECT dept_name
FROM tdept;

SELECT dept_name AS "�μ���"
        , parent_Dept AS "�����μ���"
FROM tdept;


--��� ����� ��
SELECT 
        A.dept_code AS "�μ��ڵ�"
        ,A.dept_name AS "�μ���"
        ,b.dept_name AS "�����μ���"
        ,b.dept_code AS "�����μ��ڵ�"
FROM tdept A, tdept b;

--���ϴ� ����� 
SELECT 
        A.dept_code AS "�μ��ڵ�"
        ,A.dept_name AS "�μ���"
        ,b.dept_name AS "�����μ���"
FROM tdept A, tdept b
WHERE A.parent_dept = b.dept_code;

--���ν���

CREATE OR REPLACE PROCEDURE proc_hello(x IN number, msg OUT varchar2)
IS
A number(5) := 0;
BEGIN
msg := '���ν��� �޽����Դϴ�.';
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
    msg :='5�� ��� ���� '||n_hap||' �Դϴ�.';
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
    dbms_output.put_line(dan||'���� ����մϴ�.');
    FOR n_i IN 1..9 LOOP
       dbms_output.put_line(dan||'*'||n_i||'='||(dan*n_i));
    END LOOP; 
END;

BEGIN
    proc_gugudan(3);
END; 

--�̵� �������� �۾��ð��� ª�� �ɸ��� �ð� ������� 1���� 15������ ������ 
--�Űܼ� ����Ͻÿ�.
--(��, ��ũ �Լ� ���� �ʰ�
--������ �� �� ��� ���� + 1�� ���� ��� (rno +1?)
--������ �� ���ų� ������ ��� 

SELECT * FROM t_worktime;

--3���θ� �����غ���
SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
WHERE ROWNUM <4;

--��� ����� �� ��������(�� �غ�)
SELECT *
FROM(
        SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
        WHERE ROWNUM <4
        )A,
        (
        SELECT ROWNUM rno, workcd_vc, time_nu FROM t_worktime
        WHERE ROWNUM <4
        )b; 


--������ �ð����� ���� �� ī��Ʈ�ϱ�(���� ���� �����ϱ� ���߿� ī��Ʈ�ϸ� ������ ���� ����)
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

--�� : ���� ���� �� �۾��ڵ庰 �۾��ð��� ���� ������ ǥ�� 
SELECT A.workcd_vc AS "�۾��ڵ�", A.time_nu AS "�۾��ð�", count(b.workcd_vc) 
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

    