-- check lecture inserts to find any conflicts between THE SAME SECTION
CREATE OR REPLACE FUNCTION lecture_insert() RETURNS trigger AS
$BODY$
    DECLARE
        no_conflict BOOLEAN = FALSE;
        sec_id INTEGER;

    BEGIN
        DROP TABLE IF EXISTS sec;
        CREATE TEMP TABLE sec AS
        SELECT course_id 
        FROM current_quarter
        WHERE section_number = new.section_id;

        sec_id = (SELECT * FROM sec LIMIT 1);

        -- check to see if there's a conflict in lectures
        if exists(
        SELECT * 
        FROM lecture_info 
        WHERE lecture_info_time   = new.lecture_info_time 
            AND lecture_info_day  = new.lecture_info_day
            AND (section_id = new.section_id OR course_id = sec_id))

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
            AND (section_id = new.section_id OR course_id = sec_id))

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
            AND (section_id = new.section_id OR course_id = sec_id))

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
                                DEFAULT, new.section_id, sec_id);
                 END IF;
        END IF;
        RETURN NULL;
    END;
$BODY$
LANGUAGE plpgsql;

-- check discussion inserts to find any conflicts between the SAME SECTION
CREATE OR REPLACE FUNCTION discussion_insert() RETURNS trigger AS
$BODY$
    DECLARE
        no_conflict BOOLEAN = FALSE;
        sec_id INTEGER;

    BEGIN
        DROP TABLE IF EXISTS sec;
        CREATE TEMP TABLE sec AS
        SELECT course_id 
        FROM current_quarter
        WHERE section_number = new.section_id;

        sec_id = (SELECT * FROM sec LIMIT 1);

        -- check to see if there's a conflict in lectures
        if exists(
        SELECT * 
        FROM lecture_info 
        WHERE lecture_info_time   = new.discussion_info_time 
            AND lecture_info_day  = new.discussion_info_day
            AND (section_id = new.section_id OR course_id = sec_id))

        -- a result was returned. This means there is a conflict
            THEN RAISE EXCEPTION 'Lecture Schedule Conflict -- ';
                 no_conflict = TRUE;
                 RETURN NULL;
        END IF;

        -- check to see if there's a conflict in discussions
        if exists(
        SELECT * 
        FROM discussion_info 
        WHERE discussion_info_time   = new.discussion_info_time 
            AND discussion_info_day  = new.discussion_info_day
            AND (section_id = new.section_id OR course_id = sec_id))

        -- a result was returned. This means there is a conflict
            THEN RAISE EXCEPTION 'Discussion Schedule Conflict -- ';
                 no_conflict = TRUE;
                 RETURN NULL;
        END IF;

        -- check to see if there's a conflict in labs
        if exists(
        SELECT * 
        FROM lab_info 
        WHERE lab_info_time    = new.discussion_info_time 
            AND lab_info_day   = new.discussion_info_day
            AND (section_id = new.section_id OR course_id = sec_id))

        -- a result was returned. This means there is a conflict
            THEN RAISE EXCEPTION 'Lab Schedule Conflict -- ';
                 no_conflict = TRUE;
                 RETURN NULL;
        END IF;

        IF no_conflict IS FALSE
            THEN IF pg_trigger_depth() <> 1
                    THEN RETURN new;

                 ELSE
                 INSERT INTO discussion_info 
                        VALUES (new.discussion_info_time, new.discussion_info_day, 
                                DEFAULT, new.section_id, sec_id);
                 END IF;
        END IF;
        RETURN NULL;
    END;
$BODY$
LANGUAGE plpgsql;

