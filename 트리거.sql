--과목 등록시 과목등록 여부 변경 트리거 > N -> Y

CREATE OR REPLACE TRIGGER trgUpCourseRegistration
    BEFORE
    UPDATE
    ON tblSubjectList
    FOR EACH ROW
BEGIN
    IF :NEW.subjectRegistrationStatus = 'N' THEN
        UPDATE tblCourse
        SET subjectRegistrationStatus = 'Y'
        WHERE courseSeq = :NEW.courseSeq;
    END IF;
END;





--
CREATE OR REPLACE TRIGGER trgUpCourseRegistration
    BEFORE
    UPDATE OF subjectListSeq
    ON tblSubjectList
    FOR EACH ROW
DECLARE
    vNewSubjectRegistrationStatus VARCHAR2(1);
BEGIN
    vNewSubjectRegistrationStatus := :NEW.subjectRegistrationStatus;

    IF vNewSubjectRegistrationStatus = 'N' THEN
        UPDATE tblCourse
        SET subjectRegistrationStatus = 'Y'
        WHERE courseSeq = :NEW.courseSeq;
    END IF;
END;    
    
--BEGIN
--    IF :NEW.subjectRegistrationStatus = 'N' THEN
--        UPDATE tblCourse
--        SET subjectRegistrationStatus = 'Y'
--        WHERE courseSeq = :NEW.courseSeq;
--    END IF;
--END;

drop trigger trgUpCourseRegistration;
commit;