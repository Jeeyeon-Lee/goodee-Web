/* Formatted on 2023/11/21 오전 10:14:23 (QP5 v5.215.12089.38647) */
SELECT empno, sal
  FROM (SELECT empno, ename
          FROM emp
         WHERE deptno = 10);

SELECT empno FROM emp;

SELECT ename, sal FROM emp;

--반정규화 권장하지 않음 ?

SELECT emp.empno, emp.ename, dept.dname
  FROM dept, emp
 WHERE dept.deptno = emp.deptno;

--그룹함수 max, min, avg 등 -> 전체범위 처리

SELECT TO_CHAR (MAX (sal), '999,999,999') || '만원' AS "max",
       TO_CHAR (MIN (sal), '999,999,999') || '만원' AS "min",
       TO_CHAR (ROUND (AVG (sal)), '999,999,999') || '만원' AS "avg"
  FROM emp;

SELECT ename
  FROM emp
 WHERE sal = (SELECT MAX (sal) FROM emp);

--6.TEMP의 자료 중 EMP_ID와 EMP_NAME을 각각 ‘사번’,’성명’으로 표시되어
--DISPLAY되도록 COLUMN ALLIAS를 부여하여 SELECT 하시오.


SELECT TO_CHAR (emp_id) || '번' AS "사번", emp_name AS "성명" FROM temp;

SELECT 사번, 성명
  FROM (SELECT emp_id AS "사번", emp_name AS "성명" FROM temp);

--7.TEMP의 자료를 직급 명(LEV)에 ASCENDING(오름)하면서 결과내에서 다시 사번(EMP_NAME) 순으로
--DESCENDING(내림)하게 하는 ORDER BY하는 문장을 만들어 보시오.

  SELECT *
    FROM temp
ORDER BY lev ASC, emp_name DESC;

--8. 부서별 급여 평균을 구하시오
SELECT 
    deptno AS "부서번호", 
    to_char(round(avg(sal)),'9,999')||'만원' AS "평균급여"
FROM emp
GROUP BY deptno
ORDER BY 평균급여 desc;

SELECT 
    deptno AS "부서번호", 
    to_char(round(avg(sal)),'9,999')||'만원' AS "평균급여"
FROM emp
GROUP BY deptno
HAVING avg(sal)>2000
ORDER BY 평균급여 desc;

