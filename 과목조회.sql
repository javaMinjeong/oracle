select * from tblcourse;    -- 과정

--과정 정보 목록 조회 select
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
    
--과정 정보 목록 조회 view
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


--과정 정보 목록 조회 procedure
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



과목 조인 과목명 불러오기

select * from tblsubjectlist;--과목목록조회
select * From tblsubject;   -- 과목조회
select * from tblstudent;   -- 교육생 조회
select * from tblbook;      -- 교재명 조회
select * From tblteacher;      -- 교사명 조회   

--개설과정을 선택하여 정보 조회 // 과목등록이 'Y'인 경우 select
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
                         
----개설과정을 선택하여 정보 조회 // 과목등록이 'Y'인 경우 procedure     
CREATE OR REPLACE PROCEDURE procCourseSubjectInfo (
    pcourseSeq IN NUMBER
) AS
BEGIN
    FOR course_info IN (
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
        LEFT JOIN tblsubjectlist sl ON cu.COURSESEQ = sl.COURSESEQ
        LEFT JOIN tblstudent st ON sl.COURSESEQ = st.processSeq
        WHERE cu.courseSeq = pcourseSeq
            AND cu.subjectRegistrationStatus = 'Y'
        ORDER BY cu.COURSESEQ
    ) LOOP
        
        DBMS_OUTPUT.PUT_LINE('과목명: ' || course_info."과목명");
        DBMS_OUTPUT.PUT_LINE('과목시작일자: ' || course_info."과목시작일자");
        DBMS_OUTPUT.PUT_LINE('과목종료일자: ' || course_info."과목종료일자");
        DBMS_OUTPUT.PUT_LINE('교재명: ' || course_info."교재명");
        DBMS_OUTPUT.PUT_LINE('교사명: ' || course_info."교사명");
        DBMS_OUTPUT.PUT_LINE('교육생이름: ' || course_info."교육생이름");
        DBMS_OUTPUT.PUT_LINE('주민번호 뒷자리: ' || course_info."주민번호 뒷자리");
        DBMS_OUTPUT.PUT_LINE('핸드폰번호: ' || course_info."핸드폰번호");
        DBMS_OUTPUT.PUT_LINE('등록일: ' || course_info."등록일");
        DBMS_OUTPUT.PUT_LINE('수강신청횟수: ' || course_info."수강신청횟수");
        DBMS_OUTPUT.PUT_LINE('수료일또는중도탈락일: ' || course_info."수료일또는중도탈락일");
        DBMS_OUTPUT.PUT_LINE('수료및중도탈락여부: ' || course_info."수료및중도탈락여부");
        dbms_output.put_line('---------------------------------------------------'); 
    END LOOP;
END procCourseSubjectInfo;
/

BEGIN
    procCourseSubjectInfo(1); -- 원하는 courseSeq 값으로 호출
END;
/








