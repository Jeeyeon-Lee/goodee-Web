/* Formatted on 2023/11/22 ���� 11:04:11 (QP5 v5.215.12089.38647) */
--������ �� ����
--���� �����ȹ ���̸� Ȯ���� �� �˾ƾ� �Ѵ�.

SELECT empno FROM emp;

--empno�� ���, PKŰ�̸� �ε��� ���� ������.
--INDEX��? SQL �˻� �ӵ��� ���̱� ���� ����ϴ� ��� �� �ϳ��̴�.
--https://m.blog.naver.com/dnjswls23/222026710074

SELECT empno, ename FROM emp;

SELECT /*+ALL ROWS */
       empno FROM emp;

SELECT /*+ index_desc(emp pk_emp) */
       empno FROM emp;

--īŸ�þ��� �� �߻� �����Ⱚ �߻�

SELECT empno, ename, dept.dname
  FROM emp, dept;

--������ �־� �ش��ϴ� ���� ��ȸ ����

SELECT empno, ename, dept.dname
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;



--rule base ��뿡 ���� �����ȹ ����(Nested Loop���)-> 8�и���

SELECT /*+ rule */
      *
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;

--�����Է��Ѵ�� Hash Join ��� -> 13�и���

SELECT *
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;

--rowid �� �ະ id�� ��ȸ, Ȯ�� ����

SELECT ROWID rid, ename FROM emp;

SELECT ROWNUM rno, ename FROM emp;

--rownum ������ ��������� ��ȣ ����

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

--���ϱ׷��� �׷��Լ��� �ƴϾ �� x

SELECT MAX (sal), ename FROM emp;

--1�� �ذ���. max�� ���� ������ ������ ���ϱ� ���� or Group By�� �ذ�???
--��ȿ���� ���� ���̱� ������ ���� ����

SELECT MAX (sal), MAX (ename) FROM emp;

--2�� �ذ���.

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

--��Ī�� ���� ���������� ����ϰ� �ʹٸ� �ζ��κ並 ����Ͻÿ�.

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

--decode sum�� �Բ� ���� ����(�Ұ�, �Ѱ� ��) 
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


--having��

SELECT 
        deptno, sum(sal), count(sal), max(sal), min(sal)
FROM emp
GROUP BY deptno;

SELECT greatest(1,5,3) AS "�ִ�", least(1,5,3) AS "�ּ�" FROM dual;

SELECT deptno, 
       CASE deptno
         WHEN 10 THEN 'ACCOUNTING'
         WHEN 20 THEN 'RESEARCH'
         WHEN 30 THEN 'SALES'
         ELSE 'OPERATIONS'
       END AS "Dept Name"
  FROM dept;
 
DEPTNO Dept NAME

--temp�� �ڷḦ salary�� �з��Ͽ� 30,000,000���ϴ� 'D',
--30,000,000 �ʰ� 50,000,000���ϴ� 'C'
--50,000,000 �ʰ� 70,000,000���ϴ� 'B'
--70,000,000 �ʰ��� 'A'��� ����� �з��Ͽ� ��޺� �ο����� �˰� �ʹ�.

SELECT count(���)
 FROM (
            SELECT
            CASE salary
                WHEN salary > 70000000 THEN 'A'
                WHEN salary BETWEEN 50000001 AND 70000000 THEN 'B'
                WHEN salary BETWEEN 30000001 AND 50000000 THEN 'C'
                ELSE 'D'
                END AS "���"
             FROM temp
             );


SELECT ���,count(���) AS "����" 
FROM(SELECT
            CASE 
                WHEN salary > 70000000 THEN 'A'
                WHEN salary BETWEEN 50000001 AND 70000000 THEN 'B'
                WHEN salary BETWEEN 30000001 AND 50000000 THEN 'C'
                ELSE 'D'
            END AS "���"
        FROM temp
        )
GROUP BY ���
ORDER BY ���;

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
 