CREATE TABLE T_LETITBE
(
SEQ_VC VARCHAR2(2),
WORDS_VC VARCHAR2(100)
)
/
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (1,'Let it be');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (2,'내버려 두어라');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (3,'When I find myself in times of trouble');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (4,'내가 괴로움의 시간에서 방황할 때면 ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (5,'Mother Mary comes to me Speaking words of wisdom,');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (6,'어머니는 내게 다가와 현명한 말씀을 해주신다. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (7,'Let it be ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (8,'내버려 두어라.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (9,'And in my hour of darkness ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (10,'그리고 내가 어둠속에 헤매일 때, ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (11,'She is standing right in front of me Speaking words of wisdom,');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (12,'그녀는 내 바로 앞에서, 현명한 말씀을 해주신다. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (13,'Let it be. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (14,'내버려 두어라.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (15,'And when the broken hearted people Living in the world agree, There will be an answer, ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (16,'이 세상의 상처받은 사람들은 이 말씀이 방법이 될 거라 믿는다. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (17,'Let it be ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (18,'내버려 두어라.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (19,'For though they may be parted ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (20,'그들이 헤어지더라도 여전히 그들이 만날 기회는 있을것이다. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (21,'There is still a chance that they will see, There will be an answer,');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (22,'방법은 있을 것이다.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (23,'let it be ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (24,'내버려 두어라.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (25,'And the night is cloudy, there is still a light that shines on me.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (26,'구름이 낀 밤에도, 아직 날 비추어주는 빛이 있어. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (27,'Shine until tomorrow, let it be.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (28,'희망은 계속될 것이다.내버려 두어라. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (29,'I wake up to the sound of music,');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (30,'음악 소리에 난 깨어나고, ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (31,'Mother Mary comes to me,Speaking words of whisdom,');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (32,'어머니 메어리는 내게 다가와,현명한 말씀을 해 주신다. ');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (33,'Let it be.');
INSERT INTO T_LETITBE (SEQ_VC,WORDS_VC) VALUES (34,'내버려 두어라. ');
COMMIT;

SELECT*FROM t_letitbe;
--Mod?

--홀수의 집합
SELECT mod(seq_vc,2) FROM t_letitbe
WHERE mod(seq_vc,2) =1;

--짝수의 집합
SELECT mod(seq_vc,2) FROM t_letitbe
WHERE mod(seq_vc,2) =0;

--1. 영어가사만 나와
SELECT mod(seq_vc,2), WORDS_VC FROM T_LETITBE 
WHERE mod(seq_vc,2) =1;

--2. 한글가사만 나와
SELECT mod(seq_vc,2), WORDS_VC FROM T_LETITBE 
WHERE mod(seq_vc,2) =0;

--3.영문가사와 한글가사 모두 나오게 하기 
SELECT to_number(seq_vc) , WORDS_VC FROM T_LETITBE 
WHERE mod(seq_vc,2) =1
UNION
SELECT to_number(seq_vc), WORDS_VC FROM T_LETITBE 
WHERE mod(seq_vc,2) =0;


--1. 영화 티켓을 받을 수 있는 사람의 명단과 현재 가지고 있는 포인트, 영화 티켓의 포인트
--그리고 그 티켓을 사용한 후 남은 예상 포인트를 출력하시오

SELECT * FROM T_GIFTMEM;

SELECT * FROM t_giftpoint;

--영화티켓 15000점
--남은 포인트 - 회원보유포인트-영화포인트 = 잔여포인트
--where 조건식 : 보유포인트 > 영화티켓 포인트

--from절에 들어갈 인라인 뷰 작성 -> 대상 줄여서 속도 향상
SELECT point_nu
FROM t_giftpoint
WHERE name_vc = '영화티켓';

SELECT * 
FROM t_giftmem mem,
    (
    SELECT point_nu
    FROM t_giftpoint
    WHERE name_vc = '영화티켓'
    ) poi;
    
SELECT name_vc AS "회원이름",mem.point_nu-poi.point_nu AS "잔여포인트" 
FROM t_giftmem mem,
    (
    SELECT point_nu
    FROM t_giftpoint
    WHERE name_vc = '영화티켓'
    ) poi
WHERE mem.point_nu-poi.point_nu>0;  


SELECT name_vc AS "회원이름",mem.point_nu-poi.point_nu AS "잔여포인트" 
FROM t_giftmem mem,
    (
    SELECT point_nu
    FROM t_giftpoint
    WHERE name_vc = '영화티켓'
    ) poi
WHERE mem.point_nu>=poi.point_nu;

--2.김유신씨가 보유하고 있는 마일리지 포인트로 얻을 수 있는 상품 중 
--가장 포인트가 높은 것은 무엇인가?

--김유신 포인트 가져오기
SELECT mem.NAME_vc AS "이름", mem.point_nu AS "포인트"
FROM
    t_giftmem mem  
WHERE mem.Name_vc = '김유신';

--가장 포인트 높은 상품
SELECT max(poi.point_nu)
FROM t_giftpoint poi
WHERE point_nu<=50012;

--두 개 같이
SELECT poi.name_vc AS "상품"
FROM
    t_giftpoint poi  
WHERE point_nu = (
    SELECT max(poi.point_nu)
    FROM t_giftpoint poi
    WHERE point_nu<=50012
    );

--decode 실습
SELECT decode(1,1,'t'),    --t
            decode(1,2,'t','f')  --f
 FROM dual;
 
 --학점, 시수가 같은 경우, 일반과목을 돌려받기
SELECT lec_id, lec_time, lec_point, decode(lec_time,lec_point,'일반과목','다름')
FROM lecture;

SELECT lec_id, decode(lec_time,lec_point,'일반과목',NULL)
FROM lecture;

--2. 주당 강의 시간과 학점이 같은 강좌의 숫자를 알고 싶음. (decode 사용)
SELECT count(decode(lec_time,lec_point,1)) AS "강좌의 수"
FROM lecture ;
    
 --3.강의시간과 학점이 같거나 강의시간<학점 '일반과목',
 --강의시간>학점 '실험과목',
 
 SELECT decode(lec_time-lec_point,1,'실험과목','일반과목') AS "구분"
 FROM lecture;
 
 
 SELECT 
        lec_id,
        decode(lec_time,lec_point,'일반과목') AS "구분1",  
        decode(sign(lec_time-lec_point),1,'실험과목') AS "구분2", 
        decode(sign(lec_time-lec_point),-1,'일반과목') AS "구분3"
 FROM lecture;

 
 
 --3-1.lec_time이 크면 '실험과목, lec_point가 크면 '기타과목',
 --같으면 '일반과목'으로 돌려받기 
 
 SELECT decode(sign(lec_time-lec_point),1,'기타과목','일반과목') AS "구분"
 FROM lecture;
 
 --월요일엔 해당일자에 01을 붙여서 4자리 암호를 만들고, 
--화요일엔 11, 수요일엔 21, 목요일엔, 31, 금요일엔 41, 토요일엔 51,
--일요일엔 61을 붙여서 4자리 암호를 만든다고 할 때 
--암호를 SELECT하는 SQL을 만들어 보시오.

SELECT sysdate AS "날짜", To_char(sysdate,'DD')
FROM dual;

