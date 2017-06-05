DROP TRIGGER IF EXISTS before_lecture_insert ON lecture_info;
CREATE TRIGGER before_lecture_insert
BEFORE INSERT ON lecture_info
FOR EACH ROW
EXECUTE PROCEDURE lecture_insert();

-- Check if the enrollment limit has been met or not
DROP TRIGGER IF EXISTS before_enroll_insert ON enrolled_student;
CREATE TRIGGER before_enroll_insert 
BEFORE INSERT ON enrolled_student
FOR EACH ROW
EXECUTE PROCEDURE enroll_insert();

