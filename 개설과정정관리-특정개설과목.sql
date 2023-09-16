--개설 과정 관리
--특정 개설 과정 선택 후 개설 과목 검색(개설 과정에 등록된 개설 과목 정보(과목명, 과목기간, 시작 년월일, 끝 년월일), 교재명, 교사명)
--                                  + 등록된 교육생 정보(교육생 이름, 주민번호 뒷자리, 전화번호, 등록일, 수료 및 중도탈락))
CREATE OR REPLACE PROCEDURE procCourseSearch (
    pcourseSeq IN NUMBER
) AS    
    vsubjectRegistrationStatus VARCHAR2(1);
BEGIN
    -- SubjectRegistrationStatus 값을 조회
    BEGIN
        -- "과정번호"를 사용하여 SubjectRegistrationStatus 값을 조회합니다.
        SELECT "과목등록여부"
        INTO vsubjectRegistrationStatus
        FROM vwCourseList
        WHERE "과정번호" = pcourseSeq; 
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('과정을 찾을 수 없습니다.');
            RETURN;
    END;

    -- SubjectRegistrationStatus 값에 따라 분기
    IF vsubjectRegistrationStatus = 'Y' THEN
        -- subjectRegistrationStatus가 'Y'인 경우에만 아래 쿼리 실행
        FOR cus IN (
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
            LEFT JOIN tblstudent st
            ON sl.COURSESEQ = st.processSeq   
            WHERE cu.courseSeq = pcourseSeq                           
            ORDER BY cu.COURSESEQ
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('과목명: ' || cus."과목명");
            DBMS_OUTPUT.PUT_LINE('과목시작일자: ' || cus."과목시작일자");
            DBMS_OUTPUT.PUT_LINE('과목종료일자: ' || cus."과목종료일자");
            DBMS_OUTPUT.PUT_LINE('교재명: ' || cus."교재명");
            DBMS_OUTPUT.PUT_LINE('교사명: ' || cus."교사명");
            DBMS_OUTPUT.PUT_LINE('교육생이름: ' || cus."교육생이름");
            DBMS_OUTPUT.PUT_LINE('주민번호 뒷자리: ' || cus."주민번호 뒷자리");
            DBMS_OUTPUT.PUT_LINE('핸드폰번호: ' || cus."핸드폰번호");
            DBMS_OUTPUT.PUT_LINE('등록일: ' || cus."등록일");
            DBMS_OUTPUT.PUT_LINE('수강신청횟수: ' || cus."수강신청횟수");
            DBMS_OUTPUT.PUT_LINE('수료일또는중도탈락일: ' || cus."수료일또는중도탈락일");
            DBMS_OUTPUT.PUT_LINE('수료및중도탈락여부: ' || cus."수료및중도탈락여부");
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------'); 
        END LOOP;
    ELSIF vsubjectRegistrationStatus = 'N' THEN
        -- subjectRegistrationStatus가 'N'인 경우에 수행할 작업을 여기에 추가
        DBMS_OUTPUT.PUT_LINE('과목등록이 필요합니다.');       
    ELSE
        DBMS_OUTPUT.PUT_LINE('올바르지 않은 subjectRegistrationStatus 값입니다.');
    END IF;
END procCourseSearch;
/


DECLARE
    vcourseSeq NUMBER := 7; -- 과정 번호를 여기에 입력하세요.
BEGIN
    procCourseSearch(vcourseSeq);
END;
/
commit;