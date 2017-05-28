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
INSERT INTO faculty VALUES ('Ord',   'Professor');
  
  -- for previous classes
INSERT INTO faculty VALUES ('Shacam'    , 'Professor');
INSERT INTO faculty VALUES ('Pasquelle' , 'Professor');
INSERT INTO faculty VALUES ('Disgupta'  , 'Professor');
INSERT INTO faculty VALUES ('Richards'  , 'Professor');
INSERT INTO faculty VALUES ('Jenson'    , 'Professor');

-- make sample departments
INSERT INTO department VALUES (1, 'CSE');

-- make sample courses
INSERT INTO course VALUES (1, 4    , 'Grade'  , 'CSE132B', 'FALSE', 1);
INSERT INTO course VALUES (2, 4    , 'Grade'  , 'CSE132A', 'FALSE', 1);
INSERT INTO course VALUES (3, 4    , 'Grade'  , 'CSE131' , 'FALSE', 1);
INSERT INTO course VALUES (4, 4    , 'Grade'  , 'CSE135' , 'FALSE', 1);
INSERT INTO course VALUES (5, 4    , 'Grade'  , 'CSE150' , 'FALSE', 1);
INSERT INTO course VALUES (6, 4    , 'Grade'  , 'CSE151' , 'FALSE', 1);
INSERT INTO course VALUES (7, 4    , 'Grade'  , 'CSE158' , 'FALSE', 1);
INSERT INTO course VALUES (8, '1,4', 'S/U'    , 'CSE110' , 'TRUE' , 1);

  -- for previous classes
INSERT INTO course VALUES (9,  '1,4', 'Grade' , 'CSE100' , 'FALSE' , 1);
INSERT INTO course VALUES (10, '1,4', 'Grade' , 'CSE101' , 'FALSE' , 1);
INSERT INTO course VALUES (11, '1,4', 'Grade' , 'CSE103' , 'FAlSE' , 1);
INSERT INTO course VALUES (12, '1,4', 'Grade' , 'CSE105' , 'FALSE' , 1);
INSERT INTO course VALUES (13, '1,4', 'Grade' , 'CSE127' , 'FALSE' , 1);

-- make sample classes
INSERT INTO classes VALUES (1, 'CSE132B', 20, 'SP17', '2017', 'Alan'  , 1);
INSERT INTO classes VALUES (2, 'CSE132A', 20, 'SP17', '2017', 'Nick'  , 1);
INSERT INTO classes VALUES (3, 'CSE131' , 20, 'SP17', '2017', 'Vicky' , 1);
INSERT INTO classes VALUES (4, 'CSE135' , 20, 'SP17', '2017', 'Jhala' , 1);
INSERT INTO classes VALUES (5, 'CSE110' , 20, 'SP17', '2017', 'Ord'   , 1);
INSERT INTO classes VALUES (6, 'CSE132B', 20, 'SP17', '2017', 'Alan'  , 1);

 -- for previous classes
INSERT INTO classes VALUES (7,  'CSE100', 20, 'SP16', '2016', 'Disgupta'  , 8);
INSERT INTO classes VALUES (8,  'CSE101', 20, 'SP16', '2016', 'Pasquelle' , 9);
INSERT INTO classes VALUES (9,  'CSE103', 20, 'WI16', '2016', 'Richards'  , 10);
INSERT INTO classes VALUES (10, 'CSE105', 20, 'WI16', '2016', 'Shacam'    , 11);
INSERT INTO classes VALUES (11, 'CSE127', 20, 'WI16', '2016', 'Jenson'    , 12);

-- make sample enrolled students
INSERT INTO enrolled_student VALUES (1, 1, 4, 'Grade');
INSERT INTO enrolled_student VALUES (1, 5, 2, 'S/U');
INSERT INTO enrolled_student VALUES (1, 3, 4, 'Grade');

INSERT INTO enrolled_student VALUES (2, 4, 4, 'Grade');
INSERT INTO enrolled_student VALUES (2, 5, 3, 'S/U');

INSERT INTO enrolled_student VALUES (3, 2, 4, 'Grade');
INSERT INTO enrolled_student VALUES (3, 3, 4, 'Grade');
INSERT INTO enrolled_student VALUES (3, 4, 4, 'Grade');

INSERT INTO enrolled_student VALUES (4, 1, 4, 'Grade');
INSERT INTO enrolled_student VALUES (4, 3, 4, 'Grade');
INSERT INTO enrolled_student VALUES (4, 4, 4, 'Grade');

-- make sample previous courses for students
INSERT INTO previous_class VALUES (1, 7 , 'A', 'SP16', '2016', '4', 'Grade');
INSERT INTO previous_class VALUES (1, 8 , 'C', 'SP16', '2016', '4', 'Grade');
INSERT INTO previous_class VALUES (1, 9 , 'B', 'WI16', '2016', '4', 'Grade');
INSERT INTO previous_class VALUES (1, 10, 'B', 'WI16', '2016', '4', 'Grade');

INSERT INTO previous_class VALUES (2, 7 , 'A', 'SP16', '2016', '4', 'Grade');
INSERT INTO previous_class VALUES (2, 8 , 'A', 'SP16', '2016', '4', 'Grade');
INSERT INTO previous_class VALUES (2, 9 , 'B', 'WI16', '2016', '4', 'Grade');
INSERT INTO previous_class VALUES (2, 11, 'B', 'WI16', '2016', '4', 'Grade');

INSERT INTO previous_class VALUES (3, 9 , 'D', 'WI16', '2016', '4', 'Grade');
INSERT INTO previous_class VALUES (3, 10, 'A', 'WI16', '2016', '4', 'Grade');
INSERT INTO previous_class VALUES (3, 11, 'A', 'WI16', '2016', '4', 'Grade');
