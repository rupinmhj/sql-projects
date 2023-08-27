create database college_erd;

use college_erd;

create table Professor(prof_num int not null primary key,dept_code varchar(10), prof_speciality varchar(30), prof_rank int, prof_lname varchar(25),prof_fname varchar(30),
prof_initial varchar(25), prof_email varchar(30));

create table Department( dept_code varchar(20) not null primary key, dept_name varchar(30), school_code varchar(20), prof_num int);

-- adding a foreign key( dept_code)
alter table Professor add foreign key(dept_code) references Department(dept_code);
desc Professor;

create table School(school_code varchar(20) not null primary key, school_name varchar(30), prof_num int , foreign key (prof_num) references Professor(prof_num));
desc School;

create table Semester (semester_code varchar(20) not null primary key, semester_year int, semester_term varchar(20), semester_start_date date, semester_end_date date);

create table Course (crs_code varchar(20) not null primary key, crs_title varchar(30), crs_description varchar( 30), crs_credit varchar(20), dept_code varchar(20), 
foreign key (dept_code) references Department(dept_code));
desc Course;

create table Student( stu_num int not null primary key, stu_lname varchar(20), stu_fname varchar(20), stu_initial varchar(30), stu_email varchar(30),dept_code varchar(20),prof_num int,
foreign key(dept_code) references Department(dept_code), foreign key(prof_num) references Professor(prof_num));
desc Student;

create table Building(bldg_code varchar(20) not null primary key, bldg_name varchar(30),bldg_location varchar(30));

create table Room(room_code varchar(20) not null primary key, room_type varchar(30), bldg_code varchar(20), foreign key(bldg_code) references Building(bldg_code));
desc Room;

create table Class(class_code varchar(20) not null primary key, class_section varchar(3),class_time time, crs_code varchar(20) , prof_num int, 
room_code varchar(20), semester_code varchar(20), foreign key(crs_code) references Course(crs_code), foreign key(prof_num) references Professor(prof_num),
foreign key(room_code) references Room(room_code),foreign key(semester_code) references Semester(semester_code));

CREATE TABLE Enroll (
    class_code VARCHAR(20),
    stu_num INT,
    enroll_date DATE,
    enroll_grade VARCHAR(20),
    PRIMARY KEY (class_code, stu_num),
    FOREIGN KEY (class_code) REFERENCES Class(class_code),
    FOREIGN KEY (stu_num) REFERENCES Student(stu_num)
);

show tables;

-- create table Professor(prof_num int not null primary key,dept_code varchar(10), prof_speciality varchar(30), prof_rank int, prof_lname varchar(25),prof_fname varchar(30),
-- prof_initial varchar(25), prof_email varchar(30));

-- inserting values in the tables
insert into Professor(prof_num,prof_speciality,prof_rank,prof_lname,prof_fname,prof_initial,prof_email) values(10001,"Physics",3,"Jonas","Nick","PHD","jonasnick@gmail.com");
 select * from Professor;
 
 insert into Professor(prof_num,prof_speciality,prof_rank,prof_lname,prof_fname,prof_initial,prof_email) values(10002,"Chemistry",4,"Thomas","Henry","PHD","thomashenry@gmail.com");
insert into Professor(prof_num,prof_speciality,prof_rank,prof_lname,prof_fname,prof_initial,prof_email) values(10003,"Mathematics",5,"White","Walter","PHD","mathematicswhite07@gmail.com");


-- create table Student( stu_num int not null primary key, stu_lname varchar(20), stu_fname varchar(20), stu_initial varchar(30), stu_email varchar(30),dept_code varchar(20),prof_num int,
-- foreign key(dept_code) references Department(dept_code), foreign key(prof_num) references Professor(prof_num));

insert into Student(stu_num,stu_lname,stu_fname,stu_initial,stu_email,prof_num) values(20001,"Maharjan","Roman","Bachelor","romanmaharjan07@gmail.com",10001);
insert into Student(stu_num,stu_lname,stu_fname,stu_initial,stu_email,prof_num) values(20002,"Ghimire","Sadik","Bachelor","sadikghimire04@gmail.com",10002);
insert into Student(stu_num,stu_lname,stu_fname,stu_initial,stu_email,prof_num) values(20003,"Maharjan","Suman","Bachelor","sumanmaharjan09@gmail.com",10001);

