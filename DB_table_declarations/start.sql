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
INSERT INTO student VALUES (10, 10, 'Logan', DEFAULT, 'F');
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

-- make sample degree
INSERT INTO degree VALUES (1, 10, 15, 15, 0, 1, 'BS', 'Computer Science');
INSERT INTO degree VALUES (2, 15, 20, 0, 0, 3, 'BA', 'Philosophy');
INSERT INTO degree VALUES (3, 20, 20, 10, 0, 2, 'BS', 'Mechanical Engineering');
INSERT INTO degree VALUES (4, 0, 0, 0, 45, 1, 'MS', 'Computer Science');

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
INSERT INTO classes VALUES (6, 'Databases', 'fa2015', 7, 'FALSE', 'sp2018');
INSERT INTO classes VALUES (7, 'Operating Systems', 'sp2015, wi2016', 8, 'TRUE', 'fa2017');

INSERT INTO classes VALUES (8, 'Computational Methods', 'sp2015, sp2016', 10, 'FALSE', 'sp2018');
INSERT INTO classes VALUES (9, 'Probability and Statistics', 'fa2014, wi2015, wi2016, wi2017', 11, 'TRUE', 'fa2018');

INSERT INTO classes VALUES (10, 'Intro to Logic', 'fa2015, fa2016', 12, FALSE, 'wi2018');
INSERT INTO classes VALUES (11, 'Scientific Reasoning', 'wi2016', 13, TRUE, 'wp2018');
INSERT INTO classes VALUES (12, 'Freedom, Equality, and the Law', 'sp2015, fa2015, wi2016, sp2016, fa2016', 14, 'TRUE', 'sp2018');

