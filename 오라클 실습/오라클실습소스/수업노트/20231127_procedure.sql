--hap 실행x
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
    n_i :='김유신';
    EXCEPTION
        WHEN invalid_number THEN
            dbms_output.put_line('잘못된 숫자값에 대한 에러');
        WHEN value_error THEN
            dbms_output.put_line('잘못된 데이터값에 대한 에러');
        WHEN others THEN
            dbms_output.put_line('잘못된 숫자나 데이터값에 의한 것이 아닌 에러');
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
            dbms_output.put_line('에러코드: '||err_num);
            dbms_output.put_line('에러내용: '||err_msg);
 END;
 
 CREATE OR REPLACE PROCEDURE proc_raise
 IS
    user_excep EXCEPTION;
 BEGIN
    RAISE user_excep;
    EXCEPTION
        WHEN user_excep THEN
            dbms_output.put_line('Raise를 이용한 사용자 예외처리방법');
        WHEN others THEN
            dbms_output.put_line('그 외 예외 처리');
 END;
/ 

--파라미터에 선언된 변수는 재정의 불가함. 
--좌중괄호, 우중괄호 대신 end문을 사용! (loop-end loop / if-end if)
--if문을 통해 9보다 클 경우 나가지도록 exit 넣음. 
--for문 반복문보다는 while, loop문을 연습->무한루프 당해보고, 반복문의 문제인지를 하게 됨. 
--그래야 예외처리를 할 수 있게 됨. 
CREATE OR REPLACE PROCEDURE SCOTT.proc_loop1(dan IN number)
IS
    n_i number(2);   
BEGIN
    n_i := 1;
    dbms_output.put_line(dan||'단을 출력합니다.');
    LOOP
        dbms_output.put_line(dan||'*'||n_i||'='||(dan*n_i));
        n_i := n_i + 1;
        IF n_i>9 THEN 
            exit;
        END IF;
    END LOOP;
END;
/

--1부터 10까지 세면서 짝수의 합을 구하는 프로시저 만들기
--loop, mod(if), endloop, 출력
CREATE OR REPLACE PROCEDURE proc_loop2
IS
    n_i number(2);
    hap number(5);
BEGIN
    n_i := 1;
    hap := 0;
    dbms_output.put_line('1부터 10까지 숫자 중 짝수의 합을 출력합니다..');
    LOOP
        n_i := n_i + 1;
        IF mod(n_i,2)=0 THEN 
            hap := hap + n_i;
        END IF;        
        exit WHEN n_i = 10;
    END LOOP;
    dbms_output.put_line('1부터 10까지 숫자 중 짝수의 합은 "'||hap||'" 입니다.');  
END;
/

--사원번호를 입력받아서 그 사원이 속한 부서의 평균급여보다 
--많이 받고 있다면 10% 인상을, 적거나 같게 받고 있다면 20% 인상하하여
--테이블을 업데이트 하는 프로시저 작성



--지연 시도
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
        dbms_output.put_line('급여는 "'||sal||'" 입니다.');  
END;

--정답
--number(10,2) : 소수점 두자리에서 반올림

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
            msg := ename||' 사원의 '||emp_sal||' 급여가 '||rate||'인상분으로 '||emp_sal*rate||'로 인상되었습니다.'; 
END;
/

--커서를 사용하여 부서번호를 입력받아서 그 부서의 평균급여 보다 많이 받는 사원은
--10% 인상을 하고, 적게 받는 사원은 20% 인상을 적용하여
--급여 정보를 수정하는 프로시저를 작성하시오. 


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