--��¥�� �ǸŰ���, �ǸŰ��� 

SELECT �Ǹų�¥, �ǸŰ���
FROM (SELECT indate_vc AS "�Ǹų�¥"
             CASE 
                WHEN �Ǹų�¥='20040601' THEN sum(qty_nu)
                WHEN �Ǹų�¥='20040602' THEN sum(qty_nu)
                WHEN �Ǹų�¥='20040603' THEN sum(qty_nu)                
                END AS "�ǸŰ���"
                FROM t_orderbasket             
        )
GROUP BY �Ǹų�¥;

SELECT indate_vc AS "�Ǹų�¥" FROM t_orderbasket; 

SELECT indate_vc AS "�Ǹų�¥" FROM t_orderbasket
GROUP BY indate_vc;    

SELECT indate_vc AS "�Ǹų�¥" FROM t_orderbasket,
(SELECT ROWNUM rno FROM dept WHERE ROWNUM <3);


SELECT decode(b.rno,1,indate_vc,2,'�Ѱ�') AS "�Ǹų�¥"
FROM t_orderbasket,
        (SELECT ROWNUM rno 
        FROM dept 
        WHERE ROWNUM <3) b
        GROUP BY decode(b.rno,1,indate_vc,2,'�Ѱ�')
ORDER BY �Ǹų�¥;

SELECT decode(b.rno,1,indate_vc,2,'�Ѱ�') AS "�Ǹų�¥" 
FROM t_orderbasket,
        (SELECT  
            ROWNUM rno 
            FROM dept 
            WHERE ROWNUM <3)b
            ,
            GROUP BY decode(b.rno,1,indate_vc,2,'�Ѱ�')
ORDER BY �Ǹų�¥;


SELECT decode(b.rno,1,indate_vc,2,'�Ѱ�') AS "�Ǹų�¥"
          ,to_char(sum(qty_nu)||'��') AS "�ǸŰ���"
          ,to_char(sum(qty_nu*price_nu)||' ��')AS "�ǸŰ���"
FROM t_orderbasket,
        (SELECT ROWNUM rno 
        FROM dept 
        WHERE ROWNUM <3)b
        GROUP BY decode(b.rno,1,indate_vc,2,'�Ѱ�')
ORDER BY �Ǹų�¥;

--
SELECT sum(price_nu*qty_nu) AS "�Ǹ��Ѿ�"
FROM t_orderbasket;


--��¥���� GROUP BY
SELECT deptno
FROM emp
GROUP BY deptno;

SELECT indate_vc AS "�Ǹų�¥", sum(qty_nu) AS "�Ǹż���", sum(price_nu*qty_nu) AS "�Ǹ��Ѿ�"
FROM t_orderbasket
GROUP BY indate_vc;

SELECT decode(JOB,'CLERK',sal),decode(JOB,'SALESMAN',sal), decode(JOB, 'CLERK',NULL,'SALESMAN',NULL,'ETC')


--��¥�� �ǸŰ���, �ǸŰ��� 
--�� �Ʒ� �ο쿡 '�Ѱ�'�߰�
SELECT decode(A.rno,1,indate_vc,2,'�Ѱ�') AS "�Ǹų�¥"
          ,to_char(sum(qty_nu)||'��') AS "�ǸŰ���"
          ,to_char(sum(qty_nu*price_nu)||' ��')AS "�ǸŰ���"
FROM t_orderbasket,
        (
        SELECT 1 rno FROM dual
        UNION ALL
        SELECT 2 FROM dual
        )A
        GROUP BY decode(A.rno,1,indate_vc,2,'�Ѱ�')
        ORDER BY decode(A.rno,1,indate_vc,2,'�Ѱ�');



--3�� ���� ������ ��
SELECT sum(A.�Ѱ�) AS "�Ѱ�"
FROM(
        SELECT sum(price_nu*qty_nu) AS "�Ѱ�"
        FROM t_orderbasket
        GROUP BY indate_vc
        )A;

