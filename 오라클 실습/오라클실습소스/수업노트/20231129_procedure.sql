CREATE OR REPLACE PROCEDURE proc_account2
--한 명 계산하는 프로시저
--u1~u4 수험생이 입력한 답안
--d1~d4 문제의 정답 
--r1 정답 갯수
--w1 오답 갯수
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
                INTO d1, d2, d3, d4--프로시저안에서만 사용 가능한 into
        FROM sw_design
        GROUP BY ceil(d_no/4);
        OPEN paper_cur;
        --3명의 채점 진행 -> 3바퀴 반복문 
        LOOP
            FETCH paper_cur INTO vexam_no, u1, u2, u3, u4;   
            --무한루프 방어 코드 필요 
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




--선생님 프로시저
CREATE OR REPLACE PROCEDURE SCOTT.proc_account2
IS
    vexam_no varchar2(10);
--수험생이 입력한 1번 답안
    u1 number(1):=0;
--수험생이 입력한 2번 답안    
    u2 number(1):=0;
--수험생이 입력한 3번 답안    
    u3 number(1):=0;
--수험생이 입력한 4번 답안    
    u4 number(1):=0;
    --1번 정답
    d1 number(1):=0;
    --2번 정답
    d2 number(1):=0;
    --3번 정답  
    d3 number(1):=0;
    --4번 정답
    d4 number(1):=0;
--수험생이 맞춘 정답 수를 담음    
    r1 number(3):=0;
--수험생이 틀린 수를 담음        
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
    --3명 수험생 채점 진행
    LOOP
        FETCH  paper_cur INTO vexam_no, u1,u2,u3,u4;
        --무한루프에 대한 방어 코드 작성하기
        exit WHEN paper_cur%NOTFOUND;--학생수만큼 반복된다 - 3바퀴를 돈다
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
    --1이면 아이디와 비번이 모두 일치, -1이면 아이디가 존재하지 않음. 0이면 비번이 틀림
    --아이디가 존재하면 0반환, 비번도 일치하면 1을 반환 
    SELECT nvl((SELECT m_id FROM MEMBER1 WHERE m_id=p_id),'-1') INTO status 
        FROM dual;
    IF status = -1 THEN 
        r_msg := '아이디가 존재하지 않습니다.';  
    ELSE
        SELECT nvl((SELECT m_name FROM MEMBER1 
                      WHERE m_id=p_id
                      AND m_pw = p_pw),'비번이 틀립니다.') INTO r_msg 
            FROM dual;
    END IF; 
END;
/

exec proc_login1('kiwi', '111', :ms);

--select into문은 PL/SQL에서만 사용 가능, 단일행만 담을 수 있음. 

CREATE OR REPLACE TRIGGER trg_test2
BEFORE
UPDATE OF ename ON emp
FOR EACH ROW
DECLARE
    s_msg varchar2(500) := '';
BEGIN
    IF :OLD.empno = 7566 THEN
        s_msg :='7566사번에 대한 정보는 수정할 수 없다.';
        raise_application_error(-20000, s_msg);
    END IF;
END;

UPDATE emp
set ename = 'test'
WHERE empno = 7566;


CREATE OR REPLACE TRIGGER trg_check
BEFORE UPDATE OR DELETE OR INSERT ON emp
BEGIN 
    IF(to_char(sysdate,'DY') IN('수','목'))
    THEN
        raise_application_error(-20001,'수, 목요일에는 변경할 수 없습니다.');
    END IF;
END;

DELETE FROM emp;

--트리거 비활성화
ALTER TRIGGER trg_check DISABLE;

--트리거 활성화
ALTER TRIGGER trg_check ENABLE;

--ERD 볼 수 있따- 테이블 구조 파악
--테이블 스키마 - PK, FK 힌트문에 사용가능
--복합키, 외래키

--JOIN 형식>
-- NATURAL
-- SELF
-- OUTER
-- NON-EQUAL

--join 위치>
--인라인뷰 : 조인시 속도향상을 위해 경우의 수를 줄여줄 떄, 테이블의 자리
--서브쿼리 : 값의 자리, where 절 아래 
--AND : 교집합, 경우의 수 감소
--OR : 합집합 경우의 수 증가
--로우 증가 
--select 1, 2, 3 from dual;
--컬럼증가
--select 1 from dual
--union all
--select 2 from dual;

--큰 틀
--12월부터 서블릿(자바)과 JSP(html + css + javascript + java)

--UI 부분
--nodejs 기반 화면 솔루션
--js 기반 화면 솔루션
--others 솔루션(xml 기반 화면 그리기)