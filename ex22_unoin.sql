--ex22_unoin.sql

/*

	  관계 대수 연산
	  1. 셀렉션 > select where
	  2. 프로젝션 > select column 
	  3. 조인
	  4. 합집합(union), 차집합(minus), 교집합(intersect)
	
	  유니온, union
	  - 스키마가 동일한 결과셋끼리 가능
	  
	      
 */


SELECT * FROM tblmen
UNION --더하기
SELECT * FROM tblwomen;

SELECT name, address, salary FROM tblstaff	--컬럼 이름은 안중요함, 쟈료형 구조가 중요함.
union
SELECT name, city, basicpay FROM tblinsa;	--형식, 구조 스키마 결과셋 자체가 달라서 안됨 //63명

-- 어떤 회사 > 부서별 게시판
SELECT * FROM 영업부게시판;
SELECT * FROM 총무부게시판;
SELECT * FROM 개발부게시판;

--회장님 > 모든 부서의 게시판 글 > 한번에 열람

SELECT * FROM 영업부게시판
UNION 
SELECT * FROM 총무부게시판
UNION 
SELECT * FROM 개발부게시판;

-- 야구 선수 > 공격수, 수비수
SELECT * FROM 공격수;
SELECT * FROM 수비수;

SELECT * FROM 공격수;
UNION
SELECT * FROM 수비수;

-- SNS > 하나의 테이블+ 다량의 데이터 > 기간별 테이블 분할

SELECT * FROM 게시판2020
union
SELECT * FROM 게시판2021
union
SELECT * FROM 게시판2022
union
SELECT * FROM 게시판2023;

--
CREATE TABLE tblAAA(
	name varchar2(30) NOT null
);

CREATE TABLE tblBBB(
	name varchar2(30) NOT null
);

INSERT INTO tblAAA values('강아지');
INSERT INTO tblAAA values('고양이');
INSERT INTO tblAAA values('토끼');
INSERT INTO tblAAA values('거북이');
INSERT INTO tblAAA values('병아리');

INSERT INTO tblBBB values('강아지');
INSERT INTO tblBBB values('고양이');
INSERT INTO tblBBB values('호랑이');
INSERT INTO tblBBB values('사자');
INSERT INTO tblBBB values('코끼리');

--union > 수학의 집합 > 중복 제거
SELECT * FROM tblaaa
UNION 
SELECT * FROM tblbbb;

--union all > 중복값 허용
SELECT * FROM tblaaa
UNION ALL
SELECT * FROM tblbbb;

--intersect > 교집합
SELECT * FROM tblaaa
INTERSECT
SELECT * FROM tblbbb;

--minus > 차집합(A-B)//(B-A)
SELECT * FROM tblaaa
MINUS
SELECT * FROM tblbbb;

SELECT * FROM tblbbb
MINUS
SELECT * FROM tblaaa;

