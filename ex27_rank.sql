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
	 	rank() OVER(ORDER BY basicpay desc) 
FROM tblinsa;