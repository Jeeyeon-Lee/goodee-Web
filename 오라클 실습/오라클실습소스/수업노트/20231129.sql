vean_no - 수험번호
수험자 입력답안 u1,u2,u3,u4

정답지 j1,j2,j3,j4

UPDATE exam_paper
    set right_answer
    
    
ROW -> 컬럼으로 올리기 (계단식 처리->그룹화)
--변수선언 -기준 초기화 위치
--구현해보기 

--row 늘리기
SELECT 1, 2, 3 FROM dual;

--culomn 늘리기 
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
        INTO d1, d2, d3, d4--프로시저안에서만 사용 가능한 into
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

--채점 후 정답/오답 초기화
r1:=0
w1:=0
--파싱을 통과해야 테스트 가능 

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
     
--위 : account2의 낱말카드들 


트리거의 응용

exec proc_account2; 
