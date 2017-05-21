DROP TABLE IF EXISTS student CASCADE;
CREATE TABLE public.student
(
    student_ssn         integer primary key,
    student_id          integer UNIQUE NOT NULL,
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

DROP TABLE IF EXISTS classes CASCADE;
CREATE TABLE public.classes
(
    classes_id                INTEGER PRIMARY KEY,
    classes_enrollment_limit  INTEGER NOT NULL,
    classes_mandatory         VARCHAR(20) NOT NULL,
    classes_quarter           VARCHAR(20) NOT NULL,
    classes_year              VARCHAR(20) NOT NULL
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

DROP TABLE IF EXISTS course_prereq CASCADE;
CREATE TABLE public.course_prereq
(
    course_id INTEGER REFERENCES course (course_id),
    prereq_id INTEGER REFERENCES course (course_id)
);
-- all tables regarding student

DROP TABLE IF EXISTS student CASCADE;
CREATE TABLE public.student
(
    student_ssn         integer PRIMARY KEY,
    student_id          integer UNIQUE NOT NULL,
    student_first_name  character varying(20) NOT NULL,
    student_middle_name character varying(20),
    student_last_name   character varying(20) NOT NULL,
    student_residency   character varying(10) NOT NULL,
    student_gpa	        float
)
WITH (
  OIDS=FALSE
);

DROP TABLE IF EXISTS undergrad_student CASCADE;
CREATE TABLE public.undergrad_student
(
    undergrad_student_id            INTEGER REFERENCES student (student_id) PRIMARY KEY,
    undergrad_student_college       VARCHAR(20) NOT NULL,
    undergrad_student_minor         VARCHAR(20),
    undergrad_student_major         VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS master_student CASCADE;
CREATE TABLE public.master_student
(
    master_student_id  INTEGER REFERENCES student (student_id) PRIMARY KEY
);

DROP TABLE IF EXISTS phd_student CASCADE;
CREATE TABLE public.phd_student
(
    phd_student_id      INTEGER REFERENCES student (student_id) PRIMARY KEY,
    phd_student_type    VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS thesis CASCADE;
CREATE TABLE public.thesis 
(
    thesis_student_id     INTEGER REFERENCES phd_student (phd_student_id),
    thesis_faculty_name   VARCHAR(20) REFERENCES faculty (faculty_name)
);

DROP TABLE IF EXISTS probation CASCADE;
CREATE TABLE public.probation
(
    probation_student_id    INTEGER REFERENCES student (student_id),
    probation_start         VARCHAR(20) NOT NULL,
    probation_end           VARCHAR(20) NOT NULL,
    probation_description   VARCHAR(40) NOT NULL
);

DROP TABLE IF EXISTS period_enroll CASCADE;
CREATE TABLE public.period_enroll
(
    period_enroll_student_id    INTEGER REFERENCES student (student_id),
    period_enroll_start         VARCHAR(20) NOT NULL,
    period_enroll_end           VARCHAR(20) NOT NULL,
    period_enroll_description   VARCHAR(40) NOT NULL
);

DROP TABLE IF EXISTS previous_edu CASCADE;
CREATE TABLE public.previous_edu
(
    previous_edu_student_id     INTEGER REFERENCES student (student_id),
    previous_edu_degree         VARCHAR(40) NOT NULL,
    previous_edu_school         VARCHAR(40) NOT NULL
);

DROP TABLE IF EXISTS class_history CASCADE;
CREATE TABLE public.class_history
(
    class_history_student_id      INTEGER REFERENCES student (student_id),
    class_history_classes_id      INTEGER REFERENCES classes (classes_id),
    class_history_grade           VARCHAR(20) NOT NULL
);
-- create all classes related tables

DROP TABLE IF EXISTS classes CASCADE;
CREATE TABLE public.classes
(
    classes_id                INTEGER PRIMARY KEY,
    classes_enrollment_limit  INTEGER NOT NULL,
    classes_quarter           VARCHAR(20) NOT NULL,
    classes_year              VARCHAR(20) NOT NULL,
    course_id                 INTEGER REFERENCES course (course_id)
);

DROP TABLE IF EXISTS lecture_info CASCADE;
CREATE TABLE public.lecture_info
(
    lecture_info_id         INTEGER PRIMARY KEY,
    lecture_info_time       VARCHAR(20) NOT NULL,
    lecture_info_date       VARCHAR(20),
    lecture_info_location   VARCHAR(20) NOT NULL,
    lecture_info_mandatory  VARCHAR(20) NOT NULL,
    classes_id              INTEGER REFERENCES classes (classes_id)
);

DROP TABLE IF EXISTS discussion_info CASCADE;
CREATE TABLE public.discussion_info
(
    discussion_info_id          INTEGER PRIMARY KEY,
    discussion_info_time        VARCHAR(20) NOT NULL,
    discussion_info_date        VARCHAR(20),
    discussion_info_location    VARCHAR(20) NOT NULL,
    discussion_info_mandatory   VARCHAR(20) NOT NULL,
    classes_id                  INTEGER REFERENCES classes (classes_id)
);

DROP TABLE IF EXISTS review_info CASCADE;
CREATE TABLE public.review_info
(
    review_info_id          INTEGER PRIMARY KEY,
    review_info_time        VARCHAR(20) NOT NULL,
    review_info_date        VARCHAR(20),
    review_info_location    VARCHAR(20) NOT NULL,
    review_info_mandatory   VARCHAR(20) NOT NULL,
    classes_id              INTEGER REFERENCES classes(classes_id)
);

DROP TABLE IF EXISTS lab_info CASCADE;
CREATE TABLE public.lab_info
(
    lab_info_id          INTEGER PRIMARY KEY,
    lab_info_time        VARCHAR(20) NOT NULL,
    lab_info_date        VARCHAR(20),
    lab_info_location    VARCHAR(20) NOT NULL,
    lab_info_mandatory   VARCHAR(20) NOT NULL,
    classes_id           INTEGER REFERENCES classes(classes_id)
);

DROP TABLE IF EXISTS enrolled_student CASCADE;
CREATE TABLE public.enrolled_student
(
    student_id          INTEGER REFERENCES student (student_id),
    classes_id          INTEGER REFERENCES classes (classes_id),
    enrolled_quarter    VARCHAR(20) 
);

DROP TABLE IF EXISTS waitlist_student CASCADE;
CREATE TABLE public.waitlist_student
(
    student_id          INTEGER REFERENCES student (student_id),
    classes_id          INTEGER REFERENCES classes (classes_id),
    waitlist_quarter    VARCHAR(20) 
);

DROP TABLE IF EXISTS previous_class CASCADE;
CREATE TABLE public.previous_class
(
    student_id          INTEGER REFERENCES student (student_id),
    classes_id          INTEGER REFERENCES classes (classes_id),
    grade               VARCHAR(20) NOT NULL,
    previous_quarter    VARCHAR(20)
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

DROP TABLE IF EXISTS degree_course CASCADE;
CREATE TABLE public.degree_course
(
    degree_id   INTEGER REFERENCES degree (degree_id),
    course_id   INTEGER REFERENCES course (course_id),
    identifier  INTEGER NOT NULL
);
