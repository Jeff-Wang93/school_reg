CREATE OR REPLACE FUNCTION lecture_insert() RETURNS trigger AS
$BODY$
    DECLARE
        no_conflict BOOLEAN = FALSE;

    BEGIN
        -- check to see if there's a conflict in lectures
        if exists(
        SELECT * 
        FROM lecture_info 
        WHERE lecture_info_time   = new.lecture_info_time 
            AND lecture_info_day  = new.lecture_info_day
            AND section_id        = new.section_id)

        -- a result was returned. This means there is a conflict
            THEN RAISE EXCEPTION 'Lecture Schedule Conflict -- ';
                 no_conflict = TRUE;
                 RETURN NULL;
        END IF;

        -- check to see if there's a conflict in discussions
        if exists(
        SELECT * 
        FROM discussion_info 
        WHERE discussion_info_time   = new.lecture_info_time 
            AND discussion_info_day  = new.lecture_info_day
            AND section_id           = new.section_id)

        -- a result was returned. This means there is a conflict
            THEN RAISE EXCEPTION 'Discussion Schedule Conflict -- ';
                 no_conflict = TRUE;
                 RETURN NULL;
        END IF;

        -- check to see if there's a conflict in labs
        if exists(
        SELECT * 
        FROM lab_info 
        WHERE lab_info_time    = new.lecture_info_time 
            AND lab_info_day   = new.lecture_info_day
            AND section_id     = new.section_id)

        -- a result was returned. This means there is a conflict
            THEN RAISE EXCEPTION 'Lab Schedule Conflict -- ';
                 no_conflict = TRUE;
                 RETURN NULL;
        END IF;

        IF no_conflict IS FALSE
            THEN IF pg_trigger_depth() <> 1
                    THEN RETURN new;

                 ELSE
                 INSERT INTO lecture_info 
                        VALUES (new.lecture_info_time, new.lecture_info_day, 
                                DEFAULT, new.section_id);
                 END IF;
        END IF;
        RETURN NULL;
    END;
$BODY$
LANGUAGE plpgsql;


-- Check for enrollment limits on enrolled_class insert
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
