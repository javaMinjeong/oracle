SELECT  
    (SELECT SUBNAME FROM tblsubject sj WHERE sl.SUBSEQ = sj.SUBSEQ) AS "과목명",
    TO_CHAR(sl.subjectStartDate, 'yyyy-mm-dd') AS "과목시작일자",
    TO_CHAR(sl.subjectFinishDate, 'yyyy-mm-dd') AS "과목종료일자",
    (SELECT BookNAME FROM tblbook b WHERE sl.BookSEQ = b.BookSEQ) AS "교재명",
    (SELECT name FROM tblteacher t WHERE sl.teacherseq = t.teacherSEQ) AS "교사명"
FROM vwCourseList cu
LEFT JOIN tblsubjectlist sl
    ON cu."과정번호" = sl.COURSESEQ
WHERE cu."과정번호" = 1    
    ORDER BY cu."과정번호";
    
----
drop procedure procCourseSbjInsSbj;
commit;

--개설 과목 관리
--특정 개설 과정 선택 후 개설 과목 검색( 개설 과목 정보(과목명, 과목기간(시작 년월일, 끝 년월일), 교재명, 교사명)) 및 신규 과목 등록
CREATE OR REPLACE PROCEDURE procCourseSbjInsSbj (

    vcourseSeq IN NUMBER
) AS
BEGIN
    FOR subj IN (
        SELECT  
            (SELECT SUBNAME FROM tblsubject sj WHERE sl.SUBSEQ = sj.SUBSEQ) AS "과목명",
            TO_CHAR(sl.subjectStartDate, 'yyyy-mm-dd') AS "과목시작일자",
            TO_CHAR(sl.subjectFinishDate, 'yyyy-mm-dd') AS "과목종료일자",
            (SELECT BookNAME FROM tblbook b WHERE sl.BookSEQ = b.BookSEQ) AS "교재명",
            (SELECT name FROM tblteacher t WHERE sl.teacherseq = t.teacherSEQ) AS "교사명"
        FROM vwCourseList cu
        LEFT JOIN tblsubjectlist sl
            ON cu."과정번호" = sl.COURSESEQ
        WHERE cu."과정번호" = vcourseSeq    
            ORDER BY cu."과정번호"
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('과목명: ' || subj."과목명");
        DBMS_OUTPUT.PUT_LINE('과목시작일자: ' || subj."과목시작일자");
        DBMS_OUTPUT.PUT_LINE('과목종료일자: ' || subj."과목종료일자");
        DBMS_OUTPUT.PUT_LINE('교재명: ' || subj."교재명");
        DBMS_OUTPUT.PUT_LINE('교사명: ' || subj."교사명");
        DBMS_OUTPUT.PUT_LINE('---------------------------------------------------'); 
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류: ' || SQLERRM);

END procCourseSbjInsSbj;
/

-- 개설 과목 정보를 출력하기 위한 프로시저 호출
DECLARE
    pcourseSeq NUMBER := 1; -- 원하는 과정 번호를 입력하세요
BEGIN
   procCourseSbjInsSbj(pcourseSeq);
END;
/
commit;
