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
SET FOREIGN_KEY_CHECKS=0;
SET SQL_SAFE_UPDATES = 0
select *from student;
#3-1.把peoples表中school不是GDUFS的人全部找出来？（包括school为NULL的人）写出MySQL语句。
select *from people where school != 'GDUFS'or school is NULL;
#3-2.查找计算机系每次考试学生的平均成绩(最终显示学生姓名, 考试名称, 平均分)。
select exam_name,avg(grade) from exam,student where exam.student_ID=student.ID and dept_name='computer' group by exam_name;
#3-3.查找女学霸（考试平均分达到80分或80分以上的女生的姓名, 分数）。
select name,avg(grade) from exam,student where exam.student_ID=student.ID and sex='f' group by name having avg(grade)>=80;
#3-4.找出人数最少的院系以及其年度预算。
select department.dept_name,budget from student,department where student.dept_name=department.dept_name group by dept_name order by count(department.dept_name) asc limit 0,1;
#3-5.计算机系改名了，改成计算机科学系（comp. sci.），写出mysql语句。
SET FOREIGN_KEY_CHECKS=0;
update department set dept_name = 'comp. sci.' where dept_name = 'computer';
#3-6.修改每个系的年度预算，给该系的每个学生发2000元奖金。（修改每个系的年度预算为 原预算+该系人数*2000）。
SET SQL_SAFE_UPDATES = 0；
update department set budget = budget+(select count(dept_name) from student where department.dept_name = dept_name)*2000;
#3-7.向department表中插入一条数据, dept_name属性的值为avg_budget, building为空, 年度预算为所有院系的年度预算平均值.
insert into department(dept_name,building,budget) values('avg_budget',NULL,select avg(budget) from department);
#3-8. 删除计算机系中考试成绩平均分低于70的学生.
delete from student where ID in(select ID from(select ID from student,exam  where ID = student_ID and student.dept_name = 'comp. sci.' group by student_ID having avg(grade)<70)as a);
#3-9.找出所有正在谈恋爱,但是学习成绩不佳(考试平均分低于75)的学生,强制将其情感状态改为单身.
update student 
set emotion_state = 'single'
where emotion_state = 'loving' 
and name in (
    select name from(select name 
    from student, exam 
    where ID = student_ID 
    and dept_name = 'comp. sci.'
    group by name 
    having avg(grade) < 75)as a
)

