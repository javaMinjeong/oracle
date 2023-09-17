drop procedure procInsertSubject;
commit;

CREATE OR REPLACE PROCEDURE procInsertSubject (
    vCourseSeq IN tblsubjectlist.courseSeq%TYPE,
    vStartDate IN DATE,
    vEndDate IN DATE,
    vSubjectSeq IN tblsubject.subSeq%TYPE,
    vBookSeq IN tblbook.BookSEQ%TYPE,
    vTeacherSeq IN tblteacher.teacherSEQ%TYPE -- 추가: 교사 번호를 입력 매개 변수로 받음
) IS
    vSubjectListSeq tblsubjectlist.subjectListSeq%TYPE;
    vCurrentDate DATE := SYSDATE;
BEGIN
 
    DBMS_OUTPUT.PUT_LINE('과정 번호: ' || vCourseSeq);
    DBMS_OUTPUT.PUT_LINE('과목 시작일자: ' || TO_CHAR(vStartDate, 'yyyy-mm-dd'));
    DBMS_OUTPUT.PUT_LINE('과목 종료일자: ' || TO_CHAR(vEndDate, 'yyyy-mm-dd'));
    DBMS_OUTPUT.PUT_LINE('과목 번호: ' || vSubjectSeq);
    
    -- 과목 목록 번호 설정 (마지막 번호에 1 추가)
    SELECT NVL(MAX(subjectListSeq), 0) + 1 INTO vSubjectListSeq FROM tblsubjectlist;

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
    
    -- 교재 목록
    DBMS_OUTPUT.PUT_LINE('-----교재목록---------');
    procShowAllBook; -- 교재 목록 보여주기
    DBMS_OUTPUT.PUT_LINE('-------------------');

    -- 교사 코드를 추출하고 반환
    DBMS_OUTPUT.PUT_LINE('-----교사목록-------');
    procGetTeacherInfoForSubject(vSubjectSeq);
    DBMS_OUTPUT.PUT_LINE('-------------------');
    
    -- 선택한 정보로 신규 과목 등록
    INSERT INTO tblsubjectlist (subjectListSeq, courseSeq, subSeq, SUBJECTSTARTDATE, SUBJECTFINISHDATE, BookSEQ, teacherSEQ)
    VALUES (vSubjectListSeq, vCourseSeq, vSubjectSeq, vStartDate, vEndDate, vBookSeq, vTeacherSeq);

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
    vCourseSeq tblsubjectlist.courseSeq%TYPE := 7; -- 원하는 과정 번호로 설정
    vStartDate DATE := TO_DATE('2023-11-09', 'yyyy-mm-dd');
    vEndDate DATE := TO_DATE('2024-01-01', 'yyyy-mm-dd');
    vSubjectSeq tblsubject.subSeq%TYPE := 4; -- 원하는 과목 번호로 설정
    vBookSeq tblbook.BookSEQ%TYPE; -- 교재 번호를 입력 받을 변수 추가
    vTeacherSeq tblteacher.teacherSEQ%TYPE;
BEGIN
    -- 교재 번호를 사용자로부터 입력 받음
    vBookSeq := TO_NUMBER(&vBookSeq); -- 사용자 입력 받기

    -- 교사 번호를 사용자로부터 입력 받음
    vTeacherSeq := TO_NUMBER(&vTeacherSeq); -- 사용자 입력 받기

    procInsertSubject(vCourseSeq, vStartDate, vEndDate, vSubjectSeq, vBookSeq, vTeacherSeq);
    DBMS_OUTPUT.PUT_LINE('교재 번호: ' || vBookSeq);
    DBMS_OUTPUT.PUT_LINE('교사 번호: ' || vTeacherSeq);
    DBMS_OUTPUT.PUT_LINE('과목 등록이 완료되었습니다.');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류: ' || SQLERRM);
        ROLLBACK;
END;
/

select * from tblcourse;
select * from tblsubjectlist;
