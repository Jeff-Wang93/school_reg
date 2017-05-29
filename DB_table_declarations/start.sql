--  make sample students
INSERT INTO student VALUES (1, 1, 'Benjamin', DEFAULT, 'B');
INSERT INTO student VALUES (2, 2, 'Kristen', DEFAULT, 'W');
INSERT INTO student VALUES (3, 3, 'Daniel', DEFAULT, 'F');
INSERT INTO student VALUES (4, 4, 'Clarie', DEFAULT, 'J');
INSERT INTO student VALUES (5, 5, 'Julie', DEFAULT, 'C');
INSERT INTO student VALUES (6, 6, 'Kevin', DEFAULT, 'L');
INSERT INTO student VALUES (7, 7, 'Michael', DEFAULT, 'B');
INSERT INTO student VALUES (8, 8, 'Joseph', DEFAULT, 'J');
INSERT INTO student VALUES (9, 9, 'Devin', DEFAULT, 'P');
INSERT INTO student VALUES (10, 10, 'Logal', DEFAULT, 'F');
INSERT INTO student VALUES (11, 11, 'Vikram', DEFAULT, 'N');
INSERT INTO student VALUES (12, 12, 'Rachel', DEFAULT, 'Z');
INSERT INTO student VALUES (13, 13, 'Zach', DEFAULT, 'M');
INSERT INTO student VALUES (14, 14, 'Justin', DEFAULT, 'H');
INSERT INTO student VALUES (15, 15, 'Rahul', DEFAULT, 'R');

INSERT INTO student VALUES (16, 16, 'Dave', DEFAULT, 'C');
INSERT INTO student VALUES (17, 17, 'Nelson', DEFAULT, 'H');
INSERT INTO student VALUES (18, 18, 'Andrew', DEFAULT, 'P');
INSERT INTO student VALUES (19, 19, 'Nathan', DEFAULT, 'S');
INSERT INTO student VALUES (20, 20, 'John', DEFAULT, 'H');
INSERT INTO student VALUES (21, 21, 'Anwell', DEFAULT, 'W');
INSERT INTO student VALUES (22, 22, 'Tim', DEFAULT, 'K');

