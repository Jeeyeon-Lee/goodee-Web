/* Formatted on 2023/11/21 ���� 8:10:20 (QP5 v5.215.12089.38647) */
SELECT empno, sal
  FROM (SELECT empno, ename
          FROM emp
         WHERE deptno = 10);

SELECT empno FROM emp;

SELECT ename, sal FROM emp;

--������ȭ �������� ���� ?

SELECT emp.empno, emp.ename, dept.dname
  FROM dept, emp
 WHERE dept.deptno = emp.deptno;

--�׷��Լ� max, min, avg �� -> ��ü���� ó��

SELECT TO_CHAR (MAX (sal), '999,999,999') || '����' AS "max",
       TO_CHAR (MIN (sal), '999,999,999') || '����' AS "min",
       TO_CHAR (ROUND (AVG (sal)), '999,999,999') || '����' AS "avg"
  FROM emp;

SELECT ename
  FROM emp
 WHERE sal = (SELECT MAX (sal) FROM emp);

--6.TEMP�� �ڷ� �� EMP_ID�� EMP_NAME�� ���� �������,���������� ǥ�õǾ�
--DISPLAY�ǵ��� COLUMN ALLIAS�� �ο��Ͽ� SELECT �Ͻÿ�.


SELECT TO_CHAR (emp_id) || '��' AS "���", emp_name AS "����" FROM temp;

SELECT ���, ����
  FROM (SELECT emp_id AS "���", emp_name AS "����" FROM temp);

--7.TEMP�� �ڷḦ ���� ��(LEV)�� ASCENDING(����)�ϸ鼭 ��������� �ٽ� ���(EMP_NAME) ������
--DESCENDING(����)�ϰ� �ϴ� ORDER BY�ϴ� ������ ����� ���ÿ�.

  SELECT *
    FROM temp
ORDER BY lev ASC, emp_name DESC;

--8. �μ��� �޿� ����� ���Ͻÿ�

  SELECT deptno AS "�μ���ȣ",
         TO_CHAR (ROUND (AVG (sal)), '9,999') || '����' AS "��ձ޿�"
    FROM emp
GROUP BY deptno
ORDER BY ��ձ޿� DESC;



  SELECT deptno AS "�μ���ȣ",
         TO_CHAR (ROUND (AVG (sal)), '9,999') || '����' AS "��ձ޿�"
    FROM emp
GROUP BY deptno
  HAVING AVG (sal) > 2000
ORDER BY ��ձ޿� DESC;

SELECT * FROM t_letitbe;

--Mod?

--Ȧ���� ����

SELECT MOD (seq_vc, 2)
  FROM t_letitbe
 WHERE MOD (seq_vc, 2) = 1;

--¦���� ����

SELECT MOD (seq_vc, 2)
  FROM t_letitbe
 WHERE MOD (seq_vc, 2) = 0;

--1. ����縸 ����

SELECT MOD (seq_vc, 2), WORDS_VC
  FROM T_LETITBE
 WHERE MOD (seq_vc, 2) = 1;

SELECT eng_words
  FROM (SELECT DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words FROM t_letitbe);

SELECT num, eng_words
  FROM (SELECT MOD (seq_vc, 2) num,
               DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words
          FROM t_letitbe)
 WHERE num = 1;


--2. �ѱ۰��縸 ����

SELECT MOD (seq_vc, 2), WORDS_VC
  FROM T_LETITBE
 WHERE MOD (seq_vc, 2) = 0;

SELECT num, eng_words
  FROM (SELECT MOD (seq_vc, 2) num,
               DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words
          FROM t_letitbe)
 WHERE num = 1;

--3.��������� �ѱ۰��� ��� ������ �ϱ�

SELECT TO_NUMBER (seq_vc), WORDS_VC
  FROM T_LETITBE
 WHERE MOD (seq_vc, 2) = 1
UNION
SELECT TO_NUMBER (seq_vc), WORDS_VC
  FROM T_LETITBE
 WHERE MOD (seq_vc, 2) = 0;



