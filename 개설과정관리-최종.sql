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
    procCourseList();
end;


drop procedure procCourseList;

commit;

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


--신규 과정 등록
INSERT INTO tblcourse(courseSeq, courseName, courseStartDate, courseFinishDate, classroomName, subjectRegistrationStatus, studentNumber)
VALUES (course_seq.nextval, '안녕하세요', TO_DATE('2024-03-02', 'YYYY-MM-DD'), TO_DATE('2024-08-17', 'YYYY-MM-DD'), '4', 'Y', 26);

select * from tblcourse;


drop procedure InsertCourse;
commit;
select * From tblstudent;

--과정 수료한 경우 등록된 교육생 전체에 대하여 수료 날짜 지정, 중도 탈락자 제외
UPDATE tblstudent s
SET s.complDropDate = SYSDATE,
    s.complDropStatus = '수료'
WHERE EXISTS (
    SELECT 1
    FROM tblcourse c
    WHERE s.processseq= c.courseseq
    AND c.coursefinishdate <= SYSDATE
)
AND s.complDropDate is null;

--수료상태 update procedure
CREATE OR REPLACE PROCEDURE UpdateCompletionStatus AS
BEGIN
    UPDATE tblstudent s
    SET s.complDropDate = SYSDATE,
        s.complDropStatus = '수료'
    WHERE EXISTS (
        SELECT 1
        FROM tblcourse c
        WHERE s.processseq = c.courseseq
        AND c.coursefinishdate <= SYSDATE
    )
    AND s.complDropDate IS NULL;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('수료 상태가 업데이트되었습니다.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('업데이트 중 오류가 발생했습니다.');
END;
/
BEGIN
    UpdateCompletionStatus; -- 프로시저 호출
END;
/

drop procedure InsertCourse;
commit;

--신규 과정 등록 procedure
CREATE OR REPLACE PROCEDURE procInsertCourse(
    pcourseName tblcourse.courseName%TYPE,
    pstartDate tblcourse.courseStartDate%TYPE,
    pfinishDate tblcourse.courseFinishDate%TYPE,
    pclassroomName tblcourse.classroomName%TYPE,
    psubjectStatus tblcourse.subjectRegistrationStatus%TYPE,
    pstudentNumber in out tblcourse.studentNumber%TYPE
) IS
    vclassroomName NUMBER;
    vclassroomMaxPeople NUMBER;
BEGIN
    -- 강의실명이 tblclassroom 테이블에 있는지 확인
    SELECT classroomName, classroomMaxPeople
    INTO vclassroomName, vclassroomMaxPeople
    FROM tblclassroom
    WHERE classroomName = pclassroomName;

    -- 강의실명이 없으면 오류 발생
    IF vclassroomName= 0 THEN
        DBMS_OUTPUT.PUT_LINE('오류: 입력한 강의실명이 tblclassroom에 존재하지 않습니다.');
        RETURN;
    END IF;

    -- 개설과정 시작일과 종료일이 현재 날짜 이후인지 확인
    IF pstartDate <= SYSDATE OR pfinishDate <= SYSDATE THEN
        DBMS_OUTPUT.PUT_LINE('오류: 개설과정 시작일과 종료일은 현재 날짜 이후로만 설정 가능합니다.');
        RETURN;
    END IF;

    -- 강의실에 따라 교육생 인원수 설정
    IF pclassroomName IN ('1', '2', '3') THEN
        pstudentNumber := 30;
    ELSIF pclassroomName IN ('4', '5', '6') THEN
        pstudentNumber := 26;
    ELSE
        DBMS_OUTPUT.PUT_LINE('오류: 올바른 강의실명을 입력해주세요.');
        RETURN;
    END IF;

    -- 과정 추가
    INSERT INTO tblcourse(courseSeq, courseName, courseStartDate, courseFinishDate, classroomName, subjectRegistrationStatus, studentNumber)
    VALUES (course_seq.nextval, pcourseName, pstartDate, pfinishDate, pclassroomName, psubjectStatus, pstudentNumber);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('새로 등록된 과정 정보');
    DBMS_OUTPUT.PUT_LINE('과정번호: ' || course_seq.currval);
    DBMS_OUTPUT.PUT_LINE('과정명: ' || pcourseName);
    DBMS_OUTPUT.PUT_LINE('개설과정시작일: ' || TO_CHAR(pstartDate, 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('개설과정종료일: ' || TO_CHAR(pfinishDate, 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('강의실명: ' || pclassroomName);
    DBMS_OUTPUT.PUT_LINE('과목등록여부: ' || psubjectStatus);
    DBMS_OUTPUT.PUT_LINE('교육생인원수: ' || pstudentNumber);
    DBMS_OUTPUT.PUT_LINE('과정이 성공적으로 추가되었습니다.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('과정 추가 중 오류가 발생했습니다.');
END;
/

DECLARE
    vCourseName tblcourse.courseName%TYPE := 'Sample Course';
    vStartDate tblcourse.courseStartDate%TYPE := TO_DATE('2023-09-20', 'YYYY-MM-DD');
    vFinishDate tblcourse.courseFinishDate%TYPE := TO_DATE('2024-01-20', 'YYYY-MM-DD');
    vClassroomName tblcourse.classroomName%TYPE := '1';  -- 강의실명을 여기에 입력
    vSubjectStatus tblcourse.subjectRegistrationStatus%TYPE := 'Y';
    vStudentNumber tblcourse.studentNumber%TYPE := NULL;  -- 초기값은 NULL로 설정

BEGIN
    -- 프로시저 호출
    procInsertCourse(vCourseName, vStartDate, vFinishDate, vClassroomName, vSubjectStatus, vStudentNumber);
    
--    -- 프로시저 실행 후 vStudentCount 값 확인
--    DBMS_OUTPUT.PUT_LINE('프로시저 실행 후 vStudentNumber 값: ' || vStudentNumber);
END;
/
select * from tblcourse; 
rollback;
commit;

--개설 과정번호 수정 update
UPDATE tblcourse
SET courseSeq = 13
WHERE courseSeq = 21;

--개설과정 시작일 수정
UPDATE tblcourse
SET courseStartDate =      --과목시작일
WHERE courseSeq  =    ;      --수정할 개설과정번호
  
--개설과정 종료일 수정     
UPDATE tblcourse
SET courseFinishDate =        --과목 종료일
WHERE courseSeq  =   ;           --수정할 개설과정번호

--강의실명 수정
Update tblcourse
set classroomName =
where courseSeq = ;

select * from tblcourse;

   
--개설 과정번호 수정 procedure

CREATE OR REPLACE PROCEDURE UpdateCourseSeq(
    p_currentCourseSeq NUMBER,
    p_newCourseSeq NUMBER
) IS
BEGIN
    UPDATE tblcourse
    SET courseSeq = p_newCourseSeq
    WHERE courseSeq = p_currentCourseSeq;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('과정 번호 ' || p_currentCourseSeq || '가 ' || p_newCourseSeq || '로 수정되었습니다.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('과정 번호 수정 중 오류가 발생했습니다.');
END;
/

BEGIN
    UpdateCourseSeq(22, 14); -- 현재 과정 번호 a를 b으로 수정
END;
/


--과목 시작일 변경
CREATE OR REPLACE PROCEDURE procUpdateCourseStartDate(
    pCourseSeq IN NUMBER,
    pNewStartDate IN DATE
) AS
    vCurrentDate DATE := SYSDATE;  -- 현재 날짜 가져오기
BEGIN
    -- 현재 날짜 이후인지 확인
    IF pNewStartDate <= vCurrentDate THEN
        DBMS_OUTPUT.PUT_LINE('과정 시작일은 현재 날짜 이후로만 수정 가능합니다.');
        RETURN;  -- 업데이트 거부
    END IF;

    -- 과정 시작일 업데이트
    UPDATE tblCourse
    SET courseStartDate = pNewStartDate
    WHERE courseSeq = pCourseSeq;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('과정 시작일이 수정되었습니다.');
    DBMS_OUTPUT.PUT_LINE('과정번호: ' || pCourseSeq);
    DBMS_OUTPUT.PUT_LINE('새로운 시작일: ' || TO_CHAR(pNewStartDate, 'YYYY-MM-DD'));
EXCEPTION
     WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('과정 시작일 수정 중 오류가 발생했습니다.');
        DBMS_OUTPUT.PUT_LINE('오류 메시지: ' || SQLERRM);
END;
/


--호출
DECLARE
    vCourseSeq NUMBER := 1;             -- 사용자로부터 입력받은 개설 과정 번호
    vNewStartDate DATE := TO_DATE('2022-09-01', 'YYYY-MM-DD');  -- 변경할 시작 날짜
BEGIN
    procUpdateCourseStartDate(vCourseSeq, vNewStartDate);
END;
/

drop procedure procUpdateSubFinishDate;
commit;

--과목종료일 변경
CREATE OR REPLACE PROCEDURE procUpdateCourseFinishDate(
    pCourseSeq IN NUMBER,
    pNewFinishDate IN DATE
) AS
    vCurrentDate DATE := SYSDATE;  -- 현재 날짜 가져오기
BEGIN
    -- 현재 날짜 이후인지 확인
    IF pNewFinishDate <= vCurrentDate THEN
        DBMS_OUTPUT.PUT_LINE('과정 종료일은 현재 날짜 이후로만 수정 가능합니다.');
        RETURN;  -- 업데이트 거부
    END IF;

    -- 과정 종료일 업데이트
    UPDATE tblCourse
    SET courseFinishDate = pNewFinishDate
    WHERE courseSeq = pCourseSeq;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('과정 종료일이 수정되었습니다.');
    DBMS_OUTPUT.PUT_LINE('과정번호: ' || pCourseSeq);
    DBMS_OUTPUT.PUT_LINE('새로운 종료일: ' || TO_CHAR(pNewFinishDate, 'YYYY-MM-DD'));
EXCEPTION
     WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('과정 종료일 수정 중 오류가 발생했습니다.');
        DBMS_OUTPUT.PUT_LINE('오류 메시지: ' || SQLERRM);
END;
/
--호출
DECLARE
    vCourseSeq NUMBER := 1;             -- 사용자로부터 입력받은 개설 과정 번호
    vNewFinishDate DATE := TO_DATE('2022-12-31', 'YYYY-MM-DD');  -- 변경할 종료 날짜
BEGIN
    procUpdateCourseFinishDate(vCourseSeq, vNewFinishDate);
END;
/


drop procedure procUpdateCuClassroomName;
commit;

--강의실명 수정

CREATE OR REPLACE PROCEDURE procUpdateCuClassroomName(
    pCourseSeq IN NUMBER,
    pNewClassroomName IN VARCHAR2
) AS
    vClassroomName NUMBER;
BEGIN
    -- 새로운 강의실명(pNewClassroomName)이 tblclassroom 테이블에 있는지 확인
    SELECT classroomName INTO vClassroomName
    FROM tblclassroom
    WHERE classroomName = pNewClassroomName;

    -- 만약 새로운 강의실명이 tblclassroom 테이블에 없으면 오류 발생
    IF vClassroomName = 0 THEN
        DBMS_OUTPUT.PUT_LINE('오류: 새로운 강의실명이 tblclassroom에 존재하지 않습니다.');
        RETURN;
    END IF;

    -- tblcourse 테이블의 강의실명 업데이트
    UPDATE tblcourse
    SET classroomName = pNewClassroomName
    WHERE courseSeq = pCourseSeq;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('강의실명이 수정되었습니다.');
    DBMS_OUTPUT.PUT_LINE('과정번호: ' || pCourseSeq);
    DBMS_OUTPUT.PUT_LINE('새로운 강의실명: ' || pNewClassroomName);
EXCEPTION
     WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('강의실명 수정 중 오류가 발생했습니다.');
        DBMS_OUTPUT.PUT_LINE('오류 메시지: ' || SQLERRM);
END;
/

DECLARE
    vCourseSeq NUMBER := 1;                    -- 수정할 과정 번호
    vNewClassroomName VARCHAR2(50) := 'A101';  -- 새로운 강의실명
BEGIN
   procUpdateCuClassroomName(vCourseSeq, vNewClassroomName);
END;
/

commit;



--개설과정 삭제 delete
DELETE FROM tblcourse
WHERE courseSeq = 23;

drop procedure procDeleteCourse;
commit;
--개설과정 삭제 procedure
CREATE OR REPLACE PROCEDURE procDeleteCourse(
    pcourseSeq NUMBER
) IS
    vCourseCount NUMBER;
BEGIN
    SELECT courseSeq
    INTO vCourseCount
    FROM tblcourse
    WHERE courseSeq = pcourseSeq;
    
     -- 과정 번호가 없으면 오류 발생
    IF vCourseCount = 0 THEN
        DBMS_OUTPUT.PUT_LINE('오류: 입력한 과정 번호가 존재하지 않습니다.');
        RETURN;
    END IF;
    
    -- 과정 삭제
    DELETE FROM tblcourse
    WHERE courseSeq = pcourseSeq;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('과정 번호 ' || pcourseSeq || '가 삭제되었습니다.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('과정 삭제 중 오류가 발생했습니다.');
END;
/

BEGIN
    procDeleteCourse(26); --  과정 삭제
END;
/
commit;