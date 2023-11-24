--����1:�����ȣ�� 7500�� �̻��� ������� �̸��� �Ի����� �޿��� ����Ͻÿ�.
SELECT ename, hiredate
FROM emp
WHERE empno >= 7500
ORDER BY hiredate;;


--����2:�Ի��� �⵵�� 1981���� ������� ����� ����Ͻÿ�.
SELECT empno, hiredate
FROM emp
WHERE to_char(hiredate, 'YYYY') = 1981;

--����1
SELECT empno, hiredate
FROM emp
WHERE hiredate = to_date(1981, 'YYYY');

--Ȯ��1
SELECT hiredate, to_date(1981, 'YYYY')
FROM emp;

--����3:����� �̸��� A�� ���۵Ǵ� ������� �����ȣ�� ����Ͻÿ�.
SELECT ename,empno
FROM emp
WHERE ename LIKE 'A%';

SELECT ename,empno
FROM emp
WHERE ename LIKE :x||'%';
 
--����4:�Ի����ڰ� 1981�� 2��1�� ���� 1981�� 6��30�ϻ��̿�  �ִ� ������� ����� ����� ����Ͻÿ�  
SELECT empno, ename,hiredate
 FROM emp
WHERE hiredate BETWEEN '1981-02-01' AND '1981-06-30'
ORDER BY hiredate;


 --����5:�޿��� 1000�Һ��� ũ�ų� ���� 3000�Һ��� �۰ų� ���� �������� �̸��� �޿��� ����Ͻÿ�.
SELECT ename, sal
 FROM emp
 WHERE sal<=3000 
 AND sal>=1000;
 
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 2000;
 

--����6:�޿��� 3000���� �ƴ� ������� ����� �̸��� ����Ͻÿ�.  (empno : PK) 
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

--�ε������� ���� ��ȸ�� �⺻�� ��������
SELECT empno
 FROM emp
WHERE sal <> 3000
ORDER BY empno;

--������������ ��ȸ�� �ϰ� �ʹٸ�?? 
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

--��ȸ ���� ����� �ε����� ������
SELECT  
    empno, ename
FROM emp
WHERE empno = 7566 ;

--��ȸ ���� ����� �ε����� ������
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

--�ε��� ����
CREATE INDEX i_ename ON emp(ename ASC);

--�� �ε��� ��� ������?? 
SELECT ename
 FROM emp;

--������ �ε��� �����. 
SELECT ename
 FROM emp
 WHERE ename = ' ';
 

--����7:������� �μ��� �޿������ ���Ͻÿ�. 
SELECT deptno AS "�μ���ȣ",round(avg(sal))||'��' AS "�μ��� �޿����"
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

--1.temp���� ������ ���� ���� ������ row�� ã�Ƽ� �� �ݾװ� ������ �ݾ���
--�޴� ������ ����� ������ ����Ͻÿ�.(by ��������)

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

--2.temp�� �ڷḦ �̿��Ͽ� salary�� ����� ���ϰ� �̺��� ū �ݾ��� salary�� 
--�޴� ������ ����� ����, ������ �����ֽÿ�.

SELECT avg(salary) FROM temp;
--43,800,000

SELECT emp_id AS "���", emp_name AS "����",to_char(salary,'999,999,999')||'��' AS "����" 
FROM temp 
WHERE salary >
                    (
                    SELECT avg(salary)
                    FROM temp
                    )
ORDER BY salary desc; 

--3.temp�� ���� �� ��õ�� �ٹ��ϴ� ������ ����� ������ �о���� SQL�� ����
--������ �̿��� �����ÿ�.
--emp - ename, deptno
--tdept - dept_code
SELECT dept_code FROM tdept WHERE AREA = '��õ';

SELECT ename, deptno 
FROM emp 
WHERE deptno IN(10,20);

SELECT emp_id, emp_name FROM temp
WHERE dept_code IN(SELECT dept_code FROM tdept WHERE AREA = '��õ');

--4.tcom���̺� ����
--tcom�� ���� �ܿ� Ŀ�̼��� �޴� ������ ����� �����Ǿ� �ִ�.
--�� ������ ���������� select�Ͽ� �μ� ��Ī���� Ŀ�̼��� �޴�
--�ο����� ���� ������ ����� ���ÿ�. -> ������ ���ϱ�??

--temp, tcom �� ���̺��� ������
SELECT emp_id FROM temp
INTERSECT
SELECT emp_id FROM tcom;

--20���� ����
SELECT b.dept_name
FROM temp A, tdept b
WHERE A.dept_code = b.dept_code;

--tcom�� �ִ� ����� ������? 
SELECT b.dept_name
FROM temp A, tdept b
WHERE A.dept_code = b.dept_code
AND A.emp_id IN(SELECT emp_id FROM tcom);

--�ο����� ����? �׷�����? 
SELECT b.dept_name, count(A.emp_id)
FROM temp A, tdept b
WHERE A.dept_code = b.dept_code
AND A.emp_id IN(SELECT emp_id FROM tcom)
GROUP BY b.dept_name;

