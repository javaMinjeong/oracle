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
    end as gender;
from tblinsa;

create or replace function fnGender(
    pssn varchar2
) return varchar2
is
begin
    return case
                when substr(pssn) = '1' then '남자'
                when substr(pssn) = '2' then '여자'
            end;
end fnGender;