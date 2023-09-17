--개설 과목 목록 조회// 과정 정보(과정명, 과정기간(시작 년월일, 끝 년월일), 강의실)와 과목명, 과목기간(시작 년월일, 끝 년월일), 교재명, 교사명

SELECT  
    cu.*,
    (SELECT SUBNAME FROM tblsubject sj WHERE sl.SUBSEQ = sj.SUBSEQ) AS "과목명",
    TO_CHAR(sl.subjectStartDate, 'yyyy-mm-dd') AS "과목시작일자",
    TO_CHAR(sl.subjectFinishDate, 'yyyy-mm-dd') AS "과목종료일자",
    (SELECT BookNAME FROM tblbook b WHERE sl.BookSEQ = b.BookSEQ) AS "교재명",
    (SELECT name FROM tblteacher t WHERE sl.teacherseq = t.teacherSEQ) AS "교사명"
FROM vwCourseList cu
LEFT JOIN tblsubjectlist sl
    ON cu."과정번호" = sl.COURSESEQ
WHERE cu."과정번호" = 1
    AND cu."과목등록여부" = 'Y'
ORDER BY cu."과정번호";


--개설과목 수정 UPDATE
SELECT * FROM TBLSUBJECTLIST;

rollback;
commit;
--과목 수정
UPDATE tblsubjectlist
    SET subSeq = 2   -- 수정할 과목번호
WHERE courseSeq = 1  -- 수정할 과정번호
  AND subSeq = 1;    -- 수정할 개설과목번호

--과목 시작, 종료일 수정
UPDATE tblsubjectlist
SET subjectStartDate =      --과목시작일
WHERE courseSeq  =          --수정할 개설과정번호
    and subSeq =    ;        --수정할개설과목번호
    
 UPDATE tblsubjectlist
SET  subjectFinishDate =        --과목 종료일
WHERE courseSeq  =              --수정할 개설과정번호
    and subSeq =;               --수정할 개설과목번호

--교재 수정
UPDATE tblsubjectlist
SET bookseq = 3           -- 수정할 교재번호
WHERE courseSeq = 1       -- 수정할 과정번호
     and subSeq = 1 ;     -- 수정할 개설과목번호

--교사 수정
UPDATE tblsubjectlist
SET teacherSeq = 1  -- 수정할 교사번호
WHERE courseSeq = 1 -- 수정할 과정번호
  AND subSeq = 1;   -- 수정할 개설과목번호
 
 drop  procedure procUpdateSubjectInCourse;
 commit;
 
--개설과목번호  수정 UPDATE PROCEDURE

CREATE OR REPLACE PROCEDURE procUpdateSubCourse(
    pcourseSeq IN NUMBER,
    psubSeq IN NUMBER,
    pnewSubSeq IN NUMBER
) AS
    vSubExists NUMBER;
BEGIN
      -- 선택한 과정(pcourseSeq)의 특정 과목(psubSeq)이 tblsubject 테이블에 있는지 확인
    SELECT subSeq
    INTO vSubExists
    FROM tblsubject
    WHERE subseq = pnewSubSeq;

    -- 만약 해당 과목이 존재하지 않으면 오류 처리
    IF vSubExists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('입력한 과목 번호가 존재하지 않습니다. 과목번호를 확인해주세요.');
        RETURN;
    END IF;

    -- 선택한 과정(pcourseSeq)의 특정 과목(psubSeq)을 새로운 과목(pnewSubtSeq)으로 변경
    UPDATE tblsubjectlist
     SET subSeq = pnewSubSeq
    WHERE courseSeq = pcourseSeq
      AND subSeq = psubSeq;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('과목이 수정되었습니다.');
    DBMS_OUTPUT.PUT_LINE('과정번호: ' || pcourseSeq);
    DBMS_OUTPUT.PUT_LINE('변경 된 과목번호: ' || pnewSubSeq);
