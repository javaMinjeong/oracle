-- ex03_select.sql


/*

    SQL, Query(질의)

    SELECT 문
     - DML, DQL
     - SQL은 SELECT로 시작해서 SELECT로 끝난다.
     
     - CRUD 
     
     전체가 한셋투
    [WITH <Sub Query>] WITH 절 > 대괄호 생략 가능
    SELECT column_list 
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expresstion [ASC|DESC]]
     
    SELECT column_list  -- 원하는 컬럼을 지정만 가져와라
    From table_name;    --데이터소스, 어떤 테이블로부터 데이터를 가져와라.
    
    각 질의 순사
    2. SELECT
    1. FROM
 

*/

--type이라는 테이블로부터 모든 컬럼을 가져와주세요
select * from tblType; 

--테이블 구조?? > 스키마(Scheme) > 명세서
desc employees;

select * from employees;

select first_name from employees;   --employees에서 first name만 가져와주세요

select * from tblAddressBook;
select * from tblComedian;
select * from tblCountry;
select * from tblDiary;
select * from tblHousekeeping;
select * from tblInsa;
select * from tblMen;
select * from tblWomen;
select * from tblSalary;
select * from tblTodo;
--select * from tblName;
drop table tblName;
select * from tblZoo;
select * from zipcode;

-- select 절
-- from 절 

-- select 컬럼리스트

--단일 컬럼
select * from tblComedian;
select nick from tblComedian;

select * from tblComedian;

select first, last, gender, height, weight, nick from tblComedian; --윗 문장과 동일한 문장

--다중 컬럼(컬럼명, 컬럼명, 컬럼명..)
select first, last from tblComedian;

-- 컬럼 순서 > 자유
select last, first from tblComedian;

-- 동일 컬럼 반복
select last, length(last) from tblComedian;





--다양한 스타일 코드 작성법
select last, first from tblComedian;

select last, first
from tblComedian;

select last, first
    from tblComedian;
    
--가독성 제일 높음
select
    last, first
from
    tblComedian;

--흔한 대표적 오류 
--ORA-00942: table or view does not exist 테이블명 오류
select
    last, first
from
    tblComedia;
    
-- ORA-00904: "FIRT": invalid identifier 컬럼이름이 틀렸을때
select
    last, firt
from
    tblComedian;
    