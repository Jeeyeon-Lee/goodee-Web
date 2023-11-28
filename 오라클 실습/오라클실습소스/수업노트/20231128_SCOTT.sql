CURSOR����

SELECT  deptno, count(empno)
  FROM emp
 GROUP BY deptno;

--Ŀ�� �����ϱ�

CURSOR emp_cur IS
SELECT empno, ename, sal
  FROM emp
 WHERE deptno = p_deptno;
 
 --�޿������ ���Ѵ�
 
 SELECT avg(sal) INTO avg_sal 
   FROM emp
  WHERE deptno = p_deptno;
 
 LOOP
    FETCH emp_cur INTO v_empno, v_ename, v_sal;
    EXIT WHEN emp_cur%NOTFOUND;
    IF v_sal > avg_sal THEN
        rate :=1.1;
    ELSIF v_sal <= avg_sal THEN
        rate:=1.2;
    END IF;
    UPDATE emp
           SET sal = sal * rate
       WHERE empno = v_empno;
 END LOOP;
 
OPEN emp_cur;
CLOSE  emp_cur;

--�޿� ����� ���غ���.
SELECT avg(sal) INTO avg_sal
FROM emp
WHERE deptno = p_deptno;


--Ŀ���� �ۼ� �� 
--�� : 
--declare �̸��� ����, ȣ���� �� ��, ���� �� ��, �̸��� �ʿ��� 
-- pl/sql ����ü, ���ν���, �Լ�, Ʈ���� 
--IS �����
--BEGIN ���α׷�, DML, COMMIT, ROLLBACK, �ݺ���, ���� �� �� ���� ó��(�� �྿ ����)
-----------
DECLARE

CREATE OR REPLACE [PROCEDURE, FUNCTION, TRIGGER] �̸�()
IS
    --�����
BEGIN 
    --���α׷�, dml, commit, rollback, �ݺ���
    --������ �� ���� ó��
    --�ڵ����� ä���ϱ�
    EXCEPTION
END;

--Ÿ�� �� ũ��� �ش� ���̺��� Ÿ���� �����Ͽ� �ۼ��ϵ��� �Ѵ�. 

SELECT deptno FROM dept;

CREATE OR REPLACE PROCEDURE proc_emp_update2(p_deptno IN number)
IS
    --��� �޿� ���
    avg_sal number(7,2) := 0;
    --Ŀ������ ������ �����ȣ ���
    v_empno number(5) :=0;
    --Ŀ������ ������ �޿� ���
    v_sal number(7,2) :=0;
    --Ŀ������ ������ �̸� ���
    v_ename varchar2(20) :='';
    --�޿� �λ�� ��� 
    rate number(3,1) :=0;
    --Ŀ�� �����ϱ�
    CURSOR emp_cur IS
    SELECT empno, ename, sal
      FROM emp
     WHERE deptno = p_deptno;    
BEGIN
    --�޿� ����� ���غ���.
    SELECT avg(sal) INTO avg_sal
    FROM emp
    WHERE deptno = p_deptno;
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO v_empno, v_ename, v_sal;
        EXIT WHEN emp_cur%NOTFOUND;
        IF v_sal > avg_sal THEN
            rate :=1.1;
        ELSIF v_sal <= avg_sal THEN
            rate:=1.2;
        END IF;
        UPDATE emp
               SET sal = sal * rate
           WHERE empno = v_empno;
    END LOOP;
    COMMIT;
    CLOSE  emp_cur;
    EXCEPTION 
        WHEN no_data_found THEN 
            NULL;
END;


CREATE OR REPLACE PROCEDURE proc_emp_update3(p_deptno IN number)
IS
    --��� �޿� ���
    avg_sal number(7,2) := 0;
    --Ŀ������ ������ �����ȣ ���
    v_empno number(5) :=0;
    --Ŀ������ ������ �޿� ���
    v_sal number(7,2) :=0;
    --Ŀ������ ������ �̸� ���
    v_ename varchar2(20) :='';
    --�޿� �λ�� ��� 
    rate number(3,1) :=0;
    --Ŀ�� �����ϱ�
    CURSOR emp_cur IS
    SELECT empno, ename, sal
      FROM emp
     WHERE deptno = p_deptno;    
