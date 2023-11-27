--�� ����� ����, �̸�, salary, �������ѱݾ�, �������ѱݾ��� ������ �Ѵ�.
--temp�� emp_level�� �����Ͽ� ����� �����ֵ�, ������ �������� ��ϵǾ� ���� ����
--'����' ����� ����, �̸�, salary �������̶� ���� �� �ֵ��� ������ �ۼ��Ͻÿ�.

SELECT emp_name, salary, to_sal, from_sal
FROM temp, emp_level;


SELECT emp_name, temp.lev, salary, to_sal, from_sal
FROM temp, emp_level
WHERE temp.lev = emp_level.lev(+);

--����� ���� ����� ��� ���� ���, ����̸�, �μ��̸� ��������
SELECT empno, ename, dname
FROM emp, dept
WHERE emp.deptno(+) = dept.deptno;

SELECT empno, ename, dname
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno = dept.deptno;


--��ǰ�� ȸ���� ���� ����?? (n:n) 

SELECT * FROM t_giftmem;

SELECT * FROM t_giftpoint;

--��ȭƼ�� ����� �� �ִ� ������ ?? 
SELECT  *
FROM t_giftmem, t_giftpoint;

SELECT  *
FROM t_giftmem mem, t_giftpoint poi
WHERE poi.name_vc = '��������'
AND poi.point_nu <= mem.point_nu;

COMMIT;

SELECT * FROM emp;

SELECT A.ename AS "�Ŵ���", b.ename AS "���"
FROM emp A, emp b
WHERE A.empno = b.mgr
ORDER BY A.ename;

--temp�� tdept�� �̿��Ͽ� ���� �÷��� �����ִ� SQL�� ����� ����.
--�����μ��� 'CA0001'�� �μ��� �Ҽӵ� ������ 1.���, 2.����, 3.�μ��ڵ�
--4.�μ���, 5.�����μ��ڵ�, 6.�����μ���, 7.�����μ����ڵ�, 8.�����μ��强��
--������ �����ָ� �ȴ�.(temp(20) 2, tdept(10) 2��) , 
SELECT *
FROM temp, tdept;

--1~4���� ���
--�������(natural join)
SELECT A.emp_id, A.emp_name, b.dept_code, b.dept_name
FROM temp A, tdept b
WHERE A.dept_code = b.dept_code;

--natural join���� ���(AS ���x, ������ ���� ������ ����) 
SELECT emp_id, emp_name, dept_code, dept_name
FROM temp NATURAL JOIN tdept;

--���̺� �������� n-1�� ���ڰ� ���������� ���ڿ� ����. 
SELECT A.emp_id AS "���", A.emp_name AS "����"
        , b.dept_code AS "�μ��ڵ�", b.dept_name AS "�μ���"
        , C.DEPT_code AS "�����μ��ڵ�", c.dept_name AS "�����μ���"
FROM temp A, tdept b, tdept c
WHERE A.dept_code = b.dept_code
AND b.parent_dept = c.dept_code
AND c.dept_code = 'CA0001';


--���̺� �������� n-1�� ���ڰ� ���������� ���ڿ� ����. 
SELECT A.emp_id AS "���", A.emp_name AS "����"
        , b.dept_code AS "�μ��ڵ�", b.dept_name AS "�μ���"
        , C.DEPT_code AS "�����μ��ڵ�", c.dept_name AS "�����μ���"
        , c.boss_id AS "�����μ��� ���̵�"
        , d.emp_name AS "�����μ��� �̸�"
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