EXCEPTION
     WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('과목 수정 중 오류가 발생했습니다.');
        DBMS_OUTPUT.PUT_LINE('오류 메시지: ' || SQLERRM);
END;
/

-- 프로시저 호출
DECLARE
    vcourseSeq NUMBER := 2;        -- 선택한 과정 번호
    vsubSeq NUMBER := 1;           -- 수정하려는 과목 번호
    vnewSubSeq NUMBER := 50;        -- 새로운 과목 번호
BEGIN
    procUpdateSubCourse(vcourseSeq, vsubSeq, vnewSubSeq);
END;
/
--
rollback;


select * from tblsubject;

 select * from tblsubjectlist;
 drop procedure procUpdateSubBookCu;
 commit;
 
--개설과목 교재 수정 procedure 
CREATE OR REPLACE PROCEDURE procUpdateSubBookCu(
    pCourseSeq NUMBER,
    pSubSeq NUMBER,
    pNewBookID NUMBER
) AS
    vBookExists NUMBER;
BEGIN
    -- 교재 번호가 tblbook 테이블에 존재하는지 확인
    SELECT bookSeq
    INTO vBookExists
    FROM tblbook
    WHERE bookSeq= pNewBookID;

    -- 교재가 존재하지 않으면 교재 변경 실패
    IF vBookExists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('입력한 교재 번호가 존재하지 않습니다. 교재번호를 확인해주세요.');
    ELSE
        -- 과목 목록에서 과정과 과목이 일치하는 레코드를 찾아 교재 번호 변경
        UPDATE tblsubjectlist
        SET bookSeq = pNewBookID
        WHERE courseSeq = pCourseSeq
          AND subSeq = pSubSeq;

        -- 변경된 내용을 확인하기 위해 커밋
        COMMIT;

        DBMS_OUTPUT.PUT_LINE('교재가 변경되었습니다.');
        DBMS_OUTPUT.PUT_LINE('과정번호: ' || pCourseSeq);
        DBMS_OUTPUT.PUT_LINE('과목번호: ' || pSubSeq);
        DBMS_OUTPUT.PUT_LINE('변경된 교재번호: ' || pNewBookID);
    END IF;
    EXCEPTION
         WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('데이터가 없습니다. 변경이 실패했습니다.');
         WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('교재 변경 중 오류가 발생했습니다.');
            DBMS_OUTPUT.PUT_LINE('오류 메시지: ' || SQLERRM);
END;
/
--호출 
DECLARE
    vCourseSeq NUMBER := 1;         -- 사용자로부터 입력받은 과정 번호
    vSubSeq NUMBER := 2;            -- 사용자로부터 입력받은 과목 번호
    vNewBookID NUMBER := 101;       -- 사용자로부터 입력받은 변경할 교재 번호
BEGIN
    procUpdateSubBookCu(vCourseSeq, vSubSeq, vNewBookID);
END;
/
 rollback;
 
 select * from tblsubjectlist;
 commit;
 
 drop procedure procUpdateTeacherSublist;
 commit;
 -- 개설 교사 수정
 CREATE OR REPLACE PROCEDURE procUpdateTeacherSublist(
    pCourseSeq IN NUMBER,
    pSubSeq IN NUMBER,
    pNewTeacherSeq IN NUMBER
) AS
    vAvailableTeacherSeq NUMBER;