-- check lab inserts to find any conflicts between the SAME SECTION?
CREATE OR REPLACE FUNCTION lab_insert() RETURNS trigger AS
$BODY$
    DECLARE
        no_conflict BOOLEAN = FALSE;
        sec_id INTEGER;

    BEGIN
        DROP TABLE IF EXISTS sec;
        CREATE TEMP TABLE sec AS
        SELECT course_id 
        FROM current_quarter
        WHERE section_number = new.section_id;

        sec_id = (SELECT * FROM sec LIMIT 1);

        -- check to see if there's a conflict in lectures
        if exists(
        SELECT * 
        FROM lecture_info 
        WHERE lecture_info_time   = new.lab_info_time 
            AND lecture_info_day  = new.lab_info_day
            AND (section_id = new.section_id OR course_id = sec_id))

        -- a result was returned. This means there is a conflict
            THEN RAISE EXCEPTION 'Lecture Schedule Conflict -- ';
                 no_conflict = TRUE;
                 RETURN NULL;
        END IF;

        -- check to see if there's a conflict in discussions
        if exists(
        SELECT * 
        FROM discussion_info 
        WHERE discussion_info_time   = new.lab_info_time
            AND discussion_info_day  = new.lab_info_day
            AND (section_id = new.section_id OR course_id = sec_id))

        -- a result was returned. This means there is a conflict
            THEN RAISE EXCEPTION 'Discussion Schedule Conflict -- ';
                 no_conflict = TRUE;
                 RETURN NULL;
        END IF;

        -- check to see if there's a conflict in labs
        if exists(
        SELECT * 
        FROM lab_info 
        WHERE lab_info_time    = new.lab_info_time 
            AND lab_info_day   = new.lab_info_day
            AND (section_id = new.section_id OR course_id = sec_id))

        -- a result was returned. This means there is a conflict
            THEN RAISE EXCEPTION 'Lab Schedule Conflict -- ';
                 no_conflict = TRUE;
                 RETURN NULL;
        END IF;

        IF no_conflict IS FALSE
            THEN IF pg_trigger_depth() <> 1
                    THEN RETURN new;

                 ELSE
                 INSERT INTO lab_info 
                        VALUES (new.lab_info_time, new.lab_info_day, 
                                DEFAULT, new.section_id, sec_id);
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

-- check to see if a professor has conflicts between his/her assigned classes
CREATE OR REPLACE FUNCTION assign_prof() RETURNS trigger AS
$BODY$
    DECLARE
        conflict_name VARCHAR(50);

    BEGIN
        -- get the classes a teacher already teaches and store that as a view
        DROP TABLE IF EXISTS busy_time;
        CREATE TEMP TABLE busy_time AS
        SELECT lecture_info_time, lecture_info_day, 'lecture' as name
        FROM lecture_info 
        WHERE section_id IN (SELECT section 
                             FROM faculty_teaching 
                             WHERE faculty_name = new.faculty_name)
        UNION 
        SELECT discussion_info_time, discussion_info_day, 'discussion' as name
        FROM discussion_info
        WHERE section_id IN (SELECT section 
                             FROM faculty_teaching 
                             WHERE faculty_name = new.faculty_name)
        UNION 
        SELECT lab_info_time, lab_info_day, 'lab' as name
        FROM lab_info
        WHERE section_id IN (SELECT section 
                             FROM faculty_teaching 
                             WHERE faculty_name = new.faculty_name);


        -- get the information from the class the teacher wants to teach
        DROP TABLE IF EXISTS desired_time;
        CREATE TEMP TABLE desired_time AS
        SELECT lecture_info_time, lecture_info_day, 'lecture' as name
        FROM lecture_info
        WHERE section_id = new.section
        UNION 
        SELECT discussion_info_time, discussion_info_day, 'discussion' as name
        FROM discussion_info
        WHERE section_id = new.section
        UNION 
        SELECT lab_info_time, lab_info_day, 'lab' as name
        FROM lab_info
        WHERE section_id = new.section;

        DROP TABLE IF EXISTS conflict_table;
        CREATE TEMP TABLE conflict_table AS
        SELECT * FROM busy_time INTERSECT SELECT * FROM desired_time;

        -- compare the two tables and see if there's any matches
        IF EXISTS ( SELECT * FROM busy_time INTERSECT SELECT * FROM desired_time )
            THEN RAISE EXCEPTION 'Professor has time conflict. Conflict:(Meeting Type: %)(Time: %)(Day: %) -- ', 
                (SELECT name FROM conflict_table LIMIT 1),
                (SELECT lecture_info_time FROM conflict_table LIMIT 1),
                (SELECT lecture_info_day FROM conflict_table LIMIT 1);
            RETURN NULL;
        ELSE
            IF pg_trigger_depth() <> 1
                THEN RETURN new;
            ELSE
                INSERT INTO faculty_teaching
                   VALUES(new.faculty_name, new.course_id, new.section, 
                          new.quarter, new.year);
            END IF;
        END IF;
        RETURN NULL;
    END;
