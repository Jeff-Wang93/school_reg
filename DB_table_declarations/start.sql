--  make sample students
INSERT INTO student VALUES (111, 1, 'Jack' , 'C', 'Doe');
INSERT INTO student VALUES (222, 2, 'Helga', DEFAULT , 'Johnson');
INSERT INTO student VALUES (333, 3, 'Marie', DEFAULT , 'Smith');
INSERT INTO student VALUES (444, 4, 'Kobe' , DEFAULT , 'Bryant');

-- make sample faculty
INSERT INTO faculty VALUES ('Alan' , 'Professor');
INSERT INTO faculty VALUES ('Nick' , 'TA');
INSERT INTO faculty VALUES ('Vicky', 'TA');

-- make sample departments
INSERT INTO department VALUES (1, 'CSE');
INSERT INTO department VALUES (2, 'ECE');

-- make sample courses
INSERT INTO course VALUES (1, 4  , 'Grade', 'CSE132B', 'FALSE', 1);
INSERT INTO course VALUES (2, 4  , 'Grade', 'CSE132A', 'FALSE', 1);
INSERT INTO course VALUES (3, 4  , 'Both' , 'CSE135' , 'FALSE', 1);
INSERT INTO course VALUES (4, '1,4', 'S/U'  , 'ECE141' , 'TRUE' , 2);

-- make sample classes
INSERT INTO classes VALUES (1, 'CSE132B', 20, 'SP17', '2017', 'Alan' , 1);
INSERT INTO classes VALUES (2, 'CSE132B', 20, 'SP17', '2017', 'Alan' , 1);
INSERT INTO classes VALUES (3, 'CSE135' , 20, 'SP17', '2017', 'Nick' , 3);
INSERT INTO classes VALUES (4, 'ECE141' , 20, 'SP17', '2017', 'Vicky', 4);

-- make sample enrolled students
INSERT INTO enrolled_student VALUES (1, 1, 4);
INSERT INTO enrolled_student VALUES (1, 3, 4);
INSERT INTO enrolled_student VALUES (1, 4, 4);
INSERT INTO enrolled_student VALUES (2, 1, 4);
INSERT INTO enrolled_student VALUES (2, 3, 4);
INSERT INTO enrolled_student VALUES (3, 3, 4);
INSERT INTO enrolled_student VALUES (3, 4, 4);