BEGIN
    -- 선택한 과정(pCourseSeq)과 과목(pSubSeq)에 대한 tblAvailableSubject의 교사 코드 확인
    SELECT teacherSeq
        INTO vAvailableTeacherSeq
    FROM tblAvailableSubject
        WHERE teacherSeq = pNewTeacherSeq
             AND subSeq = pSubSeq;

    -- 입력한 교사 코드(pNewTeacherSeq)와 tblAvailableSubject의 교사 코드가 일치하지 않으면 오류 처리
    IF vAvailableTeacherSeq <> pNewTeacherSeq THEN
        DBMS_OUTPUT.PUT_LINE('입력한 교사 코드와 해당 과목의 교사 코드가 일치하지 않습니다. 교사 번호를 확인해주세요.');
        RETURN;
    END IF;

    -- 선택한 과정(pCourseSeq)의 특정 과목(pSubSeq)의 교사 변경
    UPDATE tblsubjectlist
    SET teacherSeq = pNewTeacherSeq
    WHERE courseSeq = pCourseSeq
      AND subSeq = pSubSeq;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('교사가 변경되었습니다.');
    DBMS_OUTPUT.PUT_LINE('과정번호: ' || pCourseSeq);
    DBMS_OUTPUT.PUT_LINE('과목번호: ' || pSubSeq);
    DBMS_OUTPUT.PUT_LINE('새로운 교사 코드: ' || pNewTeacherSeq);
EXCEPTION
     WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('데이터가 없습니다. 변경이 실패했습니다.');
     WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('교사 변경 중 오류가 발생했습니다.');
        DBMS_OUTPUT.PUT_LINE('오류 메시지: ' || SQLERRM);
END;
/
 
 DECLARE
    vCourseSeq NUMBER := 1;             -- 사용자로부터 입력받은 과정 번호
    vSubSeq NUMBER := 14;                -- 사용자로부터 입력받은 과목 번호
    vNewTeacherSeq NUMBER := 1;       -- 사용자로부터 입력받은 변경할 교사 코드
BEGIN
    procUpdateTeacherSublist(vCourseSeq, vSubSeq, vNewTeacherSeq);
END;
/
select * from tblsubjectlist;
select * From tblavailablesubject;
rollback;

commit;

--과목 시작일 변경
CREATE OR REPLACE PROCEDURE procUpdateSubStartDate(
    pCourseSeq IN NUMBER,
    pSubSeq IN NUMBER,
    pNewStartDate IN DATE
) AS
    vCurrentDate DATE := SYSDATE;  -- 현재 날짜 가져오기
BEGIN
    -- 현재 날짜 이후인지 확인
    IF pNewStartDate <= vCurrentDate THEN
        DBMS_OUTPUT.PUT_LINE('과목 시작일은 현재 날짜 이후로만 수정 가능합니다.');
        RETURN;  -- 업데이트 거부
    END IF;

    -- 과목 시작일 업데이트
    UPDATE tblsubjectList
    SET subjectStartDate = pNewStartDate
    WHERE courseSeq = pCourseSeq
      AND subSeq = pSubSeq;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('과목 시작일이 수정되었습니다.');
    DBMS_OUTPUT.PUT_LINE('과정번호: ' || pCourseSeq);
    DBMS_OUTPUT.PUT_LINE('과목번호: ' || pSubSeq);
    DBMS_OUTPUT.PUT_LINE('새로운 시작일: ' || TO_CHAR(pNewStartDate, 'YYYY-MM-DD'));
EXCEPTION
     WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('과목 시작일 수정 중 오류가 발생했습니다.');
        DBMS_OUTPUT.PUT_LINE('오류 메시지: ' || SQLERRM);
END;
/

--호출
DECLARE
    vCourseSeq NUMBER := 1;             -- 사용자로부터 입력받은 개설 과정 번호
    vSubSeq NUMBER := 1;                -- 사용자로부터 입력받은 개설 과목 번호
    vNewStartDate DATE := TO_DATE('2022-09-01', 'YYYY-MM-DD');  -- 변경할 시작 날짜
BEGIN
    procUpdateSubStartDate(vCourseSeq, vSubSeq, vNewStartDate);
END;
/

drop procedure procUpdateSubFinishDate;
commit;

--과목종료일 변경
CREATE OR REPLACE PROCEDURE procUpdateSubFinishDate(
    pCourseSeq IN NUMBER,
    pSubSeq IN NUMBER,
    pNewFinishDate IN DATE
) AS
    vCurrentDate DATE := SYSDATE;  -- 현재 날짜 가져오기
