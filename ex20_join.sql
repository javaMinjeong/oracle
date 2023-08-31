-- ex20_join.sql

/*
  
 	관계형 데이터베이스 시스템이 지양하는 것들
 	- 테이블 다시 수정해야 고쳐지는 것들 > 구조적인 문제!!
 	
 	1. 테이블에 기본키가 없는 상태 > 데이터 조작 곤란
 	2. null이 많은 상태의 테이블 > 공간 낭비
  	3. 데이터가 중복되는 상태 > 공간 낭비 + 데이터 조작 곤란
  	4. 하나의 속성 값이 원자 값이 아닌 상태 > 더 이상 쪼개지지 않는 값을 넣어야 한다.
  
  
 */

--1. 테이블에 기본키가 없는 상태 > 데이터 조작 곤란
CREATE TABLE tblTest
(
	name varchar2(30) NOT NULL,
	age number(3) NOT NULL,
	nick varchar2(30) NOT null
);

-- 홍길동, 20, 강아지
-- 아무개, 22, 바보
-- 테스트, 20, 반장
-- 홍길동, 20, 강아지 > 발생(X), 조작(?)

-- 홍길동 별명 수정
UPDATE TABLE SET nick = '고양이' WHERE name = ''; --식별 불가능

-- 홍길동 탈퇴
DELETE FROM tblTest WHERE name = '홍길동';	--식별 불가능
DELETE FROM tblTest;

--2. null이 많은 상태의 테이블 > 공간 낭비
CREATE TABLE tblTest
(
	name varchar2(30) PRIMARY KEY,
	age number(3) NOT NULL,
	nick varchar2(30) NOT NULL,
	hobby1 varchar2(100) NULL,
	hobby2 varchar2(100) NULL,
	hobby3 varchar2(100) NULL,
	..
	hobby8 varchar2(100) NULL
);

--홍길동, 20, 강아지, null, null, null, null, null, null, null, null
-- 아무개, 22, 고양이, 게임, null, null, null, null, null, null, null
-- 이순신, 24, 거북이, 수영, 활쏘기, null, null, null, null, null, null
-- 테스트 25, 닭, 수영, 독서, 낮잠, 여행, 맛집, 공부, 코딩, 영화
