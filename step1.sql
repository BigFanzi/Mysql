create database university;
use university;
create table department(
	     dept_name varchar(20) NOT NULL,
         building varchar(20) NOT NULL,
         budget float(20),
         PRIMARY key (dept_name)
);
create table exam(
		 student_ID int(5) NOT NULL auto_increment,
         exam_name varchar(20) NOT NULL,
         grade int(3),
         PRIMARY key (student_ID,exam_name),
         foreign key (student_ID)  references student(ID)
);
create table student(
		 ID int(5) NOT NULL auto_increment,
         sex char(1),
         age int(3),
         emotion_state varchar(20),
         dept_name varchar(20) NOT NULL,
         PRIMARY key (ID),
         foreign key (dept_name)  references department(dept_name)
);