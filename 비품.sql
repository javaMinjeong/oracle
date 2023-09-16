SELECT * fROM TBLFIXTUREMNG;
SELECT * FROM tblFixture;  --WHERE FIXTURESEQ =799;

SELECT A.*
     , B.TYPE, B.INUSE
  FROM TBLFIXTUREMNG A
    INNER JOIN tblFixture B
    ON A.fixtureSeq = B.fixtureSeq;
        --WHERE b.fixtureseq = 1;
   
-- 비품 목록 조회        
CREATE OR REPLACE VIEW vwfxlist
AS
SELECT
    A.*,
    B.TYPE, B.INUSE
FROM TBLFIXTUREMNG A
     INNER JOIN tblFixture B
         ON A.fixtureSeq = B.fixtureSeq;       
drop view fxlist;
    
select * from vwfxlist;


select * from tblstudent;

create or replace procedure procStudentList(
    pCourse number
)
is
    cursor vcursor
    is 
    select 
        studentseq as 교육생번호, name as 교육생이름, phone as 전화번호, registerdate as 등록일, compldropstatus as 수료중도탈락여부 -- stdentseq, name, phone, registerdate, compldropstatus
    from tblstudent 
    where processseq = 2;
    
    vstdseq tblstudent.studentseq%type;
    vstdname tblstudent.name%type;
    vstdphone tblstudent.phone%type;
    vstdreg tblstudent.registerdate%type;
    vstdcom tblstudent.compldropstatus%type;
begin
     dbms_output.put_line('교육생이름');
     open vcursor;
        loop
            fetch vcursor into vstdseq, vstdname, vstdphone, vstdreg, vstdcom;
            exit when vcursor%notfound;
            
            dbms_output.put_line('    ' || vstdname); -- 위의 변수 그대로 더 사용하면 출력됨.
            
        end loop;
     close vcursor;
end;



begin
    procStudentList(2);
end;



    
update tblFixture set INUSE = '미사용' WHERE FIXTURESEQ =  1;
    
ROLLBACK;   

DELETE from tblFixture where FIXTURESEQ =  783;

insert into tblFixture (fixtureSeq, type, inUse) values (fixture_seq.nextVal,'키보드','사용중');
  
