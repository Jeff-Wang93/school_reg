-- Check if the enrollment limit has been met or not
DROP TRIGGER IF EXISTS before_enroll_insert ON enrolled_student;
CREATE TRIGGER before_enroll_insert 
BEFORE INSERT ON enrolled_student
FOR EACH ROW
EXECUTE PROCEDURE enroll_insert();

CREATE OR REPLACE FUNCTION enroll_insert() RETURNS trigger AS
$BODY$
    BEGIN
            IF (SELECT enrollment 
            FROM current_enrollment 
            WHERE section_id = new.section_id) + 1 > (SELECT enroll_limit 
                                                      FROM current_enrollment 
                                                      WHERE section_id = new.section_id)
        THEN
            RAISE EXCEPTION 'Chosen Section is Full -- ';
            RETURN null;
        ELSE
            -- prevent infinite loops on insert!!!
            IF pg_trigger_depth() <> 1 
            THEN RETURN new;
            END IF;

            INSERT INTO enrolled_student 
                VALUES(new.student_id, new.section_id, new.units, new.grade_type);

            -- dont forget to increment the counter in current_enrollment
            UPDATE current_enrollment 
            SET enrollment = (SELECT enrollment 
                              FROM current_enrollment 
                              WHERE section_id = new.section_id) + 1
            WHERE section_id = new.section_id;
            RAISE NOTICE 'Inserted Successfully';

        END IF;
        RETURN null;
    END;
$BODY$
LANGUAGE plpgsql;