--�������� ���� 


-- case...when������ Ȱ���Ұ�
--member1���̺��� �̿��Ͽ� ���̵� �������� ������ -1�� ��ȯ�ϰ�
--���̵� �����ϸ� ������� ���Ͽ� ������ 1�� ��ȯ�ϰ�
--�ٸ��� 0�� ��ȯ�ϴ� select���� �ۼ��Ͻÿ�.

--=:�� ���� ��Ű�� ���ǿ� ��´�?? 
SELECT m_name
FROM member1
WHERE m_id =:ID
AND m_pw=:pw;

edit member1;

SELECT CASE WHEN m_id =:ID THEN 0 END FROM member1;


SELECT CASE WHEN m_id =:ID THEN 0 END FROM member1
WHERE ROWNUM =1;

SELECT CASE WHEN m_id =:ID THEN 0
              ELSE -1
              END
   FROM member1
WHERE ROWNUM =1;


SELECT m_ID, ROWNUM
FROM member1;

SELECT result
FROM(
        SELECT CASE WHEN m_id =:ID THEN 
            CASE WHEN m_pw =:pw THEN 1 
            ELSE 0 
            END                 
          ELSE -1 
          END AS result
        FROM member1
        ORDER BY result desc
        )
WHERE ROWNUM =1;

--1���� ��¥�� ���� ��� 
--2���� �Ѱ豸�� �� ��갪���� ���



--�����н�����
--�� �࿡ 1�г���� 4�г���� �и� �� �࿡ �ϳ��� �г⸸ �������� (6��-06-002)
--����� �ο쿡 �г⺰ ���� -> �÷����� �г⺰ ������ �������� ��ȯ
--12�� �а�, 4�г� īŸ�þ� �� ��� & decode ��� ???

SELECT * FROM test11;

        

SELECT dept 
         ,decode(rno,1,'1�г�',2,'2�г�',3,'3�г�',4,'4�г�') AS "�г�"
         ,decode(rno,1,fre,2,sup,3,jun,4,sen) AS "����"
FROM test11,
        ( 
        SELECT ROWNUM rno FROM dept WHERE ROWNUM <=4
        )
ORDER BY dept ASC, decode(rno,1,'1�г�',2,'2�г�',3,'3�г�',4,'4�г�') ASC;

--��������
--���� : ������̺��� job�� clerk�� ����� �޿� ��,  salesman�� �����
--�޿��� ���� ���ϰ� ������ job�� ���ؼ��� ��Ÿ ������ ���Ͻÿ�.

SELECT dname FROM dept;

--������
SELECT 1,2,3 FROM dual;

--�Ʒ��� 
SELECT 1,2,3 FROM dual
UNION ALL
SELECT 1,2,3 FROM dual;



--�켱, ������ �޿��հ����! 
SELECT dname,       
       sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
       sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
       sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
       sum(sal) AS "DEPT_SAL"
FROM emp, dept
GROUP BY dept.dname; 

--�Ѱ�ֱ�
SELECT '�Ѱ�',      
       sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
       sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
       sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
       sum(sal) AS "DEPT_SAL"
FROM emp; 

--��ġ�� 
SELECT dname,       
       sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
       sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
       sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
       sum(sal) AS "DEPT_SAL"
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY dept.dname 
UNION ALL 
SELECT '�Ѱ�',      
       sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
       sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
       sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
       sum(sal) AS "DEPT_SAL"
FROM emp; 
--�������� ã�ƺ��� (���̺��� �ѹ��� �а� ó���ϵ���!) 
 
SELECT deptno,
    sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
    sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
    sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
    sum(sal) AS "DEPT_SAL"
FROM emp 
GROUP BY deptno;

SELECT 
        deptno, CLERK, SALESMAN, ETC, DEPT_SAL        
FROM
        (  
        SELECT deptno,
            sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
            sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
            sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
            sum(sal) AS "DEPT_SAL"
        FROM emp 
        GROUP BY deptno
        );
        