--1. ��ȭ Ƽ���� ���� �� �ִ� ����� ��ܰ� ���� ������ �ִ� ����Ʈ, ��ȭ Ƽ���� ����Ʈ
--�׸��� �� Ƽ���� ����� �� ���� ���� ����Ʈ�� ����Ͻÿ�

SELECT * FROM T_GIFTMEM;

SELECT * FROM t_giftpoint;

--��ȭƼ�� 15000��
--���� ����Ʈ - ȸ����������Ʈ-��ȭ����Ʈ = �ܿ�����Ʈ
--where ���ǽ� : ��������Ʈ > ��ȭƼ�� ����Ʈ

--from���� �� �ζ��� �� �ۼ� -> ��� �ٿ��� �ӵ� ���

SELECT point_nu
  FROM t_giftpoint
 WHERE name_vc = '��ȭƼ��';

SELECT *
  FROM t_giftmem mem,
       (SELECT point_nu
          FROM t_giftpoint
         WHERE name_vc = '��ȭƼ��') poi;

SELECT name_vc AS "ȸ���̸�",
       mem.point_nu - poi.point_nu AS "�ܿ�����Ʈ"
  FROM t_giftmem mem,
       (SELECT point_nu
          FROM t_giftpoint
         WHERE name_vc = '��ȭƼ��') poi
 WHERE mem.point_nu - poi.point_nu > 0;


SELECT name_vc AS "ȸ���̸�",
       mem.point_nu - poi.point_nu AS "�ܿ�����Ʈ"
  FROM t_giftmem mem,
       (SELECT point_nu
          FROM t_giftpoint
         WHERE name_vc = '��ȭƼ��') poi
 WHERE mem.point_nu >= poi.point_nu;

--2.�����ž��� �����ϰ� �ִ� ���ϸ��� ����Ʈ�� ���� �� �ִ� ��ǰ ��
--���� ����Ʈ�� ���� ���� �����ΰ�?

--������ ����Ʈ ��������

SELECT mem.NAME_vc AS "�̸�", mem.point_nu AS "����Ʈ"
  FROM t_giftmem mem
 WHERE mem.Name_vc = '������';

--���� ����Ʈ ���� ��ǰ

SELECT MAX (poi.point_nu)
  FROM t_giftpoint poi
 WHERE point_nu <= 50012;

--�� �� ����

SELECT poi.name_vc AS "��ǰ"
  FROM t_giftpoint poi
 WHERE point_nu = (SELECT MAX (poi.point_nu)
                     FROM t_giftpoint poi
                    WHERE point_nu <= 50012);

--decode �ǽ�

SELECT DECODE (1, 1, 't'),                                                 --t
                          DECODE (1, 2, 't', 'f')                          --f
                                                 FROM DUAL;

 --����, �ü��� ���� ���, �Ϲݰ����� �����ޱ�

SELECT lec_id,
       lec_time,
       lec_point,
       DECODE (lec_time, lec_point, '�Ϲݰ���', '�ٸ�')
  FROM lecture;

SELECT lec_id, DECODE (lec_time, lec_point, '�Ϲݰ���', NULL)
  FROM lecture;

--2. �ִ� ���� �ð��� ������ ���� ������ ���ڸ� �˰� ����. (decode ���)

SELECT COUNT (DECODE (lec_time, lec_point, 1)) AS "������ ��"
  FROM lecture;

 --3.���ǽð��� ������ ���ų� ���ǽð�<���� '�Ϲݰ���',
 --���ǽð�>���� '�������',

SELECT DECODE (lec_time - lec_point, 1, '�������', '�Ϲݰ���')
          AS "����"
  FROM lecture;


SELECT lec_id,
       DECODE (lec_time, lec_point, '�Ϲݰ���') AS "����1",
       DECODE (SIGN (lec_time - lec_point), 1, '�������') AS "����2",
       DECODE (SIGN (lec_time - lec_point), -1, '�Ϲݰ���') AS "����3"
  FROM lecture;



 --3-1.lec_time�� ũ�� '�������, lec_point�� ũ�� '��Ÿ����',
 --������ '�Ϲݰ���'���� �����ޱ�

