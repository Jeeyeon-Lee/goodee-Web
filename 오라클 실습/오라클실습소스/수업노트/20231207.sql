CREATE SEQUENCE Seq_notice_no;

INSERT INTO  notice(n_no,  n_title, n_content, n_writer)
VALUES(seq_notice_no.NEXTVAL, 1, '力格', '累己磊');

UPDATE notice
      set n_title = '力格1'
          ,  n_content = '郴侩1'
          , n_writer = '累己磊1'
  WHERE n_no = 1;
  
DELETE FROM notice WHERE n_no = 1;  

COMMIT;