-- make sample student course history
INSERT INTO previous_class VALUES (1, 1 , 'A-', 'fa2014', '2014', 4, 'Grade');
INSERT INTO previous_class VALUES (3, 1, 'B+', 'fa2014', '2014', 4, 'Grade');
INSERT INTO previous_class VALUES (2, 1, 'C-', 'sp2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (4, 1, 'A-', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (5, 1, 'B', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (1, 2, 'A-', 'wi2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (5, 2, 'B+', 'wi2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (4, 2, 'C', 'wi2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (16, 4, 'C', 'fa2014', '2014', 4, 'Grade');
INSERT INTO previous_class VALUES (22, 4, 'B+', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (18, 4, 'D', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (19, 4, 'F', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (17, 5, 'A', 'wi2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (19, 5, 'A', 'wi2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (20, 6, 'B-', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (18, 6, 'B', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (21, 6, 'F', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (17, 7, 'A-', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (22, 8, 'A', 'sp2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (20, 8, 'A', 'sp2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (10, 10, 'B+', 'sp2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (8, 11, 'B-', 'fa2014', '2014', 2, 'Grade');
INSERT INTO previous_class VALUES (7, 11, 'A-', 'fa2014', '2014', 2, 'Grade');
INSERT INTO previous_class VALUES (6, 11, 'B', 'wi2015', '2015', 2, 'Grade');
INSERT INTO previous_class VALUES (10, 11, 'B+', 'wi2015', '2015', 2, 'Grade');
INSERT INTO previous_class VALUES (11, 12, 'A', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (12, 12, 'A', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (13, 12, 'C-', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (14, 12, 'C+', 'fa2015', '2015', 4, 'Grade');
INSERT INTO previous_class VALUES (15, 14, 'F', 'sp2015', '2015', 2, 'Grade');
INSERT INTO previous_class VALUES (12, 14, 'D', 'sp2015', '2015', 2, 'Grade');
INSERT INTO previous_class VALUES (11, 14, 'A-', 'fa2015', '2015', 2, 'Grade');

-- make sample current quarter
INSERT INTO current_quarter VALUES(1, 11, 'sp', '2017',  'M,W,F', '10:00,am', DEFAULT, DEFAULT, 2);
INSERT INTO current_quarter VALUES(2, 8, 'sp', '2017', 'M,W,F', '10:00,am', DEFAULT, DEFAULT, 5);
INSERT INTO current_quarter VALUES(3, 6, 'sp', '2017', 'M,W,F', '12:00,pm', DEFAULT, DEFAULT, 5 );
INSERT INTO current_quarter VALUES(4, 13, 'sp', '2017', 'M,W,F', '12:00,pm', DEFAULT, DEFAULT, 2 );
INSERT INTO current_quarter VALUES(5, 8, 'sp', '2017', 'M,W,F', '12:00,pm', DEFAULT, DEFAULT, 3);
INSERT INTO current_quarter VALUES(6, 2, 'sp', '2017',  'T,Th', '2:00,pm', 'F', '6:00,pm', 3);
INSERT INTO current_quarter VALUES(7, 14, 'sp', '2017', 'T,Th', '3:00,pm', DEFAULT, DEFAULT, 3);
INSERT INTO current_quarter VALUES(8, 11, 'sp', '2017', 'T,Th', '3:00,pm', DEFAULT, DEFAULT, 1);
INSERT INTO current_quarter VALUES(9, 8, 'sp', '2017', 'T,Th', '5:00,pm', DEFAULT, DEFAULT, 2);
INSERT INTO current_quarter VALUES(10, 1, 'sp', '2017', 'T,Th', '5:00,pm', 'W', '7:00,pm', 5);

-- make sample enrollment limits
INSERT INTO current_enrollment VALUES(1, 2, 2);
INSERT INTO current_enrollment VALUES(2, 2, 5);
INSERT INTO current_enrollment VALUES(3, 3, 5);
INSERT INTO current_enrollment VALUES(4, 2, 2);
INSERT INTO current_enrollment VALUES(5, 2, 3);
INSERT INTO current_enrollment VALUES(6, 1, 3);
INSERT INTO current_enrollment VALUES(7, 2, 3);
INSERT INTO current_enrollment VALUES(8, 1, 1);
INSERT INTO current_enrollment VALUES(9, 2, 2);
INSERT INTO current_enrollment VALUES(10, 3, 5);

-- make sample lecture times
INSERT INTO lecture_info VALUES('10:00,am', 'M', DEFAULT, 1, 11);
INSERT INTO lecture_info VALUES('10:00,am', 'W', DEFAULT, 1, 11);
INSERT INTO lecture_info VALUES('10:00,am', 'F', DEFAULT, 1, 11);
INSERT INTO lecture_info VALUES('10:00,am', 'M', DEFAULT, 2, 8);
INSERT INTO lecture_info VALUES('10:00,am', 'W', DEFAULT, 2, 8);
INSERT INTO lecture_info VALUES('10:00,am', 'F', DEFAULT, 2, 8);
INSERT INTO lecture_info VALUES('12:00,pm', 'M', DEFAULT, 3, 6);
INSERT INTO lecture_info VALUES('12:00,pm', 'W', DEFAULT, 3, 6);
INSERT INTO lecture_info VALUES('12:00,pm', 'F', DEFAULT, 3, 6);
INSERT INTO lecture_info VALUES('12:00,pm', 'M', DEFAULT, 4, 13);
INSERT INTO lecture_info VALUES('12:00,pm', 'W', DEFAULT, 4, 13);
INSERT INTO lecture_info VALUES('12:00,pm', 'F', DEFAULT, 4, 13);
INSERT INTO lecture_info VALUES('12:00,pm', 'M', DEFAULT, 5, 8);
INSERT INTO lecture_info VALUES('12:00,pm', 'W', DEFAULT, 5, 8);
INSERT INTO lecture_info VALUES('12:00,pm', 'F', DEFAULT, 5, 8);
INSERT INTO lecture_info VALUES('2:00,pm', 'T', DEFAULT, 6, 2);
INSERT INTO lecture_info VALUES('2:00,pm', 'Th', DEFAULT, 6, 2);
INSERT INTO lecture_info VALUES('3:00,pm', 'T', DEFAULT, 7, 14);
INSERT INTO lecture_info VALUES('3:00,pm', 'Th', DEFAULT, 7, 14);
INSERT INTO lecture_info VALUES('3:00,pm', 'T', DEFAULT, 8, 11);
INSERT INTO lecture_info VALUES('3:00,pm', 'Th', DEFAULT, 8, 11);
INSERT INTO lecture_info VALUES('5:00,pm', 'T', DEFAULT, 9, 8);
INSERT INTO lecture_info VALUES('5:00,pm', 'Th', DEFAULT, 9, 8);
INSERT INTO lecture_info VALUES('5:00,pm', 'T', DEFAULT, 10, 1);
INSERT INTO lecture_info VALUES('5:00,pm', 'Th', DEFAULT, 10, 1);

-- make sample discussion times
INSERT INTO discussion_info VALUES('10:00,am', 'T', DEFAULT, 1, 11);
INSERT INTO discussion_info VALUES('10:00,am', 'Th', DEFAULT, 1, 11);
INSERT INTO discussion_info VALUES('11:00,am', 'T', DEFAULT, 2, 8);
INSERT INTO discussion_info VALUES('11:00,am', 'Th', DEFAULT, 2, 8);
INSERT INTO discussion_info VALUES('1:00,pm', 'W', DEFAULT, 4, 13);
INSERT INTO discussion_info VALUES('1:00,pm', 'F', DEFAULT, 4, 13);
INSERT INTO discussion_info VALUES('12:00,pm', 'T', DEFAULT, 5, 8);
INSERT INTO discussion_info VALUES('12:00,pm', 'Th', DEFAULT, 5, 8);
INSERT INTO discussion_info VALUES('6:00,pm', 'F', DEFAULT, 6, 2);
INSERT INTO discussion_info VALUES('1:00,pm', 'Th', DEFAULT, 7, 14);
INSERT INTO discussion_info VALUES('3:00,pm', 'M', DEFAULT, 8, 11);
INSERT INTO discussion_info VALUES('9:00,am', 'M', DEFAULT, 9, 8);
INSERT INTO discussion_info VALUES('9:00,am', 'F', DEFAULT, 9, 8);
INSERT INTO discussion_info VALUES('7:00,pm', 'W', DEFAULT, 10, 1);

-- make sample lab times
INSERT INTO lab_info VALUES('6:00,pm', 'F', DEFAULT, 1, 11);
INSERT INTO lab_info VALUES('5:00,pm', 'F', DEFAULT, 8, 11);
INSERT INTO lab_info VALUES('3:00,pm', 'T', DEFAULT, 10, 1);
INSERT INTO lab_info VALUES('3:00,pm', 'Th', DEFAULT, 10, 1);

-- make sample review sessions


-- make sample enrolled students
INSERT INTO enrolled_student VALUES(16, 2, 'Grade', 4);
INSERT INTO enrolled_student VALUES(17, 9, 'S/U', 4);
INSERT INTO enrolled_student VALUES(18, 5, 'Grade', 4);
INSERT INTO enrolled_student VALUES(19, 2, 'Grade', 4);
INSERT INTO enrolled_student VALUES(20, 9, 'Grade', 4);
INSERT INTO enrolled_student VALUES(21, 5, 'S/U', 4);
INSERT INTO enrolled_student VALUES(22, 3, 'Grade', 4);
INSERT INTO enrolled_student VALUES(16, 3, 'Grade', 4);
INSERT INTO enrolled_student VALUES(17, 3, 'Grade', 4);
INSERT INTO enrolled_student VALUES(1, 10, 'S/U', 4);
INSERT INTO enrolled_student VALUES(5, 10, 'Grade', 4);
INSERT INTO enrolled_student VALUES(3, 10, 'Grade', 4);
INSERT INTO enrolled_student VALUES(7, 1, 'Grade', 4);
INSERT INTO enrolled_student VALUES(8, 1, 'Grade', 4);
INSERT INTO enrolled_student VALUES(9, 8, 'Grade', 4);
INSERT INTO enrolled_student VALUES(4, 6, 'Grade', 4);
INSERT INTO enrolled_student VALUES(12, 4, 'Grade', 4);
INSERT INTO enrolled_student VALUES(13, 7, 'S/U', 4);
INSERT INTO enrolled_student VALUES(14, 4, 'Grade', 4);
INSERT INTO enrolled_student VALUES(15, 7, 'Grade', 4);

-- make sample faculty teaching
INSERT INTO faculty_teaching VALUES('Justin Bieber', 1, DEFAULT,'fa', '2014');
INSERT INTO faculty_teaching VALUES('Flo Rida', 3, DEFAULT, 'sp', '2016');
INSERT INTO faculty_teaching VALUES('Selena Gomez', 1, DEFAULT, 'fa', '2015');
INSERT INTO faculty_teaching VALUES('Adele', 11, 1, 'sp', '2017');
INSERT INTO faculty_teaching VALUES('Taylor Swift', 2, DEFAULT, 'wi', '2015');
INSERT INTO faculty_teaching VALUES('Kelly Clarkson', 1, DEFAULT, 'sp', '2015');
INSERT INTO faculty_teaching VALUES('Bjork', 4, DEFAULT, 'fa', '2015');
INSERT INTO faculty_teaching VALUES('Bjork', 12, DEFAULT, 'fa', '2016');
INSERT INTO faculty_teaching VALUES('Justin Bieber', 5, DEFAULT, 'wi', '2016');
INSERT INTO faculty_teaching VALUES('Flo Rida', 6, 3, 'sp', '2017');
INSERT INTO faculty_teaching VALUES('Selena Gomez', 11, 8, 'sp', '2017');
INSERT INTO faculty_teaching VALUES('Adele', 1, 10, 'sp', '2017');
INSERT INTO faculty_teaching VALUES('Taylor Swift', 2, 6, 'sp', '2017');
INSERT INTO faculty_teaching VALUES('Kelly Clarkson', 7, DEFAULT, 'fa', '2016');
INSERT INTO faculty_teaching VALUES('Adam Levine', 14, DEFAULT, 'fa', '2016');
INSERT INTO faculty_teaching VALUES('Bjork', 10, DEFAULT, 'sp', '2016');
INSERT INTO faculty_teaching VALUES('Justin Bieber', 8, 9, 'sp', '2017');
INSERT INTO faculty_teaching VALUES('Selena Gomez', 11, DEFAULT, 'wi', '2017');
INSERT INTO faculty_teaching VALUES('Adam Levine', 13, 4, 'sp', '2017');
INSERT INTO faculty_teaching VALUES('Bjork', 4, DEFAULT, 'fa', '2014');
INSERT INTO faculty_teaching VALUES('Taylor Swift', 14, 7, 'sp', '2017');
INSERT INTO faculty_teaching VALUES('Kelly Clarkson', 8, 2, 'sp', '2017');
INSERT INTO faculty_teaching VALUES('Kelly Clarkson', 8, 5, 'sp', '2017');

INSERT INTO faculty_teaching VALUES('Justin Bieber', 1, DEFAULT,'fa', '2016');

-- make sample MS concentrations
INSERT INTO ms_concentration VALUES(1, 4, 4, 3, 'Databases');
INSERT INTO ms_concentration VALUES(2, 4, 8, 3.1, 'AI');
INSERT INTO ms_concentration VALUES(3, 4, 4, 3.3, 'Systems');

-- make sample MS concentration req classes
INSERT INTO degree_course VALUES(1, 7);
INSERT INTO degree_course VALUES(2, 4);
INSERT INTO degree_course VALUES(2, 6);
INSERT INTO degree_course VALUES(3, 8);

-- make sample MS CSE tech electives
INSERT INTO tech_elective VALUES (4);
INSERT INTO tech_elective VALUES (8);
INSERT INTO tech_elective VALUES (2);
INSERT INTO tech_elective VALUES (10);
INSERT INTO tech_elective VALUES (9);

-- make sample lower division classes
INSERT INTO lower_division VALUES (1);
INSERT INTO lower_division VALUES (9);
INSERT INTO lower_division VALUES (12);
INSERT INTO lower_division VALUES (13);

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
