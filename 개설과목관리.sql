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
UPDATE tblsubject
SET SUBNAME = '새로운과목명'
WHERE SUBSEQ = (SELECT SUBSEQ FROM tblsubject WHERE SUBNAME = '현재과목명');

UPDATE tblsubjectlist sl
SET sl.BookSEQ = (SELECT BookSEQ FROM tblbook WHERE BookNAME = '새로운교재명')
WHERE sl.COURSESEQ = 1;
 
--개설과목 수정 UPDATE PROCEDURE
 
-- 과목 등록이 N인 경우                         
;
    -- 개설 과목 등록
-- course update -> Y, subject list 해당과목등록   insert// 과목번호 넣고 출력>과목명, 과목기간(시작 사명년월일, 끝 년월일) , 교재명, 교사명
--insert into tblsubjectlist() values ();
-- 교재 선택 -> 교재명 목록 출력 프로시저
-- 교사 선택 -> 교사 명단 출력 프로시저
 
 update tblsubjectlist set s = 'Y' WHERE subjectRegistrationStatus =  N;
select * from tblsubjectlist
    ;
