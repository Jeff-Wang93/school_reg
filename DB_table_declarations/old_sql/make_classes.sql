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
