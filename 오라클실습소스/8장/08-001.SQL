--변수이름 p 붙이기
--DDL문을 통해 함수도 만들 수 있음.
--tmp :=0 초기화의 과정 (: 을 써야함.) 
CREATE OR REPLACE FUNCTION func_crate(pdate varchar2)
RETURN number
IS 
    tmp number;
BEGIN 
    tmp :=0;
    SELECT crate INTO tmp
    FROM test02
    WHERE cdate = (
                        SELECT max(cdate) 
                        FROM test02
                        WHERE cdate<pdate
                        );
    RETURN tmp; 
END;