SELECT dname, clerk, salesman, etc, dept_sal
FROM
        (
        SELECT 
        deptno, CLERK, SALESMAN, ETC, DEPT_SAL        
        FROM
        (  
        SELECT deptno,
            sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
            sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
            sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
            sum(sal) AS "DEPT_SAL"
        FROM emp 
        GROUP BY deptno
        )
        )E, dept d
WHERE E.deptno = d.deptno;

SELECT dname, clerk, salesman, etc, dept_sal
         FROM
            (
            SELECT 
                    deptno, CLERK, SALESMAN, ETC, DEPT_SAL        
             FROM
                    (  
                    SELECT deptno,
                              sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
                              sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
                              sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
                              sum(sal) AS "DEPT_SAL"
                     FROM emp 
                    GROUP BY deptno
                    )
            )E, dept d
        WHERE E.deptno = d.deptno
        )A,
        (SELECT ROWNUM rno FROM dept WHERE ROWNUM < 3)b;

SELECT 
        decode(b.rno,1,dname,2,'�Ѱ�')
FROM 
        (
        SELECT dname, clerk, salesman, etc, dept_sal
         FROM
            (
            SELECT 
                    deptno, CLERK, SALESMAN, ETC, DEPT_SAL        
             FROM
                    (  
                    SELECT deptno,
                              sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
                              sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
                              sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
                              sum(sal) AS "DEPT_SAL"
                     FROM emp 
                    GROUP BY deptno
                    )
            )E, dept d
        WHERE E.deptno = d.deptno
        )A,
        (SELECT ROWNUM rno FROM dept WHERE ROWNUM < 3)b
GROUP BY decode(b.rno,1,dname,2,'�Ѱ�')
ORDER BY decode(b.rno,1,dname,2,'�Ѱ�');

SELECT 
        decode(b.rno,1,dname,2,'�Ѱ�') AS "dname",sum(clerk) AS "CLERK" , sum(salesman) AS "SALESMAN", sum(etc) AS "ETC"
FROM 
        (
        SELECT dname, clerk, salesman, etc, dept_sal
         FROM
            (
            SELECT 
                    deptno, CLERK, SALESMAN, ETC, DEPT_SAL        
             FROM
                    (  
                    SELECT deptno,
                              sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
                              sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
                              sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
                              sum(sal) AS "DEPT_SAL"
                     FROM emp 
                    GROUP BY deptno
                    )
            )E, dept d
        WHERE E.deptno = d.deptno
        )A,
        (SELECT ROWNUM rno FROM dept WHERE ROWNUM < 3)b
GROUP BY decode(b.rno,1,dname,2,'�Ѱ�')
ORDER BY decode(b.rno,1,dname,2,'�Ѱ�');

SELECT 
        decode(b.rno,1,dname,2,'�Ѱ�') AS "dname",sum(clerk) AS "CLERK" , sum(salesman) AS "SALESMAN", sum(etc) AS "ETC"
FROM 
        (
        SELECT dname, clerk, salesman, etc, dept_sal
         FROM
            (
            SELECT 
                    deptno, CLERK, SALESMAN, ETC, DEPT_SAL        
             FROM
                    (  
                    SELECT deptno,
                              sum(DECODE (JOB, 'CLERK', sal)) AS "CLERK",
                              sum(DECODE (JOB, 'SALESMAN', sal)) AS "SALESMAN",
                              sum(DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL, sal)) AS "ETC",
                              sum(sal) AS "DEPT_SAL"
                     FROM emp 
                    GROUP BY deptno
                    )
            )E, dept d
        WHERE E.deptno = d.deptno
        )A,
        (SELECT ROWNUM rno FROM dept WHERE ROWNUM < 3)b
GROUP BY decode(b.rno,1,dname,2,'�Ѱ�')
ORDER BY decode(b.rno,1,dname,2,'�Ѱ�');


