--ex19_subquery.sql

/*
  
 	 SQL
 	 1. Main Query, 일반 쿼리
  	 	- 하나의 문장 안에 하나의 SELECT(INSERT, UPDATE, DELETE)로 되어 있는 쿼리
  	 	
  	 2. Sub Query, 서브 쿼리, 부속 질의
  	 	- 하나의 문장 안에(SELECT, INSERT, UPDATE, DELETE) 또 다른 문장(SELECT)이 들어있는 쿼리
  		- 하나의 SELECT 안에 또 다른 SELECT 문이 들어있는 쿼리
  		- 삽입 위치 > SELECT절, FROM절, WHERE절, GROUP BY절, HAVING절, ORDER BY절
  		- 컬럼(값)을 넣을 수 있는 장소면 서브쿼리가 들어갈 수 있다.
  		 
 */

--tblCountry 인구수가 가장 많은 나라의 이름? 중국

UPDATE tblcountry SET POPULATION = POPULATION + 100 WHERE name = '중국';



SELECT
	MAX(POPULATION)
FROM tblcountry;


SELECT
	name
FROM tblcountry
	WHERE POPULATION = 120760;	--매번 수정해야함. 실수 할 확률 높음.

SELECT
	name
FROM tblcountry
	WHERE POPULATION = MAX(POPULATION);

SELECT
	name
FROM tblcountry
	WHERE POPULATION = (SELECT MAX(POPULATION) FROM tblcountry);

-- tblComedian. 몸무게가 가장 많이 나가는 사람의 이름?
SELECT MAX(WEIGHT) FROM tblcomedian;
SELECT * FROM TBLCOMEDIAN WHERE WEIGHT = 129;

SELECT * FROM tblcomedian WHERE weight = (SELECT MAX(WEIGHT) FROM tblcomedian);

--tblinsa 평균 급여보다 많이 직원들?
SELECT * FROM tblinsa WHERE BASICPAY >= (SELECT AVG(BASICPAY) FROM tblinsa);

--tblmen/tblwomen 남자(166)의 여자친구의 키?
SELECT * FROM tblmen;
SELECT * FROM tblwomen;

--SELECT * FROM tblwomen WHERE 조건

--1. 서브쿼리 값부터 맞는지 확인하기 -> 맞으면 전체문장 확인하기
SELECT * FROM tblwomen WHERE couple = (SELECT NAME FROM tblmen WHERE HEIGHT = 166);

/*
  
  	서브쿼리 삽입 위치
 	 1. 조건절 > 비교값으로 사용
 	 	a. 반환값이 1행 1열 > 단일값 반환 > 상수 취급 > 값 1개
 	 	b. 반환값이 n행 1열 > 다중값 반환 > 열거형 비교 > in 사용
 	 	c. 반환값이 1행 N열 > 다중값 반환
 	 	d. 반환값이 N행 N열 > 다중값 반환
  
 */

--급여가 260만원 이상 받는 직원이 근무하는 부서의 직원 명단을 가져오시오.
SELECT
*
FROM tblinsa
	WHERE BUSEO = (급여가 260만원 이상 받는 직원이 근무하는 부서);


--ORA-01427: single-row subquery returns more than one row 오른쪽 값이 두갠데 어떻게 왼쪽 한개랑 비교함?
SELECT
*
FROM tblinsa
	WHERE BUSEO = (SELECT BUSEO FROM tblinsa WHERE BASICPAY >= 2600000);

SELECT
*
FROM tblinsa
	WHERE BUSEO = '총무부' OR BUSEO = '기획부';

SELECT
*
FROM tblinsa
	WHERE BUSEO IN('총무부', '기획부');

SELECT
*
FROM tblinsa
	WHERE BUSEO IN (SELECT BUSEO FROM tblinsa WHERE BASICPAY >= 2600000);

