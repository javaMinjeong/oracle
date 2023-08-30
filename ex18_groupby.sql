--ex18_groupby.sql

/*
  
    [WITH <Sub Query>] WITH 절 > 대괄호 생략 가능
    SELECT column_list 
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC|DESC]]
  
    select 컬럼리스트		4. 컬럼 지정(보고 싶은 컬럼만 가져오기) > projection
 	from 테이블			1. 테이블 지정
 	where 조건			2. 조건 지정(보고 싶은 행만 가져오기) > selection
 	group by 기준		3. (레코드끼리)그룹을 나눈다.
	order by 정렬 기준;	5. 순서대로
  
  
 */

-- tblinsa, 부서별 평균 급여?
SELECT * FROM tblinsa;

SELECT round(avg(basicpay)) FROM tblinsa; --155만원, 전체 60명

SELECT DISTINCT buseo FROM tblinsa; -- 7개

SELECT round(avg(basicpay)) FROM tblinsa WHERE buseo = '총무부'; --171만원
SELECT round(avg(basicpay)) FROM tblinsa WHERE buseo = '개발부'; --138만원
SELECT round(avg(basicpay)) FROM tblinsa WHERE buseo = '영업부'; --160만원
SELECT round(avg(basicpay)) FROM tblinsa WHERE buseo = '기획부'; --185만원
SELECT round(avg(basicpay)) FROM tblinsa WHERE buseo = '인사부'; --153만원
SELECT round(avg(basicpay)) FROM tblinsa WHERE buseo = '자재부'; --141만원
SELECT round(avg(basicpay)) FROM tblinsa WHERE buseo = '홍보부'; --145만원

--SELECT
--	*
--FROM tblinsa
--	GROUP BY 그룹짓기위한 기준컬럼;

--*** group by 목적 > 그룹별 통계값을 구하기 위해서!!! > 집계 함수 사용

SELECT
	count(*) AS "부서별 인원수",
	round(avg(basicpay)) AS "부서별 평균 급여",
	sum(basicpay) AS "부서별 지급액",
	max(basicpay) AS "부서내의 최고 급여",
	min(basicpay) AS "부서내의 최저 급여",
	buseo
FROM tblinsa
	GROUP BY buseo;

SELECT
	count(decode(gender, 'm', 1)) AS "남자수",
	count(decode(gender, 'f', 1)) AS "여자수"
FROM tblcomedian;

SELECT
	count(*), gender
FROM tblcomedian
	GROUP BY gender;


SELECT
	jikwi,
	count(*)
FROM tblinsa
	GROUP BY jikwi;
	
SELECT
	gender,
	max(height),
	min(height),
	max(weight),
	avg(weight),
	avg(height)
FROM tblcomedian
	GROUP BY gender;
	
--ORA-00979: not a GROUP BY expression
--group by 사용시 > select 컬럼리스트 > 일반 컬럼 명시 불가능
SELECT
	count(*), buseo --그룹에서 쓰인 공통값// 직계함수, group by 함수만 올 수 있음 -- name은 count 하고 성질이 달라서 사용 불가
FROM tblinsa
	GROUP BY buseo;

-- 다중 그룹
