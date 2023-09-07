--ex.29_plsql.sql

/*

    PL/SQL
    - Oracle > Procedural language extension to SQL
    - 기존의 ANSI - SQL + 절차 지향 언어 기능 추가
    - ANSI-SQL + 확장팩(변수, 제어흐름(제어문), 객체(메서드), 정의)
    
    프로시져, Procedure
    - 메서드, 함수 등..
    - 순서가 있는 명령어의 집합
    - 모든 PL/SQL 구믄은 프로시저내에서만 작성/동작이 가능하다.
    - 프로시저가 아닌 영역 > ANSI-SQL 영역
    
    1. 익명 프로시저
        - 1회용 코드 작성용
    
    2. 실명 프로시저
        - 데이터베이스 객체 
        - 저장용
        - 재호출
        
        
    PL/SQL 프로시저 구조
    
    1. 4개의 블럭(키워드)으로 구성
        - DECLARE
        - BEGIN
        - EXXCEPTION
        - END
   
    2. DECLARE     
        - 선언부
        - 프로시저내에서 사용할 변수, 객체 등을 선언하는 영역 
        - 생략 가능
        
    3. BEGIN - END(비슷 CASE END, PUBLIC VOID TEST..., try catch의 catch)
        - 실행부, 구현부
        - 구현된 코드틀 가지는 영역(메서드의 BODY 영역)
        - 생략 불가능
        - 구현된 코드 > ANSI-SQL + PL/SQL(연산, 제어 등)    
        
    4. EXCEPTION(비슷 TRY CATCH)
        - 예외처리부
        - catch 역할, 3번 영역이 try 역할
        - 생략 가능
        
    자료형 + 변수
    
    PL/SQL 자료형
    - ANSI-SQL와 동일
    
    변수 선언하기
    - 변수명 자료형 [not null] [default 값];
    
    PL/SQL 연산자
    - ANSI-SQL과 동일
    
    대입연산자(ANSI-SQL과 다름)
    - ANSI-SQL 대입 연산자
        ex) update table set column = '값'
    - PL/SQL 대입 연산자
        ex) 변수 := '값';
    

*/


/*declare
--선언부
begin
--구현부
end;
*/

--결과값 눈으로 보기 위한 작업
set SERVEROUTPUT on;    --현재 세션에서만 유효(접속 해제 > 초기화;;)
set serverout on;

--보기 싫음 끄는법
set SERVEROUTPUT off;
set serverout off;


--익명 프로시저
declare

    num number;     --변수 선언
    name varchar2(30);
    today date;
begin

    num := 10;
    dbms_output.put_line(num);     --syso랑 똑같음
    
    name := '홍길동';
    dbms_output.put_line(name);  
    
    today := sysdate;
    dbms_output.put_line(today); 
            
end;
/

declare
    num1 number;
    num2 number;
    num3 number := 30;
    num4 number default 40; 
    num5 number not null := 50; --declare 블럭에서 초기화를 해야한다. (구현부 X)
begin

    dbms_output.put_line(num1);     --null이라 실행해도 안보임
    num2 := 20;
    dbms_output.put_line(num2);  
    
    dbms_output.put_line(num3); 
    
    dbms_output.put_line(num4); 
    
    num4 := 400;
    dbms_output.put_line(num4); 
    
    dbms_output.put_line(num5); 
    
    num5 := 50;
    dbms_output.put_line(num5); 
    syso
end;
/   --이거 하면 블럭 안잡아도 실행 됨

/*

    변수 > 어떤 용도로 사용?
    
    - select 결과를 담는 용도(*************)
    - select into 절(PL/SQL)
    

*/

declare

    vbuseo varchar2(15);
begin

   -- vbuseo =( select buseo from tblInsa where name = '홍길동');
   
    select buseo into vbuseo from tblInsa where name = '홍길동';
    dbms_output.put_line(vbuseo); 
    
--    select buseo from tblInsa where name = '홍길동';
--    dbms_output.put_line(buseo); --identifier 'BUSEO' must be declared 
    