BEGIN
    --�޿� ����� ���غ���.
    SELECT avg(sal) INTO avg_sal
    FROM emp
    WHERE deptno = p_deptno;
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO v_empno, v_ename, v_sal;
        EXIT WHEN emp_cur%NOTFOUND;
        IF v_sal > avg_sal THEN
            rate :=1.1;
            dbms_output.put_line(v_empno||'�� �λ� �� �ݿ� : '||v_sal||' / �λ�� �޿� : '||v_sal*rate);
        ELSIF v_sal <= avg_sal THEN
            rate:=1.2;
            dbms_output.put_line(v_empno||'�� �λ� �� �ݿ� : '||v_sal||' / �λ�� �޿� : '||v_sal*rate);
        END IF;
        UPDATE emp
               SET sal = sal * rate
           WHERE empno = v_empno;
    END LOOP;
    COMMIT;
    CLOSE  emp_cur;
    EXCEPTION 
        WHEN no_data_found THEN 
            NULL;
END;

exec proc_emp_update3(10);

--���� ���� �Է��ϱ� 
edit exam_paper;
COMMIT;
  
SELECT * FROM exam_paper;

--���俩�θ� ������ִ� ���ν��� �����غ���
--������ �� ��, �� ���� �޾ƾ� �� -> fecth �� into �� n�ǿ� ���� ó�� ����, �� �� �� ����(�ݺ����� ����)
--����
CREATE OR REPLACE PROCEDURE proc_account(p_dap IN number msg OUT varchar2)
IS
    right_answer number(1) := 0;
    wrong_answer  number(1) := 0;
    score number(2) := 0;
    CURSOR exam_cur IS
        SELECT dap1, dap2, dap3, dap4
        FROM exam_paper
BEGIN
END;



--��->���� �� ��ȸ�غ���?
SELECT decode(d_no,1,dap)
FROM sw_design;

--��ü �� �����ͺ���
SELECT decode(d_no,1,dap)
         ,decode(d_no,2,dap)
         ,decode(d_no,3,dap)
         ,decode(d_no,4,dap)
FROM sw_design;

--�� �÷����� ���ĺ��� 1
SELECT 
         ceil(d_no/4)
         ,decode(d_no,1,dap)
         ,decode(d_no,2,dap)
         ,decode(d_no,3,dap)
         ,decode(d_no,4,dap)
FROM sw_design;

--�� �÷����� ���ĺ��� 1
--sum & decode ���� �����ϱ�!! 

--���� ���η� ��ȯ�Ϸ��Ͽ��� -> ���ν����� ����غ��� 
SELECT 
         sum(decode(d_no,1,dap)) ��1
         ,sum(decode(d_no,2,dap)) ��2
         ,sum(decode(d_no,3,dap)) ��3 
         ,sum(decode(d_no,4,dap)) ��4
FROM sw_design
GROUP BY ceil(d_no/4);

SELECT
d1, d2, d3, d4 INTO d1, d2, d3, d4
FROM (
        SELECT 
             sum(decode(d_no,1,dap)) d1
             ,sum(decode(d_no,2,dap)) d2
             ,sum(decode(d_no,3,dap)) d3 
             ,sum(decode(d_no,4,dap)) d4
        FROM sw_design
        GROUP BY ceil(d_no/4);  
        );

--�� �� ����ϴ� ���ν���
--u1~u4 ������� �Է��� ���
--d1~d4 ������ ���� 
--r1 ���� ����
--w1 ���� ����
--jdap Ŀ������ ������ ���

CREATE OR REPLACE PROCEDURE proc_account1(p_examno IN varchar2, msg OUT varchar2)
IS
    u1 number(1) := 0;
    u2 number(1) := 0;
    u3 number(1) := 0;
    u4 number(1) := 0;    
    r1 number(3) := 0;
    w1 number(3) := 0;
    jdap number(2) := 0;
    d_no number(3) := 1;
    CURSOR dap_cur IS
    SELECT dap FROM sw_design;
