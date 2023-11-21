/* Formatted on 2023/11/21 ���� 10:14:23 (QP5 v5.215.12089.38647) */
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
SELECT 
    deptno AS "�μ���ȣ", 
    to_char(round(avg(sal)),'9,999')||'����' AS "��ձ޿�"
FROM emp
GROUP BY deptno
ORDER BY ��ձ޿� desc;

SELECT 
    deptno AS "�μ���ȣ", 
    to_char(round(avg(sal)),'9,999')||'����' AS "��ձ޿�"
FROM emp
GROUP BY deptno
HAVING avg(sal)>2000
ORDER BY ��ձ޿� desc;

CREATE TABLE T_LETITBE
(
SEQ_VC VARCHAR2(2),
WORDS_VC VARCHAR2(100)
)
/
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (1,'Let it be');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (2,'������ �ξ��');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (3,'When I find myself in times of trouble');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (4,'���� ���ο��� �ð����� ��Ȳ�� ���� ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (5,'Mother Mary comes to me Speaking words of wisdom,');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (6,'��Ӵϴ� ���� �ٰ��� ������ ������ ���ֽŴ�. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (7,'Let it be ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (8,'������ �ξ��.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (9,'And in my hour of darkness ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (10,'�׸��� ���� ��Ҽӿ� ����� ��, ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (11,'She is standing right in front of me Speaking words of wisdom,');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (12,'�׳�� �� �ٷ� �տ���, ������ ������ ���ֽŴ�. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (13,'Let it be. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (14,'������ �ξ��.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (15,'And when the broken hearted people Living in the world agree, There will be an answer, ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (16,'�� ������ ��ó���� ������� �� ������ ����� �� �Ŷ� �ϴ´�. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (17,'Let it be ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (18,'������ �ξ��.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (19,'For though they may be parted ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (20,'�׵��� ��������� ������ �׵��� ���� ��ȸ�� �������̴�. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (21,'There is still a chance that they will see, There will be an answer,');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (22,'����� ���� ���̴�.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (23,'let it be ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (24,'������ �ξ��.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (25,'And the night is cloudy, there is still a light that shines on me.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (26,'������ �� �㿡��, ���� �� ���߾��ִ� ���� �־�. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (27,'Shine until tomorrow, let it be.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (28,'����� ��ӵ� ���̴�.������ �ξ��. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (29,'I wake up to the sound of music,');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (30,'���� �Ҹ��� �� �����, ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (31,'Mother Mary comes to me,Speaking words of whisdom,');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (32,'��Ӵ� �޾�� ���� �ٰ���,������ ������ �� �ֽŴ�. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (33,'Let it be.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (34,'������ �ξ��. ');
COMMIT;

SELECT*FROM t_letitbe;
--Mod?

--Ȧ���� ����
SELECT mod(seq_vc,2) FROM t_letitbe
WHERE mod(seq_vc,2) =1;

--¦���� ����
SELECT mod(seq_vc,2) FROM t_letitbe
WHERE mod(seq_vc,2) =0;

--1. ����縸 ����
SELECT mod(seq_vc,2), WORDS_VC FROM T_LETITBE 
WHERE mod(seq_vc,2) =1;

--2. �ѱ۰��縸 ����
SELECT mod(seq_vc,2), WORDS_VC FROM T_LETITBE 
WHERE mod(seq_vc,2) =0;

--3.��������� �ѱ۰��� ��� ������ �ϱ� 
SELECT to_number(seq_vc) , WORDS_VC FROM T_LETITBE 
WHERE mod(seq_vc,2) =1
UNION
SELECT to_number(seq_vc), WORDS_VC FROM T_LETITBE 
WHERE mod(seq_vc,2) =0;


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
    (
    SELECT point_nu
    FROM t_giftpoint
    WHERE name_vc = '��ȭƼ��'
    ) poi;
    
SELECT name_vc AS "ȸ���̸�",mem.point_nu-poi.point_nu AS "�ܿ�����Ʈ" 
FROM t_giftmem mem,
    (
    SELECT point_nu
    FROM t_giftpoint
    WHERE name_vc = '��ȭƼ��'
    ) poi
WHERE mem.point_nu-poi.point_nu>0;  


SELECT name_vc AS "ȸ���̸�",mem.point_nu-poi.point_nu AS "�ܿ�����Ʈ" 
FROM t_giftmem mem,
    (
    SELECT point_nu
    FROM t_giftpoint
    WHERE name_vc = '��ȭƼ��'
    ) poi
WHERE mem.point_nu>=poi.point_nu;

--2.�����ž��� �����ϰ� �ִ� ���ϸ��� ����Ʈ�� ���� �� �ִ� ��ǰ �� 
--���� ����Ʈ�� ���� ���� �����ΰ�?

--������ ����Ʈ ��������
SELECT mem.NAME_vc AS "�̸�", mem.point_nu AS "����Ʈ"
FROM
    t_giftmem mem  
WHERE mem.Name_vc = '������';

--���� ����Ʈ ���� ��ǰ
SELECT max(poi.point_nu)
FROM t_giftpoint poi
WHERE point_nu<=50012;

--�� �� ����
SELECT poi.name_vc AS "��ǰ"
FROM
    t_giftpoint poi  
WHERE point_nu = (
    SELECT max(poi.point_nu)
    FROM t_giftpoint poi
    WHERE point_nu<=50012
    );

--decode �ǽ�
SELECT decode(1,1,'t'),    --t
            decode(1,2,'t','f')  --f
 FROM dual;
 
 --����, �ü��� ���� ���, �Ϲݰ����� �����ޱ�
SELECT lec_id, lec_time, lec_point, decode(lec_time,lec_point,'�Ϲݰ���','�ٸ�')
FROM lecture;

SELECT lec_id, decode(lec_time,lec_point,'�Ϲݰ���',NULL)
FROM lecture;

--2. �ִ� ���� �ð��� ������ ���� ������ ���ڸ� �˰� ����. (decode ���)
SELECT count(decode(lec_time,lec_point,1)) AS "������ ��"
FROM lecture ;
    
 --3.���ǽð��� ������ ���ų� ���ǽð�<���� '�Ϲݰ���',
 --���ǽð�>���� '�������',
 
 SELECT decode(lec_time-lec_point,1,'�������','�Ϲݰ���') AS "����"
 FROM lecture;
 
 
 SELECT 
        lec_id,
        decode(lec_time,lec_point,'�Ϲݰ���') AS "����1",  
        decode(sign(lec_time-lec_point),1,'�������') AS "����2", 
        decode(sign(lec_time-lec_point),-1,'�Ϲݰ���') AS "����3"
 FROM lecture;

 
 
 --3-1.lec_time�� ũ�� '�������, lec_point�� ũ�� '��Ÿ����',
 --������ '�Ϲݰ���'���� �����ޱ� 
 
 SELECT decode(sign(lec_time-lec_point),1,'��Ÿ����','�Ϲݰ���') AS "����"
 FROM lecture;
 
 --�����Ͽ� �ش����ڿ� 01�� �ٿ��� 4�ڸ� ��ȣ�� �����, 
--ȭ���Ͽ� 11, �����Ͽ� 21, ����Ͽ�, 31, �ݿ��Ͽ� 41, ����Ͽ� 51,
--�Ͽ��Ͽ� 61�� �ٿ��� 4�ڸ� ��ȣ�� ����ٰ� �� �� 
--��ȣ�� SELECT�ϴ� SQL�� ����� ���ÿ�.

SELECT sysdate AS "��¥", To_char(sysdate,'DD')
FROM dual;