end;


begin
    -- PL/SQL 프로시저 안에서는 순수한 select문은 올 수 없다.(절대)
    -- PL/SQL 프로시저 안에서는 select into문만 사용한다.
    select buseo from tblInsa where name = '홍길동';       --an INTO clause is expected in this SELECT statement
end;

--성과급 받는 직원명
create table tblName(
    name varchar2(15)
);

drop table tblName;

-- 1. 개발부 + 부장 > select > name?
-- 2. tblName > name > insert

insert into tblName(name)
    values((select name from tblInsa where buseo = '개발부' and jikwi = '부장'));
/
declare
    vname varchar2(15);
begin
    --1.
    select name into vname from tblInsa where buseo = '개발부' and jikwi = '부장';
    
    --2.
    insert into tblName (name) values (vname);

end;
/
select * from tblName;

declare
    vname varchar2(15);
    vbuseo varchar2(15);
    vjikwi varchar2(15);
    vbasicpay number;
begin

--    select name into vname , buseo into vbuseo, jikwi into vjikwi, basicpay into vbasicpay from tblInsa where num = 1001;

    -- insert 사용시
    -- 1. 컬럼의 개수와 변수의 개수 일치
    -- 2. 컬럼의 순서와 변수의 순서 일치
    -- 3. 컬럼과 변수의 자료형 일치
     select name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay from tblInsa where num = 1001;        --컬럼 리스트 뒤에 옴
     dbms_output.put_line(vname); 
     dbms_output.put_line(vbuseo); 
     dbms_output.put_line(vjikwi); 
     dbms_output.put_line(vbasicpay); 
     
end;

desc tblInsa;

/*

    타입 참조
    
    %type
    - 사용하는 테이블의 특정 컬럼값의 스키마를 알아내서 변수에 적용
    - 복사되는 정보
        a. 자료형
        b. 길이
    - 컬럼 1개 참조    
        
    %rowtype    
    - 행 전체 참조(여러개의 컬럼을 한 번에 참조)    
    - %type의 집합형
    - 레코드 전체(여러개 컬럼)을 하나의 변수에 저장 가능
        
*/


declare
    --vbuseo varchar2(15);
    vbuseo tblinsa.buseo%type;
begin
    select buseo into vbuseo from tblInsa where name = '홍길동';
    dbms_output.put_line(vbuseo); 
end;


declare
    vname tblInsa.name%type;
    vbuseo tblInsa.buseo%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;
begin

     select name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay from tblInsa where num = 1001;        --컬럼 리스트 뒤에 옴
     dbms_output.put_line(vname); 
     dbms_output.put_line(vbuseo); 
     dbms_output.put_line(vjikwi); 
     dbms_output.put_line(vbasicpay); 
     
end;

-- 직원 중 일부에게 보너스 지급(급여*1.5) > 내역 저장
create table tblBonus(
    seq number primary key,
    num number(5) not null references tblinsa(num), --직원번호(FK)
    bonus number not null
);

declare
    vnum tblInsa.num%type;
    vbasicpay tblinsa.basicpay%type;
begin 
    select num, basicpay into vnum, vbasicpay
        from tblInsa where city = '서울' and jikwi = '부장' and buseo = '영업부';
        
    insert into tblBonus (seq, num, bonus)
        values((select.nv1max(seq),0)+1 from tblBonus), vnum, vbasicpay*1.5);

end;

select * From tblBonus;

select * from tblBonus b
    inner join tblInsa i
        on i.num = b.num;

select * from tblmen;
select * from tblwomen;

--무명씨 > 성전환 수술 > tblMen > tblWomen > 옮기기
--1. '무명씨' > tblMen > select
--2. tblWomen > insert
--3. tblmen > delete

declare
    vrow tblmen%rowtype;    -- vrow tblmen의 레코드1개(모든 컬럼값)을 저장할 수있는 변수
