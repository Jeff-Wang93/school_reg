DROP TABLE IF EXISTS faculty CASCADE;
CREATE TABLE public.faculty
(
    faculty_name      character varying(50) NOT NULL,
    faculty_title     character varying(50) NOT NULL,
    CONSTRAINT faculty_pkey PRIMARY KEY (faculty_name)
)
WITH (
  OIDS=FALSE
);

DROP TABLE IF EXISTS department CASCADE;
CREATE TABLE public.department
(
    department_id    INTEGER PRIMARY KEY,
    department_title varchar(150) NOT NULL	
)
WITH (
  OIDS=FALSE
 );

-- GRADE OPTIONS = Grade, S/U, Both
DROP TABLE IF EXISTS course CASCADE;
CREATE TABLE public.course
(
    course_id             integer primary key,
    course_units          varchar(150) NOT NULL,
    course_grade_type     character varying(10) NOT NULL,
    course_title          character varying(10) NOT NULL UNIQUE,
    course_department_id  integer REFERENCES department (department_id)
)
WITH (
  OIDS=FALSE
);

DROP TABLE IF EXISTS classes CASCADE;
CREATE TABLE public.classes
(
    classes_id                INTEGER PRIMARY KEY,
    classes_title             varchar(150),
    classes_quarter           varchar(150) NOT NULL,
    classes_course_id         INTEGER REFERENCES course (course_id),
    classes_current           VARCHAR(5),
    classes_next              VARCHAR(20)
);

DROP TABLE IF EXISTS current_quarter CASCADE;
CREATE TABLE public.current_quarter
(
    section_number INTEGER PRIMARY KEY,
    course_id      INTEGER REFERENCES course (course_id),
    quarter        VARCHAR(20),
    year           VARCHAR(20),
    lec_days       VARCHAR(20),
    lec_time       VARCHAR(20),
    dis_days       VARCHAR(20),
    dis_time       VARCHAR(20),
    enrollment_limit INTEGER
);

DROP TABLE IF EXISTS current_enrollment CASCADE;
CREATE TABLE public.current_enrollment
(
    section_id      INTEGER REFERENCES current_quarter (section_number),
    enrollment      INTEGER,
    limit           INTEGER
);

DROP TABLE IF EXISTS degree CASCADE;
CREATE TABLE public.degree
(
    degree_id                 INTEGER PRIMARY KEY,
    degree_lower_div_req      INTEGER NOT NULL,
    degree_upper_div_req      INTEGER NOT NULL,
    degree_tech_req           INTEGER NOT NULL,
    degree_grad_units         INTEGER NOT NULL,
    degree_department_id      INTEGER REFERENCES department (department_id),
    degree_type               varchar(150),
    degree_name               varchar(150)
)
with (
  OIDS=FALSE
);

DROP TABLE IF EXISTS course_prereq CASCADE;
CREATE TABLE public.course_prereq
(
    course_id INTEGER REFERENCES course (course_id),
    prereq_id INTEGER REFERENCES course (course_id)
);

DROP TABLE IF EXISTS student CASCADE;
CREATE TABLE public.student
(
    student_ssn         integer PRIMARY KEY,
    student_id          integer UNIQUE NOT NULL,
    student_first_name  character varying(50) NOT NULL,
    student_middle_name character varying(50),
    student_last_name   character varying(50) NOT NULL,
    student_residency   character varying(50),
    student_gpa	        float
)
WITH (
  OIDS=FALSE
);

DROP TABLE IF EXISTS undergrad_student CASCADE;
CREATE TABLE public.undergrad_student
(
    undergrad_student_id            INTEGER REFERENCES student (student_id) PRIMARY KEY,
    undergrad_student_college       varchar(150) NOT NULL,
    undergrad_student_minor         varchar(150),
    undergrad_student_major         varchar(150) NOT NULL
);

DROP TABLE IF EXISTS master_student CASCADE;
CREATE TABLE public.master_student
(
    master_student_id       INTEGER REFERENCES student (student_id) PRIMARY KEY,
    master_student_major    varchar(150) NOT NULL
);

DROP TABLE IF EXISTS phd_student CASCADE;
CREATE TABLE public.phd_student
(
    phd_student_id      INTEGER REFERENCES student (student_id) PRIMARY KEY,
    phd_student_type    varchar(150) NOT NULL
);

DROP TABLE IF EXISTS thesis CASCADE;
CREATE TABLE public.thesis 
(
    thesis_student_id     INTEGER REFERENCES phd_student (phd_student_id),
    thesis_faculty_name   varchar(150) REFERENCES faculty (faculty_name)
);