$BODY$
LANGUAGE plpgsql;

-- function for CPGQ "view"
-- on previous_class input, update the "view"
CREATE OR REPLACE FUNCTION insert_cpgq() RETURNS trigger AS
$BODY$
    DECLARE
        prof_name VARCHAR(50);

    BEGIN
        prof_name = (SELECT faculty_name
                     FROM faculty_teaching
                     WHERE quarter = substr(new.quarter, 1, 2) 
                     AND year = substr(new.quarter, 3, 4)
                     AND course_id = new.course_id);

        -- if it's a grade we havent seen yet, add it
        IF NOT EXISTS(SELECT a_count
                      FROM cpgq
                      WHERE course_id = new.course_id
                      AND quarter = new.quarter
                      AND a_name LIKE substr(new.grade,1,1) || '%' 
                      AND faculty_name IN (SELECT faculty_name 
                                           FROM faculty_teaching
                                           WHERE quarter = substr(new.quarter, 1, 2) 
                                                 AND year = substr(new.quarter, 3, 4)
                                                 AND course_id = new.course_id))
            THEN INSERT INTO cpgq 
                    VALUES (prof_name, new.course_id, new.quarter, 1, substr(new.grade,1,1));
        ELSE
            -- If inserted, just add one to the count if exists
            UPDATE CPGQ
            SET a_count = a_count + 1
            WHERE course_id = new.course_id
            AND quarter = new.quarter
            AND a_name LIKE substr(new.grade,1,1) || '%'
            AND faculty_name IN (SELECT faculty_name 
                                 FROM faculty_teaching
                                 WHERE quarter = substr(new.quarter, 1, 2) 
                                       AND year = substr(new.quarter, 3, 4)
                                       AND course_id = new.course_id);
        END IF;
        RETURN NEW;
    END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_cpgq() RETURNS trigger AS
$BODY$
    DECLARE
        prof_name VARCHAR(50);

    BEGIN
        prof_name = (SELECT faculty_name
                     FROM faculty_teaching
                     WHERE quarter = substr(new.quarter, 1, 2) 
                     AND year = substr(new.quarter, 3, 4)
                     AND course_id = new.course_id);

        -- if the grade doesnt exist, add it in
        IF NOT EXISTS(SELECT a_name
                  FROM cpgq
                  WHERE course_id = new.course_id
                  AND quarter = new.quarter
                  AND a_name LIKE substr(new.grade,1,1) || '%'
                  AND faculty_name IN (SELECT faculty_name 
                                       FROM faculty_teaching
                                       WHERE quarter = substr(new.quarter, 1, 2) 
                                             AND year = substr(new.quarter, 3, 4)
                                             AND course_id = new.course_id))
        THEN INSERT INTO cpgq 
                VALUES (prof_name, new.course_id, new.quarter, 1, substr(new.grade,1,1));

        --if updated, subtract one from old grade then add to the new
        ELSE
                        
            UPDATE CPGQ
            SET a_count = a_count + 1
            WHERE course_id = new.course_id
            AND quarter = new.quarter
            AND a_name LIKE substr(new.grade,1,1) || '%'
            AND faculty_name IN (SELECT faculty_name 
                                 FROM faculty_teaching
                                 WHERE quarter = substr(new.quarter, 1, 2) 
                                       AND year = substr(new.quarter, 3, 4)
                                       AND course_id = new.course_id);
        END IF;

        -- regardless, subtract when updating
        UPDATE CPGQ
            SET a_count = a_count - 1
            WHERE course_id = new.course_id
            AND quarter = new.quarter
            AND a_name LIKE substr(old.grade,1,1) || '%'
            AND faculty_name IN (SELECT faculty_name 
                                 FROM faculty_teaching
                                 WHERE quarter = substr(new.quarter, 1, 2) 
                                       AND year = substr(new.quarter, 3, 4)
                                       AND course_id = new.course_id);

        RETURN NEW;
    END;
