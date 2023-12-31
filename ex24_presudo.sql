--ex24_presudo.sql

/*
  
 	의사 컬럼, Presudo Column 
  	- 실제 컬럼이 아닌데 컬럼처럼 행동하는 객체
  	
  	rownum
  	- 오라클 전용
  	- 행번호
  	- 시퀀스 객체 생관X
  	- 현재 테이블을 행번호를 가져오는 역할
  	- 테이블에 저장된 값이 아니라, select 실행 시 동적으로 계산 되어 만들어지다.(*****)
  	- from절이 실행될 떄 각 레코드에 rownum을 할당한다.(*********************)
  	- where절이 실행될 때 상황에 따라 rownum이 재계산된다.(***********) > from절에서 만들어진 rownum은 where절이 실행될때 변경될 수 있다.
 */

SELECT
	name, buseo, 	 -- 컬럼(속성) > OUTPUT > 객체(레코드)의 특성에 따라 다른 값을 가진다.
	100,			 -- 상수 > OUTPUT > 모든 레코드가 동일한 값을 가진다.
	substr(name, 2), -- 함수 > INPUT + OUTPUT > 객체의 특성에 따라 다른 값을 가진다.
	rownum			 -- 의사 컬럼 > OUTPUT // 데이터 일련번호 붙여주는 애 //시퀀스 = 연결되는 번호 생성
FROM tblinsa;

-- 게시판 > 페이지
-- 1페이지 > rownum between 1 and 20 
-- 2페이지 > rownum between 21 and 40
-- 3페이지 > rownum between 41 and 60

SELECT name, buseo, rownum FROM tblinsa WHERE rownum = 1;
SELECT name, buseo, rownum FROM tblinsa WHERE rownum <= 5;

SELECT name, buseo, rownum FROM tblinsa WHERE rownum > 5 AND rownum <= 10;	-- 값이 안나옴..

SELECT name, buseo, rownum	--2. 소비 > 1에서 만든 rownum을 가져온다. (여기서 생성X)
FROM tblinsa;				--1. 생성 > from절이 실행되는 순간 모든 레코드 rownum이 할당됨

SELECT name, buseo, rownum	--3. 소비
FROM tblinsa				--1. 생성 60개 가져오는 순간 1번부터 rownum 할당
WHERE rownum = 1;			--2. 조건 내부적으로 for문 돈다고 생각!! 루프는 계쏙 돌음 rownum 1이 또 있을 수 있어서

SELECT name, buseo, rownum	--3. 소비
FROM tblinsa				--1. 생성 
WHERE rownum = 3;	--안뚬	--2. 조건 너 1번이니? 노우 1번 탈락 (select문에서는 없는 애랑 똑같음 결과셋 포함 X) -> 첫번째 탈락 시키고 2번이 1번됨 계속 계속 값이 바뀜 남는놈 없음// 자바Arraylist 인덱스 값 처럼


SELECT name, buseo, rownum	--3. 소비
FROM tblinsa				--1. 생성 
WHERE rownum < = 3;			--2. 1이 포함되어 있어서 1,2,3이 반환됨.

SELECT name, buseo, basicpay, rownum	
FROM tblinsa							-- from절이 실행될 떄 각 레코드에 rownum을 할당한다. 
ORDER BY basicpay DESC;					-- 그래서 순서가 뒤죽박죽 나옴

--**내가 원하는 순서대로 정렬 후 > rownum을 할당하는 방법 > 서브쿼리 사용(***)
SELECT name, buseo, basicpay, rownum, rnum				-- 안쪽 로우넘을 가지고 가고 싶으면 무조건 별칭 붙여서 표현!!
from( SELECT name, buseo, basicpay, rownum AS rnum		-- 메인 쿼리: 바깥쪽에서 만든 2차 rownum// 오버라이딩 됨
      FROM tblinsa										-- 서브쿼리: 위에 rownum하고 다른 rownum임 1차 rownum하고
	  ORDER BY basicpay DESC) WHERE rownum <= 3	;

-- 급여 5~10등까지
-- 원하는 범위 추출(1이 포함X) > rownum 사용 뷸가능
	 --1. 내가 원하는 순서대로 정렬
	 --2. 1을 서브쿼리로 묶는다. + rownum(rnum)
	 --3. 2를 서브쿼리로 묶는다. + rownum(불필요 + rnum 사용(***))	
SELECT name, buseo, basicpay, rnum, rownum
	from( SELECT name, buseo, basicpay, rownum AS rnum			--2
					from( SELECT name, buseo, basicpay
					      FROM tblinsa										
						  ORDER BY basicpay DESC)) 				--1	
						 	WHERE rnum BETWEEN 5 AND 10;		-- rnum으로 하면 가능// 안쪽에서 이미 픽스된 값이라 where절에 영향을 받지 않음.

--페이징 > 나눠서 보기 > 한번에 20명씩 보기 + 이름순으로
SELECT * FROM tbladdressbook; --2,000

--1. 
SELECT * FROM tbladdressbook ORDER BY name ASC;


--2. 이 때의 rownum이 필요하다.
SELECT a.*,rownum FROM(SELECT *From tbladdressbook ORDER BY name ASC) a ;	--*와 특정 다른 단일, 상수 컬럼을 한 번에 못적음// 붙이려면 테이블 이름과 함께

--3. rownum을 조건 사용 > 한번 더 서브쿼리
SELECT* FROM(SELECT a.*,rownum FROM(SELECT *From tbladdressbook ORDER BY name ASC) a);

SELECT* FROM(SELECT a.*,rownum AS rnum FROM(SELECT *From tbladdressbook ORDER BY name ASC) a) where rnum BETWEEN 1 AND 20;


SELECT* FROM(SELECT a.*,rownum AS rnum FROM(SELECT *From tbladdressbook ORDER BY name ASC) a) where rnum BETWEEN 21 AND 40;

SELECT* FROM(SELECT a.*,rownum AS rnum FROM(SELECT *From tbladdressbook ORDER BY name ASC) a) where rnum BETWEEN 1981 AND 2000;


SELECT* FROM(SELECT a.*,rownum FROM(SELECT *From tbladdressbook ORDER BY name ASC) a);	--가장 바깥쪽에 있는 서브쿼리를 VIEW로 만들어서 사용해도 됨

CREATE OR REPLACE VIEW viewaddressBook
AS
SELECT a.*,rownum AS rnum FROM(SELECT *From tbladdressbook ORDER BY name ASC) a;		--AS 안붙이면 오류뜸!!

SELECT* FROM viewaddressBook;

SELECT* FROM viewaddressBook where rnum BETWEEN 1 AND 20; --아래문장하고 동일

SELECT* FROM(SELECT a.*,rownum AS rnum FROM(SELECT *From tbladdressbook ORDER BY name ASC) a) where rnum BETWEEN 1 AND 20; --이렇게 쓰는 경우가 더 많긴 함. 뷰 만드는게 더 구찮음..

