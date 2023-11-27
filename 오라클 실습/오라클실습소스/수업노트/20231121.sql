/* Formatted on 2023/11/21 오후 8:10:20 (QP5 v5.215.12089.38647) */
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

  SELECT deptno AS "부서번호",
         TO_CHAR (ROUND (AVG (sal)), '9,999') || '만원' AS "평균급여"
    FROM emp
GROUP BY deptno
ORDER BY 평균급여 DESC;



  SELECT deptno AS "부서번호",
         TO_CHAR (ROUND (AVG (sal)), '9,999') || '만원' AS "평균급여"
    FROM emp
GROUP BY deptno
  HAVING AVG (sal) > 2000
ORDER BY 평균급여 DESC;

SELECT * FROM t_letitbe;

--Mod?

--홀수의 집합

SELECT MOD (seq_vc, 2)
  FROM t_letitbe
 WHERE MOD (seq_vc, 2) = 1;

--짝수의 집합

SELECT MOD (seq_vc, 2)
  FROM t_letitbe
 WHERE MOD (seq_vc, 2) = 0;

--1. 영어가사만 나와

SELECT MOD (seq_vc, 2), WORDS_VC
  FROM T_LETITBE
 WHERE MOD (seq_vc, 2) = 1;

SELECT eng_words
  FROM (SELECT DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words FROM t_letitbe);

SELECT num, eng_words
  FROM (SELECT MOD (seq_vc, 2) num,
               DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words
          FROM t_letitbe)
 WHERE num = 1;


--2. 한글가사만 나와

SELECT MOD (seq_vc, 2), WORDS_VC
  FROM T_LETITBE
 WHERE MOD (seq_vc, 2) = 0;

SELECT num, eng_words
  FROM (SELECT MOD (seq_vc, 2) num,
               DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words
          FROM t_letitbe)
 WHERE num = 1;

--3.영문가사와 한글가사 모두 나오게 하기

SELECT TO_NUMBER (seq_vc), WORDS_VC
  FROM T_LETITBE
 WHERE MOD (seq_vc, 2) = 1
UNION
SELECT TO_NUMBER (seq_vc), WORDS_VC
  FROM T_LETITBE
 WHERE MOD (seq_vc, 2) = 0;



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
       (SELECT point_nu
          FROM t_giftpoint
         WHERE name_vc = '영화티켓') poi;

SELECT name_vc AS "회원이름",
       mem.point_nu - poi.point_nu AS "잔여포인트"
  FROM t_giftmem mem,
       (SELECT point_nu
          FROM t_giftpoint
         WHERE name_vc = '영화티켓') poi
 WHERE mem.point_nu - poi.point_nu > 0;


SELECT name_vc AS "회원이름",
       mem.point_nu - poi.point_nu AS "잔여포인트"
  FROM t_giftmem mem,
       (SELECT point_nu
          FROM t_giftpoint
         WHERE name_vc = '영화티켓') poi
 WHERE mem.point_nu >= poi.point_nu;

--2.김유신씨가 보유하고 있는 마일리지 포인트로 얻을 수 있는 상품 중
--가장 포인트가 높은 것은 무엇인가?

--김유신 포인트 가져오기

SELECT mem.NAME_vc AS "이름", mem.point_nu AS "포인트"
  FROM t_giftmem mem
 WHERE mem.Name_vc = '김유신';

--가장 포인트 높은 상품

SELECT MAX (poi.point_nu)
  FROM t_giftpoint poi
 WHERE point_nu <= 50012;

--두 개 같이

SELECT poi.name_vc AS "상품"
  FROM t_giftpoint poi
 WHERE point_nu = (SELECT MAX (poi.point_nu)
                     FROM t_giftpoint poi
                    WHERE point_nu <= 50012);

--decode 실습

SELECT DECODE (1, 1, 't'),                                                 --t
                          DECODE (1, 2, 't', 'f')                          --f
                                                 FROM DUAL;

 --학점, 시수가 같은 경우, 일반과목을 돌려받기

SELECT lec_id,
       lec_time,
       lec_point,
       DECODE (lec_time, lec_point, '일반과목', '다름')
  FROM lecture;

SELECT lec_id, DECODE (lec_time, lec_point, '일반과목', NULL)
  FROM lecture;

