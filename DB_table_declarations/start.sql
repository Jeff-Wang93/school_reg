--  make sample students
INSERT INTO student VALUES (111, 1, 'Jack'   , 'C'     , 'Doe'     , 'RESIDENT');
INSERT INTO student VALUES (222, 2, 'Helga'  , DEFAULT , 'Johnson' , 'RESIDENT');
INSERT INTO student VALUES (333, 3, 'Marie'  , DEFAULT , 'Smith'   , 'OUT OF STATE');
INSERT INTO student VALUES (444, 4, 'Kobe'   , DEFAULT , 'Bryant'  , 'OUT OF STATE');
INSERT INTO student VALUES (555, 5, 'LeBron' , DEFAULT , 'James'   , 'INTERNATIONAL');

-- make sample faculty
INSERT INTO faculty VALUES ('Alan' , 'Professor');
INSERT INTO faculty VALUES ('Nick' , 'TA');
INSERT INTO faculty VALUES ('Vicky', 'TA');
INSERT INTO faculty VALUES ('Jhala', 'Professor');

-- make sample departments
INSERT INTO department VALUES (1, 'CSE');
INSERT INTO department VALUES (2, 'ECE');

-- make sample courses
INSERT INTO course VALUES (1, 4    , 'Grade'  , 'CSE132B', 'FALSE', 1);
INSERT INTO course VALUES (2, 4    , 'Grade'  , 'CSE132A', 'FALSE', 1);
INSERT INTO course VALUES (3, 4    , 'Both'   , 'CSE135' , 'FALSE', 1);
INSERT INTO course VALUES (4, '1,4', 'S/U'    , 'ECE141' , 'TRUE' , 2);
INSERT INTO course VALUES (5, 4    , 'Grade'  , 'CSE131' , 'FALSE', 1);
INSERT INTO course VALUES (6, 4    , 'Grade'  , 'CSE130' , 'FALSE', 1);
INSERT INTO course VALUES (7, 4    , 'Grade'  , 'CSE120' , 'FALSE', 1);

-- make sample classes
INSERT INTO classes VALUES (1, 'CSE132B', 20, 'SP17', '2017', 'Alan' , 1);
INSERT INTO classes VALUES (2, 'CSE132B', 20, 'SP17', '2017', 'Alan' , 1);
INSERT INTO classes VALUES (3, 'CSE135' , 20, 'SP17', '2017', 'Nick' , 3);
INSERT INTO classes VALUES (4, 'ECE141' , 20, 'SP17', '2017', 'Vicky', 4);
INSERT INTO classes VALUES (5, 'CSE131' , 20, 'WI17', '2017', 'Jhala', 5);
INSERT INTO classes VALUES (6, 'CSE130' , 20, 'WI17', '2017', 'Jhala', 6);
INSERT INTO classes VALUES (7, 'CSE120' , 20, 'FA16', '2016', 'Jhala', 7);
INSERT INTO classes VALUES (8, 'CSE132A', 20, 'WI17', '2017', 'Jhala', 2);
INSERT INTO classes VALUES (9, 'ECE141' , 20, 'WI14', '2014', 'Nick' , 4);

-- make sample enrolled students
INSERT INTO enrolled_student VALUES (1, 1, 4, 'Grade');
INSERT INTO enrolled_student VALUES (1, 3, 4, 'Grade');
INSERT INTO enrolled_student VALUES (1, 4, 3, 'S/U');

INSERT INTO enrolled_student VALUES (2, 1, 4, 'Grade');
INSERT INTO enrolled_student VALUES (2, 3, 4, 'Grade');

INSERT INTO enrolled_student VALUES (3, 3, 4, 'Grade');
INSERT INTO enrolled_student VALUES (3, 4, 2, 'S/U');

-- make sample previous courses for students
INSERT INTO previous_class VALUES (1, 6, 'C', 'WI17', '2017', '4', 'Grade');
INSERT INTO previous_class VALUES (1, 5, 'B', 'WI17', '2017', '4', 'Grade');
INSERT INTO previous_class VALUES (1, 7, 'A', 'WI17', '2017', '4', 'Grade');
INSERT INTO previous_class VALUES (1, 9, 'D', 'WI14', '2014', '4', 'S/U');

INSERT INTO previous_class VALUES (4, 8, 'A', 'WI17', '2017', '4', 'Grade');
INSERT INTO previous_class VALUES (4, 9, 'A', 'WI14', '2014', '4', 'S/U');
INSERT INTO previous_class VALUES (4, 5, 'A', 'WI17', '2017', '4', 'Grade');
