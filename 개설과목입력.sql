drop procedure procinsertsubject;
commit;
--개설과목입력
CREATE OR REPLACE PROCEDURE procInsertSubject (
    vCourseSeq IN tblsubjectlist.courseSeq%TYPE,
    vStartDate IN DATE,
    vEndDate IN DATE,
    vSubjectName IN tblsubject.SUBNAME%TYPE,
    vBookName IN tblbook.BookNAME%TYPE,
    vTeacherName IN tblteacher.name%TYPE
) IS
    vSubjectListSeq tblsubjectlist.subjectListSeq%TYPE;
    vSubjectSeq tblsubject.subSeq%TYPE;
    vBookSeq tblbook.BookSEQ%TYPE;
    vTeacherSeq tblteacher.teacherSEQ%TYPE;   
    vCurrentDate DATE := SYSDATE; -- 현재 날짜를 가져옴
    
    -- 커서 선언
    v_book_cursor SYS_REFCURSOR;
    v_teacherlist SYS_REFCURSOR;
    v_teachername tblteacher.name%TYPE;
    psubseq NUMBER;

BEGIN
    -- 과목 목록 번호 설정 (마지막 번호에 1 추가)
    SELECT NVL(MAX(subjectListSeq), 0) + 1 INTO vSubjectListSeq FROM tblsubjectlist;

    -- 과목명으로 과목 번호 조회
    SELECT subSeq INTO vSubjectSeq FROM tblsubject WHERE SUBNAME = vSubjectName;

    
    -- 과목 시작일자가 현재 날짜 이후인지 확인
    IF vStartDate <= vCurrentDate THEN
        DBMS_OUTPUT.PUT_LINE('오류: 과목 시작일자는 현재 날짜 이후여야 합니다.');
        RETURN;
    END IF;
    
    -- 과목 종료일자가 현재 날짜 이후인지 확인
    IF vEndDate <= vCurrentDate THEN
        DBMS_OUTPUT.PUT_LINE('오류: 과목 종료일자는 현재 날짜 이후여야 합니다.');
        RETURN;
    END IF;

    --교재번호 교재목록 출력
    procGetBookData(v_book_cursor);
    
    -- 호출한 프로시저의 결과를 사용하여 작업 수행
    LOOP
        FETCH v_book_cursor INTO vbookseq, vbookname;
        EXIT WHEN v_book_cursor%NOTFOUND;
        
        -- 결과를 처리
        DBMS_OUTPUT.PUT_LINE('교재번호: ' || vbookseq || ', 교재명: ' || vbookname);
    END LOOP;
    
    -- 과목명으로 조회한 과목번호를 사용
    psubseq := vSubjectSeq;
    
    -- 사용자가 선택한 교재명으로 교재 번호 조회
    SELECT BookSeq INTO vBookSeq FROM tblbook WHERE BookNAME = vBookName;
    
    
    --입력받은 과목번호로 해당 과목에 강의 가능한 교사 목록 출력
     procGetTeachersForSubject(psubseq, vteacherlist);
     
     --
     LOOP
        FETCH v_teacherlist INTO v_teachername;
        EXIT WHEN v_teacherlist%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('강의 가능한 교사 목록:');
         DBMS_OUTPUT.PUT_LINE('과목명: ' || vSubjectName);
        DBMS_OUTPUT.PUT_LINE('과목번호: ' || psubseq);
        DBMS_OUTPUT.PUT_LINE('교사명: ' || v_teachername);
      END LOOP;      
   
    -- 선택한 정보로 신규 과목 등록
    INSERT INTO tblsubjectlist (subjectListSeq, subSeq, SUBJECTSTARTDATE, SUBJECTFINISHDATE, BookSEQ, teacherSEQ)
    VALUES (vSubjectListSeq, vSubjectSeq, vStartDate, vEndDate, vBookSeq, vTeacherSeq);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('신규 과목 등록이 완료되었습니다.');
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('오류: 해당 정보로 등록할 수 없습니다.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('오류: ' || SQLERRM);
            ROLLBACK;
 
END procInsertSubject;
/


DECLARE
    vCourseSeq tblsubjectlist.courseSeq%TYPE := 7;  -- 원하는 과정 번호로 설정
    vStartDate DATE := TO_DATE('2023-11-09', 'yyyy-mm-dd');
    vEndDate DATE := TO_DATE('2024-01-01', 'yyyy-mm-dd');
    vSubjectName tblsubject.SUBNAME%TYPE := 'java';
    vBookName tblbook.BookNAME%TYPE := '자바 알고리즘 인터뷰';
    vTeacherName tblteacher.name%TYPE := '김형우';
BEGIN
    procInsertSubject(vCourseSeq, vStartDate, vEndDate, vSubjectName, vBookName, vTeacherName);
END;
/

set SERVEROUTPUT on;