$BODY$
LANGUAGE plpgsql;

-- function for CPG "view"
-- on previous_class input, update the "view"
CREATE OR REPLACE FUNCTION insert_cpg() RETURNS trigger AS
$BODY$
    DECLARE
        prof_name VARCHAR(50);

    BEGIN
        prof_name = (SELECT faculty_name
                     FROM faculty_teaching
                     WHERE quarter = substr(new.quarter, 1, 2) 
                     AND year = substr(new.quarter, 3, 4)
                     AND course_id = new.course_id);

        -- if it's a grade we havent seen yet, add it
        IF NOT EXISTS(SELECT total_num
                      FROM cpg
                      WHERE course_id = new.course_id
                      --AND quarter = new.quarter
                      AND a_name LIKE substr(new.grade,1,1) || '%' 
                      AND faculty_name IN (SELECT faculty_name 
                                           FROM faculty_teaching
                                           WHERE quarter = substr(new.quarter, 1, 2) 
                                                 AND year = substr(new.quarter, 3, 4)
                                                 AND course_id = new.course_id))
            THEN INSERT INTO cpg 
                    VALUES (prof_name, new.course_id, 1, substr(new.grade,1,1));
        ELSE
            -- If inserted, just add one to the count if exists
            UPDATE CPG
            SET total_num = total_num + 1
            WHERE course_id = new.course_id
            --AND quarter = new.quarter
            AND a_name LIKE substr(new.grade,1,1) || '%'
            AND faculty_name IN (SELECT faculty_name 
                                 FROM faculty_teaching
                                 WHERE quarter = substr(new.quarter, 1, 2) 
                                       AND year = substr(new.quarter, 3, 4)
                                       AND course_id = new.course_id);
        END IF;
        RETURN NEW;
    END;
$BODY$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_cpg() RETURNS trigger AS
$BODY$
    DECLARE
        prof_name VARCHAR(50);

    BEGIN
        prof_name = (SELECT faculty_name
                     FROM faculty_teaching
                     WHERE quarter = substr(new.quarter, 1, 2) 
                     AND year = substr(new.quarter, 3, 4)
                     AND course_id = new.course_id);

        -- if the grade doesnt exist, add it in
        IF NOT EXISTS(SELECT total_num
                  FROM cpg
                  WHERE course_id = new.course_id
                  --AND quarter = new.quarter
                  AND a_name LIKE substr(new.grade,1,1) || '%'
                  AND faculty_name IN (SELECT faculty_name 
                                       FROM faculty_teaching
                                       WHERE quarter = substr(new.quarter, 1, 2) 
                                             AND year = substr(new.quarter, 3, 4)
                                             AND course_id = new.course_id))
        THEN INSERT INTO cpg 
                VALUES (prof_name, new.course_id, 1, substr(new.grade,1,1));

        --if updated, subtract one from old grade then add to the new
        ELSE
                        
            UPDATE CPG
            SET total_num = total_num + 1
            WHERE course_id = new.course_id
            --AND quarter = new.quarter
            AND a_name LIKE substr(new.grade,1,1) || '%'
            AND faculty_name IN (SELECT faculty_name 
                                 FROM faculty_teaching
                                 WHERE quarter = substr(new.quarter, 1, 2) 
                                       AND year = substr(new.quarter, 3, 4)
                                       AND course_id = new.course_id);
        END IF;

        -- regardless, subtract when updating
        UPDATE CPG
            SET total_num = total_num - 1
            WHERE course_id = new.course_id
            --AND quarter = new.quarter
            AND a_name LIKE substr(old.grade,1,1) || '%'
            AND faculty_name IN (SELECT faculty_name 
                                 FROM faculty_teaching
                                 WHERE quarter = substr(new.quarter, 1, 2) 
                                       AND year = substr(new.quarter, 3, 4)
                                       AND course_id = new.course_id);

        RETURN NEW;
    END;
$BODY$
LANGUAGE plpgsql;
