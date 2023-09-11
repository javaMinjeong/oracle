--plsql 3

/*

    저장 프로시저
    1. 저장 프로시저
    2. 저장 함수
    
    저장 함수, Stored Function > 함수(Function)
    - 저장 프로시저와 동일
    - 반환 값이 반드시 존재 > out 파라미타를 말하는게 아니라 > return 문을 사용한다.
    - out 파라미터를 사용 금지 > 대신 return 문을 사용
    - in 파라미터는 사용한다.
    - 이런 특성때문에 호출하는 구문이 조금 다르다.(**)
    
    
    
*/

-- num1 + num2 > 합
    
-- 프로시저
create or replace procedure procSum(
    num1 in number,
    num2 in number,
    presult out number    
)
is
begin
    presult := num1+num2;
end procSum;


-- 함수
create or replace function fnSum(
    num1 in number,
    num2 in number
    --presult out number -- out을 사용하면 함수의 고유 특성이 사라진다. 프로시져와 동일해져서 사용하면 안됨.//out쓸꺼면 프로시져 써라
) return number            --괄호 끝에다가 리턴타입 적어야 컴파일 됨.
is
begin
    --presult := num1 + num2;
    return num1  + num2;
    
end fnSum;




--
declare
    vresult number;
begin
    procSum(10,20,vresult);
    dbms_output.put_line(vresult);
    
    vresult := fnSum(10,20);
    dbms_output.put_line(vresult);
    
end;   
/

-- 프로시저 : PL/SQL 전용 > 업무 절차 모듈화
-- 함수: ANSI-SQL 보조
select 
    name, basicpay, sudang, 
   -- procSum(basicpay, sudang, 변수)
   fnSum(basicpay, sudang)
from tblinsa;


--이름, 부서, 직위, 성별(남자/여자)

SELECT 
    name, buseo, jikwi,
    case
        when substr(ssn,8,1) = '1' then '남자'
        when substr(ssn,8,1) = '2' then '여자'
    end as gender,
    fnGender(ssn) as gender2
from tblInsa;

create or replace function fnGender(
    pssn varchar2
) return varchar2
is
begin
    return case
                when substr(pssn,8,1) = '1' then '남자'
                when substr(pssn,8,1) = '2' then '여자'
            end;
end fnGender;


/*
    
    프로시져
    1. 프로시져
    2. 함수
    3. 트리거
    
    
    트리거, Trigger
    - 프로시저의 한 종류
    - 개발자의 호출이 아닌, 미리 지정한 특정 사건이 발생하면 시스템이 자동으로 실행하는 프로시저
    - 예약(사건) > 사건 발생 > 프로시저 호출 
    - 특정 테이블 지정 > 지정 테이블 오라클 감시 > 
        > insert or update or delete > 미리 준비해 놓은 프로시저 호출
    
    트리거 구문
    create or replace trigger 트리거명
        before| after
        insert|update|delete
        on 테이블명
        [for each row];
    declare
        선언부;
    begin
        구현부;
    exception
        예외처리부;
    end;
*/


--tblinsa > 직원 삭제
create or replace trigger trgInsa
    before          -- 삭제가 발생하기 직전에 아래의 구현부를 먼저 실행해라!!
    delete          -- 삭제가 발생하는지 감시
    on tblInsa      --tblinsa 테이블에서(감시)
begin
    dbms_output.put_line(to_char(sysdate, 'hh:mi:ss')|| '트리거가 실행되었습니다.');
    
    --월요일에1-299999는 퇴사가 불가능
    if to_Char(sysdate, 'dy') = '월' then
    
    --강제로 에러 발생
    --throw new Exception
    -- -200000
    raise_application_error(-20001, '월요일에는 퇴사가 불가능합니다.');   
         
    end if;        
end trgInsa;

select * from tblinsa;

delete from tblinsa where num = 1010;

select * from tblBonus;

delete from tblBonus;

rollback;

INSERT INTO tblinsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1010, '김종서', '751010-1122233', '1997-08-08', '부산', '011-3214-5555', '영업부',
   '부장', 2540000, 130000);

commit;


select * from tblDiary;

--로그 기록
create table tblLogDiary(
    seq number primary key,
    message varchar2(1000) not null,
    regdate date default sysdate not null
);

create sequence seqLogDiary;

create or replace trigger trgDiary
    after 
    insert or update or delete
    on tblDiary
declare
    vmessage varchar2(1000);
begin

    --dbms_output.put_line(to_char(sysdate, 'hh:mi:ss')|| '트리거가 실행되었습니다.');
    
    if inserting then
       --dbms_output.put_line('추가'); 
       vmessage := '새로운 항목이 추가되었습니다.';
    elsif updating then
       -- dbms_output.put_line('수정'); 
       vmessage := '기존 항목이 수정되었습니다.';
    elsif deleting then
       --dbms_output.put_line('삭제'); 
       vmessage := '기존 항목이 삭제되었습니다.';
    end if;
    
    insert into tblLogDiary values (seqLogDiary.nextVal, vmessage, default);
end trgDiary;   --오류 찾기

insert into tblDiary values (11, '프로시저를 공부했다.', '흐림', sysdate);

update tblDiary set subject = '프로시저를 복습했다' where seq = 11;

delete from tblDiary where seq = 11;

select * from tblLogDiary;

