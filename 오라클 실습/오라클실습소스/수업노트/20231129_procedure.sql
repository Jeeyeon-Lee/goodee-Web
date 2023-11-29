CREATE OR REPLACE PROCEDURE proc_account2
--�� �� ����ϴ� ���ν���
--u1~u4 ������� �Է��� ���
--d1~d4 ������ ���� 
--r1 ���� ����
--w1 ���� ����
IS
    vexam_no varchar2(10);
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
    CURSOR paper_cur IS
    SELECT exam_no, dap1, dap2, dap3, dap4 FROM exam_paper;
BEGIN
        SELECT min(decode(d_no,1,dap)) 
                , min(decode(d_no,2,dap))
                , min(decode(d_no,3,dap))
                , min(decode(d_no,4,dap)) 
                INTO d1, d2, d3, d4--���ν����ȿ����� ��� ������ into
        FROM sw_design
        GROUP BY ceil(d_no/4);
        OPEN paper_cur;
        --3���� ä�� ���� -> 3���� �ݺ��� 
        LOOP
            FETCH paper_cur INTO vexam_no, u1, u2, u3, u4;   
            --���ѷ��� ��� �ڵ� �ʿ� 
            LOOP
            exit WHEN paper_cur%NOTFOUND;
            IF u1 = d1 THEN
               r1:=r1+1;
            ELSE
                w1:=w1+1;
            END IF;
            IF u2 = d2 THEN
               r1:=r1+1;
            ELSE
                w1:=w1+1;
            END IF;
            IF u3 = d3 THEN
               r1:=r1+1;
            ELSE
                w1:=w1+1;
            END IF;
            IF u1 = d1 THEN
               r1:=r1+1;
            ELSE
                w1:=w1+1;
            END IF;    
            END LOOP;
            COMMIT;    
        END LOOP;
COMMIT; 
        CLOSE paper_cur;
END;




--������ ���ν���
CREATE OR REPLACE PROCEDURE SCOTT.proc_account2
IS
    vexam_no varchar2(10);
--������� �Է��� 1�� ���
    u1 number(1):=0;
--������� �Է��� 2�� ���    
    u2 number(1):=0;
--������� �Է��� 3�� ���    
    u3 number(1):=0;
--������� �Է��� 4�� ���    
    u4 number(1):=0;
    --1�� ����
    d1 number(1):=0;
    --2�� ����
    d2 number(1):=0;
    --3�� ����  
    d3 number(1):=0;
    --4�� ����
    d4 number(1):=0;
--������� ���� ���� ���� ����    
    r1 number(3):=0;
--������� Ʋ�� ���� ����        
    w1 number(3):=0;
    CURSOR paper_cur IS
    SELECT exam_no, dap1, dap2, dap3, dap4 FROM  exam_paper;
BEGIN
    SELECT 
                  min(decode(d_no,1,dap))
               ,  min(decode(d_no,2,dap))
               ,  min(decode(d_no,3,dap))
               ,  min(decode(d_no,4,dap)) 
               INTO d1, d2, d3, d4
       FROM sw_design
    GROUP BY ceil(d_no/4);
    OPEN paper_cur;
    --3�� ����� ä�� ����
    LOOP
        FETCH  paper_cur INTO vexam_no, u1,u2,u3,u4;
        --���ѷ����� ���� ��� �ڵ� �ۼ��ϱ�
        exit WHEN paper_cur%NOTFOUND;--�л�����ŭ �ݺ��ȴ� - 3������ ����
        IF u1 = d1 THEN
            r1:=r1+1;
        ELSE
            w1:=w1+1;
        END IF; 
        IF u2 = d2 THEN
            r1:=r1+1;
        ELSE
            w1:=w1+1;
        END IF;    
        IF u3 = d3 THEN
            r1:=r1+1;
        ELSE
            w1:=w1+1;
        END IF;    
        IF u4 = d4 THEN
            r1:=r1+1;
        ELSE
            w1:=w1+1;
        END IF;   
        UPDATE exam_paper
              set right_answer = r1,
                     wrong_answer = w1
        WHERE exam_no = vexam_no;     
        COMMIT;
        r1:=0;
        w1:=0;                                   
    END LOOP;
    CLOSE paper_cur;
END;
/

exec proc_account2;

edit exam_paper;

COMMIT;

SELECT * FROM exam_paper;

CREATE OR REPLACE PROCEDURE SCOTT.proc_login1(p_id IN varchar2, p_pw IN varchar2, r_msg OUT varchar2)
IS
    status number(2):=7;
BEGIN
    --1�̸� ���̵�� ����� ��� ��ġ, -1�̸� ���̵� �������� ����. 0�̸� ����� Ʋ��
    --���̵� �����ϸ� 0��ȯ, ����� ��ġ�ϸ� 1�� ��ȯ 
    SELECT nvl((SELECT m_id FROM MEMBER1 WHERE m_id=p_id),'-1') INTO status 
        FROM dual;
    IF status = -1 THEN 
        r_msg := '���̵� �������� �ʽ��ϴ�.';  
    ELSE
        SELECT nvl((SELECT m_name FROM MEMBER1 
                      WHERE m_id=p_id
                      AND m_pw = p_pw),'����� Ʋ���ϴ�.') INTO r_msg 
            FROM dual;
    END IF; 
END;
/

exec proc_login1('kiwi', '111', :ms);

--select into���� PL/SQL������ ��� ����, �����ุ ���� �� ����. 

CREATE OR REPLACE TRIGGER trg_test2
BEFORE
UPDATE OF ename ON emp
FOR EACH ROW
DECLARE
    s_msg varchar2(500) := '';
BEGIN
    IF :OLD.empno = 7566 THEN
        s_msg :='7566����� ���� ������ ������ �� ����.';
        raise_application_error(-20000, s_msg);
    END IF;
END;

UPDATE emp
set ename = 'test'
WHERE empno = 7566;


CREATE OR REPLACE TRIGGER trg_check
BEFORE UPDATE OR DELETE OR INSERT ON emp
BEGIN 
    IF(to_char(sysdate,'DY') IN('��','��'))
    THEN
        raise_application_error(-20001,'��, ����Ͽ��� ������ �� �����ϴ�.');
    END IF;
END;

DELETE FROM emp;

--Ʈ���� ��Ȱ��ȭ
ALTER TRIGGER trg_check DISABLE;

--Ʈ���� Ȱ��ȭ
ALTER TRIGGER trg_check ENABLE;

--ERD �� �� �ֵ�- ���̺� ���� �ľ�
--���̺� ��Ű�� - PK, FK ��Ʈ���� ��밡��
--����Ű, �ܷ�Ű

--JOIN ����>
-- NATURAL
-- SELF
-- OUTER
-- NON-EQUAL

--join ��ġ>
--�ζ��κ� : ���ν� �ӵ������ ���� ����� ���� �ٿ��� ��, ���̺��� �ڸ�
--�������� : ���� �ڸ�, where �� �Ʒ� 
--AND : ������, ����� �� ����
--OR : ������ ����� �� ����
--�ο� ���� 
--select 1, 2, 3 from dual;
--�÷�����
--select 1 from dual
--union all
--select 2 from dual;

--ū Ʋ
--12������ ����(�ڹ�)�� JSP(html + css + javascript + java)

--UI �κ�
--nodejs ��� ȭ�� �ַ��
--js ��� ȭ�� �ַ��
--others �ַ��(xml ��� ȭ�� �׸���)