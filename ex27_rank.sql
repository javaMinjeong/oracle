--ex27_rank.sql

/*
 
	순위 함수
	- rownum > 기반으로 만들어진 함수
	
	 1. rank() over(order by 컬럼명 [asc|desc])
	 
	 2. dense_rank() over(order by 컬럼명 [asc|desc])
	 
	 3. row_number() over(order by 컬럼명 [asc|desc])
  
 */

--tblinsa 급여순으로 가져오시오 + 순위 표시
SELECT name, buseo, basicpay, rownum
	from(SELECT name, buseo, basicpay FROM tblinsa ORDER BY basicpay DESC);
	
SELECT
		name, buseo, basicpay,
	 	rank() OVER(ORDER BY basicpay desc) AS rnum		--1~60
FROM tblinsa;

SELECT
		name, buseo, basicpay,
	 	dense_rank() OVER(ORDER BY basicpay desc) AS rnum	--1~42
FROM tblinsa;


SELECT
		name, buseo, basicpay,
	 	row_number() OVER(ORDER BY basicpay desc) AS rnum	--1~60
FROM tblinsa;


--급여 5위? 
SELECT
		name, buseo, basicpay,
	 	row_number() OVER(ORDER BY basicpay desc) AS rnum	--1~60
FROM tblinsa
	WHERE row_number() OVER(ORDER BY basicpay desc) = 5 ;	--ORA-30483: window  functions are not allowed here
	

SELECT * From(SELECT
					name, buseo, basicpay,
				 	row_number() OVER(ORDER BY basicpay desc) AS rnum	--1~60
			  FROM tblinsa)
					WHERE rnum = 5;	

-- 순위 함수 + order by
-- 순위 함수 + partition by + order by	 > 순위 함수 + group by > 그룹별 순위 구하기	

SELECT
	name, buseo, basicpay,
	rank() OVER(PARTITION BY buseo ORDER BY basicpay desc) AS rum
FROM tblinsa;	


SELECT * from
			(SELECT
				name, buseo, basicpay,
				rank() OVER(PARTITION BY buseo ORDER BY basicpay desc) AS rnum	--그룹별 1등을 가져와라
			FROM tblinsa)
				WHERE rnum = 1;
				