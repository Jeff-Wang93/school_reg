DROP TABLE IF EXISTS course CASCADE;
CREATE TABLE public.course
(
    course_id             integer primary key,
    course_units          integer NOT NULL,
    course_grade_type     character varying(10) NOT NULL,
    course_number         character varying(10) NOT NULL,
    course_lab            character varying(10) NOT NULL,
    course_department_id  integer REFERENCES department (department_id)
)
WITH (
  OIDS=FALSE
);

DROP TABLE IF EXISTS course_prereq CASCADE;
CREATE TABLE public.course_prereq
(
    course_id INTEGER REFERENCES course (course_id),
    prereq_id INTEGER REFERENCES course (course_id)
);
