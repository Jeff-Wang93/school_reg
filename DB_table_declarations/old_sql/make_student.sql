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
    thesis_student_id     INTEGER REFERENCES student (student_id) PRIMARY KEY,
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
