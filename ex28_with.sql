-- ex28_with.sql

/*

 	[WITH <Sub Query>] WITH 절 > 대괄호 생략 가능
    SELECT column_list 
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC|DESC]] 
  
  	from 절 서브쿼리 > 이름없는 테이블 > 1회용 테이블
  	from 테이블 > 이름있는 테이블 > N회용 테이블
  	
  	With 절 
  	- 인라인뷰(from 절 서브쿼리)에 이름을 붙이는 기술
  	
  	with 임시테이블명 as (서브 쿼리)
  	selct 문;
  	
  	
 */

SELECT * from (SELECT name, buseo, jikwi from tblinsa WHERE city = '서울');

WITH seoul AS (SELECT name, buseo, jikwi from tblinsa WHERE city = '서울')	--ORA-00928: missing SELECT keyword 셀렉트문(꼭 아녀도 됨) 없어서 오류뜸
SELECT * FROM seoul;	-- 하나의 SELECT 문 임.


SELECT * FROM (SELECT name, age, couple FROM tblmen WHERE weight < 90) a
	INNER JOIN (SELECT name, age, couple FROM tblwomen WHERE weight > 60) b
		ON a.couple = b.name;
		
WITH a AS (SELECT name, age, couple FROM tblmen WHERE weight < 90),
	b AS (SELECT name, age, couple FROM tblwomen WHERE weight > 60)
	
	SELECT * FROM a
		INNER JOIN b
			ON a.couple = b.name;

-- null 함수
-- null value
		
-- 1. nvL(컬럼, 값)
-- 2. nvL2(컬럼, 값, 값)

		
SELECT
	name,
	CASE
		WHEN population IS NOT NULL THEN population
		WHEN population IS NULL THEN 0
	END
FROM tblcountry;	
		

SELECT name, nvL(population, 0) FROM tblcountry;

CREATE TABLE tblitem
(
	seq NUMBER PRIMARY KEY,
	name varchar2(100) NOT NULL,
	color varchar2(50) NOT null
);

--ora 01400 cannot insert null into (hr,tblitem, seq)
INSERT INTO tblitem(seq,name,color)
		VALUES ((SELECT nvL(max(seq),0)+1 FROM tblitem),'마우스','white');
	
INSERT INTO tblitem(seq,name,color)
		VALUES (1,'마우스','white');	
	
SELECT * FROM tblitem;
	
DELETE FROM tblitem;	

SELECT
 name, nvL2(population, 'A', 'B')		--인구수 있음 a 없음 b
FROM tblcountry;