--2. 주당 강의 시간과 학점이 같은 강좌의 숫자를 알고 싶음. (decode 사용)

SELECT COUNT (DECODE (lec_time, lec_point, 1)) AS "강좌의 수"
  FROM lecture;

 --3.강의시간과 학점이 같거나 강의시간<학점 '일반과목',
 --강의시간>학점 '실험과목',

SELECT DECODE (lec_time - lec_point, 1, '실험과목', '일반과목')
          AS "구분"
  FROM lecture;


SELECT lec_id,
       DECODE (lec_time, lec_point, '일반과목') AS "구분1",
       DECODE (SIGN (lec_time - lec_point), 1, '실험과목') AS "구분2",
       DECODE (SIGN (lec_time - lec_point), -1, '일반과목') AS "구분3"
  FROM lecture;



 --3-1.lec_time이 크면 '실험과목, lec_point가 크면 '기타과목',
 --같으면 '일반과목'으로 돌려받기

SELECT DECODE (SIGN (lec_time - lec_point),
               1, '기타과목',
               0, '일반과목',
               -1, '실험과목')
          AS "구분"
  FROM lecture;

 --3-2. 강의시간 = 학점 , '일반과목' & 정렬

  SELECT lec_id, DECODE (lec_time, lec_point, '일반과목', NULL) AS "과목"
    FROM lecture
ORDER BY lec_id;

  SELECT lec_id, DECODE (lec_time, lec_point, '일반과목', NULL) AS "과목"
    FROM lecture
ORDER BY DECODE (lec_time, lec_point, '일반과목', NULL) ASC;

 --인센티브 많이 받는 사원 순

  SELECT comm
    FROM emp
   WHERE comm IS NOT NULL
ORDER BY comm DESC;

-- 널이 있는 경우에는 널값이 제일 위로 올라옴.

  SELECT comm
    FROM emp
ORDER BY comm DESC;


--(if문 decode) 월요일엔 해당일자에 01을 붙여서 4자리 암호를 만들고,
--화요일엔 11, 수요일엔 21, 목요일엔, 31, 금요일엔 41, 토요일엔 51,
--일요일엔 61을 붙여서 4자리 암호를 만든다고 할 때
--암호를 SELECT하는 SQL을 만들어 보시오.

--어제, 오늘, 내일 but 자주 사용x 왜?? UI 받아오는 값이 대부분이고, 그 값이 대부분 문자열임

SELECT SYSDATE - 1, SYSDATE, SYSDATE + 1 FROM DUAL;

SELECT SYSDATE AS "오늘",
       TO_CHAR (SYSDATE, 'DD') AS "날짜",
       TO_CHAR (SYSDATE, 'day') AS "요일"
  FROM DUAL;

--(if문 decode) 월요일엔 해당일자에 01을 붙여서 4자리 암호를 만들고,
--화요일엔 11, 수요일엔 21, 목요일엔, 31, 금요일엔 41, 토요일엔 51,
--일요일엔 61을 붙여서 4자리 암호를 만든다고 할 때
--암호를 SELECT하는 SQL을 만들어 보시오.

SELECT    DECODE (TO_CHAR (SYSDATE, 'day'),
                  '월요일', '01',
                  '화요일', '11',
                  '수요일', '21',
                  '목요일', '31',
                  '금요일', '41',
                  '토요일', '51',
                  '일요일', '61')
       || TO_CHAR (SYSDATE, 'DD')
          AS "생성 암호"
  FROM DUAL;


--실전문제
--문제 : 사원테이블에서 job이 clerk인 사람의 급여 합,  salesman인 사람의
--급여의 합을 구하고 나머지 job에 대해서는 기타 합으로 구하시오.

  SELECT JOB, TO_CHAR (SUM (sal), '9,999') || '원' AS "총급여"
    FROM emp
GROUP BY JOB;

SELECT DECODE (JOB, 'clerk', sal, NULL) FROM emp;


SELECT DECODE (JOB, 'CLERK', sal, NULL),
       DECODE (JOB, 'SALESMAN', sal, NULL),
       DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL,  sal)
  FROM emp;