-- create table School(school_code varchar(20) not null primary key, school_name varchar(30), prof_num int , foreign key (prof_num) references Professor(prof_num));

insert into School values("Sc5001","St. Mary",10001);
insert into School values("Sc5003","St. Paul",10002);
insert into School values("Sc5005","St. Louis",10003);

-- create table Department( dept_code varchar(20) not null primary key, dept_name varchar(30), school_code varchar(20), prof_num int);

insert into Department values("D61","English","Sc5001",10001);
insert into Department values("D62","IT","Sc5002",10002);
insert into Department values("D63","Science","Sc5002",10001);


-- create table Semester (semester_code varchar(20) not null primary key, semester_year int, semester_term varchar(20), semester_start_date date, semester_end_date date);

insert into Semester values("Se701",2020,"2nd",'2018-01-01','2021-12-30');
insert into Semester values("Se702",2020,"2nd",'2019-01-01','2022-12-30');
insert into Semester values("Se703",2020,"2nd",'2018-01-01','2021-12-30');


-- create table Course (crs_code varchar(20) not null primary key, crs_title varchar(30), crs_description varchar( 30), crs_credit varchar(20), dept_code varchar(20), 
-- foreign key (dept_code) references Department(dept_code));

insert into Course values("CR301","Major English","Analyze diverse texts.","260 hrs","D61");
insert into Course values("CR302","Computer Network","Analyze diverse networks.","265 hrs","D62");
insert into Course values("CR303","Quantum Physics","Analyze diverse quanta.","280 hrs","D63");

insert into Building values("Bld5","Gokuldham","Gpregaun");
insert into Building values("Bld6","Sydney Colony","Sydney");
insert into Building values("Bld7","Melbourne Colony","Melbourne");

 -- table Room(room_code varchar(20) not null primary key, room_type varchar(30), bldg_code varchar(20), foreign key(bldg_code) references Building(bldg_code));

insert into Room values("R401","Classroom", "Bld5");
insert into Room values("R402","Store room", "Bld6");
insert into Room values("R407","Library", "Bld7");

-- create table Class(class_code varchar(20) not null primary key, class_section varchar(3),class_time time, crs_code varchar(20) , prof_num int, 
-- room_code varchar(20), semester_code varchar(20), foreign key(crs_code) references Course(crs_code), foreign key(prof_num) references Professor(prof_num),
-- foreign key(room_code) references Room(room_code),foreign key(semester_code) references Semester(semester_code));

insert into Class values("CS801","A","9:00:00","CR301",10001,"R401","Se701");
insert into Class values("CS802","B","10:00:00","CR302",10002,"R402","Se702");
insert into Class values("CS803","C","9:00:00","CR303",10003,"R407","Se703");


-- CREATE TABLE Enroll (
--     class_code VARCHAR(20),
--     stu_num INT,
--     enroll_date DATE,
--     enroll_grade VARCHAR(20),
--     PRIMARY KEY (class_code, stu_num),
--     FOREIGN KEY (class_code) REFERENCES Class(class_code),
--     FOREIGN KEY (stu_num) REFERENCES Student(stu_num)
-- );
insert into Enroll values("CS801",20001,'2019-01-01','A');
insert into Enroll values("CS802",20002,'2019-01-01','B');
insert into Enroll values("CS803",20003,'2019-01-01','C');

update Professor set dept_code="D61" where prof_num=10001;
update Professor set dept_code="D62" where prof_num=10002;
update Professor set dept_code="D63" where prof_num=10003;

select * from Enroll;

-- left outer join between professor and school
select prof_speciality,prof_rank,prof_lname,prof_fname,prof_initial,school_name from Professor left outer join School on Professor.prof_num=school.prof_num;

-- right outer join between professor and student
select * from Professor left outer join Student on Professor.prof_num=Student.prof_num;

-- full outer join between professor and class
select * from Professor left outer join Class on Professor.prof_num=Class.prof_num union
select * from Professor right outer join Class on Professor.prof_num=Class.prof_num ;






























