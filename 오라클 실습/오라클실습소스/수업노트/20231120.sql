/* Formatted on 2023/11/20 ���� 2:01:39 (QP5 v5.215.12089.38647) */
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

--���̺� acess���� �ʰ� ��ȸ�� �ȴ�.
--empno�� pk�̱� ������ �ε����� �⺻���� -> ������ ��ȸ
--��Ƽ�������� ���� ���� ���� ���� ã�ƿ�.

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

--������ ����(cross join - īŸ�þ��� �� - ����, �Ұ� ���� �� ���)
--emp 14row, dept 4row -> 56���� ���� ����. 
--�� �����ϳ�?? �ϳ��� ���� ���� �Ѱ�, �Ұ�, �߰� �� ������ ���Ǿ�� �ϱ� �����̴�. .
SELECT 
            dept.dname, emp.deptno, dept.deptno
FROM emp, dept;

--�����Ⱚ�� ���ԵǾ� �ִ�.  �̰� �����Ϸ���??  natural join 
--where�� ����  1:n�� ���迡�� deptno�� �ܷ�Ű�� �� ���� �� �� �ΰ��� ���� ���� ���ǹ��� ���� ����������
--���ǹ��� 14���� ���� ����. 
SELECT 
            dept.dname, emp.deptno, dept.deptno
FROM emp, dept
WHERE emp. deptno = dept.deptno;

SELECT max(sal), min(sal), avg(sal), round((avg(sal)),1) FROM emp;

SELECT ename FROM emp;

--ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
SELECT max(sal), min(sal), avg(sal), round((avg(sal)),1), ename FROM emp;


SELECT floor(-4.6) FROM dual;
INSERT INTO TEMP VALUES (19970101,'��浿',TO_DATE('19740125','YYYYMMDD'),'AA0001','����','Y','','���',100000000,'����');
INSERT INTO TEMP VALUES (19960101,'ȫ�浿',TO_DATE('19730322','YYYYMMDD'),'AB0001','����','Y','','����',72000000,'����');
INSERT INTO TEMP VALUES (19970201,'�ڹ���',TO_DATE('19750415','YYYYMMDD'),'AC0001','����','Y','','�ٵ�',50000000,'����');
INSERT INTO TEMP VALUES (19930331,'������',TO_DATE('19760525','YYYYMMDD'),'BA0001','����','Y','','�뷡',70000000,'����');
INSERT INTO TEMP VALUES (19950303,'�̼���',TO_DATE('19730615','YYYYMMDD'),'BB0001','����','Y','','',56000000,'�븮');
INSERT INTO TEMP VALUES (19966102,'������',TO_DATE('19720705','YYYYMMDD'),'BC0001','����','Y','','',45000000,'����');
INSERT INTO TEMP VALUES (19930402,'������',TO_DATE('19720815','YYYYMMDD'),'CA0001','����','Y','','',64000000,'����');
INSERT INTO TEMP VALUES (19960303,'����ġ',TO_DATE('19710925','YYYYMMDD'),'CB0001','����','Y','','',35000000,'���');
INSERT INTO TEMP VALUES (19970112,'�����',TO_DATE('19761105','YYYYMMDD'),'CC0001','����','Y','','',45000000,'�븮');
INSERT INTO TEMP VALUES (19960212,'�����',TO_DATE('19721215','YYYYMMDD'),'CD0001','����','Y','','',39000000,'����');
--
INSERT INTO TDEPT VALUES ('AA0001','�濵����','AA0001','Y','����',19940101);
INSERT INTO TDEPT VALUES ('AB0001','�繫','AA0001','Y','����',19960101);
INSERT INTO TDEPT VALUES ('AC0001','�ѹ�','AA0001','Y','����',19970201);
INSERT INTO TDEPT VALUES ('BA0001','�������','BA0001','Y','��õ',19930301);
INSERT INTO TDEPT VALUES ('BB0001','H/W����','BA0001','Y','��õ',19950303);
INSERT INTO TDEPT VALUES ('BC0001','S/W����','BA0001','Y','��õ',19966102);
INSERT INTO TDEPT VALUES ('CA0001','����','CA0001','Y','����',19930402);
INSERT INTO TDEPT VALUES ('CB0001','������ȹ','CA0001','Y','����',19950103);
INSERT INTO TDEPT VALUES ('CC0001','����1','CA0001','Y','����',19970112);
INSERT INTO TDEPT VALUES ('CD0001','����2','CA0001','Y','����',19960212);

COMMIT;

SELECT salary FROM temp;

SELECT salary/18, salary*2/18 FROM temp;

SELECT salary/9 FROM temp;

--1.�� �޿��� ������ 18�� ������ Ȧ�� �޿��� ������ 1/18�� ���޵ǰ�, 
--¦���޿��� ������ 2/18�� ���޵ȴٰ� �������� �� Ȧ�� �ް� ¦�� �޿� ���� �ݾ��� ��Ÿ���ÿ�.

