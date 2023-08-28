--ex06_colum.sql

-- 컬럼 리스트에서 할 수 있는 행동
-- select 컬럼 리스트

-- 컬럼 명시
SELECT  * FROM TBLINSA ;

SELECT name, ssn FROM TBLINSA ; 

--연산
SELECT name || '님', basicpay * 2 FROM TBLINSA ;

--상수
SELECT 100  FROM TBLINSA ;

/*
  
 Java Stream > list.stream.distinct().forEach()
   
 distinct 
 - 컬럼 리스트에서 사용
 - 중복값 제거
 - distinct 컬럼명(X) > distinct 컬럼 리스트(O)에 붙인거 
 - 한개뿐 아니라 두개 세개도 가능 고유값 안가진 것에 한하여
  
  
 */


SELECT DISTINCT CONTINENT  FROM  TBLCOUNTRY ;

--tblinsa > 수많은 부서 > 어떤 부서가 있습니까? > 중복값 제거
SELECT buseo FROM TBLINSA; 

SELECT DISTINCT BUSEO FROM TBLINSA; 

SELECT DISTINCT JIKWI  FROM TBLINSA; 

SELECT DISTINCT name FROM TBLINSA;

SELECT 
	DISTINCT  BUSEO, NAME 
FROM TBLINSA ;

SELECT 
	DISTINCT  BUSEO, JIKWI  
FROM TBLINSA ;


/*
 * 
 * 
 * case
 * - 대부분의 절에서 사용 가능
 * - 조건문 역할 > 컬럼값 조작
 * - 조건을 만족하지 못하면 NULL을 반환(****************)
 * 
 * 
 * 
 * 
 * */

SELECT  
	LAST || FIRST AS name,
	GENDER 
FROM TBLCOMEDIAN; 

SELECT  
	LAST || FIRST AS name,
	CASE					--시작괄호	
		--WHEN 조건 THEN 값
		WHEN GENDER = 'm' THEN '남자'
		WHEN GENDER = 'f' THEN '여자'
	END AS GENDER						--닫는 괄호// 두번째 반환값
FROM TBLCOMEDIAN; 


SELECT 
	NAME, CONTINENT,
	CASE
		WHEN CONTINENT = 'AS' THEN '아시아'
		WHEN CONTINENT = 'EU' THEN  '유렵'
		WHEN CONTINENT = 'AF' THEN '아프리카'
--		ELSE '기타'
--		ELSE CONTINENT 
--		ELSE 100	--  inconsistent datatypes: expected CHAR got NUMBER/ 모든 경우의 수가 자료형이 일치해야함
--		ELSE CAPITAL -- 실행은 되나 상식적으로 만들어야함
	END	AS continentNAME
FROM TBLCOUNTRY; 


SELECT 
	"LAST" || "FIRST"  AS name,
	WEIGHT, 
	CASE
		WHEN WEIGHT > 50 AND WEIGHT <= 90 THEN '정상체중'
		ELSE '주의체중'
	END AS state
FROM TBLCOMEDIAN; 


SELECT 
	"LAST" || "FIRST"  AS name,
	WEIGHT, 
	CASE
		WHEN WEIGHT BETWEEN 50 AND 90 THEN '정상체중'
		ELSE '주의체중'
	END AS state
FROM TBLCOMEDIAN; 

SELECT 
	name, jikwi,
	CASE
		WHEN jikwi = '과장' OR jikwi = '부장' THEN '관리직'
		ELSE '생산직'
	END,
	CASE
		WHEN jikwi IN ('과장','부장') THEN '관리직'
		ELSE '생산직'
	END
FROM TBLINSA; 

SELECT
	name, sudang,
	CASE 
		WHEN NAME LIKE '홍%' THEN 50000
		ELSE 0
	END + SUDANG 
FROM TBLINSA ;

SELECT
	TITLE,
	CASE
		WHEN COMPLETEDATE IS NULL THEN '미완료'
		WHEN COMPLETEDATE IS NOT NULL THEN '완료'
	END AS state
FROM TBLTODO; 