begin 
    select
       * into vrow
    from tblmen where name = '정형돈';
    
    dbms_output.put_line(vrow.name); 
    dbms_output.put_line(vrow.age); 
    dbms_output.put_line(vrow.height); 
    dbms_output.put_line(vrow.weight); 
    dbms_output.put_line(vrow.couple); 

    insert into tblwomen (name, age, height, weight,couple)
        values(vrow.name, vrow.age, vrow.height, vweight, vrow.couple);
    
 delete from tblmen where name = vrow.name;

end;


/*

    제어문
    1. 조건문
    2. 반복문
    3. 분기문
    
*/

declare
    vnum number := -10;
begin

    if vnum > 0 then
        dbms_output.put_line('양수'); 
    else
        dbms_output.put_line('음수'); 
    end if;
    
end;


declare
    vnum number := 10;
begin

    if vnum > 0 then
        dbms_output.put_line('양수'); 
    elsif vnum < 0 then         --else if, elseif, elsif 등..
        dbms_output.put_line('음수');
    else
        dbms_output.put_line('0'); 
    end if;
    
end;

-- tblInsa 남자 직원/ 여자 직원 > 다른 업무

declare
    vgender char(1)
begin
    select substr(ssn, 8, 1) into vgender from tblInsa where num = '1035';       --정영희
    
    if vgender = '1' then
        dbms_output.put_line('남자직원'); 
    elsif vgender = '2' then
        dbms_output.put_line('여자직원'); 
    end if;
    
end;

-- 직원 1명 선택(num) > 보너스 지급
-- 차등 지급
-- a. 과장/부장 > basicpay * 1.5
-- b. 대리/사원 > basicpay *2

declare
    vnum tblInsa.num%type;
    vbasicpay tblinsa.basicpay%type;
    vjikwi tblinsa.jikwi%type;
    vbonus number;
begin 
    select num, basicpay, jikwi into vnum, vbasicpay,vjikwi
        from tblInsa where num = 1040;
        
         if vjikwi = '과장' or '부장' then
            vbonus = basicpay * 1.5;
         elsif vjikwi in('사원', '대리') then
            vbonus = basicpay*2; 
        
    end if;
                
    insert into tblBonus (seq, num, bonus)
        values((select.nv1max(seq),0)+1 from tblBonus), vnum, vbonus);

end;

select * from tblBonus b
    inner join tblInsa i
        on i.num = b.num;
        
        
/*

    case문
    - ANSI-SQL의 case문과 거의 유사
    - 자바의 switch문, 다중 if문


*/        


declare
    vcontinent tblcountry.continent&type;
    vresult varchar2(30);
begin
       select continent into vcontinent from tblcountry where name = '영국';
       
       if vcontinent = 'AS' then
        vresult := '아시아';
       elsif vcontinent = 'EU' then
        vresult := '유럽';
       elsif vcontinent = 'AF' then
        vresult := '아프리카';
       else
        vresult := '기타';
    end if;
    dbms_output.put_line(vresult); 
    
    case 
        when vcontinent = 'AS' then vresult := '아시아';
         when vcontinent = 'EU' then vresult := '유럽';
         when vcontinent = 'AF' then vresult := '아프리카';
         else vresult := '기타';
    end case;
        dbms_output.put_line(vresult); 
        
     case
        when 'AS' then result := '아시아';
        when 'EU' then vresult := '유럽';
        when 'EU' then vresult := '아프리카';
        else result := '기타';
     end case;
        dbms_output.put_line(vresult); 
end;

/*

    반복문
    1. loop
        - 단순 반복
        
    2. for loop
        - 횟수 반복(자바 for)
        - loop 기반
    
    3. while loop
        - 조건 반복(자바 while)
        - loop 기반
        
*/

--무한 루프
begin
    loop
        dbms_output.put_line('100'); 
    end loop;
end;

declare
    vnum number := 1;
begin
    loop
        dbms_output.put_line('100'); 
        vnum := vnum +1;
        
        --exit 조건;
        exit when vnum > 10; --조건부 break
        
    end loop;
