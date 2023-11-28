CURSOR정의

SELECT  deptno, count(empno)
  FROM emp
 GROUP BY deptno;

--커서 선언하기

CURSOR emp_cur IS
SELECT empno, ename, sal
  FROM emp
 WHERE deptno = p_deptno;
 
 --급여평균을 구한다
 
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

--급여 평균을 구해보자.
SELECT avg(sal) INTO avg_sal
FROM emp
WHERE deptno = p_deptno;


--커서문 작성 시 
--예 : 
--declare 이름이 없다, 호출이 안 됨, 재사용 안 됨, 이름이 필요함 
-- pl/sql 구조체, 프로시저, 함수, 트리거 
--IS 선언부
--BEGIN 프로그램, DML, COMMIT, ROLLBACK, 반복문, 여러 건 한 번에 처리(한 행씩 접근)
-----------
DECLARE

CREATE OR REPLACE [PROCEDURE, FUNCTION, TRIGGER] 이름()
IS
    --선언부
BEGIN 
    --프로그램, dml, commit, rollback, 반복문
    --여러건 한 번에 처리
    --자동으로 채점하기
    EXCEPTION
END;

--타입 및 크기는 해당 테이블의 타입을 참고하여 작성하도록 한다. 

SELECT deptno FROM dept;

CREATE OR REPLACE PROCEDURE proc_emp_update2(p_deptno IN number)
IS
    --평균 급여 담기
    avg_sal number(7,2) := 0;
    --커서에서 꺼내온 사원번호 담기
    v_empno number(5) :=0;
    --커서에서 꺼내온 급여 담기
    v_sal number(7,2) :=0;
    --커서에서 꺼내온 이름 담기
    v_ename varchar2(20) :='';
    --급여 인상분 담기 
    rate number(3,1) :=0;
    --커서 선언하기
    CURSOR emp_cur IS
    SELECT empno, ename, sal
      FROM emp
     WHERE deptno = p_deptno;    
BEGIN
    --급여 평균을 구해보자.
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
    --평균 급여 담기
    avg_sal number(7,2) := 0;
    --커서에서 꺼내온 사원번호 담기
    v_empno number(5) :=0;
    --커서에서 꺼내온 급여 담기
    v_sal number(7,2) :=0;
    --커서에서 꺼내온 이름 담기
    v_ename varchar2(20) :='';
    --급여 인상분 담기 
    rate number(3,1) :=0;
    --커서 선언하기
    CURSOR emp_cur IS
    SELECT empno, ename, sal
      FROM emp
     WHERE deptno = p_deptno;    
BEGIN
    --급여 평균을 구해보자.
    SELECT avg(sal) INTO avg_sal
    FROM emp
    WHERE deptno = p_deptno;
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO v_empno, v_ename, v_sal;
        EXIT WHEN emp_cur%NOTFOUND;
        IF v_sal > avg_sal THEN
            rate :=1.1;
            dbms_output.put_line(v_empno||'의 인상 전 금여 : '||v_sal||' / 인상분 급여 : '||v_sal*rate);
        ELSIF v_sal <= avg_sal THEN
            rate:=1.2;
            dbms_output.put_line(v_empno||'의 인상 전 금여 : '||v_sal||' / 인상분 급여 : '||v_sal*rate);
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

--정답 내용 입력하기 
edit exam_paper;
COMMIT;
  
SELECT * FROM exam_paper;

--정답여부를 계산해주는 프로시저 생성해보기
--문제가 네 개, 한 번에 받아야 함 -> fecth … into → n건에 대한 처리 가능, 한 행 씩 접근(반복문과 결합)
--지연
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



--행->열별 답 조회해보기?
SELECT decode(d_no,1,dap)
FROM sw_design;

--전체 답 가져와보기
SELECT decode(d_no,1,dap)
         ,decode(d_no,2,dap)
         ,decode(d_no,3,dap)
         ,decode(d_no,4,dap)
FROM sw_design;

--한 컬럼으로 합쳐보기 1
SELECT 
         ceil(d_no/4)
         ,decode(d_no,1,dap)
         ,decode(d_no,2,dap)
         ,decode(d_no,3,dap)
         ,decode(d_no,4,dap)
FROM sw_design;

--한 컬럼으로 합쳐보기 1
--sum & decode 컨셉 이해하기!! 

--답을 가로로 전환완료하였음 -> 프로시저에 사용해보기 
SELECT 
         sum(decode(d_no,1,dap)) 답1
         ,sum(decode(d_no,2,dap)) 답2
         ,sum(decode(d_no,3,dap)) 답3 
         ,sum(decode(d_no,4,dap)) 답4
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

