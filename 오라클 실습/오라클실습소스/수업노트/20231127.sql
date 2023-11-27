SELECT * FROM MEMBER;

SELECT * FROM QNA;

SELECT * FROM QNA_COMMENT; 

edit member;

edit QNA;

edit qna_comment;

COMMIT;


SELECT qna_title, qna_content, mem_name
FROM qna, member
WHERE member.mem_no = qna.mem_no;

SELECT 
        qna_title, qna_content, mem_name
FROM qna NATURAL JOIN member;

--
SELECT 
        qna_title, qna_content, mem_name, qc_content
FROM qna, member, qna_comment
WHERE member.mem_no = qna.mem_no
AND qna.qna_no = qna_comment.qna_no;


--����� ���� ���̶� �ҷ����� -> outer join (���� ������ + ���̱�) 
SELECT 
        qna_title, qna_content, mem_name, qc_content
FROM qna, member, qna_comment 
WHERE member.mem_no = qna.mem_no
AND qna.qna_no = qna_comment.qna_no(+);
