--�𸣰ڴ�
--2.13

--����1 ���缭���� ���� �䱸�ϴ� ���� ������ ���� SQL���� �ۼ��Ͻÿ�

--1.1 ������ȣ�� 1�� ������ �̸�
SELECT bookname, bookid
FROM book
WHERE bookid = 1;

--1.2 ������ 20000�� �̻��� ������ �̸�
SELECT bookname, price
FROM book
WHERE price >= 20000;

--1.3 �������� �� ���ž�
SELECT sum(saleprice)
FROM orders
WHERE custid = 1;

SELECT sum(saleprice)
FROM orders A, customer b
WHERE A.custid = 1
AND A.custid = b.custid;

--1.4 �������� ������ ������ ��
SELECT count(bookid)
FROM orders A, customer b
WHERE A.custid = 1
AND A.custid = b.custid;

--1.5 �������� ������ ������ ���ǻ� ��
SELECT count(publisher)
FROM orders A, customer b, book c
WHERE A.custid = 1
AND A.custid = b.custid
AND A.bookid = c.bookid;

--1.6 �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
SELECT b.NAME, bookname,saleprice,price-saleprice
FROM orders A, customer b, book c
WHERE A.custid = 1
AND A.custid = b.custid
AND A.bookid = c.bookid;

--1.7 �������� �������� ���� ������ �̸�(outer)
SELECT b.NAME, bookname
FROM orders A, customer b, book c
WHERE A.custid != 1
AND A.custid = b.custid
AND c.bookid = A.bookid;

--����2 ���缭���� ��ڿ� �濵�ڰ� �䱸�ϴ� ���� ������ ���� SQL�� �ۼ��Ͻÿ�

--2.1 ���缭�� ������ �� ��
SELECT count(bookname)
FROM book;

--2.2 ���缭���� ������ ����ϴ� ���ǻ��� �Ѽ�
SELECT count(DISTINCT publisher)
FROM book;

--2.3 ��� ���� �̸�, �ּ�
SELECT NAME, address
FROM customer;

--2.4 2020�� 7�� 4��~ 7�� 7�� ���̿� �ֹ����� ������ �ֹ���ȣ

SELECT orderid, orderdate
FROM orders
WHERE orderdate BETWEEN to_date('2020/07/04') AND to_date('2020/07/07');

--2.5 2020�� 7�� 4�� ~ 7�� 7�� ���̿� �ֹ����� ������ ������ ������ �ֹ���ȣ
SELECT orderid, orderdate
FROM orders
WHERE orderdate NOT BETWEEN to_date('2020/07/04') AND to_date('2020/07/07');

--2.6 ���� �达�� ���� �̸��� �ּ�
SELECT NAME, address
FROM customer
WHERE NAME NOT LIKE '��%';

--2.7���� �达�̰� �̸��� '��'�� ������ ���� �̸��� �ּ�
SELECT NAME, address
FROM customer
WHERE NAME LIKE '��%��';

--2.8 �ֹ����� ���� ���� �̸�(�����������) 
SELECT NAME
FROM customer
WHERE custid NOT IN
            (SELECT custid FROM orders);

--2.9 �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��ձݾ�
SELECT sum(saleprice) �Ѿ�, avg(saleprice) ��ձݾ�
FROM orders;

--2.10 ���� �̸��� ���� ���ž�
SELECT NAME �̸�, to_char(sum(saleprice),'999,999')||'��' ���ž�
FROM customer, orders
WHERE customer.custid = orders.custid
GROUP BY NAME;

--2.11 ���� �̸��� ���� ������ ���� ���
SELECT NAME, bookname
FROM customer A, orders b, book c
WHERE A.custid = b.custid
AND B.BOOKID = c.bookid;

--2.12 ������ ����(book ���̺�) �� �ǸŰ���(Orders ���̺�) �� ���̰� ���� ���� �ֹ�
SELECT max(pricegap) ����
FROM (
            SELECT b.NAME, bookname,saleprice,price-saleprice pricegap
            FROM orders A, customer b, book c
            WHERE A.custid = b.custid
            AND A.bookid = c.bookid
          );

--2.13 ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
SELECT avg(saleprice) 
FROM orders; 

SELECT sum(saleprice)
FROM orders, customer
WHERE orders.custid = customer.custid;

SELECT NAME
FROM customer
WHERE (SELECT avg(saleprice) 
            FROM orders) <
            (SELECT avg(saleprice)
            FROM orders, customer
            WHERE orders.custid = customer.custid);
            
           
--����3 ���缭������ ������ ��ȭ�� ������ ���� SQL ���� �ۼ��Ͻÿ�

--3.1 �������� ������ ������ ���ǻ�� ���� ���ǻ翡�� ������ ������ ���� �̸�

SELECT DISTINCT c.NAME
FROM customer c
INNER JOIN orders o ON c.custid = o.custid
INNER JOIN book b ON o.bookid = b.bookid
WHERE b.publisher IN
          (SELECT b.publisher 
          FROM orders o 
          INNER JOIN book b ON o.bookid = b.bookid
          WHERE o.custid = 1)
AND NAME != '������';

--3.2 �� �� �̻��� ���� �ٸ� ���ǻ翡�� ������ ������ ���� �̸�

SELECT NAME, count(publisher)
FROM customer,orders, book
WHERE orders.bookid = book.bookid
AND customer.custid = orders.custid
GROUP BY NAME;

SELECT NAME
FROM customer
WHERE 2<= (
                    SELECT count(publisher)
                    FROM customer,orders, book
                    WHERE orders.bookid = book.bookid
                    AND customer.custid = orders.custid
                    GROUP BY NAME
                    );

--3.3 ��ü ���� 30% �̻��� ������ ����
SELECT bookname
FROM book A NATURAL JOIN orders o
GROUP BY A.bookname
HAVING count(DISTINCT o.custid) >= round(0.3*5);


--���� 4 ���� ���ǿ� ���� DDL���� DML ���� �ۼ��Ͻÿ�

--4.1 ���ο� ����('������ ����','���ѹ̵��','10000��')�� ���缭���� �԰�Ǿ���. 
--������ �� �� ��� �ʿ��� �����Ͱ� �� �ִ��� ã�ƺ��ÿ�
INSERT INTO book VALUES (11, '������ ����','���ѹ̵��','10000');

--4.2 '�Ｚ��' ���� ������ ������ �����Ͻÿ�
DELETE FROM book WHERE publisher = '�Ｚ��';

--4.3 '�̻�̵��' ���� ������ ������ �����Ͻÿ�. ������ �� �Ǹ� ������ �����غ��ÿ�
--orders�� �ش� å �Ǹų����� �־ ������ �ȵǴ� �� ����. 
DELETE FROM book WHERE publisher = '�̻�̵��';


--4.4 ���ǻ� '���ѹ̵��'�� '�������ǻ�'�� �̸��� �ٲٽÿ�

--4.5 (���̺����) ���ǻ翡 ���� ������ �����ϴ� ���̺� Bookcompany(name, address,begin)�� �����ϰ����Ѵ�.

--name�� �⺻Ű�̸� VARCHAR(20), address�� VARCHAR(20), begin�� DATE Ÿ������ �����Ͽ� �����Ͻÿ�

--4.6 (���̺� ����) Bookcompany���̺� ���ͳ� �ּҸ� �����ϴ� webaddress�Ӽ��� VARCHAR(30)���� �߰��Ͻÿ�

--4.7 Bookcompany���̺� ������ Ʃ�� name=�Ѻ���ī����, address=����� ������, begin=1993-01-01, webaddress://hanbit.co.kr�� �����Ͻÿ�





--[���� 4-1] -78�� +78�� ������ ���Ͻÿ�.(ABS)

--[���� 4-2] 4.875�� �Ҽ� ù° �ڸ����� �ݿø��� ���� ���Ͻÿ�.(ROUND)

--[���� 4-3] ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.(ROUND)

--[���� 4-4] ���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ����� ���̽ÿ�.(REPLACE)

--[���� 4-5] ���½����������� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.(LENGTH, LENGTHB)

--[���� 4-6] ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.(SUBSTR)

--[���� 4-7] ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.

--[���� 4-8] ���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. �� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.

--[���� 4-9] DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.(NVL)

--[���� 4-10] �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� ������ó���������� ǥ���Ͻÿ�.(ROWNUM)

--[���� 4-11] ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.

--[���� 4-12] ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.

--[���� 4-13] �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.

--[���� 4-14] �����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.

--[���� 4-15] 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.(ALL)

--[���� 4-16] EXISTS �����ڸ� ����Ͽ� �����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.(EXISTS)

--[���� 4-17] ���缭���� ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).

--[���� 4-19] ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).

--���⼭���ʹ� ��, �ε��� ���� --

--[���� 4-20] �ּҿ� �����ѹα����� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_Customer�� �����Ͻÿ�.

--[���� 4-21] Orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��, ���迬�ơ� ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.

--[���� 4-22] [���� 4-20]���� ������ �� vw_Customer�� �ּҰ� �����ѹα����� ���� �����ش�. 

--[���� 4-23] �ռ� ������ �� vw_Customer�� �����Ͻÿ�.

--[���� 4-24] Book ���̺��� bookname ���� ������� �ε��� ix_Book�� �����Ͻÿ�.

--[���� 4-25] Book ���̺��� publisher, price ���� ������� �ε��� ix_Book2�� �����Ͻÿ�.

--[���� 4-26] �ε��� ix_Book�� ������Ͻÿ�.

--[���� 4-27] �ε��� ix_Book�� �����Ͻÿ�.