--한 명 계산하는 프로시저
--u1~u4 수험생이 입력한 답안
--d1~d4 문제의 정답 
--r1 정답 갯수
--w1 오답 갯수
--jdap 커서에서 꺼낸값 담기

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
    msg := '정답 : '||r1||', 오답 : '||w1;
    UPDATE exam_paper
        set right_answer = r1,
            wrong_answer = w1
     WHERE exam_no = p_examno;
     COMMIT;
END;


CREATE OR REPLACE PROCEDURE proc_account2(p_examno IN varchar2)
--한 명 계산하는 프로시저
--u1~u4 수험생이 입력한 답안
--d1~d4 문제의 정답 
--r1 정답 갯수
--w1 오답 갯수
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

--생성, 삭제 프로시저 진행 후 진행이 잘되었는지 확인
--백엔드는 전처리, 후처리를 염두해두는 쿼리문 알고 있어야 함. 
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

--insert2 - 조회, 초기화 같이(상수로)
CREATE OR REPLACE PROCEDURE proc_deptInsert2(p_deptno IN number, p_dname IN varchar2, p_loc IN varchar2)
IS
BEGIN
    INSERT INTO dept(deptno, dname, loc) SELECT 50, '운영부', '강원' FROM dual;
    COMMIT;
END;

--이미 초기화 값이 들어가 있기 때문에 파라미터값으로는 생성되지 않음. 
BEGIN 
    proc_deptInsert2(54, '기획', '서울');
END;

SELECT * FROM dept;

BEGIN 
    proc_deptDelete(60);
END;

--insert3 - 조회, 초기화 같이(변수로로)
CREATE OR REPLACE PROCEDURE proc_deptInsert3(p_deptno IN number, p_dname IN varchar2, p_loc IN varchar2)
IS
BEGIN
    INSERT INTO dept(deptno, dname, loc) SELECT p_deptno, p_dname, p_loc FROM dual;
    COMMIT;
END;

--파라미터값으로 생성되는 프로시저이기 떄문에 파라미터값으로 생성됨 . 
BEGIN 
    proc_deptInsert3(53, '기획', '서울');
END;

SELECT * FROM dept;

SELECT * FROM dept WHERE deptno IN (50,51,53);


--update문1 기획 -> dev
CREATE OR REPLACE PROCEDURE proc_deptUpdate(p_deptno IN number)
IS
BEGIN
    UPDATE dept set dname = 'dev' WHERE deptno = p_deptno;
END;

BEGIN
    proc_deptUpdate(53);
END;

--update문2 파라미터 3개

CREATE OR REPLACE PROCEDURE proc_deptUpdate2(p_deptno IN number, p_dname IN varchar2, p_loc IN varchar2)
IS
BEGIN
    UPDATE dept 
          set dname = p_dname
               ,loc = p_loc
    WHERE deptno = p_deptno;
END;

BEGIN
    proc_deptUpdate2(53,'DBA', '인천');
END;

SELECT * FROM dept WHERE deptno IN (50,51,53);


--트리거 생성
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

--트리거 테스트 
DELETE FROM dept WHERE deptno = 53;

BEGIN
    proc_deptUpdate2(53,'DBA', '인천');
END;

BEGIN 
    proc_deptInsert3(53, '기획', '서울');
END;

--트리거 비활성화 
ALTER TRIGGER trg_dept DISABLE;

--트리거 활성화
ALTER TRIGGER trg_dept ENABLE;

--트리거 재컴파일
ALTER TRIGGER 트리거명 COMPILE;

--트리거 삭제
DROP TRIGGER 트리거명;

--syntax 
CREATE TRIGGER 트리거명
  --전처리, 후처리(update, delete, insert 전/후 - 커밋 롤백 대상, 실제 데이터 반영)
  BEFORE (OR AFTER) 
  UPDATE OR DELETE OR INSERT ON 테이블명 --수정전(old), 수정후(new) 분류 가능 
  [FOR EACH ROW] --히스토리 따질 때 건건이 실행되도록(속도 영향 有) ->old, new 사용 시
DECLARE
  변수선언부
BEGIN
  프로그램 코딩부
END;

--트리거 동기화, 복제, 보안 등 실습 
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
        WHERE deptno = :OLD.deptno;  --기존에 있는 것을 바꾸는 것이라서 old 사용
    ELSIF deleting THEN
        DELETE FROM dept_copy
        WHERE deptno = :OLD.deptno;
    END IF;
END;

--테스트 시나리오 
--데이터 복제 트리거 적용여부 확인 

INSERT INTO dept(deptno, dname, loc) VALUES(80, '전산과','서울');

UPDATE dept set loc = '포항' WHERE deptno = 80;

DELETE FROM dept WHERE deptno = 80;

SELECT * FROM dept_copy;