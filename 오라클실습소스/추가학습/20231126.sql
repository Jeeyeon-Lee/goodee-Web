--< Book 테이블 > 20231126
-- [질의 3-1] 모든 도서의 이름과 가격을 검색하시오.

SELECT bookname, price
FROM BOOK;
 
-- [질의 3-2] 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT bookid,bookname, publisher,price
FROM BOOK;

-- [질의 3-3] 도서 테이블에 있는 모든 출판사를 검색하시오.
SELECT publisher
FROM BOOK;


-- [질의 3-4] 가격이 20,000원 미만인 도서를 검색하시오.
SELECT bookname, price
FROM BOOK
WHERE price <20000;

-- [질의 3-5] 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
SELECT bookname, price
FROM BOOK
WHERE price BETWEEN 10000 AND 20000;


-- [질의 3-6] 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
SELECT bookname, publisher
FROM BOOK
WHERE publisher IN ('굿스포츠','대한미디어');


-- [질의 3-7] ‘축구의 역사’를 출간한 출판사를 검색하시오.
SELECT bookname, publisher
FROM BOOK
WHERE bookname = '축구의 역사';

-- [질의 3-8] 도서이름에 ‘축구’ 가 포함된 출판사를 검색하시오.
SELECT bookname, publisher
FROM BOOK
WHERE bookname LIKE '%축구%';


-- [질의 3-9] 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
SELECT bookname, publisher
FROM BOOK
WHERE bookname LIKE '_구%';


-- [질의 3-10] 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT bookname, price
FROM BOOK
WHERE bookname LIKE '%축구%'
AND price >=20000;

-- [질의 3-11] 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
SELECT bookname, publisher
FROM BOOK
WHERE publisher IN ('굿스포츠','대한미디어');

-- [질의 3-12] 도서를 이름순으로 검색하시오.
SELECT bookname
FROM BOOK
ORDER BY bookname ASC;

-- [질의 3-13] 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT bookname, price
FROM BOOK
ORDER BY price ASC, bookname ASC;

SELECT *
FROM book
ORDER BY price, bookname;

-- [질의 3-14] 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 출력하시오.
SELECT *
FROM book
ORDER BY price desc, publisher ASC;

< Orders 테이블 >
-- [질의 3-15] 고객이 주문한 도서의 총 판매액을 구하시오.

SELECT to_char(sum(saleprice),'999,999')||'원' AS "총 판매액"
FROM orders;

-- [질의 3-16] 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT to_char(sum(saleprice),'999,999')||'원' AS "총 판매액"
FROM orders
WHERE custid = 2;

-- [질의 3-17] 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT to_char(sum(saleprice),'999,999')||'원' AS "총 판매액"
           ,to_char(avg(saleprice),'999,999')||'원' AS "평균값"
           ,to_char(min(saleprice),'999,999')||'원' AS "최저가"
           ,to_char(max(saleprice),'999,999')||'원' AS "최고가"
FROM orders;

-- [질의 3-18] 마당서점의 도서 판매 건수를 구하시오.
SELECT count(*)
FROM  Orders;

-- [질의 3-19] 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT custid, count(*) AS "주문 수량", to_char(sum(saleprice),'999,999')||'원' AS "총 판매액"
FROM orders
GROUP BY CUSTID;

-- [질의 3-20] 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단, 두 권 이상 구매한 고객만 구하시오.
SELECT custid, count(*) AS "주문 수량", to_char(sum(saleprice),'999,999')||'원' AS "총 판매액"
FROM orders
WHERE saleprice >=8000
GROUP BY custid
HAVING count(*)>=2;


--< 여기부터는 Customer(row 5), Orders(row 10), Book(row 10) 테이블 중 알아서 ㅋ  >
-- [질의 3-21] 고객과 고객의 주문에 관한 데이터를 모두 보이시오.

--All 50
SELECT *
FROM orders, customer;

--유의미값 10
SELECT *
FROM orders, customer
WHERE orders.custid = customer.custid;


--[질의 3-22] 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오.
--이건 되고,,,
SELECT    *
FROM    Customer, Orders
WHERE    Customer.custid=Orders.custid
ORDER BY    Customer.custid;

--왜 이건 안되지???
SELECT *
FROM orders, customer
WHERE orders.custid = customer.custid
GROUP BY orders.custid;

--[질의 3-23] 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT NAME, saleprice AS "판매가격"
FROM customer, orders
WHERE orders.custid = customer.custid;


--[질의 3-24] 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT NAME, to_char(sum(saleprice),'999,999')||'원' AS "총 판매액"
FROM customer, orders
WHERE orders.custid = customer.custid
GROUP BY NAME
ORDER BY NAME;


--[질의 3-25] 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT NAME, bookname
FROM customer, book, orders
WHERE book.bookid = orders.bookid
AND customer.custid = orders.custid;

--[질의 3-26] 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT NAME, bookname
FROM customer, book, orders
WHERE saleprice = 20000
AND customer.custid =orders.custid
AND book.bookid = orders.bookid;

--[질의 3-27] 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
--outer join -> 기본되는 테이블에 따라 left, right 
--조인이 되는 칼럼을 on절로 표시함. 

SELECT NAME, saleprice
FROM customer 
LEFT OUTER JOIN orders
ON orders.custid = customer.custid;

--[질의 3-28] 가장 비싼 도서의 이름을 보이시오.
SELECT bookname, price
FROM book
WHERE price =(SELECT max(price) FROM book);

--[질의 3-29] 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT DISTINCT(NAME)
FROM customer, orders
WHERE customer.custid = orders.custid

--[질의 3-30] ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT NAME
FROM customer, orders, book
WHERE publisher = '대한미디어'
AND customer.custid = orders.custid
AND book.bookid = orders.bookid;

--[질의 3-31] 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
--평균 : 굿스포츠 7000/이상미디어 16500, 나무수 13000, 대한미디어    28500
--Pearson 13000/삼성당    7500
SELECT publisher,avg(price) FROM book GROUP BY publisher;

--평균가격 이상 도서 갯수 3개
SELECT count(bookname)
FROM book A
WHERE price>
            (SELECT publisher,avg(price) FROM book b GROUP BY publisher)
AND A.publisher = b.publisher;


--[질의 3-32] 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT NAME 
FROM customer
MINUS
SELECT NAME
FROM customer, orders
WHERE customer.custid = orders.custid;

--[질의 3-33] 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT DISTINCT(NAME), address
FROM customer, orders, book
WHERE customer.custid = orders.custid