BEGIN
    -- 현재 날짜 이후인지 확인
    IF pNewFinishDate <= vCurrentDate THEN
        DBMS_OUTPUT.PUT_LINE('과목 종료일은 현재 날짜 이후로만 수정 가능합니다.');
        RETURN;  -- 업데이트 거부
    END IF;

    -- 과목 시작일 업데이트
    UPDATE tblsubjectList
    SET subjectFinishDate = pNewFinishDate
    WHERE courseSeq = pCourseSeq
      AND subSeq = pSubSeq;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('과목 종료일이 수정되었습니다.');
    DBMS_OUTPUT.PUT_LINE('과정번호: ' || pCourseSeq);
    DBMS_OUTPUT.PUT_LINE('과목번호: ' || pSubSeq);
    DBMS_OUTPUT.PUT_LINE('새로운 종료일: ' || TO_CHAR(pNewFinishDate, 'YYYY-MM-DD'));
EXCEPTION
     WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('과목 종료일 수정 중 오류가 발생했습니다.');
        DBMS_OUTPUT.PUT_LINE('오류 메시지: ' || SQLERRM);
END;
/

--호출
DECLARE
    vCourseSeq NUMBER := 1;             -- 사용자로부터 입력받은 개설 과정 번호
    vSubSeq NUMBER := 1;                -- 사용자로부터 입력받은 개설 과목 번호
    vNewFinishDate DATE := TO_DATE('2022-09-01', 'YYYY-MM-DD');  -- 변경할 종료 날짜
BEGIN
    procUpdateSubFinishDate(vCourseSeq, vSubSeq, vNewFinishDate);
END;
/


 
 select * from tblsubjectlist;
 rollback;
 commit;
 
 
 --개설 과목 삭제 delete
 
DELETE FROM tblsubjectlist;
WHERE courseSeq = ;

drop procedure DeleteSubjectList;
commit;

--개설과정 삭제 procedure
CREATE OR REPLACE PROCEDURE DeleteSubjectList(
    pSubjectListSeq NUMBER
) IS
    vRowCount NUMBER;
BEGIN
    -- 입력한 번호가 과목 목록에 있는지 확인
    SELECT COUNT(*)
    INTO vRowCount
    FROM tblsubjectlist
    WHERE subjectListSeq = pSubjectListSeq;

    IF vRowCount = 0 THEN
        -- 입력한 번호가 과목 목록에 없으면 오류 처리
        DBMS_OUTPUT.PUT_LINE('입력한 번호가 과목 목록에 존재하지 않습니다. 삭제가 불가능합니다.');
    ELSE
        -- 입력한 번호에 해당하는 과목 목록 삭제
        DELETE FROM tblsubjectlist
        WHERE subjectListSeq = pSubjectListSeq;
        
        commit;
        
        DBMS_OUTPUT.PUT_LINE('과목 목록 번호 ' || pSubjectListSeq || '가 삭제되었습니다.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('과목 목록 삭제 중 오류가 발생했습니다.');
END;
/

DECLARE
    vSubjectListSeq NUMBER := 56; -- 삭제할 과목 목록 번호 설정
BEGIN
    DeleteSubjectList(vSubjectListSeq);  
END;
/
 
 
 
-- 과목 등록이 N인 경우                         

    -- 개설 과목 등록
-- course update -> Y, subject list 해당과목등록   insert// 과목번호 넣고 출력>과목명, 과목기간(시작 사명년월일, 끝 년월일) , 교재명, 교사명
--insert into tblsubjectlist() values ();
-- 교재 선택 -> 교재명 목록 출력 프로시저
-- 교사 선택 -> 교사 명단 출력 프로시저
 
 update tblsubjectlist set s = 'Y' WHERE subjectRegistrationStatus =  N;
select * from tblsubjectlist    ;
