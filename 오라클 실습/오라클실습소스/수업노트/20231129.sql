vean_no - �����ȣ
������ �Է´�� u1,u2,u3,u4

������ j1,j2,j3,j4

UPDATE exam_paper
    set right_answer
    
    
ROW -> �÷����� �ø��� (��ܽ� ó��->�׷�ȭ)
--�������� -���� �ʱ�ȭ ��ġ
--�����غ��� 

--row �ø���
SELECT 1, 2, 3 FROM dual;

--culomn �ø��� 
SELECT 1 FROM dual
UNION ALL
SELECT 2 FROM dual;

SELECT dap FROM sw_design;

SELECT ceil(d_no/4), 2, 3 FROM sw_design
GROUP BY ceil(d_no/4);

SELECT min(decode(d_no,1,dap)) 
        , min(decode(d_no,2,dap))
        , min(decode(d_no,3,dap))
        , min(decode(d_no,4,dap)) 
        INTO d1, d2, d3, d4--���ν����ȿ����� ��� ������ into
FROM sw_design
GROUP BY ceil(d_no/4);

LOOP
 FETCH paper_cur INTO vexam_no, u1, u2, u3,u4;
 exit WHEN paper_cur%NOTFOUND
 IF u1 = d1 THEN
    r1:=r1+1;
 ELSE
    w1:=w1+1;
END LOOP;
COMMIT; 

--ä�� �� ����/���� �ʱ�ȭ
r1:=0
w1:=0
--�Ľ��� ����ؾ� �׽�Ʈ ���� 

CREATE TABLE USERS (NICKNAME
    ID varchar2(20)
    ,PASSWORD varchar2(20)
    ,nickname varchar2(20)
);

edit users;
COMMIT;

    FETCH paper_cur INTO vexam_no, u1, u2, u3, u4

    UPDATE exam_paper
        set right_answer = r1,
            wrong_answer = w1
     WHERE exam_no = vexam_no;
     COMMIT;
     
--�� : account2�� ����ī��� 


Ʈ������ ����

exec proc_account2; 