BEGIN
    OPEN dap_cur;
    SELECT dap1, dap2, dap3, dap4 INTO u1, u2, u3, u4
      FROM exam_paper
      WHERE exam_no = p_examno;
    LOOP
        FETCH dap_cur INTO jdap;
        exit WHEN dap_cur%NOTFOUND;
        IF d_no =1 THEN
            IF jdap = u1 THEN
                r1 := r1+1;
            ELSE
                w1 := w1+1;
            END IF;
        ELSIF d_no=2 THEN
            IF jdap = u2 THEN
                r1 := r1+1;
            ELSE
                w1 := w1+1;
            END IF;
        ELSIF d_no=3 THEN
            IF jdap = u3 THEN
                r1 := r1+1;
            ELSE
                w1 := w1+1;
            END IF;
        ELSIF d_no=4 THEN
            IF jdap = u4 THEN
                r1 := r1+1;
            ELSE
                w1 := w1+1;
            END IF;
         END IF;
        d_no := d_no +1;
    END LOOP;
    CLOSE dap_cur;
    msg := '���� : '||r1||', ���� : '||w1;
    UPDATE exam_paper
        set right_answer = r1,
            wrong_answer = w1
     WHERE exam_no = p_examno;
     COMMIT;
END;


CREATE OR REPLACE PROCEDURE proc_account2(p_examno IN varchar2)
--�� �� ����ϴ� ���ν���
--u1~u4 ������� �Է��� ���
--d1~d4 ������ ���� 
--r1 ���� ����
--w1 ���� ����
IS
    u1 number(1) := 0;
    u2 number(1) := 0;
    u3 number(1) := 0;
    u4 number(1) := 0;    
    d1 number(1) := 0;
    d2 number(1) := 0;
    d3 number(1) := 0;
    d4 number(1) := 0;    
    r1 number(3) := 0;
    w1 number(3) := 0;
    score number(2) := 0;
BEGIN
        SELECT
        d1, d2, d3, d4 INTO d1, d2, d3, d4
        FROM (
                SELECT 
                     sum(decode(d_no,1,dap)) d1
                     ,sum(decode(d_no,2,dap)) d2
                     ,sum(decode(d_no,3,dap)) d3 
                     ,sum(decode(d_no,4,dap)) d4
                FROM sw_design
                GROUP BY ceil(d_no/4);  
                )
END;

edit exam_paper;
COMMIT;

--insert
CREATE OR REPLACE PROCEDURE proc_deptInsert(p_deptno IN number, p_dname IN varchar2, p_loc IN varchar2)
IS
BEGIN
    INSERT INTO dept(deptno, dname, loc) VALUES(p_deptno, p_dname, p_loc);
    COMMIT;
END;

--delete
CREATE OR REPLACE PROCEDURE proc_deptDelete(p_deptno IN number)
IS
BEGIN
    DELETE FROM dept WHERE deptno = p_deptno;
    COMMIT;
END;

--����, ���� ���ν��� ���� �� ������ �ߵǾ����� Ȯ��
--�鿣��� ��ó��, ��ó���� �����صδ� ������ �˰� �־�� ��. 
BEGIN 
    proc_deptInsert(51, 'developer', 'Pusan');
END;

BEGIN
    proc_deptDelete(50);
END;

SELECT * FROM dept WHERE deptno = 50;

SELECT
        nvl((SELECT deptno FROM dept WHERE deptno = 50),-1) AS "null(-1)"
FROM dual;

--insert2 - ��ȸ, �ʱ�ȭ ����(�����)
CREATE OR REPLACE PROCEDURE proc_deptInsert2(p_deptno IN number, p_dname IN varchar2, p_loc IN varchar2)
IS
BEGIN
    INSERT INTO dept(deptno, dname, loc) SELECT 50, '���', '����' FROM dual;
    COMMIT;
END;

--�̹� �ʱ�ȭ ���� �� �ֱ� ������ �Ķ���Ͱ����δ� �������� ����. 
BEGIN 
    proc_deptInsert2(54, '��ȹ', '����');
END;

SELECT * FROM dept;

BEGIN 
    proc_deptDelete(60);
END;

--insert3 - ��ȸ, �ʱ�ȭ ����(�����η�)
CREATE OR REPLACE PROCEDURE proc_deptInsert3(p_deptno IN number, p_dname IN varchar2, p_loc IN varchar2)
IS
BEGIN
    INSERT INTO dept(deptno, dname, loc) SELECT p_deptno, p_dname, p_loc FROM dual;
    COMMIT;
