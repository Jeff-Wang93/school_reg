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
