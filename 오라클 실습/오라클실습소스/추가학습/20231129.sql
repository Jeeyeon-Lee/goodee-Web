
--[���� 4-1] -78�� +78�� ������ ���Ͻÿ�.(ABS)

SELECT abs(-78) AS "���밪", abs(78) AS "���밪" FROM dual;

--[���� 4-2] 4.875�� �Ҽ� ù° �ڸ����� �ݿø��� ���� ���Ͻÿ�.(ROUND)

SELECT round(4.875,1) FROM dual;

--[���� 4-3] ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.(ROUND)
SELECT round(

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


--[���� 5-3] Book ���̺� ����� ������ ��հ����� ��ȯ�ϴ� ���ν����� �ۼ��Ͻÿ�.

--[���� 5-4] Orders ���̺��� �Ǹ� ������ ���� ������ ����ϴ� ���ν����� �ۼ��Ͻÿ�.


--��������


--1. ���� ���α׷��� ���ν����� �ۼ��ϰ� �����Ͻÿ�. DB�� ���缭���� �̿�

--1.1 ���� ���� ����ϴ� InsertCustomer()���ν����� �ۼ��Ͻÿ�


CREATE OR REPLACE PROCEDURE proc_insertC(p_id IN number , p_name IN varchar2, p_address IN varchar2, p_phone IN varchar2)
IS
BEGIN
    INSERT INTO customer (custid, NAME, address, phone) VALUES(p_id,p_name,p_address,p_phone);
    COMMIT;
END;

--1.2 ���ο� ������ �����ϴ�  BookInsertOrUpdate() ���ν����� �ۼ�, ������ ������ �ִٸ� ������ ���� ���� ������Ʈ

CREATE OR REPLACE PROCEDURE bookInsertOrUpdate(p_bookid IN number, p_bookname IN varchar2, p_publisher IN varchar2, p_price IN number) 
IS
    new_price number(8) := 0;
    save_price number(8) := 0;
BEGIN
    --����, ���� ���� �� ��ȸ�Ͽ� ���ο� å  ���Ͽ� ���������� ������ ����
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

--2. ���� ���α׷��� ���ν����� �ۼ��ϰ� �����Ͻÿ�. DB�� ���缭���� �̿�

--2.1 ���ǻ簡 '�̻�̵��' �� ������ �̸��� ������ �����ִ� ���ν����� �ۼ�

CREATE OR REPLACE PROCEDURE proc_found
IS
    v_bookname varchar2(40):= '';
    v_price number(8) := 0;    
BEGIN
    SELECT bookname, price INTO v_bookname, v_price
    FROM book WHERE publisher = '�̻�̵��';
    dbms_output.put_line('�̻�̵��� ���� ���ǻ��� ������'||v_bookname||'�� �ְ�, �� ������ '||v_price||'�Դϴ�'); 
END;

--2.2 ���ǻ纰�� ���ǻ� �̸��� ������ �Ǹ� �Ѿ��� ���̽ÿ�(Orders ���̺� �̿�)
--group, for��?, sum 
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

--2.3 ���ǻ纰�� ������ ��հ����� ��� ������ �̸��� ���̽ÿ�(���� ��� A ���ǻ� ������ ��հ��� 20,000���̶�� A���ǻ� ���� �� 20000�� �̻��� ������ ���̸� ��)
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;

--2.4 ������ ������ �� �� �����ߴ����� �ѱ��ž��� ���̽ÿ�
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;

--2.5 �ֹ��� �ִ� ���� �̸��� �ֹ� �Ѿ��� ����ϰ�, �ֹ��� ���� ���� �̸��� ����ϴ� ���ν����� �ۼ�
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;


--3. ���� PL/SQL �Լ��� �ۼ��Ͻÿ� DB�� ���缭�� �̿�
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;


--3.1 ���� �ֹ� �Ѿ��� ����Ͽ� 20000�� �̻��̸� '���' 20000�� �̸��̸� '����'�� ��ȯ�ϴ� �Լ� Grade()�� �ۼ��Ͻÿ�. 
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;

--Grade()�� ȣ���Ͽ� ���� �̸��� ����� ���̴� SQL�� �ۼ��Ͻÿ�
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;


--3.2 �����ּҸ� �̿��Ͽ� ������ �����ϸ� '��������', �ؿܿ� �����ϸ� '���ܰ���'�� ��ȯ�ϴ� �Լ� Domestic()�� �ۼ��Ͻÿ�.
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;

--Domestic()�� ȣ���Ͽ� �� �̸��� ����/���� ���� ���θ� ����ϴ� SQL���� �ۼ��Ͻÿ�
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;



--3.3 '3.2' ���� �ۼ��� Domestic()�� ȣ���Ͽ� �������� ���� �Ǹ� �Ѿװ� ���ܰ��� ���� �Ǹ��Ѿ��� ����ϴ� SQL���� �ۼ��Ͻÿ�
CREATE OR REPLACE PROCEDURE
IS
BEGIN
END;
