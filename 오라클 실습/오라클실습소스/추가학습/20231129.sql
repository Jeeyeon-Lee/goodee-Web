
--[질의 4-1] -78과 +78의 절댓값을 구하시오.(ABS)

SELECT abs(-78) AS "절대값", abs(78) AS "절대값" FROM dual;

--[질의 4-2] 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오.(ROUND)

SELECT round(4.875,1) FROM dual;

--[질의 4-3] 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.(ROUND)
SELECT round(

--[질의 4-4] 도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록을 보이시오.(REPLACE)

--[질의 4-5] ‘굿스포츠’에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.(LENGTH, LENGTHB)

--[질의 4-6] 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.(SUBSTR)

--[질의 4-7] 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.

--[질의 4-8] 마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.

--[질의 4-9] DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.(NVL)

--[질의 4-10] 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 표시하시오.(ROWNUM)

--[질의 4-11] 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.

--[질의 4-12] 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.

--[질의 4-13] 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.

--[질의 4-14] ‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.

--[질의 4-15] 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.(ALL)

--[질의 4-16] EXISTS 연산자를 사용하여 ‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.(EXISTS)

--[질의 4-17] 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력).

--[질의 4-19] 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력).


--[예제 5-3] Book 테이블에 저장된 도서의 평균가격을 반환하는 프로시저를 작성하시오.

--[예제 5-4] Orders 테이블의 판매 도서에 대한 이익을 계산하는 프로시저를 작성하시오.


--연습문제


--1. 다음 프로그램을 프로시저로 작성하고 실행하시오. DB는 마당서점을 이용

--1.1 고객을 새로 등록하는 InsertCustomer()프로시저를 작성하시오


CREATE OR REPLACE PROCEDURE proc_insertC(p_id IN number , p_name IN varchar2, p_address IN varchar2, p_phone IN varchar2)
IS
BEGIN
    INSERT INTO customer (custid, NAME, address, phone) VALUES(p_id,p_name,p_address,p_phone);
    COMMIT;
END;

--1.2 새로운 도서를 삽입하는  BookInsertOrUpdate() 프로시저를 작성, 동일한 도서가 있다면 가격이 높은 것을 업데이트

CREATE OR REPLACE PROCEDURE bookInsertOrUpdate(p_bookid IN number, p_bookname IN varchar2, p_publisher IN varchar2, p_price IN number) 
IS
    new_price number(8) := 0;
    save_price number(8) := 0;
BEGIN
    --가격, 제목 같은 것 조회하여 새로운 책  비교하여 높은가격을 변수로 저장
    SELECT price INTO new_price
    FROM book
    WHERE bookname = p_bookname;
    IF p_price>new_price THEN save_price := p_price;
    ELSE save_price := new_price;
    END IF;
    INSERT INTO book (bookid, bookname, publisher, price)
        VALUES (p_bookid, p_bookname, p_publisher, save_price);
    COMMIT;    
END;

--2. 다음 프로그램을 프로시저로 작성하고 실행하시오. DB는 마당서점을 이용

--2.1 출판사가 '이상미디어' 인 도서의 이름과 가격을 보여주는 프로시저를 작성

CREATE OR REPLACE PROCEDURE proc_found
IS
    v_bookname varchar2(40):= '';
    v_price number(8) := 0;    
BEGIN
    SELECT bookname, price INTO v_bookname, v_price
    FROM book WHERE publisher = '이상미디어';
    dbms_output.put_line('이상미디어와 같은 출판사인 도서는'||v_bookname||'이 있고, 그 가격은 '||v_price||'입니다'); 
END;

--2.2 출판사별로 출판사 이름과 도서의 판매 총액을 보이시오(Orders 테이블 이용)
--group, for문?, sum 
CREATE OR REPLACE PROCEDURE proc_calc
IS
BEGIN
    SELECT * FROM orders
END;

SELECT publisher, sum(saleprice) 
          ,(SELECT bookname FROM book GROUP BY bookname) 
FROM orders, book
WHERE orders.bookid = book.bookid
GROUP BY publisher;

--2.3 출판사별로 도서의 편균가보다 비싼 도서의 이름을 보이시오(예를 들어 A 출판사 도서의 평균가가 20,000원이라면 A출판사 도서 중 20000원 이상인 도서를 보이면 됨)
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;

--2.4 고객별로 도서를 몇 권 구입했는지와 총구매액을 보이시오
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;

--2.5 주문이 있는 고객의 이름과 주문 총액을 출력하고, 주문이 없는 고객은 이름만 출력하는 프로시저를 작성
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;


--3. 다음 PL/SQL 함수를 작성하시오 DB는 마당서점 이용
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;


--3.1 고객의 주문 총액을 계산하여 20000원 이상이면 '우수' 20000원 미만이면 '보통'을 반환하는 함수 Grade()를 작성하시오. 
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;

--Grade()를 호출하여 고객의 이름과 등급을 보이는 SQL도 작성하시오
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;


--3.2 고객의주소를 이용하여 국내에 거주하면 '국내거주', 해외에 거주하면 '국외거주'를 반환하는 함수 Domestic()을 작성하시오.
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;

--Domestic()을 호출하여 고객 이름과 국내/국외 거주 여부를 출력하는 SQL문도 작성하시오
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;



--3.3 '3.2' 에서 작성한 Domestic()을 호출하여 국내거주 고객의 판매 총액과 국외거주 고객의 판매총액을 출력하는 SQL문을 작성하시오
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;
