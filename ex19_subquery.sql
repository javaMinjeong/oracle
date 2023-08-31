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
 	 	c. 반환값이 1행 N열 > 다중값 반환 > 그룹 비교 > N컬럼 : N컬럼
 	 	d. 반환값이 N행 N열 > 다중값 반환 > 2+3 > in + 그룹비교
 	 	
  
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

-- '홍길동'과 같은 지역, 같은 부서인 직원 명단을 가져오시오. (서울, 기획부)
SELECT * FROM tblinsa
	WHERE city = '서울' AND BUSEO = '기획부';

SELECT * FROM tblinsa
	WHERE city = (SELECT city FROM tblinsa WHERE name = '한석봉')
		AND BUSEO = (SELECT buseo FROM tblinsa WHERE name = '한석봉');	-- 두개 한번에 고치기 귀찮음

--ORA-00913: too many values		
SELECT * FROM tblinsa
	WHERE (city, buseo) = (SELECT city, buseo FROM tblinsa WHERE name = '홍길동' );
	-- where 2:2

-- 급여가 200만원 이상 받은 직원과 같은 부서, 같은 지역 > 직원 명단

SELECT
	*
FROM tblinsa
	WHERE (buseo, city) in (SELECT buseo, city FROM tblinsa WHERE basicpay >= 2600000);
/*
 
	서브쿼리 삽입 위치
 	 1. 조건절 > 비교값으로 사용
 	 	a. 반환값이 1행 1열 > 단일값 반환 > 상수 취급 > 값 1개
 	 	b. 반환값이 n행 1열 > 다중값 반환 > 열거형 비교 > in 사용
 	 	c. 반환값이 1행 N열 > 다중값 반환 > 그룹 비교 > N컬럼 : N컬럼
 	 	d. 반환값이 N행 N열 > 다중값 반환 > 2+3 > in + 그룹비교
 	 	
 	 2. 컬럼리스트 > 컬럼값(출력값)으로 사용	
 	 	- 반드시 결과값이 1행 1열이어야 한다. > 스칼라 쿼리 > 원자값 반환
 	 	 a. 정적 쿼리 > 모든 행에 동일한 값을 반환
 	 	 b. 상관 서브 쿼리(*****) > 서브쿼리의 값과 바깥쪽 메인쿼리의 값을 서로 연결
 	 	
 
 */

SELECT
	name, buseo, basicpay,
	(SELECT * FROM dual)
FROM tblinsa

SELECT
	name, buseo, basicpay,
	(SELECT round(avg(basicpay)) FROM tblinsa) AS avg
FROM tblinsa;

--ORA-01427: single-row subquery returns more than one row
SELECT
	name, buseo, basicpay,
	(SELECT jikwi FROM tblinsa)
FROM tblinsa;


SELECT
	name, buseo, basicpay,
	(SELECT jikwi FROM tblinsa WHERE num = 1001)
FROM tblinsa;


SELECT
	name, buseo, basicpay,
	(SELECT round(avg(basicpay)) FROM tblinsa WHERE buseo = a.buseo) AS avg
FROM tblinsa a;

SELECT * FROM tblmen;
SELECT * FROM tblwonen;

--남자(이름, 키, 몸무게) + 여자(이름, 키 ,몸무게)
SELECT
	name AS "남자 이름",
	height AS "남자 키",
	weight AS "남자 몸무게",
	couple AS "여자 이름",
	(SELECT height FROM tblwomen WHERE name = tblmen.couple)AS "여자 키",
	(SELECT weight FROM tblwomen WHERE name = tblmen.couple)AS "여자 몸무게"
FROM tblmen;


/*
 
	서브쿼리 삽입 위치
 	 1. 조건절 > 비교값으로 사용
 	 	a. 반환값이 1행 1열 > 단일값 반환 > 상수 취급 > 값 1개
 	 	b. 반환값이 n행 1열 > 다중값 반환 > 열거형 비교 > in 사용
 	 	c. 반환값이 1행 N열 > 다중값 반환 > 그룹 비교 > N컬럼 : N컬럼
 	 	d. 반환값이 N행 N열 > 다중값 반환 > 2+3 > in + 그룹비교
 	 	
 	 2. 컬럼리스트 > 컬럼값(출력값)으로 사용	
 	 	- 반드시 결과값이 1행 1열이어야 한다. > 스칼라 쿼리 > 원자값 반환
 	 	 a. 정적 쿼리			  > 모든 행에 동일한 값을 반환
 	 	 b. 상관 서브 쿼리(*****) > 서브쿼리의 값과 바깥쪽 메인쿼리의 값을 서로 연결
 	 
 	 3. FROM절에서 사용
 	 	- 서브쿼리의 결과 테이블을 하나의 테이블이라고 생각하고 메인 쿼리가 실행된다.
 	 	- 인라인 뷰(Inline View)
 
 */

SELECT
	*									--4.
FROM									--1.
	(
		SELECT name, buseo				--3.
		FROM tblinsa					--2.
	);

-- 인라인뷰의 컬럼 별칭 > 바깥쪽 메인 쿼리에서 그대로 전달 + 사용
--ORA-00904: "SSN": invalid identifier // as 반드시 붙여야함
SELECT name, gender
FROM (SELECT name, substr(ssn, 1, 8) AS gender FROM tblinsa);

SELECT
	name, height, couple,
	(SELECT height FROM tblwomen WHERE name = tblmen.couple) AS height2
FROM tblmen
	ORDER BY height2;	-- 별칭 동일하게 안정하기!!! // ORA-00960: ambiguous column naming in select list // height가 겹침 