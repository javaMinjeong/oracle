--ex09_numerical_function.sql

/*
  
 	숫자 함수(=수학 함수) 
  	-Math.xxxx()
  	
  
	round()
	- 반올림 함수  
  	- number round(컬럼명) : 정수 반환
  	- number round(컬럼명, 소수이하 자릿수) : 실수 반환
  
  
 */


SELECT * FROM dual;	-- 시스템 테이블 > 1행 테이블(***)


--현재 시간 필요
SELECT sysdate FROM tblinsa WHERE num = 1001;

SELECT sysdate FROM dual;

SELECT 1+1 FROM tblcomedian;
SELECT 1 + 1 FROM dual;

SELECT
	3.5678,
	round(3.5678),
	round(3.5678, 1),	--소수 이하 첫째자리 반올림
	round(3.5678, 2),	--소수 이하 첫째자리 반올림
	round(3.5678, 3)	--소수 이하 첫째자리 반올림
FROM dual;	


--평균 급여

SELECT round(avg(basicpay)) FROM tblinsa;	--1556527


/*
  
 	floor(), trunc() 
  	- 절삭 함수
  	- 무조건 내림 함수
  	- number floor (컬럼명) : 무조건 정수 반환
  	- number trunc (컬럼명) : 정수 반환
  	- number trunc (컬럼명, 소수이하 자릿수): 실수 변환
 */

SELECT
	3.5678,
	floor(3.5678),
	trunc(3.5678),
	trunc(3.5678, 1),	--소수 이하 첫째자리 반올림
	trunc(3.5678, 2),	--소수 이하 첫째자리 반올림
	trunc(3.5678, 0)	--소수 이하 첫째자리 반올림
FROM dual;	


/*
  
 	ceil()
 	- 무조건 올림 함수 
 	- 천장
  	- number ceil(컬럼명)
  	
  
 */

SELECT
	3.14,
	ceil(3.14)
FROM dual;	

-- round(), floor(), ceil()

/*
  
 	mod() 
 	- 나머지 함수
 	- number mod(피제수, 제수)
 	
  
 */

SELECT 
	10/3,
	mod(10,3) AS 나머지,	-- 정수 % 정수
	floor(10/3) AS 몫	-- 정수 / 저ㅏㅇ수
fROM dual;

SELECT
	abs(10), abs(-10),	-- 절대값
	power(2,2), power(2,3),power(2,4),	-- 2의 2승..
	sqrt(4),sqrt(9), sqrt(16) --제곱근
FROM dual;