end;

create table tblLoop(

    seq number primary key,
    data varchar2(100) not null

);
     
create sequence seqLoop; 

select * from tblLoop;

--데이터 X 1000건 추가
--data > '항목1', '항목2',,,,,'항목1000'

declare
    vnum number :=1;
begin
    loop
        insert into tblLoop values(seqLoop.nextVal, '항목'|| vnum);
        vnum := vnum +1;
        exit when vnum > 1000;
    end loop;
end;

select * From tblLoop;

--2. for loop
/*

    향상된 for문
    - foreach문
    - for in

    for(int n : list){
    
    }
    
    for(int n in list){
    
    }


*/


begin
    for i in 1..10 loop
        dbms_output.put_line(i); 
    end loop;
end;

create table tblGugudan(
    
    dan number not null,       --table can have only one primary key
    num number not null,
    result number not null,
    constraint tblgugudan_dan_num_pk primary key(dan,num)   --복합키 (composita key)
);

drop table tblgugudan;

create table tblGugudan(    
    dan number not null,    
    num number not null,
    result number not null    
);

alter table tblGugudan
    add constraint tblgugudan_dan_num_pk primary key(dan,num);
    
 
begin
    for dan in 2..9 loop
        
        for num in 1..9 loop
        
            insert into tblGugudan(dan, num, result)
                values (dan, num, dan*num);
        
        end loop;        
    end loop;
end;

select * from tblgugudan;

--reverse 루프 반대로 돌리기
begin

        for i in reverse 1..10 loop
         dbms_output.put_line(i); 
        end loop;  

end;

--3. while loop
declare 
    vnum number := 1;
begin

        for i in reverse 1..10 loop
             dbms_output.put_line(i); 
             vnum := vnum +1;
             exit when vnum > 10;
        end loop;  

end;

-------
declare 
    vnum number := 1;
begin
        --while 반복조건 loop
        while vnum <= 10 loop
             dbms_output.put_line(vnum); 
             vnum := vnum +1;   
        end loop;  

end;

/*

    select  > 결과셋 > PL/SQL 변수 대입
    1. select into
        - 결과셋의 레코드가 1개일 때만 사용이 가능하다.
    
    2. currsor
        - 결과셋의 레코드가 N개일 때 사용한다.
        
        declare
            변수 선언;
            커서 선언;  --결과셋 참조 객체
        begin
            커서 열기;
                loop
                    데이터 접근(루프 1회전 > 레코드 1개) <- 커서 사용
                end loop;
            커서 닫기;
        end;


*/

declare
    vname tblInsa.name%type;
begin
    --ORA-01422: exact fetch returns more than requested number of rows
    select name into vname from tblInsa ;
    dbms_output.put_line(vname); 
end;


    create view vview
    as
    select 문
 
    cursor vcursor
    is
    select문;


declare
    cursor vcursor
    is
    select name from tblInsa;
    vname tblInsa.name%type;
begin
    
    open vcursor;   --커서 열기 > select 실행> 결과셋을 커서가 참조
    
--        fetch vcursor into vname; --select into 역할
--         dbms_output.put_line(vname);    
--         
--        fetch vcursor into vname; --select into 역할
--         dbms_output.put_line(vname);  

--        for i in 1..60 loop
--             fetch vcursor into vname;
--            dbms_output.put_line(vname);
--        end loop;
         
         loop
            fetch vcursor into vname;
            --exit when 조건;
            exit when vcursor%notfound; --bool
            
             dbms_output.put_line(vname);
         end loop;
         
    close vcursor;
    
end;


-- '기획부' > 이름, 직위, 급여 > 출력

declare
    cursor vcursor
        is select name, jikwi, basicpay from tblInsa where buseo = '기획부';
        vname tblInsa.name%type;
        vjikwi tblInsa.jikwi%type;
        vbasicpay tblInsa.basicpay%type;
        