--�������ڵ� �����ϱ�(���簡 �ƴ� �Ϸ� �� �ݾ����� ����ϱ�)
--��¥���� AMT(�޷��ݾ�) , CRATE(ȯ��), ȯ��*�޷� = ��ȭ�ݾ�
--���� �����ؾ��� ��ȭ�ݾ� ����ϱ�  
--������� ������?? LIKE?? date -1 ?? lag ?? ROWNUM ?? 

SELECT * FROM test02;

SELECT cdate AS "����", amt AS "�ݾ�", crate AS "ȯ��" ,amt*crate AS "���� ������ �ݾ�"
FROM test02;

--�õ�1. LAG ���
SELECT cdate AS "����", amt AS "�ݾ�", crate AS "ȯ��" 
        ,(amt)*(lag(crate) OVER(ORDER BY cdate)) AS "���� ������ �ݾ�"
FROM test02
ORDER BY cdate;

--�õ�2. rownum ���
--1)���̺� �� �� ����
SELECT ROWNUM org_no, cdate, crate, amt FROM test02;

SELECT ROWNUM org_no, cdate, crate, amt FROM test02;

--2)�ο�� �� ������ īŸ�þ� �� �����(�� �྿ ����)
SELECT *
FROM (
        SELECT ROWNUM org_no, cdate, crate, amt FROM test02
        )A,
        (
        SELECT ROWNUM org_no, cdate, crate, amt FROM test02
        )b
WHERE A.org_no-1 = b.org_no;

--3)���ε� ���̺��� ���ϴ� ���� ����Ʈ 
SELECT 
        A.cdate AS "����"
        ,to_char(A.amt,'999,999')||' $' AS "�ݾ�"
        , b.crate AS "ȯ��"
        ,to_char(A.amt*b.crate,'999,999,999')||' ��' AS "��ȭ�ݾ�"
FROM (
        SELECT ROWNUM org_no, cdate, crate, amt FROM test02
        )A,
        (
        SELECT ROWNUM org_no, cdate, crate, amt FROM test02
        )b
WHERE A.org_no-1 = b.org_no;

SELECT mod(5,2) FROM dual;

SELECT func_crate('20010903') FROM dual;

--�Ұ�, �Ѱ� ���ϱ� 
--�Ѱ��� ���� �߰��Ѵ�. 
--���? �����͸� 2����� ��������! 
--��? �� ��(���� 1)�� ��¥�� ���, �ٸ� �� ��(���� 2)�� �Ѱ踦 ���ϴ� ������ ���� 
--rownum�� ������ ��ȣ�� �Ű��ָ� �۰ų� �����͸� �ȴ�(ũ�� x)
--1�� ���� ���� ���̸� �о �ϳ��� ���, �κ� ���� ó�� ����
--��, 2�� �� �Ұ���, 1�� ����

SELECT ROWNUM rno FROM dept
WHERE ROWNUM >3;

SELECT indate_vc FROM t_orderbasket;


SELECT 1 rno FROM dual
UNION ALL
SELECT 2 FROM deual;

--���̺� t_orderbasket
--�ζ��κ�, �׷����, ������ ������ �������̺� ���(3���̻�)
SELECT * FROM t_orderbasket;

SELECT deptno
 FROM 
 t_orderbasket;

SELECT indate_vc, gubun_vc,qty_nu, qty_nu*price_nu
FROM t_orderbasket;

SELECT ROWNUM rno FROM dept WHERE ROWNUM<3;

--------------------------------------------------------------------------------------------------------
SELECT decode(b.rno,1,indate_vc, 2, '�Ѱ�') 
          ,sum(qty_nu) 
          ,sum(qty_nu*price_nu)
FROM t_orderbasket,
          (
          SELECT ROWNUM rno FROM dept WHERE ROWNUM<3
          )b
GROUP BY decode(b.rno,1,indate_vc, 2, '�Ѱ�')
ORDER BY decode(b.rno,1,indate_vc, 2, '�Ѱ�');

--------------------------------------------------------------------------------------------------------
SELECT decode(b.rno,1,indate_vc, 2, '�Ѱ�',3,'�Ұ�') AS " �Ǹų�¥"
         ,decode(b.rno,3,gubun_vc||'��',1,gubun_vc) AS "��ǰ����"
         ,sum(qty_nu)  AS "�Ǹż���"
         ,sum(qty_nu*price_nu)  AS "�ǸŰ���"
FROM t_orderbasket,
             (SELECT ROWNUM rno FROM dept WHERE ROWNUM<4)b
GROUP BY decode(b.rno,1,indate_vc, 2, '�Ѱ�',3,'�Ұ�')
             ,decode(b.rno,3,gubun_vc||'��',1,gubun_vc)
ORDER BY decode(b.rno,1,indate_vc, 2, '�Ѱ�',3,'�Ұ�')
             ,decode(b.rno,3,gubun_vc||'��',1,gubun_vc);

-----------------------------------------------------------------------------------------------------------
--���� �� Ǯ��� 
SELECT * FROM emp;

--1)�μ���ȣ�� �����ͺ���
SELECT deptno
         ,sum(decode(JOB,'CLERK',sal)) clerk
                  ,sum(decode(JOB,'SALESMAN',sal)) salesman
         ,sum(decode(JOB,'CLERK',NULL,'MANAGER',NULL,sal)) etc
         ,sum(sal) dept_sal
