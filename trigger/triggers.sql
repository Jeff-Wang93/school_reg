-- check lecture inserts to find conflicts
DROP TRIGGER IF EXISTS before_lecture_insert ON lecture_info;
CREATE TRIGGER before_lecture_insert
BEFORE INSERT ON lecture_info
FOR EACH ROW
EXECUTE PROCEDURE lecture_insert();

-- check discussion inserts to find conflicts
DROP TRIGGER IF EXISTS before_discussion_insert ON discussion_info;
CREATE TRIGGER before_discussion_insert
BEFORE INSERT ON discussion_info
FOR EACH ROW
EXECUTE PROCEDURE discussion_insert();

-- check discussion inserts to find conflicts
DROP TRIGGER IF EXISTS before_lab_insert ON lab_info;
CREATE TRIGGER before_lab_insert
BEFORE INSERT ON lab_info
FOR EACH ROW
EXECUTE PROCEDURE lab_insert();

-- Check if the enrollment limit has been met or not
DROP TRIGGER IF EXISTS before_enroll_insert ON enrolled_student;
CREATE TRIGGER before_enroll_insert 
BEFORE INSERT ON enrolled_student
FOR EACH ROW
EXECUTE PROCEDURE enroll_insert();

-- Check if professor can teach desired class with given schedule
DROP TRIGGER IF EXISTS before_faculty_insert ON faculty_teaching;
CREATE TRIGGER before_faculty_insert
BEFORE INSERT ON faculty_teaching
FOR EACH ROW
EXECUTE PROCEDURE assign_prof();

