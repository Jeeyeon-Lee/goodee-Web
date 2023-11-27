--hap ����x
BEGIN 
    proc_hap(3);
END;

BEGIN 
    proc_gugudan(1);
 END;
 
 CREATE OR REPLACE PROCEDURE proc_exception1
 IS
    n_i number(5);
 BEGIN
    n_i := 0;
    n_i :='������';
    EXCEPTION
        WHEN invalid_number THEN
            dbms_output.put_line('�߸��� ���ڰ��� ���� ����');
        WHEN value_error THEN
            dbms_output.put_line('�߸��� �����Ͱ��� ���� ����');
        WHEN others THEN
            dbms_output.put_line('�߸��� ���ڳ� �����Ͱ��� ���� ���� �ƴ� ����');
 END;
 /
 
 CREATE OR REPLACE PROCEDURE proc_errormsg
 IS
    err_num number;
    err_msg varchar2(300);
    n_i number(5) := 0;
 BEGIN
    n_i := 120/0;
    EXCEPTION
            WHEN others THEN
            err_num := SQLCODE;
            err_msg := substr(SQLERRM,1,100);     
            dbms_output.put_line('�����ڵ�: '||err_num);
            dbms_output.put_line('��������: '||err_msg);
 END;
 
 CREATE OR REPLACE PROCEDURE proc_raise
 IS
    user_excep EXCEPTION;
 BEGIN
    RAISE user_excep;
    EXCEPTION
        WHEN user_excep THEN
            dbms_output.put_line('Raise�� �̿��� ����� ����ó�����');
        WHEN others THEN
            dbms_output.put_line('�� �� ���� ó��');
 END;
/ 

--�Ķ���Ϳ� ����� ������ ������ �Ұ���. 
--���߰�ȣ, ���߰�ȣ ��� end���� ���! (loop-end loop / if-end if)
--if���� ���� 9���� Ŭ ��� ���������� exit ����. 
--for�� �ݺ������ٴ� while, loop���� ����->���ѷ��� ���غ���, �ݺ����� ���������� �ϰ� ��. 
--�׷��� ����ó���� �� �� �ְ� ��. 
CREATE OR REPLACE PROCEDURE SCOTT.proc_loop1(dan IN number)
IS
    n_i number(2);   
BEGIN
    n_i := 1;
    dbms_output.put_line(dan||'���� ����մϴ�.');
    LOOP
        dbms_output.put_line(dan||'*'||n_i||'='||(dan*n_i));
        n_i := n_i + 1;
        IF n_i>9 THEN 
            exit;
        END IF;
    END LOOP;
END;
/

--1���� 10���� ���鼭 ¦���� ���� ���ϴ� ���ν��� �����
--loop, mod(if), endloop, ���
CREATE OR REPLACE PROCEDURE proc_loop2
IS
    n_i number(2);
    hap number(5);
BEGIN
    n_i := 1;
    hap := 0;
    dbms_output.put_line('1���� 10���� ���� �� ¦���� ���� ����մϴ�..');
    LOOP
        n_i := n_i + 1;
        IF mod(n_i,2)=0 THEN 
            hap := hap + n_i;
        END IF;        
        exit WHEN n_i = 10;
    END LOOP;
    dbms_output.put_line('1���� 10���� ���� �� ¦���� ���� "'||hap||'" �Դϴ�.');  
END;
/

--�����ȣ�� �Է¹޾Ƽ� �� ����� ���� �μ��� ��ձ޿����� 
--���� �ް� �ִٸ� 10% �λ���, ���ų� ���� �ް� �ִٸ� 20% �λ����Ͽ�
--���̺��� ������Ʈ �ϴ� ���ν��� �ۼ�



--���� �õ�
CREATE OR REPLACE PROCEDURE proc_sal(emp_no IN number, msg OUT varchar2)
IS
    emp_no number(4);
    sal number(20);
    avg_sal number(20);
BEGIN
        SELECT sal
        INTO sal
        FROM emp
        WHERE empno = emp_no;
    
        SELECT deptno, avg(sal)
        INTO avg_sal
        FROM emp
        GROUP BY deptno;
        
        IF sal >avg_sal THEN 
        
        END IF;
        dbms_output.put_line('�޿��� "'||sal||'" �Դϴ�.');  
END;

--����
--number(10,2) : �Ҽ��� ���ڸ����� �ݿø�

CREATE OR REPLACE PROCEDURE proc_sal(emp_no IN number, msg OUT varchar2)
IS
    ename varchar2(30) :='';
    emp_sal number(20) :=0;
    avg_sal number(10,2) := 0;
    rate number(5,2) := 0;
BEGIN
        SELECT ename, sal
        INTO ename, emp_sal
        FROM emp
        WHERE empno = emp_no;
        SELECT avg(sal)
        INTO avg_sal
        FROM emp
        WHERE deptno = (SELECT deptno FROM emp WHERE empno = emp_no);
        IF emp_sal >avg_sal THEN rate := 1.1;
        ELSE
            rate := 1.2;
        END IF;
        UPDATE emp
            set sal = sal * rate
            WHERE emp_no = empno;
            COMMIT;
            msg := ename||' ����� '||emp_sal||' �޿��� '||rate||'�λ������ '||emp_sal*rate||'�� �λ�Ǿ����ϴ�.'; 
END;
/

--Ŀ���� ����Ͽ� �μ���ȣ�� �Է¹޾Ƽ� �� �μ��� ��ձ޿� ���� ���� �޴� �����
--10% �λ��� �ϰ�, ���� �޴� ����� 20% �λ��� �����Ͽ�
--�޿� ������ �����ϴ� ���ν����� �ۼ��Ͻÿ�. 


CREATE OR REPLACE PROCEDURE proc_empcursor(rc_emp OUT sys_refcursor)
IS
BEGIN
    OPEN rc_emp 
    FOR SELECT empno, ename, sal, hiredate FROM emp;
END;


CREATE OR REPLACE PROCEDURE proc_login1(p_id IN varchar2, p_pw IN varchar2, r_name OUT varchar2, r_status OUT number)
IS
BEGIN
    SELECT nvl((SELECT m_id FROM member1 WHERE m_id=p_id),-1)
    INTO r_status
    FROM dual;
END;
/