-- make sample course history
INSERT INTO previous_class VALUES (1, 1 , 'A-', 'fa2014', '2014', 4, 'Grade');
INSERT INTO previous_class VALUES (3, 1, 'B+', 'fa2014', '2014', 4, 'Grade');
INSERT INTO previous_class VALUES (2, 1, 'C-', 'fa2014', '2014', 4, 'Grade');
INSERT INTO previous_class VALUES (4, 1, 'A-', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (5, 1, 'B', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (1, 2, 'A-', 'wi2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (5, 2, 'B+', 'wi2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (4, 2, 'C', 'wi2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES(16, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');
INSERT INTO previous_class VALUES(, , , , , , 'Grade');

-- make sample undergrad students
INSERT INTO undergrad_student VALUES (1, 'DEFAULT', DEFAULT, 'Computer Science');
INSERT INTO undergrad_student VALUES (2, 'DEFAULT', DEFAULT, 'Computer Science');
INSERT INTO undergrad_student VALUES (3, 'DEFAULT', DEFAULT, 'Computer Science');
INSERT INTO undergrad_student VALUES (4, 'DEFAULT', DEFAULT, 'Computer Science');
INSERT INTO undergrad_student VALUES (5, 'DEFAULT', DEFAULT, 'Computer Science');
INSERT INTO undergrad_student VALUES (6, 'DEFAULT', DEFAULT, 'Mechanical Engineering');
INSERT INTO undergrad_student VALUES (7, 'DEFAULT', DEFAULT, 'Mechanical Engineering');
INSERT INTO undergrad_student VALUES (8, 'DEFAULT', DEFAULT, 'Mechanical Engineering');
INSERT INTO undergrad_student VALUES (9, 'DEFAULT', DEFAULT, 'Mechanical Engineering');
INSERT INTO undergrad_student VALUES (10, 'DEFAULT', DEFAULT, 'Mechanical Engineering');
INSERT INTO undergrad_student VALUES (11, 'DEFAULT', DEFAULT, 'Philosophy');
INSERT INTO undergrad_student VALUES (12, 'DEFAULT', DEFAULT, 'Philosophy');
INSERT INTO undergrad_student VALUES (13, 'DEFAULT', DEFAULT, 'Philosophy');
INSERT INTO undergrad_student VALUES (14, 'DEFAULT', DEFAULT, 'Philosophy');
INSERT INTO undergrad_student VALUES (15, 'DEFAULT', DEFAULT, 'Philosophy');

-- make sample master students
INSERT INTO master_student VALUES (16, 'Computer Science');
INSERT INTO master_student VALUES (17, 'Computer Science');
INSERT INTO master_student VALUES (18, 'Computer Science');
INSERT INTO master_student VALUES (19, 'Computer Science');
INSERT INTO master_student VALUES (20, 'Computer Science');
INSERT INTO master_student VALUES (21, 'Computer Science');
INSERT INTO master_student VALUES (22, 'Computer Science');

-- make sample faculty
INSERT INTO faculty VALUES ('Justin Bieber' , 'Associate Professor');
INSERT INTO faculty VALUES ('Flo Rida' , 'Professor');
INSERT INTO faculty VALUES ('Selena Gomez' , 'Professor');
INSERT INTO faculty VALUES ('Adele' , 'Professor');
INSERT INTO faculty VALUES ('Taylor Swift' , 'Professor');
INSERT INTO faculty VALUES ('Kelly Clarkson' , 'Professor');
INSERT INTO faculty VALUES ('Adam Levine' , 'Professor');
INSERT INTO faculty VALUES ('Bjork' , 'Professor');
  
-- make sample departments
INSERT INTO department VALUES (1, 'CSE');
INSERT INTO department VALUES (2, 'MAE');
INSERT INTO department VALUES (3, 'PHIL');

-- make sample courses
INSERT INTO course VALUES (1, '2,4', 'Both', 'CSE8A'   , 1);
INSERT INTO course VALUES (2, '2,4', 'Both', 'CSE105'  , 1);
INSERT INTO course VALUES (3, '2,4', 'Both', 'CSE123'  , 1);
INSERT INTO course VALUES (4, '2,4', 'Both', 'CSE250A' , 1);
INSERT INTO course VALUES (5, '2,4', 'Both', 'CSE250B' , 1);
INSERT INTO course VALUES (6, '2,4', 'Both', 'CSE255'  , 1);
INSERT INTO course VALUES (7, '2,4', 'Both', 'CSE232A' , 1);
INSERT INTO course VALUES (8, '2,4', 'Both', 'CSE221'  , 1);

INSERT INTO course VALUES (9, '2,4', 'Both', 'MAE3' , 2);
INSERT INTO course VALUES (10, '2,4', 'Both', 'MAE107' , 2);
INSERT INTO course VALUES (11, '2,4', 'Both', 'MAE108' , 2);

INSERT INTO course VALUES (12, '2,4', 'Both', 'PHIL10' , 3);
INSERT INTO course VALUES (13, '2,4', 'Both', 'PHIL12' , 3);
INSERT INTO course VALUES (14, '2,4', 'Both', 'PHIL165' , 3);
INSERT INTO course VALUES (15, '2,4', 'Both', 'PHIL167' , 3);

-- make sample classes
INSERT INTO classes VALUES (1, 'Introduction to Computer Science: Java', 'fa2014, sp2015, fa2015, fa2016, wi2016, wi2017', 1, 'TRUE', 'sp2018');
INSERT INTO classes VALUES (2, 'Intro to Theory', 'wi2015, wi2016', 2, 'TRUE', 'fa2017');
INSERT INTO classes VALUES (3, 'Probabilistic Reasoning', 'fa2014, fa2015,wi2015, fa2016', 4, 'FALSE', 'sp2018');
INSERT INTO classes VALUES (4, 'Machine Learning', 'wi2016, wi2015, fa2015', 5, 'FALSE', 'fa2018');
INSERT INTO classes VALUES (5, 'Data Mining and Predictive Analytics', 'fa2015, wi2016', 6, 'TRUE', 'wi2018');
INSERT INTO classes VALUES (6, 'Databases', 'fa2015', 8, 'FALSE', 'sp2018');
INSERT INTO classes VALUES (7, 'Operating Systems', 'sp2015, wi2016', 8, 'TRUE', 'fa2017');


INSERT INTO classes VALUES (8, 'Computational Methods', 'sp2015, sp2016', 10, 'FALSE', 'sp2018');
INSERT INTO classes VALUES (9, 'Probability and Statistics', 'fa2014, wi2015, wi2016, wi2017', 11, 'TRUE', 'fa2018');

INSERT INTO classes VALUES (10, 'Intro to Logic', 'fa2015, fa2016', 12, FALSE, 'wi2018');
INSERT INTO classes VALUES (11, 'Scientific Reasoning', 'wi2016', 13, TRUE, 'wp2018');
INSERT INTO classes VALUES (12, 'Freedom, Equality, and the Law', 'sp2015, fa2015, wi2016, sp2016, fa2016', 14, 'TRUE', 'sp2018');

-- make sample student course history

-- make sample grade conversion table 
insert into grade_conversion values('A+', 4.0);
insert into grade_conversion values('A', 4.0);
insert into grade_conversion values('A-', 3.7);
insert into grade_conversion values('B+', 3.3);
insert into grade_conversion values('B', 3.0);
insert into grade_conversion values('B-', 2.7);
insert into grade_conversion values('C+', 2.3);
insert into grade_conversion values('C', 2.0);
insert into grade_conversion values('C-', 1.7);
insert into grade_conversion values('D', 1.0);
insert into grade_conversion values('F', 0.0);
