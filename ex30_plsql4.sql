/*

함수 return
1. 단일값 O
2. 다중값x > cursor


프로시저 out parameter
1. 단일 값 (단일 레코드)
    a. number
    b. varchar2
    c. date
2. 다중값 (다중 레코드)
a. cursor

*/

create or replace procedure procBuseo(
    pbuseo varchar2
)
is
    cursor vcursor
    is
    select * From tblinsa where buseo = pbuseo;
    
    vrow tblinsa%rowtype;
    
begin

    open vcursor;
    loop
        fetch vcursor into vrow;        --select into
        exit when vcursor%notfound;
        
        --업무
        dbms_output.put_line(vrow.name || ',' || vrow.buseo);   
        
    end loop;
    close vcursor;
    
end procBuseo;

begin
    procBuseo('영업부');
end;

create or replace procedure procBuseo(

    pbuseo in varchar2, 
    pcursor out sys_refcursor       --커서의 자료화
)
is
    --cursor vcursor is select --반환값일땐 사용 안함
begin
    open pcursor
    for 
    select * from tblinsa where buseo = pbuseo;
end procBuseo;

declare
    vcursor sys_refcursor;  --커서 참조 변수
    vrow tblinsa%rowtype;
begin

    procBuseo('영업부',vcursor);

    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        --업무
        dbms_output.put_line(vrow.name); 
    end loop;

end;

--프로시저 총정리 > CRUD

--1. 추가 작업(C)
create or replace procedure 추가작업(
    추가할 데이터 -> in 매개변수,
    추가할 데이터 -> in 매개변수,
    추가할 데이터 -> in 매개변수, --원하는 만큼
    성공 유무 반환 -> out 매개변수 -- 피드백(1.0)
)

is
    내부 변수 선언
begin
    작업(insert +(select, update, delete))
exception
    when others then
        예외처리
end;

select * from tblTodo;
--할 일 추가하기(C)
create or replace procedure procAddTodo(
    ptitle varchar2,
    presult out number --1or0

)
is
begin
    insert into tblTodo(seq, title, adddate, completedate)
    values (seqTodo.nextVal, ptitle, sysdate, null);
    
    presult := 1; --성공
exception
    when others then
        presult :=0;    --실패
end procAddTodo;

select * From tblTodo;

create sequence seqTodo start with 22;

declare 
    vresult number;
begin
    procAddTodo('새로운 할 일입니다.', vresult);
    dbms_output.put_line(vresult);
end;    

--2. 수정작업(U)
create or replace procedure 수정작업(
    수정할 데이터 -> in 매개변수,
    수정할 데이터 -> in 매개변수,
    수정할 데이터 -> in 매개변수,   -- 원하는 개수
    식별자       -> in 매개변수,   -- where절에 사용 할 PK or 데이터
    

)
is
    내부 변수 선언
begin
    작업(update + (insert, update, delete, select..))
exception
    when others then
        예외처리
end;

-- 할 일 수정하기(U) > completedate > 채우기 > 할일 완료 처리하기
create or replace procedure procCompleteTodo(
    --pcompletedate data > 수정할 날짜 > 지금 > sysdate 처리
    pseq in number, --수정할 할 일 번호
    presult out number
)
is
begin
    update tblTodo set
        completedate = sysdate
            where seq = pseq;
    presult := 1;        
exception
    when others then
    presult := 0; 
end procCompleteTodo;

declare
    vresult number;
begin
    procCompleteTodo(22, vresult);  
    dbms_output.put_line(vresult); 
end;

select * from tblTodo;

--3. 삭제 작업(D)
create or replace procedure 삭제작업(
    식별자     -> in 매개변수,
    성공 유무 반환 -> out 매개변수

)
is
    내부 변수 선언
begin
    작업(delete + (insert, update, delete, select))
exception
    when others then
        예외처리
end;        

--할 일 삭제하기
create or replace procedure procDeleteTodo(
    pseq in number,
    presult out number
)

is
begin
    delete from tblTodo where seq = pseq;
    presult := 1;
exception
    when others then
        presult := 0;
end procdeleteTodo;

declare
    vresult number;
begin
    procDeleteTodo(22,vresult);
    dbms_output.put_line(vresult);
end;  

select * from tblTodo;

--4. 읽기 작업(R)
-- : 조건 유/무
-- : 반환 단일행/다중행, 단일컬럼/다중컬럼

-- 한일 몇개? 안한일 몇개? 총 몇개?
create or replace procedured 읽기작업(
    조건 데이터 -> int 매개변수,
    단일 반환값 -> out 매개변수,
    다중 반환값 -> out 매개변수(커서)
)
is
    내부 변수 선언
begin
    작업(select + (insert, update, delete, select))
exception
    when others then
        예외처리
end;

--한일 몇개? 안한일 몇개? 총 몇개?
create or replace procedure procCountTodo(
    pcount1 out number, --한일
    pcount2 out number, --안한일
    pcount3 out number  --모든일
)
is
begin
    select count(*) into pcount1 from tblTodo where completedate is not null;
    select count(*) into pcount2 from tblTodo where completedate is null;
    select count(*) into pcount3 from tblTodo;
exception
    when others then
        dbms_output.put_line('예외 처리'); 
end procCountTodo;

declare
    vcount1 number;
    vcount2 number;
    vcount3 number;
begin
    procCountTodo(vcount1,vcount2,vcount3);
    dbms_output.put_line(vcount1); 
    dbms_output.put_line(vcount2); 
    dbms_output.put_line(vcount3); 
 end;   
/ 
 
 
 create or replace procedure procCountTodo(
    psel in number,     --선택(1(한일),2(안한일),3(모든일))
    pcount out number   

)
is
begin
    if psel = 1 then
        select count(*) into pcount from tblTodo where completedate is not null;
    elsif psel = 2 then
        select count(*) into pcount from tblTodo where completedate is null;
    elsif psel = 3 then
        select count(*) into pcount from tblTodo;
    end if;    
exception
    when others then
        dbms_output.put_line('예외 처리'); 
end procCountTodo;

declare
    vcount number;
begin
    procCountTodo(3,vcount);
    dbms_output.put_line(vcount); 
end;

--번호 > 할일 1개 반환
create or replace procedure procGetTodo(
    pseq in number,
    prow out tblTodo%rowtype
)
is
begin
    select * into prow from tblTodo where seq = pseq;
exception
    when others then
        dbms_output.put_line('예외처리'); 
end;

declare
    vrow tblTodo%rowtype;
begin
    procGetTodo(1,vrow);
    dbms_output.put_line(vrow.title); 
end;

--다중 레코드 반환
--1. 한일 목록을 반환
--2. 안한일 목록 반환
--3. 모든일 목록 반환

create or replace procedure procListTodo(
    psel in number,
    pcursor out sys_refcursor
)
is
begin
    if psel = 1 then
        open pcursor
        for
        select * From tblTodo where completedate is not null;
    elsif psel = 2 then
        open pcursor
        for
        select * From tblTodo where completedate is null;
    elsif psel = 3 then
        open pcursor
        for
        select * From tblTodo;
    end if;
    
exception
    when others then
        dbms_output.put_line('예외처리');
end procListTodo;        

declare
    vcursor sys_refcursor;
    vrow tblTodo%rowtype;
begin
    procListTodo(1, vcursor);
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.title || ',' || vrow.completedate); 
    end loop;
    
end;