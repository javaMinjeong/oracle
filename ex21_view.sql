--ex21_view.sql

/*
  
 	view, 뷰 (만드는 파일이자 수정하는 파일)
 	- 데이터베이스 객체 중 하나(테이블, 제약사항, 뷰, 시퀀스)
 	- 가상 테이블, 뷰 테이블 등..
 	- 테이블처럼 사용한다.(***)
 	- 쿼리의 양을 줄인다.
 	
 	
 	 create [or replace] view 뷰이름 
 	 as 
 	 select 문;
 	 
 
 */

CREATE OR REPLACE VIEW vwInsa
AS 
SELECT * FROM tblinsa;


SELECT * FROM vwinsa;	--tblinsa 테이블의 복사본

-- '영업부' 직원

CREATE OR REPLACE VIEW 영업부
AS 
SELECT
	num, name, city, basicpay, substr(ssn, 8) AS ssn
FROM tblinsa
	WHERE buseo = '영업부';

SELECT * FROM 영업부;

-- 비디오 대여점 사장 > 날마다 > 업무		
CREATE OR REPLACE VIEW vwCheck
as
SELECT
	m.name AS 회원,
	v.name AS 비디오,
	r.rentdate AS 언제,
	r.retdate AS 반납,
	r.rentdate + g.period AS 반납예정일,
	sysdate - (r.rentdate + g.period) AS 연체일,
	(sysdate - (r.rentdate + g.period)) * g.price * 0.1 AS 연체료
FROM tblrent r
	INNER JOIN tblvideo v
		ON r.video = v.seq
			INNER JOIN tblmember m	
				ON m.seq = r.MEMBER
					INNER JOIN tblgenre g
						ON g.seq = v.genre;

SELECT * FROM tblgenre;

SELECT * FROM vwcheck;			

