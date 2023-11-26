--< Book ���̺� > 20231126
-- [���� 3-1] ��� ������ �̸��� ������ �˻��Ͻÿ�.

SELECT bookname, price
FROM BOOK;
 
-- [���� 3-2] ��� ������ ������ȣ, �����̸�, ���ǻ�, ������ �˻��Ͻÿ�.
SELECT bookid,bookname, publisher,price
FROM BOOK;

-- [���� 3-3] ���� ���̺� �ִ� ��� ���ǻ縦 �˻��Ͻÿ�.
SELECT publisher
FROM BOOK;


-- [���� 3-4] ������ 20,000�� �̸��� ������ �˻��Ͻÿ�.
SELECT bookname, price
FROM BOOK
WHERE price <20000;

-- [���� 3-5] ������ 10,000�� �̻� 20,000 ������ ������ �˻��Ͻÿ�.
SELECT bookname, price
FROM BOOK
WHERE price BETWEEN 10000 AND 20000;


-- [���� 3-6] ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.
SELECT bookname, publisher
FROM BOOK
WHERE publisher IN ('�½�����','���ѹ̵��');


-- [���� 3-7] ���౸�� ���硯�� �Ⱓ�� ���ǻ縦 �˻��Ͻÿ�.
SELECT bookname, publisher
FROM BOOK
WHERE bookname = '�౸�� ����';

-- [���� 3-8] �����̸��� ���౸�� �� ���Ե� ���ǻ縦 �˻��Ͻÿ�.
SELECT bookname, publisher
FROM BOOK
WHERE bookname LIKE '%�౸%';


-- [���� 3-9] �����̸��� ���� �� ��° ��ġ�� ��������� ���ڿ��� ���� ������ �˻��Ͻÿ�.
SELECT bookname, publisher
FROM BOOK
WHERE bookname LIKE '_��%';


-- [���� 3-10] �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT bookname, price
FROM BOOK
WHERE bookname LIKE '%�౸%'
AND price >=20000;

-- [���� 3-11] ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.
SELECT bookname, publisher
FROM BOOK
WHERE publisher IN ('�½�����','���ѹ̵��');

-- [���� 3-12] ������ �̸������� �˻��Ͻÿ�.
SELECT bookname
FROM BOOK
ORDER BY bookname ASC;

-- [���� 3-13] ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�.
SELECT bookname, price
FROM BOOK
ORDER BY price ASC, bookname ASC;

SELECT *
FROM book
ORDER BY price, bookname;

-- [���� 3-14] ������ ������ ������������ �˻��Ͻÿ�. ���� ������ ���ٸ� ���ǻ��� ������������ ����Ͻÿ�.
SELECT *
FROM book
ORDER BY price desc, publisher ASC;

< Orders ���̺� >
-- [���� 3-15] ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.

SELECT to_char(sum(saleprice),'999,999')||'��' AS "�� �Ǹž�"
FROM orders;

-- [���� 3-16] 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT to_char(sum(saleprice),'999,999')||'��' AS "�� �Ǹž�"
FROM orders
WHERE custid = 2;

-- [���� 3-17] ���� �ֹ��� ������ �� �Ǹž�, ��հ�, ������, �ְ��� ���Ͻÿ�.
SELECT to_char(sum(saleprice),'999,999')||'��' AS "�� �Ǹž�"
           ,to_char(avg(saleprice),'999,999')||'��' AS "��հ�"
           ,to_char(min(saleprice),'999,999')||'��' AS "������"
           ,to_char(max(saleprice),'999,999')||'��' AS "�ְ�"
FROM orders;

-- [���� 3-18] ���缭���� ���� �Ǹ� �Ǽ��� ���Ͻÿ�.
SELECT count(*)
FROM  Orders;

-- [���� 3-19] ������ �ֹ��� ������ �� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT custid, count(*) AS "�ֹ� ����", to_char(sum(saleprice),'999,999')||'��' AS "�� �Ǹž�"
FROM orders
GROUP BY CUSTID;

-- [���� 3-20] ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. ��, �� �� �̻� ������ ���� ���Ͻÿ�.
SELECT custid, count(*) AS "�ֹ� ����", to_char(sum(saleprice),'999,999')||'��' AS "�� �Ǹž�"
FROM orders
WHERE saleprice >=8000
GROUP BY custid
HAVING count(*)>=2;


--< ������ʹ� Customer(row 5), Orders(row 10), Book(row 10) ���̺� �� �˾Ƽ� ��  >
-- [���� 3-21] ���� ���� �ֹ��� ���� �����͸� ��� ���̽ÿ�.

--All 50
SELECT *
FROM orders, customer;

--���ǹ̰� 10
SELECT *
FROM orders, customer
WHERE orders.custid = customer.custid;


--[���� 3-22] ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�.
--�̰� �ǰ�,,,
SELECT    *
FROM    Customer, Orders
WHERE    Customer.custid=Orders.custid
ORDER BY    Customer.custid;

--�� �̰� �ȵ���???
SELECT *
FROM orders, customer
WHERE orders.custid = customer.custid
GROUP BY orders.custid;

--[���� 3-23] ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT NAME, saleprice AS "�ǸŰ���"
FROM customer, orders
WHERE orders.custid = customer.custid;


--[���� 3-24] ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT NAME, to_char(sum(saleprice),'999,999')||'��' AS "�� �Ǹž�"
FROM customer, orders
WHERE orders.custid = customer.custid
GROUP BY NAME
ORDER BY NAME;


--[���� 3-25] ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
SELECT NAME, bookname
FROM customer, book, orders
WHERE book.bookid = orders.bookid
AND customer.custid = orders.custid;

--[���� 3-26] ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
SELECT NAME, bookname
FROM customer, book, orders
WHERE saleprice = 20000
AND customer.custid =orders.custid
AND book.bookid = orders.bookid;

--[���� 3-27] ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.
--outer join -> �⺻�Ǵ� ���̺� ���� left, right 
--������ �Ǵ� Į���� on���� ǥ����. 

SELECT NAME, saleprice
FROM customer 
LEFT OUTER JOIN orders
ON orders.custid = customer.custid;

--[���� 3-28] ���� ��� ������ �̸��� ���̽ÿ�.
SELECT bookname, price
FROM book
WHERE price =(SELECT max(price) FROM book);

--[���� 3-29] ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
SELECT DISTINCT(NAME)
FROM customer, orders
WHERE customer.custid = orders.custid

--[���� 3-30] �����ѹ̵����� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT NAME
FROM customer, orders, book
WHERE publisher = '���ѹ̵��'
AND customer.custid = orders.custid
AND book.bookid = orders.bookid;

--[���� 3-31] ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
--��� : �½����� 7000/�̻�̵�� 16500, ������ 13000, ���ѹ̵��    28500
--Pearson 13000/�Ｚ��    7500
SELECT publisher,avg(price) FROM book GROUP BY publisher;

--��հ��� �̻� ���� ���� 3��
SELECT count(bookname)
FROM book A
WHERE price>
            (SELECT publisher,avg(price) FROM book b GROUP BY publisher)
AND A.publisher = b.publisher;


--[���� 3-32] ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
SELECT NAME 
FROM customer
MINUS
SELECT NAME
FROM customer, orders
WHERE customer.custid = orders.custid;

--[���� 3-33] �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT DISTINCT(NAME), address
FROM customer, orders, book
WHERE customer.custid = orders.custid
