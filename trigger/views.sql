DROP TABLE IF EXISTS CPGQ;
CREATE TABLE CPGQ AS
-- create CTEs for later joins
WITH 
    -- get all professor and course id that they taught
    prof_course AS (
        SELECT faculty_name, course_id, quarter || year AS quarter
        FROM faculty_teaching
    )

SELECT p.faculty_name, p.course_id, p.quarter, g.a_count, g.a_name 
FROM prof_course p, 
        (SELECT COUNT(grade) AS a_count, course_id, quarter, 'A' as a_name
         FROM previous_class
         WHERE grade LIKE 'A%'
         GROUP BY quarter, course_id
         UNION 
         SELECT COUNT(grade) AS b_count, course_id, quarter, 'B' as b_name
         FROM previous_class
         WHERE grade LIKE 'B%'
         GROUP BY quarter, course_id
         UNION
         SELECT COUNT(grade) AS c_count, course_id, quarter, 'C' as c_name
         FROM previous_class
         WHERE grade LIKE 'C%'
         GROUP BY quarter, course_id
         UNION
         SELECT COUNT(grade) AS d_count, course_id, quarter, 'D' as d_name
         FROM previous_class
         WHERE grade LIKE 'D%'
         GROUP BY quarter, course_id
         UNION
         SELECT COUNT(grade) AS f_count, course_id, quarter, 'F' as f_name
         FROM previous_class
         WHERE grade LIKE 'F%'
         GROUP BY quarter, course_id
        ) AS g
WHERE p.course_id = g.course_id AND p.quarter = g.quarter
ORDER BY p.faculty_name, p.quarter, p.course_id;


-- 3.a.iii, course id, prof y, grade z
-- contains count of specific grade z that prof Y has given when teaching course
-- x
-- Current status: I think it's right?
DROP TABLE IF EXISTS CPG;
CREATE TABLE CPG AS
-- create CTEs for later joins
WITH 
    -- get all professor and course id that they taught
    prof_course AS (
        SELECT faculty_name, course_id, quarter || year AS quarter
        FROM faculty_teaching
    )

SELECT p.faculty_name, p.course_id, SUM(g.a_count) AS total_num, g.a_name 
FROM prof_course p, 
        (SELECT COUNT(grade) AS a_count, course_id, quarter, 'A' as a_name
         FROM previous_class
         WHERE grade LIKE 'A%'
         GROUP BY course_id, quarter
         UNION 
         SELECT COUNT(grade) AS b_count, course_id, quarter, 'B' as b_name
         FROM previous_class
         WHERE grade LIKE 'B%'
         GROUP BY course_id, quarter
         UNION
         SELECT COUNT(grade) AS c_count, course_id, quarter, 'C' as c_name
         FROM previous_class
         WHERE grade LIKE 'C%'
         GROUP BY course_id, quarter
         UNION
         SELECT COUNT(grade) AS d_count, course_id, quarter, 'D' as d_name
         FROM previous_class
         WHERE grade LIKE 'D%'
         GROUP BY course_id, quarter
         UNION
         SELECT COUNT(grade) AS f_count, course_id, quarter, 'F' as f_name
         FROM previous_class
         WHERE grade LIKE 'F%'
         GROUP BY course_id, quarter
        ) AS g
WHERE p.course_id = g.course_id AND p.quarter = g.quarter
GROUP BY p.faculty_name, p.course_id, g.a_name, g.a_count
--ORDER BY p.faculty_name, p.quarter, p.course_id; 
