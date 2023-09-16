select * from tblcourse;    -- 과정

--개설 과정 정보 목록 조회 select //개설 과정명, 개설 과정기간(시작 년월일, 끝 년월일), 강의실명, 개설 과목 등록 여부, 교육생 등록 인원
select
    t1.courseSeq AS "과정번호",
    t1.courseName AS "과정명",
    TO_CHAR(t1.courseStartDate, 'yyyy-mm-dd') AS "개설과정시작일",
    TO_CHAR(t1.courseFinishDate, 'yyyy-mm-dd') AS "개설과정종료일",
    t2.classRoomName AS "강의실명",
    t1.subjectRegistrationStatus AS "과목등록여부",
    t1.studentNumber AS "교육생인원수"    
from tblcourse t1
         inner join TBLCLASSROOM t2
                ON t1.classroomName = t2.classroomName;
    --where courseseq = 1; 
    
--개설 과정 정보 목록 조회 view
create or replace view vwCourseList
as
select
    t1.courseSeq AS "과정번호",
    t1.courseName AS "과정명",
    TO_CHAR(t1.courseStartDate, 'yyyy-mm-dd') AS "개설과정시작일",
    TO_CHAR(t1.courseFinishDate, 'yyyy-mm-dd') AS "개설과정종료일",
    t2.classRoomName AS "강의실명",
    t1.subjectRegistrationStatus AS "과목등록여부",
    t1.studentNumber AS "교육생인원수"    
from tblcourse t1
         inner join TBLCLASSROOM t2
                ON t1.classroomName = t2.classroomName; 
    
select * from vwcourselist;    


--개설 과정 정보 목록 조회 procedure
CREATE OR REPLACE PROCEDURE procCourseList(
    pseq IN NUMBER
) IS
BEGIN   
        FOR c IN (
        SELECT *
        FROM vwCourseList
        WHERE "과정번호" = pseq
        ORDER BY "과정번호"
    ) LOOP
        -- 결과를 출력
        DBMS_OUTPUT.PUT_LINE('과정번호: ' || c."과정번호");
        DBMS_OUTPUT.PUT_LINE('과정명: ' || c."과정명");
        DBMS_OUTPUT.PUT_LINE('개설과정시작일: ' || c."개설과정시작일");
        DBMS_OUTPUT.PUT_LINE('개설과정종료일: ' || c."개설과정종료일");
        DBMS_OUTPUT.PUT_LINE('강의실명: ' || c."강의실명");
        DBMS_OUTPUT.PUT_LINE('과목등록여부: ' || c."과목등록여부");
        DBMS_OUTPUT.PUT_LINE('교육생인원수: ' || c."교육생인원수");
    END LOOP;
END;

begin
    procCourseList(1);
end;





select * from tblsubjectlist;--과목목록조회
select * From tblsubject;   -- 과목조회
select * from tblstudent;   -- 교육생 조회
select * from tblbook;      -- 교재명 조회
select * From tblteacher;      -- 교사명 조회   
SELECT subjectRegistrationStatus FROM tblcourse cu WHERE courseSeq = 7;
--개설과정을 선택하여 정보 조회 -> 과목등록이 'Y'인 경우 select
-- 개설 과목 정보(과목명, 과목기간(시작 년월일, 끝 년월일), 교재명, 교사명)
--  +등록된 교육생 정보(교육생 이름, 주민번호 뒷자리, 전화번호, 등록일, 수료 및 중도탈락날짜, 수료 및 중도탈락 여부)
SELECT  
    (SELECT SUBNAME FROM tblsubject sj WHERE sl.SUBSEQ = sj.SUBSEQ) AS "과목명",
    TO_CHAR(sl.subjectStartDate, 'yyyy-mm-dd') AS "과목시작일자",
    TO_CHAR(sl.subjectFinishDate, 'yyyy-mm-dd') AS "과목종료일자",
    (SELECT BookNAME FROM tblbook b WHERE sl.BookSEQ = b.BookSEQ) AS "교재명",
    (SELECT name FROM tblteacher t WHERE sl.teacherseq = t.teacherSEQ) AS "교사명",
    st.name AS "교육생이름",
    st.ssn AS "주민번호 뒷자리",
    st.phone AS "핸드폰번호",
    TO_CHAR(st.registerdate, 'yyyy-mm-dd') AS "등록일",
    st.applicationClass AS "수강신청횟수",
    TO_CHAR(st.compldropdate, 'yyyy-mm-dd') AS "수료일또는중도탈락일",
    st.compldropstatus AS "수료및중도탈락여부"
FROM tblcourse cu
   LEFT JOIN tblsubjectlist sl
       ON cu.COURSESEQ = sl.COURSESEQ        
              left join tblstudent st
                on sl.COURSESEQ = st.processSeq
                 where cu.courseSeq = 1
                     and cu.subjectRegistrationStatus = 'Y'
                         order by cu.COURSESEQ;
                         

----view 생성
--create or replace view vwCourseSbjList
--as
--SELECT  
--    (SELECT SUBNAME FROM tblsubject sj WHERE sl.SUBSEQ = sj.SUBSEQ) AS "과목명",
--    TO_CHAR(sl.subjectStartDate, 'yyyy-mm-dd') AS "과목시작일자",
--    TO_CHAR(sl.subjectFinishDate, 'yyyy-mm-dd') AS "과목종료일자",
--    (SELECT BookNAME FROM tblbook b WHERE sl.BookSEQ = b.BookSEQ) AS "교재명",
--    (SELECT name FROM tblteacher t WHERE sl.teacherseq = t.teacherSEQ) AS "교사명",
--    st.name AS "교육생이름",
--    st.ssn AS "주민번호 뒷자리",
--    st.phone AS "핸드폰번호",
--    TO_CHAR(st.registerdate, 'yyyy-mm-dd') AS "등록일",
--    st.applicationClass AS "수강신청횟수",
--    TO_CHAR(st.compldropdate, 'yyyy-mm-dd') AS "수료일또는중도탈락일",
--    st.compldropstatus AS "수료및중도탈락여부"
--FROM tblcourse cu
--   LEFT JOIN tblsubjectlist sl
--       ON cu.COURSESEQ = sl.COURSESEQ        
--              left join tblstudent st
--                on sl.COURSESEQ = st.processSeq   
--                     where cu.subjectRegistrationStatus = 'Y'
--                         order by cu.COURSESEQ;
--                         
----                          where cu.courseSeq = 1
--                     --and cu.subjectRegistrationStatus = 'N'
--select * from vwCourseSbjList;
--
--drop view vwCourseSbjList;

commit;
 
DROP procedure procCourseSubjectInfo;
COMMIT;
                         
-- 특정 개설 과정 선택 후 개설 과목 검색
-- -> 과목 등록여부 Y: 개설 과정에 등록된 개설 과목 정보(과목명, 과목기간, 시작 년월일, 끝 년월일), 교재명, 교사명)
--    + 등록된 교육생 정보(교육생 이름, 주민번호 뒷자리, 전화번호, 등록일, 수료 및 중도탈락)을 확인
-- -> 과목 등록여부 N: 과목 등록여부 필요


commit;
SELECT T.* 
  FROM TBLTEACHER T
 INNER JOIN tblAvailableSubject TA
    ON T.TEACHERSEQ = TA.TEACHERSEQ
  WHERE TA.SUBSEQ = 2 -- 과목번호
  ;

SELECT * FROM tblAvailableSubject WHERE SUBSEQ = 1;