SELECT salary/18 AS "¦�� �޿�", salary*2/18 AS "Ȧ�� �� �޿�" FROM temp;

--1-1���޿� ����, ������������ ����
SELECT to_char((salary), '999,999,999')||'��' AS "sal(ASC)" 
FROM temp 
ORDER BY salary ASC;

SELECT to_char((salary), '999,999,999')||'��' AS "sal(DESC)" 
FROM temp 
ORDER BY salary desc;


--2.������ ���� �� �޿��� ����� 10������ ���޵ȴٸ�(¦������ 20����)���� ������
--��� �ٲ��� �ۼ��� ���ÿ�.

SELECT (salary/18)+100000 AS "¦�� �޿�", (salary*2/18)+200000 AS "Ȧ�� �� �޿�" FROM temp;

SELECT to_Char( ((salary/18)+100000),'999,999,999')||'��' AS "¦�� �޿�", to_char(((salary*2/18)+200000),'999,999,999')||'��' AS "Ȧ�� �� �޿�" FROM temp;

SELECT sysdate, To_char(sysdate,'YYYY-MM-DD')
    ,to_char(sysdate, 'YYYY-MM-DD HH24:mi:ss am')
    ,to_char(sysdate, 'YYYY-MM-DD HH:mi:ss am')
    ,to_char(sysdate, 'day')
FROM dual;

SELECT round(12345.6789,1), round(12345.6789,-1), round(12345.6789,0) FROM dual;

--3.TEMP ���̺��� ��̰� NULL �� �ƴ� ����� ������ �о���ÿ�. -> 4��
SELECT emp_name, hobby 
FROM temp 
WHERE hobby IS NOT NULL;

SELECT emp_name, hobby
FROM temp
MINUS
SELECT emp_name, hobby
FROM temp
WHERE hobby IS NULL;

--3-0  -> 6��
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
SELECT emp_name,hobby FROM temp WHERE hobby = '���'
ORDER BY emp_name ASC;

--3-1.����̳� ���� ��̸� ���� ���� �̸� �������� in ���� ����ϱ� 
SELECT emp_name, hobby  
FROM temp
WHERE hobby IN('���', '����');

SELECT emp_name, hobby  
FROM temp
WHERE hobby ='���'
     OR hobby = '����';


--3-2.hobby�� null �Ǵ� ����� ���, ���Ͻÿ� 
SELECT emp_name, hobby  
FROM temp
WHERE hobby IS NULL 
     OR hobby = '���';
     
--3-3.hobby�� null �Ǵ� '����' ��ο� ������ �ʴ� ���
SELECT emp_name, hobby
FROM temp
MINUS
SELECT emp_name, hobby
FROM temp
WHERE hobby IS NULL 
     OR hobby = '����';

SELECT emp_name, hobby
FROM temp
WHERE hobby IS NOT NULL
MINUS
SELECT emp_name, hobby
FROM temp
WHERE hobby = '����';

SELECT emp_name, hobby
FROM temp
WHERE hobby IS NOT NULL
   AND hobby NOT IN('����');

--4.TEMP ���̺��� ��̰� NULL�� ����� ��� HOBBY�� ���������̶�� ���� ġȯ�Ͽ� �������� 
--�������� �״�� ���� �о���ÿ�.

SELECT emp_name, NVL(hobby,'����') AS "���" 
FROM temp;

--���ڸ� 0���� ġȯ�ϱ�
SELECT ename, comm, nvl(comm,0) FROM emp;

--5.TEMP�� �ڷ� �� HOBBY�� ���� NULL�� ����� ����ꡯ���� ġȯ���� �� 
--HOBBY�� ������� ����� ������ �������� ������ �ۼ��Ͻÿ�.

SELECT emp_name, ���
FROM (SELECT emp_name, NVL(hobby,'���') AS ��� FROM temp)
WHERE ��� = '���';

SELECT emp_name, NVL(hobby,'���') AS hobby FROM temp;

SELECT emp_name FROM temp
WHERE nvl(hobby,'���') = '���';

--6.TEMP�� �ڷ� �� EMP_ID�� EMP_NAME�� ���� �������,���������� ǥ�õǾ� 
--DISPLAY�ǵ��� COLUMN ALLIAS�� �ο��Ͽ� SELECT �Ͻÿ�.


SELECT to_char(emp_id)||'��' AS "���", emp_name AS "����"
FROM temp;

--7.TEMP�� �ڷḦ ���� ��(LEV)�� ASCENDING(����)�ϸ鼭 ��������� �ٽ� ���(EMP_NAME) ������
--DESCENDING(����)�ϰ� �ϴ� ORDER BY�ϴ� ������ ����� ���ÿ�.

SELECT lev, emp_name
FROM temp
ORDER BY emp_name desc;