begin
    open vcursor;
    
    loop
        fetch vcursor into vname, vjikwi,vbasicpay;
        exit when vcursor%notfound;
        
        --업무 > 기획부 직원 한사람씩 접근..
        dbms_output.put_line(vname ||','||vjikwi ||','|| vbasicpay); 
        
    end loop;
    
    close vcursor;
end;

--문제 tblBonus
select * from tblBonus;

declare

    cursor vcursor
        is select num, basicpay, jikwi from tblInsa;
    
    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
    vjikwi tblInsa.jikwi%type;
    vbonus number;
    
 begin
 
    open vcursor;
    loop
        fetch vcursor into vnum, vbasicpay, vjikwi;
        exit when vcursor%notfound;
        
        if vjikwi in('과장','부장') then
            vbonus := vbasicpay * 1.5;
        else vjikwi in ('사원','대리') then
            vbonus := vbasicpay * 2;
        end if;
        
        insert into tblBonus (seq, num, bonus)
            values((select nv1(max(seq),0)+1 from tblBonus), vnum, vbasicpay, vjikwi);
        
    end loop;
    close vcursor;
    
 end;   
 
 
 --커서 탐색
 -- 1. 커서 + loop > 정석
 -- 2. 커서 + for loop
 
 declare
    cursor vcursor
    is select * from tblInsa;
    vrow tblInsa%rowtype;
 
 begin
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name); 
     end loop;   
    close vcursor;
 end;
 
  --forloop
  declare
    cursor vcursor
    is select * from tblInsa;
    --vrow tblInsa%rowtype;
 
 begin
    --open vcursor;
    --loop
    --for 루프변수 in 집합 loop
      for vrow in vcursor loop       -- loop + fetch into + vrow + exit when
        --fetch vcursor into vrow;
        --exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name); 
     end loop;   
   -- close vcursor;
 end;
 
  declare
    cursor vcursor
    is select * from tblInsa;
  begin
      for vrow in vcursor loop   
        dbms_output.put_line(vrow.name); 
     end loop;     
 end;
 
 -- 예외처리
 -- 실행부에서(begin-end) 발생하는 예외를 처리하는 블럭 > exception 블럭
 
 declare
    vname varchar2(5); 
 
 begin
    dbms_output.put_line('하나'); 
    select name into vname from tblInsa where num = 1001;
    dbms_output.put_line('둘'); 
    
    dbms_output.put_line(vname); 

exception                   --begin과 end사이 exception 위가 try구현 아래 catch예외
    
    when others then
        dbms_output.put_line('예외처리'); 
    
 end;
 
 -- 예외 발생 > DB 저장
 create table tblLog(
    seq number primary key,         --PK
    code varchar2(7) not null check (code in ('A001','B001','B002','C001')), --에러상태코드
    message varchar2(1000) not null,        --에러메세지
    regdate date default sysdate not null   --에러 발생 시각
  );
 
 create sequence seqLog;
 
 declare
    vcnt number;
    vname tblInsa.name%type;
 begin
 
    select count(*) into  vcnt from tblCountry where name = '태국'; --01476. 00000 -  "divisor is equal to zero"  
    dbms_output.put_line(100/vcnt); 
    
    select name into vname from tblInsa where num = 1000;
    dbms_output.put_line(vname); 
    
 exception
    --모든 에러 잡는애
    --when others then 
    
    when ZERO_DIVIDE then
    dbms_output.put_line('0으로 나누기'); 
    insert into tblLog values (seqlog.nextval, 'B001', '가져온 레코드가 없습니다.', default);
    
    when NO_DATA_FOUND then
    dbms_output.put_line('데이터가 없음'); 
    insert into tblLog values (seqlog.nextval, 'A001', '직원이 존재하지 않습니다.', default);
    
    when others then
     dbms_output.put_line('나머지 예외'); 
     insert into tblLog values (seqlog.nextval, 'C001', '기타 예외가 발생했습니다.', default);
     
 end;
 
 select * from tblLog;
 
 -- -익명 프로시저
 -- -실명 프로시저