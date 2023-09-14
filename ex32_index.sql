--ex32_index.sql

/*
인덱스 , index
- 검색을 빠른 속도로 하기 위해 사용하는 도구
- SQL 명령 처리 속도를 빠르게 하기 위해서, 특정 칼럼에 대해 생성되는 도구
- 책 > 인덱스(찾아보기) > 검색 도구

데이터베이스
- 테이블내의 레코드 순서가 사용자 원하는 정렬 상태가 아니다. > DBMS가 자체적 정렬 보관
- 어떤 데이터 검색 > 처음 - 끝까지 차례대로 검색 > table full scan
- 특정 컬럼 선택 > 별도의 테이블에 복사 > 미리 정렬 > 인덱스
- 원본 테이블 <- 참조 -> 인덱스

인덱스 장단점
- 처리 속도를 향상 시킨다.
- 무분별한 인덱스 사용은 DB 성능을 저하시킨다.

자동으로 인덱스가 걸리는 컬럼
1. Primary key
2. Unique
-** 테이블에서 PK컬럼을 검색하는 속도 > 테이블에서 PK가 아닌 컬럼을 검색하는 속도


*/

create table tblIndex
as
select * from tbladdressbook;   --2000

select count(*) from tblindex;  --8,192,000

insert into tblIndex select * From tblIndex;

select * from tbladdressbook; -- seq(PK)
select * From tblindex      -- 제약사항(X), 없음(PK)

--시간 확인
set timing on;

--SQL실행
-- 1.ctrl + enter > 결과 . 테이블
--2. f5           > 결과 > 텍스트

-- 인덱스 없이 검색 > 결과시간 > 경과 시간: 00:00:01.322
select count(*) from tblindex where name = '최민기';

-- 인덱스 생성
create index idxName
    on tblIndex(name);

--인덱스 검색 > 경과시간 : 00:00:00.009    
select count(*) from tblindex where name = '최민기';   

/*

 인덱스 종류
 1. 고유 인덱스
 2. 비고유 인덱스
 
 3. 단일 인덱스
 4. 복합 인덱스
 
 5. 함수 기반 인덱스
 



*/

 -- 고유인덱스
 -- : 색인의 값이 중복이 불가능하다.
 -- : PK, UNIQUE
 
 create unique index inxName  on tblIndex(name);    -- 동명이인(X)
  create unique index inxContinent  on tblCountry(continent);
  
  --비고유 인덱스
  --: 색인의 값이 중복이 가능하다.
  --: 일반 컬럼
  
create index indexHonetown on tblIndex(hometown)

--단일 인덱스
--: 컬럼 1개월 대상으로 만든 인덱스

create index idxhometown on tblIndex(hometown);
drop index idxHometown;

select count(*) from tblIndex where hometown = '서울';    --경과 시간: 00:00:00.101

select count(*) from tblIndex where hometown = '서울' and job = '학생'; -- 경과 시간: 00:00:07.734 //둘중 하나만 인덱스면 많이 느려짐

-- 복합(결합) 인덱스
-- : 컬럼 N개를 대상으로 만든 인덱스

create index idxhometownJob on tblIndex(hometown, job);     --경과 시간: 00:00:08.835

select count(*) from tblIndex where hometown = '서울' and job = '학생'; --경과 시간: 00:00:00.021
select count(*) from tblIndex where job = '학생' and hometown = '서울'; --경과 시간: 00:00:00.020

select count(*) from tblIndex where hometown = '서울';
select count(*) from tblindex where job = '학생';

--함수기반 인덱스
-- 가공된 값을 사용하는 인덱스

select count(*) from tblIndex where substr(email, instr(email, '@')) = '@naver.com';    --경과 시간: 00:00:01.969

create index idxEmail on tblIndex(email);   --가공되기 전 인덱스// 위 인덱스 안걸림

drop index idxEmail;

create index idxEmail on tblIndex(substr(email, instr(email, '@')));    --인덱스 제약사항 통째로 걸어줘야함.// 경과 시간: 00:00:00.271