SELECT JOB, DECODE (JOB,  'CLERK', sal,  'SALESMAN', sal,  sal) AS "합"
  FROM emp;


  SELECT JOB, TO_CHAR (SUM (sal), '9,999') || '원'
    FROM emp,
         (SELECT DECODE (JOB,  'CLERK', sal,  'SALESMAN', sal,  sal) FROM emp)
GROUP BY JOB;

  SELECT JOB, SUM (sal)
    FROM emp,
         (SELECT DECODE (JOB,  'CLERK', sal,  'SALESMAN', sal,  sal) FROM emp)
GROUP BY JOB;


SELECT SUM (DECODE (JOB, 'CLERK', sal)) FROM emp;


SELECT dname,
       DECODE (JOB, 'CLERK', sal, NULL) AS "CLERK",
       DECODE (JOB, 'MANAGER', sal, NULL) AS "MANAGER",
       DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL,  sal) AS "ETC"
  FROM emp, dept;


SELECT DISTINCT
       dname,
       DECODE (JOB, 'CLERK', sal, NULL) AS "CLERK",
       DECODE (JOB, 'MANAGER', sal, NULL) AS "MANAGER",
       DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL,  sal) AS "ETC"
  FROM emp, dept
 WHERE emp.deptno = dept.deptno;

  SELECT DISTINCT dname,
                  CLERK,
                  MANAGER,
                  ETC
    FROM (SELECT dname,
                 DECODE (JOB, 'CLERK', sal, NULL) AS "CLERK",
                 DECODE (JOB, 'MANAGER', sal, NULL) AS "MANAGER",
                 DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL,  sal) AS "ETC"
            FROM emp, dept
           WHERE emp.deptno = dept.deptno)
ORDER BY dname;


--empno 에 max 를 씌운 것은 문법적 문제를 해결하기 위해서일 뿐이다.

SELECT MAX (empno),
       COUNT (DECODE (JOB, 'CLERK', sal, NULL)),
       SUM (DECODE (JOB, 'CLERK', sal, NULL)),
       COUNT (DECODE (JOB, 'SALESMAN', sal, NULL)),
       SUM (DECODE (JOB, 'SALESMAN', sal, NULL))
  FROM emp;


--empno 에 max 를 씌운 것은 문법적 문제를 해결하기 위해서일 뿐이다.

SELECT SUM (DECODE (JOB, 'CLERK', sal, NULL)),
       SUM (DECODE (JOB, 'SALESMAN', sal, NULL)),
       SUM (DECODE (JOB,  'CLERK', NULL,  'SALESMAN', NULL,  sal)) etc_sal,
       SUM (sal)
  FROM emp;

--한번 읽고 처리하도록

--emp 테이블 사원이름을 한 행에 사번, 성명을 세 명씩 보여주는 쿼리문을 작성하시오.

--사전학습문제
--각 행에 1학년부터 4학년까지 분리 한 행에 하나의 학년만 나오도록 (6장-06-002)
--현재는 로우에 학년별 정원 -> 컬럼으로 학년별 정원이 나오도록 변환
--12개 학과, 4학년 카타시안 곱 사용 & decode 사용 ???

SELECT * FROM test11;


--max, min줘도 영향이 없는 건 A컬럼에 대해 문법적 문제를 해결하는 용도로 사용되었기 때문이다.

SELECT A.dept,
       b.rno AS "학년",
       DECODE (b.rno,  1, A.fre,  2, A.sup,  3, A.jun,  4, A.sen)
          AS "정원수"
  FROM (SELECT dept,
               fre,
               sup,
               jun,
               sen
          FROM test11
         WHERE dept = '항공우주공학과') A,
       (SELECT ROWNUM rno
          FROM dept
         WHERE ROWNUM <= 4) b;

SELECT DECODE (MOD (seq_vc, 2), 1, words_vc, '0') eng_words FROM t_letitbe;

SELECT dname FROM emp;

SELECT DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words
  FROM t_letitbe
 WHERE eng_words = 1;

 별칭을 굳이 조건절에서 사용하고 싶다면 인라인뷰를 사용하시오.

SELECT eng_words
  FROM (SELECT DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words FROM t_letitbe);

SELECT num, eng_words
  FROM (SELECT MOD (seq_vc, 2) num,
               DECODE (MOD (seq_vc, 2), 1, words_vc) eng_words
          FROM t_letitbe)
 WHERE num = 1;