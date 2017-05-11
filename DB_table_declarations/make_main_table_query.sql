DROP TABLE IF EXISTS student CASCADE;
CREATE TABLE public.student
(
    student_ssn         integer primary key,
    student_id          integer NOT NULL,
    student_first_name  character varying(20) NOT NULL,
    student_middle_name character varying(20),
    student_last_name   character varying(20) NOT NULL,
    student_residency   character varying(10) NOT NULL,
    student_gpa	        float NOT NULL
)
WITH (
  OIDS=FALSE
);

DROP TABLE IF EXISTS faculty CASCADE;
CREATE TABLE public.faculty
(
    faculty_name      character varying(20) NOT NULL,
    faculty_title     character varying(20) NOT NULL,
    CONSTRAINT faculty_pkey PRIMARY KEY (faculty_name)
)
WITH (
  OIDS=FALSE
);

DROP TABLE IF EXISTS department CASCADE;
CREATE TABLE public.department
(
    department_id    INTEGER PRIMARY KEY,
    department_title VARCHAR(20) NOT NULL	
)
WITH (
  OIDS=FALSE
 );

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

DROP TABLE IF EXISTS classes CASCADE;
CREATE TABLE public.classes
(
    classes_id                INTEGER PRIMARY KEY,
    classes_title             VARCHAR(20) NOT NULL,
    classes_enrollment_limit  INTEGER NOT NULL,
    classes_quarter           VARCHAR(20) NOT NULL,
    classes_year              VARCHAR(20) NOT NULL,
    classes_instructor_name   varchar(20) REFERENCES faculty (faculty_name),
    classes_course_id         integer REFERENCES course (course_id)
)
with (
	OIDS=FALSE
);

DROP TABLE IF EXISTS degree CASCADE;
CREATE TABLE public.degree
(
    degree_id                 INTEGER PRIMARY KEY,
    degree_gpa_requirement    FLOAT NOT NULL,
    degree_lower_div_req      INTEGER NOT NULL,
    degree_upper_div_req      INTEGER NOT NULL,
    degree_department_id      INTEGER REFERENCES department (department_id)
)
with (
  OIDS=FALSE
);

DROP TABLE IF EXISTS thesis CASCADE;
CREATE TABLE public.thesis 
(
    thesis_id             INTEGER PRIMARY KEY,
    thesis_student_ssn    INTEGER REFERENCES student (student_ssn),
    thesis_faculty_name   VARCHAR(20) REFERENCES faculty (faculty_name)
)
with (
  OIDS=FALSE
)

DROP TABLE IF EXISTS classes CASCADE;
CREATE TABLE public.classes
(
    classes_id                INTEGER PRIMARY KEY,
    classes_enrollment_limit  INTEGER NOT NULL,
    classes_mandatory         VARCHAR(20) NOT NULL,
    classes_quarter           VARCHAR(20) NOT NULL,
    classes_year              VARCHAR(20) NOT NULL,
)
with (
    OIDS=FALSE
)