END;

--�Ķ���Ͱ����� �����Ǵ� ���ν����̱� ������ �Ķ���Ͱ����� ������ . 
BEGIN 
    proc_deptInsert3(53, '��ȹ', '����');
END;

SELECT * FROM dept;

SELECT * FROM dept WHERE deptno IN (50,51,53);


--update��1 ��ȹ -> dev
CREATE OR REPLACE PROCEDURE proc_deptUpdate(p_deptno IN number)
IS
BEGIN
    UPDATE dept set dname = 'dev' WHERE deptno = p_deptno;
END;

BEGIN
    proc_deptUpdate(53);
END;

--update��2 �Ķ���� 3��

CREATE OR REPLACE PROCEDURE proc_deptUpdate2(p_deptno IN number, p_dname IN varchar2, p_loc IN varchar2)
IS
BEGIN
    UPDATE dept 
          set dname = p_dname
               ,loc = p_loc
    WHERE deptno = p_deptno;
END;

BEGIN
    proc_deptUpdate2(53,'DBA', '��õ');
END;

SELECT * FROM dept WHERE deptno IN (50,51,53);


--Ʈ���� ����
CREATE OR REPLACE TRIGGER trg_dept
  BEFORE
  UPDATE OR DELETE OR INSERT ON dept
DECLARE
  msg varchar2(200) := '';
BEGIN
  IF UPDATING THEN 
    dbms_output.put_line('=>UPDATE');
  END IF;
  IF deleting THEN 
    dbms_output.put_line('=>Delete');
  END IF;  
  IF INSERTING THEN 
    dbms_output.put_line('=>Insert');
  END IF;
END;

--Ʈ���� �׽�Ʈ 
DELETE FROM dept WHERE deptno = 53;

BEGIN
    proc_deptUpdate2(53,'DBA', '��õ');
END;

BEGIN 
    proc_deptInsert3(53, '��ȹ', '����');
END;

--Ʈ���� ��Ȱ��ȭ 
ALTER TRIGGER trg_dept DISABLE;

--Ʈ���� Ȱ��ȭ
ALTER TRIGGER trg_dept ENABLE;

--Ʈ���� ��������
ALTER TRIGGER Ʈ���Ÿ� COMPILE;

--Ʈ���� ����
DROP TRIGGER Ʈ���Ÿ�;

--syntax 
CREATE TRIGGER Ʈ���Ÿ�
  --��ó��, ��ó��(update, delete, insert ��/�� - Ŀ�� �ѹ� ���, ���� ������ �ݿ�)
  BEFORE (OR AFTER) 
  UPDATE OR DELETE OR INSERT ON ���̺�� --������(old), ������(new) �з� ���� 
  [FOR EACH ROW] --�����丮 ���� �� �ǰ��� ����ǵ���(�ӵ� ���� ��) ->old, new ��� ��
DECLARE
  ���������
BEGIN
  ���α׷� �ڵ���
END;

--Ʈ���� ����ȭ, ����, ���� �� �ǽ� 
CREATE TABLE dept_copy AS 
SELECT * FROM dept;

CREATE OR REPLACE TRIGGER trg_deptcopy
AFTER
UPDATE OR DELETE OR INSERT ON dept
FOR EACH ROW
BEGIN 
    IF INSERTING THEN
        INSERT INTO dept_copy(deptno, dname, loc)
        VALUES(:NEW.deptno, :NEW.dname, :NEW.loc);
    ELSIF UPDATING THEN 
        UPDATE dept_copy
        set dname=:NEW.dname, loc=:NEW.loc
        WHERE deptno = :OLD.deptno;  --������ �ִ� ���� �ٲٴ� ���̶� old ���
    ELSIF deleting THEN
        DELETE FROM dept_copy
        WHERE deptno = :OLD.deptno;
    END IF;
END;

--�׽�Ʈ �ó����� 
--������ ���� Ʈ���� ���뿩�� Ȯ�� 

INSERT INTO dept(deptno, dname, loc) VALUES(80, '�����','����');

UPDATE dept set loc = '����' WHERE deptno = 80;

DELETE FROM dept WHERE deptno = 80;

SELECT * FROM dept_copy;