SELECT DECODE (SIGN (lec_time - lec_point),
               1, '��Ÿ����',
               0, '�Ϲݰ���',
               -1, '�������')
          AS "����"
  FROM lecture;

 --3-2. ���ǽð� = ���� , '�Ϲݰ���' & ����

  SELECT lec_id, DECODE (lec_time, lec_point, '�Ϲݰ���', NULL) AS "����"
    FROM lecture
ORDER BY lec_id;

  SELECT lec_id, DECODE (lec_time, lec_point, '�Ϲݰ���', NULL) AS "����"
    FROM lecture
ORDER BY DECODE (lec_time, lec_point, '�Ϲݰ���', NULL) ASC;

 --�μ�Ƽ�� ���� �޴� ��� ��

  SELECT comm
    FROM emp
   WHERE comm IS NOT NULL
ORDER BY comm DESC;

-- ���� �ִ� ��쿡�� �ΰ��� ���� ���� �ö��.

  SELECT comm
    FROM emp
ORDER BY comm DESC;


--(if�� decode) �����Ͽ� �ش����ڿ� 01�� �ٿ��� 4�ڸ� ��ȣ�� �����,
--ȭ���Ͽ� 11, �����Ͽ� 21, ����Ͽ�, 31, �ݿ��Ͽ� 41, ����Ͽ� 51,
--�Ͽ��Ͽ� 61�� �ٿ��� 4�ڸ� ��ȣ�� ����ٰ� �� ��
--��ȣ�� SELECT�ϴ� SQL�� ����� ���ÿ�.

--����, ����, ���� but ���� ���x ��?? UI �޾ƿ��� ���� ��κ��̰�, �� ���� ��κ� ���ڿ���

SELECT SYSDATE - 1, SYSDATE, SYSDATE + 1 FROM DUAL;

SELECT SYSDATE AS "����",
       TO_CHAR (SYSDATE, 'DD') AS "��¥",
       TO_CHAR (SYSDATE, 'day') AS "����"
  FROM DUAL;

--(if�� decode) �����Ͽ� �ش����ڿ� 01�� �ٿ��� 4�ڸ� ��ȣ�� �����,
--ȭ���Ͽ� 11, �����Ͽ� 21, ����Ͽ�, 31, �ݿ��Ͽ� 41, ����Ͽ� 51,
--�Ͽ��Ͽ� 61�� �ٿ��� 4�ڸ� ��ȣ�� ����ٰ� �� ��
--��ȣ�� SELECT�ϴ� SQL�� ����� ���ÿ�.

SELECT    DECODE (TO_CHAR (SYSDATE, 'day'),
                  '������', '01',
                  'ȭ����', '11',
                  '������', '21',
                  '�����', '31',
                  '�ݿ���', '41',
                  '�����', '51',
                  '�Ͽ���', '61')
       || TO_CHAR (SYSDATE, 'DD')
          AS "���� ��ȣ"
  FROM DUAL;


--��������
--���� : ������̺��� job�� clerk�� ����� �޿� ��,  salesman�� �����
--�޿��� ���� ���ϰ� ������ job�� ���ؼ��� ��Ÿ ������ ���Ͻÿ�.

  SELECT JOB, TO_CHAR (SUM (sal), '9,999') || '��' AS "�ѱ޿�"
    FROM emp
GROUP BY JOB;

SELECT DECODE (JOB, 'clerk', sal, NULL) FROM emp;


SELECT DECODE (JOB, 'CLERK', sal, NULL),
       DECODE (JOB, 'SALESMAN', sal, NULL),
       DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL,  sal)
  FROM emp;


SELECT JOB, DECODE (JOB,  'CLERK', sal,  'SALESMAN', sal,  sal) AS "��"
  FROM emp;


  SELECT JOB, TO_CHAR (SUM (sal), '9,999') || '��'
    FROM emp,
         (SELECT DECODE (JOB,  'CLERK', sal,  'SALESMAN', sal,  sal) FROM emp)