FROM emp
GROUP BY deptno;

--2)dname ���� ���� ���� 1�� �����ϱ� & dname ���� �͸� ���(4��->3���� ����) 

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

--3)�Ѱ� �κ��� �ֱ� ���� ������ �����Ϳ� join�ϱ�
--(�μ���, �Ѱ�� ������ �ϴ� 2�� �ο�Ѱ� ���� �ʿ�)        

SELECT decode(rno,1,dname,2,'�Ѱ�'), sum(clerk), sum(salesman), sum(etc), sum(dept_sal)
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
GROUP BY decode(rno,1,dname,2,'�Ѱ�') 
ORDER BY decode(rno,1,dname,2,'�Ѱ�'); 



-------------------Ȯ���غ���--------------------------------------------------

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
     decode(b.NO,1,A.dname,2,'�Ѱ�')
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
     decode(b.NO,1,A.dname,2,'�Ѱ�')
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
 GROUP BY  decode(b.NO,1,A.dname,2,'�Ѱ�')
 ORDER BY  decode(b.NO,1,A.dname,2,'�Ѱ�');


-----------------------------------------------------------------------------------------

SELECT decode(b.rno,1,indate_vc, 2, '�Ѱ�',3,'�Ұ�') AS " �Ǹų�¥"
         ,decode(b.rno,3,gubun_vc||'��',1,gubun_vc) AS "��ǰ����"
         ,sum(qty_nu)  AS "�Ǹż���"
         ,sum(qty_nu*price_nu)  AS "�ǸŰ���"
FROM t_orderbasket,
             (SELECT ROWNUM rno FROM dept WHERE ROWNUM<4)b
GROUP BY decode(b.rno,1,indate_vc, 2, '�Ѱ�',3,'�Ұ�')
             ,decode(b.rno,3,gubun_vc||'��',1,gubun_vc)
ORDER BY decode(b.rno,1,indate_vc, 2, '�Ѱ�',3,'�Ұ�')
             ,decode(b.rno,3,gubun_vc||'��',1,gubun_vc);

--���ð� ����

--(����)��¥��, (����)��ǰ���к� (�׷�)�ǸŰ����� (�׷�)�ǸŰ���!!
-- +��ü �Ѱ�, ��ǰ�� �Ұ�  

--�׷��Լ� ����� �ȵǴ� �� -> ��¥, ��ǰ����
--�׷��Լ� �Ǵ� ��->�ǸŰ���, �ǸŰ���

--1)��ü ��ȸ
SELECT *
FROM T_ORDERBASKET;

--2)��ȸ �� �����ؾ��ϴ� �� ��ȸ
SELECT indate_vc, gubun_vc,qty_nu, qty_nu*price_nu
FROM T_ORDERBASKET;

--3)������ �������̺� ��ȸ
--�� 3���� �ο찡 �ִ� ���̺�� �����ϴ°�?
--�Ѿ��� ������� �ʰ�, �߰��ϱ� ���ؼ� 
--���� ��ȸ���̺� �Ʒ��� �Ұ�, �Ѱ���� �߰��Ͽ� �� ������ �ο찡 �ʿ��ϱ⿡!
SELECT '1' NO FROM dual
UNION ALL
SELECT '2' FROM dual 
UNION ALL
SELECT '3' FROM dual;

--4)�����غ���
SELECT qty_nu, qty_nu*price_nu
FROM T_ORDERBASKET,
           (SELECT '1' NO FROM dual
            UNION ALL
            SELECT '2' FROM dual 
            UNION ALL
            SELECT '3' FROM dual
           )b;
 
--5)���� �� decode �������� rownum �� �����ϱ�
--1�� �Ǹų�¥, ��ǰ����, �ǸŰ���, �ǸŰ��� �� ���
--2�� �Ǹų�¥(�Ұ�)��ǰ����, �ǸŰ���, �ǸŰ��� ��� 
--3�� �Ǹų�¥(�Ѱ�),�ǸŰ���,�ǸŰ��� ���           
SELECT decode(b.NO,'1',indate_vc,'2','�Ұ�','3','�Ѱ�') AS "�Ǹų�¥"
           ,decode(b.NO,'1',gubun_vc,'2',gubun_vc) AS "��ǰ����"
           ,sum(qty_nu)||'��' AS "�ǸŰ���"
           ,to_char(sum(qty_nu*price_nu),'999,999')||'��' AS "�ǸŰ���"
FROM T_ORDERBASKET,
           (SELECT '1' NO FROM dual
            UNION ALL
            SELECT '2' FROM dual 
            UNION ALL
            SELECT '3' FROM dual
           )b
GROUP BY decode(b.NO,'1',indate_vc,'2','�Ұ�','3','�Ѱ�')
                ,decode(b.NO,'1',gubun_vc,'2',gubun_vc)
ORDER BY decode(b.NO,'1',indate_vc,'2','�Ұ�','3','�Ѱ�')
               ,decode(b.NO,'1',gubun_vc,'2',gubun_vc);