/*

    [for each row]
    1. 생략
        - 문장(Query) 단위 트리거 Table level trigger
        - 사건에 적용된 행의 갯수 무관 > 트리거 딱 1회 호출
        - 적용된 레코드의 정보는 중요하지 않은 경우 + 사건 자체가 중요한 경우
    2. 사용
        - 행(Record) 단위 트리거
        - 사건에 적용된 행의 개수만큼 > 트리거가 호출
        - 적용된 레코드의 정보가 중요한 경우 + 사건 자체보다...
        - 상관 관계를 사용한다. > 일종의 가상 레코드 > old, new
        
     insert
     - :new > 방금 추가한 행
     
     delete
     - :old > 수정되기 전 행
     - :new > 수정된  후 행
     
     delete
     - :old > 삭제되기 전 행
        

*/

select * from tblMen;

create or replace trigger trgMen
    
    after
    delete
    on tblmen
    --for each row                --적용된 행에 반응 반응한 트리거 다 찍힘

begin 
    dbms_output.put_line('레코드를 삭제했습니다.'|| :old.name);       --ORA-04082: NEW or OLD references not allowed in table level triggers 문장단위트리거
end trgMen;

select * from tblmen;

delete from tblMen where name = '홍길동';  --1회 삭제; 트리거 1회 실행

delete from tblMen where age < 25;      -- 3명 삭제 > 트리거 1회 실행

rollback;

INSERT INTO tblmen VALUES ('홍길동', 25, 180, 70, '장도연');
INSERT INTO tblmen VALUES ('아무개', 22, 175, NULL, '이세영');
INSERT INTO tblmen VALUES ('하하하', 27, NULL, 80, NULL);
INSERT INTO tblmen VALUES ('무명씨', 21, 177, 72, NULL);
INSERT INTO tblmen VALUES ('정형돈', 28, NULL, 92, NULL);
INSERT INTO tblmen VALUES ('양세형', 22, 166, 55, '김민경');
INSERT INTO tblmen VALUES ('조세호', 24, 165, 58, '오나미');

create or replace trigger tblMen
    after
    update
    on tblmen
    for each row

begin
    dbms_output.put_line('레코드를 수정했습니다.' || :old.name); 
    dbms_output.put_line('수정하기 전 나이: ' || :old.age);
    dbms_output.put_line('수정한 후 나이: '|| :new.age); 
end trgMen;

update tblmen set age = age + 1 where name = '홍길동';

update tblmen set age = age + 1;

--회사 > 프로젝트 위임
select * from tblStaff;

select * From tblProject;

-- 직원을 퇴사 > 퇴사 바로 직전 > 담당 프로젝트 체크 > 위임

create or replace trigger trgDeleteStaff
    before              --1. 전에
    delete              --2. 회사    
    on tblStaff         --3. 직원테이블에서
    for each row        --4. 해당 직원 정보
    
begin
    --5. 위임 진행
    update tblProject set
        staff_Seq = 3
         where staff_Seq = :old.seq; --퇴사하는 직원 번호
    
end trgDeleteStaff;


select * from tblStaff;

select * From tblProject;

delete from tblStaff where seq = 2;

-- - 회원 테이블, 게시판 테이블
-- - 포인트 제도 
--  1. 글 작성 > 포인트 + 100
--  2. 글 삭제 > 포인트 - 50
drop table tblUser;
drop table tblBoard;

create table tblUser(
    id varchar2(30) primary key,
    point number default 1000 not null
);

create table tblBoard(
    seq number primary key,
    subject varchar2(1000) not null,
    id varchar2(30) not null references tblUser(id)
);

create sequence seqBoard;

insert into tblUser values ('hong', default);

select * from tblUser;

--1. 글을 쓴다. (삭제한다.)
--2. 포인트를 누적(차감)한다.

--case1. hard
--개발자 직접 제어
-- 실수 > 일부 업무 누락;

--1.1 글쓰기
insert into tblBoard values (seqBoard.nextVal, '게시판입니다.', 'hong');

--1.2 포인트 누적하기
update tblUser set point = point + 100 where id = 'hong';

--1.3 글 삭제
delete from tblBoard where seq = 1;

--1.4 포인트 차감하기
update tblUser set point = point -50 where id = 'hong';

select * From tblUser;

--case 1. 프로시저
create or replace procedure procAddBoard(
    pid varchar2,
    psubject varchar2
)
is 

begin

--글쓰기
insert into tblBoard values (seqBoard.nextVal, psubject, pid);
--1.2 포인트 누적하기
update tblUser set point = point + 100 where id = pid;

end procAddBoard;

--case 1. 삭제 프로시저
create or replace procedure procDeleteBoard(
  pseq number
)
is 
    vid varchar2(30);
begin
    
    --2.1 삭제글의 작성자
    select id into vid from tblBoard where seq = pseq;
    --2.2 글 삭제
    delete from tblBoard where seq = pseq;
    --2.3 포인트 차감하기
    update tblUser set point = point -50 where id = vid;

end procDeleteBoard;

begin
    procedure ('hong','글을 작성합니다.');
    procDeleteBoard(2);     -- 몇번인지 확인하고 숫자 기재
end;

select * from tblUser; --1150


-- case 3. 트리거
create or replace trigger trgBoard
    after
    insert or delete
    on tblBoard
    for each row
    
begin
   if inserting then
    update tblUser set point = point + 100 where id = :new.id;
   elsif deleting then
    update tblUser set point = point -50 where id = :old.id;    
   end if;

end trgBoard;

insert into tblBoard values (seqBoard.nextVal, '또 다시 글을 씁니다', 'hong');


delete from tblBoard where seq = 5;

select * from tblUser;