GROUP BY JOB;

  SELECT JOB, SUM (sal)
    FROM emp,
         (SELECT DECODE (JOB,  'CLERK', sal,  'SALESMAN', sal,  sal) FROM emp)
GROUP BY JOB;


SELECT SUM (DECODE (JOB, 'CLERK', sal)) FROM emp;


SELECT dname,
       DECODE (JOB, 'CLERK', sal, NULL) AS "CLERK",
       DECODE (JOB, 'MANAGER', sal, NULL) AS "MANAGER",
       DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL,  sal) AS "ETC"
  FROM emp, dept;


SELECT DISTINCT
       dname,
       DECODE (JOB, 'CLERK', sal, NULL) AS "CLERK",
       DECODE (JOB, 'MANAGER', sal, NULL) AS "MANAGER",
       DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL,  sal) AS "ETC"
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;

  SELECT DISTINCT dname,
                  CLERK,
                  MANAGER,
                  ETC
    FROM (SELECT dname,
                 DECODE (JOB, 'CLERK', sal, NULL) AS "CLERK",
                 DECODE (JOB, 'MANAGER', sal, NULL) AS "MANAGER",
                 DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL,  sal) AS "ETC"
            FROM emp, dept
           WHERE emp.deptno = dept.deptno)
ORDER BY dname;


--empno �� max �� ���� ���� ������ ������ �ذ��ϱ� ���ؼ��� ���̴�.

SELECT MAX (empno),
       COUNT (DECODE (JOB, 'CLERK', sal, NULL)),
       SUM (DECODE (JOB, 'CLERK', sal, NULL)),
       COUNT (DECODE (JOB, 'SALESMAN', sal, NULL)),
       SUM (DECODE (JOB, 'SALESMAN', sal, NULL))
  FROM emp;


--empno �� max �� ���� ���� ������ ������ �ذ��ϱ� ���ؼ��� ���̴�.

SELECT SUM (DECODE (JOB, 'CLERK', sal, NULL)),
       SUM (DECODE (JOB, 'SALESMAN', sal, NULL)),
       SUM (DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL,  sal)) etc_sal,
       SUM (sal)
  FROM emp;

--�ѹ� �а� ó���ϵ���

--emp ���̺� ����̸��� �� �࿡ ���, ������ �� �� �����ִ� �������� �ۼ��Ͻÿ�.

--�����н�����
--�� �࿡ 1�г���� 4�г���� �и� �� �࿡ �ϳ��� �г⸸ �������� (6��-06-002)
--����� �ο쿡 �г⺰ ���� -> �÷����� �г⺰ ������ �������� ��ȯ
--12�� �а�, 4�г� īŸ�þ� �� ��� & decode ��� ???

SELECT * FROM test11;


--max, min�൵ ������ ���� �� A�÷��� ���� ������ ������ �ذ��ϴ� �뵵�� ���Ǿ��� �����̴�.

SELECT A.dept,
       b.rno AS "�г�",
       DECODE (b.rno,  1, A.fre,  2, A.sup,  3, A.jun,  4, A.sen)
          AS "������"
  FROM (SELECT dept,
               fre,
               sup,
               jun,
               sen
          FROM test11
         WHERE dept = '�װ����ְ��а�') A,
       (SELECT ROWNUM rno
          FROM dept
         WHERE ROWNUM <= 4) b;

SELECT DECODE (MOD (seq_vc, 2), 1, words_vc, '0') eng_words FROM t_letitbe;

SELECT dname FROM emp;

SELECT DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words
  FROM t_letitbe
 WHERE eng_words = 1;

 ��Ī�� ���� ���������� ����ϰ� �ʹٸ� �ζ��κ並 ����Ͻÿ�.

SELECT eng_words
  FROM (SELECT DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words FROM t_letitbe);

SELECT num, eng_words
  FROM (SELECT MOD (seq_vc, 2) num,
               DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words
          FROM t_letitbe)
 WHERE num = 1;