-- rownum + group by


-- 1. tblInsa. 남자 급여(기본급+수당)을 (내림차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
SELECT a.*, rownum FROM(SELECT
				name, buseo, jikwi, (basicpay+sudang)
				FROM tblinsa
					WHERE ssn LIKE '%-1%'
							ORDER BY (basicpay+Sudang) DESC) a;

-- 2. tblInsa. 여자 급여(기본급+수당)을 (오름차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
SELECT a.*, rownum FROM(SELECT
				name, buseo, jikwi, (basicpay+sudang)
				FROM tblinsa
					WHERE ssn LIKE '%-2%'
							ORDER BY (basicpay+Sudang) asc) a;						
						


-- 3. tblInsa. 여자 인원수가 (가장 많은 부서 및 인원수) 가져오시오.

SELECT * from(SELECT
				buseo, count(*)
				FROM tblinsa
					WHERE substr(ssn, 8, 1) = '2'
						GROUP BY buseo
							ORDER BY count(*) DESC) 
								WHERE rownum = 1;						

SELECT * FROM tblinsa;


-- 4. tblInsa. 지역별 인원수 (내림차순)순위를 가져오시오.(city, 인원수)

SELECT a.*, rownum from(SELECT
				city, count(*)
				FROM tblinsa
					GROUP BY city
						ORDER BY count(*) DESC)a;


-- 5. tblInsa. 부서별 인원수가 가장 많은 부서 및원수 출력.
SELECT * from(
		SELECT a.*, rownum AS rnum from(SELECT 
	buseo,count(*)
	FROM tblinsa
		GROUP BY buseo
			ORDER BY count(*) desc)a)
				WHERE rnum = 1;
			
select * from (select buseo, count(*) from tblinsa
	group by buseo order by count(*) desc) where rownum = 1;	

-- 6. tblInsa. 남자 급여(기본급+수당)을 (내림차순) 3~5등까지 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)

SELECT * from(SELECT a.*, rownum AS rnum FROM(SELECT
				name, buseo, jikwi, (basicpay+sudang)
				FROM tblinsa
					WHERE substr(ssn, 8, 1) = '1'
							ORDER BY (basicpay+Sudang) DESC) a)
								WHERE rnum between 3 and 5;
							

-- 7. tblInsa. 입사일이 빠른 순서로 5순위까지만 가져오시오.
							
SELECT a.*, rownum from(SELECT
					name, ibsadate
				FROM tblinsa
					GROUP BY name, ibsadate
						ORDER BY ibsadate ASC) a
							WHERE rownum <=5;

							

-- 8. tblhousekeeping. 지출 내역(가격 * 수량) 중 가장 많은 금액을 지출한 내역 3가지를 가져오시오.

SELECT * FROM tblhousekeeping;						
						

-- 9. tblinsa. 평균 급여 2위인 부서에 속한 직원들을 가져오시오.// select 안 select,, rownum 값 고정하고 rnum = 2로 빼내기...
SELECT * from(SELECT a.*, rownum AS rnum
				from(
					SELECT
						buseo, round(avg(basicpay))
					FROM tblinsa
						GROUP BY buseo
							ORDER BY round(avg(basicpay)) DESC) a)
								WHERE rnum = 2; 
	

-- 10. tbltodo. 등록 후 가장 빠르게 완료한 할일을 순서대로 5개 가져오시오.
SELECT
*
FROM tbltodo
	WHERE completedate IS NOT NULL
		ORDER BY completedate desc;

-- 11. tblinsa. 남자 직원 중에서 급여를 3번째로 많이 받는 직원과 9번째로 많이 받는 직원의 급여 차액은 얼마인가?