DROP TABLE IF EXISTS probation CASCADE;
CREATE TABLE public.probation
(
    probation_student_id    INTEGER REFERENCES student (student_id),
    probation_start         varchar(150) NOT NULL,
    probation_end           varchar(150) NOT NULL,
    probation_description   VARCHAR(40) NOT NULL
);

DROP TABLE IF EXISTS period_enroll CASCADE;
CREATE TABLE public.period_enroll
(
    period_enroll_student_id    INTEGER REFERENCES student (student_id),
    period_enroll_start         varchar(150) NOT NULL,
    period_enroll_end           varchar(150) NOT NULL,
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
    class_history_grade           varchar(150) NOT NULL
);
-- create all classes related tables

DROP TABLE IF EXISTS lecture_info CASCADE;
CREATE TABLE public.lecture_info
(
    lecture_info_time       varchar(150) NOT NULL,
    lecture_info_day        varchar(150),
    lecture_info_date       varchar(150),
    section_id              INTEGER REFERENCES current_quarter (section_number)
);

DROP TABLE IF EXISTS discussion_info CASCADE;
CREATE TABLE public.discussion_info
(
    discussion_info_time        varchar(150) NOT NULL,
    discussion_info_day         varchar(150),
    discussion_info_date        varchar(150),
    section_id                  INTEGER REFERENCES current_quarter (section_number)
);

DROP TABLE IF EXISTS review_info CASCADE;
CREATE TABLE public.review_info
(
    review_info_time        varchar(150) NOT NULL,
    review_info_day         varchar(150),
    review_info_date        varchar(150),
    section_id              INTEGER REFERENCES current_quarter (section_number)
);

DROP TABLE IF EXISTS lab_info CASCADE;
CREATE TABLE public.lab_info
(
    lab_info_time        varchar(150) NOT NULL,
    lab_info_day         varchar(150),
    lab_info_date        varchar(150),
    section_id           INTEGER REFERENCES current_quarter (section_number)
);

DROP TABLE IF EXISTS final_info CASCADE;
CREATE TABLE public.final_info
(
    final_info_time     VARCHAR(150) NOT NULL,
    final_info_day      VARCHAR(150),
    final_info_date     VARCHAR(150), 
    section_id          INTEGER REFERENCES current_quarter (section_number)
);

DROP TABLE IF EXISTS enrolled_student CASCADE;
CREATE TABLE public.enrolled_student
(
    student_id          INTEGER REFERENCES student (student_id),
    section_id          INTEGER REFERENCES current_quarter (section_number),
    units               varchar(150),
    grade_type          varchar(150)
);

DROP TABLE IF EXISTS waitlist_student CASCADE;
CREATE TABLE public.waitlist_student
(
    student_id          INTEGER REFERENCES student (student_id),
    classes_id          INTEGER REFERENCES classes (classes_id),
    units               INTEGER
);

DROP TABLE IF EXISTS previous_class CASCADE;
CREATE TABLE public.previous_class
(
    student_id          INTEGER REFERENCES student (student_id),
    course_id           INTEGER REFERENCES course (course_id),
    grade               varchar(150) NOT NULL,
    quarter             varchar(150),
    year                varchar(150),
    units               varchar(150),
    grade_type          varchar(150)
);

DROP TABLE IF EXISTS ms_concentration CASCADE;
CREATE TABLE public.ms_concentration
(
    concentration_id    INTEGER PRIMARY KEY,
    degree_id           INTEGER REFERENCES degree (degree_id),
    units_req           INTEGER,
    min_gpa             FLOAT,
    concentration_name  VARCHAR(20)
);

DROP TABLE IF EXISTS degree_course CASCADE;
CREATE TABLE public.degree_course
(
    concentration_id   INTEGER REFERENCES ms_concentration (concentration_id),
    course_id   INTEGER REFERENCES course (course_id)
);

DROP TABLE IF EXISTS tech_elective CASCADE;
CREATE TABLE public.tech_elective
(
    course_id  INTEGER REFERENCES course (course_id)
);

DROP TABLE IF EXISTS lower_division CASCADE;
CREATE TABLE public.lower_division
(
    course_id INTEGER REFERENCES course (course_id)
);

DROP TABLE IF EXISTS faculty_teaching CASCADE;
CREATE TABLE public.faculty_teaching
(
    faculty_name VARCHAR(50) REFERENCES faculty (faculty_name),
    course_id    INTEGER REFERENCES course (course_id),
    section      INTEGER REFERENCES current_quarter (section_number), 
    quarter      VARCHAR(20),
    year         VARCHAR(20)
);

DROP TABLE IF EXISTS grade_conversion CASCADE;
CREATE TABLE public.grade_conversion
( 
    letter_grade CHAR(2) NOT NULL,
    number_grade DECIMAL(2,1)
);
