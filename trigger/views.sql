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

-- each entry is prof name, course_id, quarter, grade


--DROP TABLE IF EXISTS CPG;

