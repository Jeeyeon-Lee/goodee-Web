CREATE SEQUENCE Seq_notice_no;

INSERT INTO  notice(n_no,  n_title, n_content, n_writer)
VALUES(seq_notice_no.NEXTVAL, 1, '����', '�ۼ���');

UPDATE notice
      set n_title = '����1'
          ,  n_content = '����1'
          , n_writer = '�ۼ���1'
  WHERE n_no = 1;
  
DELETE FROM notice WHERE n_no = 1;  

COMMIT;