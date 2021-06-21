use quanlysinhvien;
insert into class(classid,classname,startdate,status)
value(1,'A1','2018-12-20',1),
	(2,'A2','2018-12-22',1),
	(3,'B3',current_date,1);
insert into student(studentname,address,phone,status,classid)
value('Hung','Ha Noi','0912113113',1,1),	
	('Hoa','Hai Phong',null,1,1),
	('Manh','HCM','0123123123',0,2);
insert into subject(subid,subname,credit,status)
value(1,'CF',5,1),	
	(2,'C',6,1),
	(3,'HDJ',5,1),
	(4,'RDBMS',10,1); 
insert into mark(subid,studentid,mark,examtimes)
value(1,1,8,1),	
	(1,2,10,2),
	(2,1,12,1);
 /* Hien thi danh sach tat ca hoc vien*/
 select *
 from student;
 
 /*Hiển thị danh sách các học viên đang theo học*/
select *
from student
where status = true;

select *
from subject
where credit < 10;	 

/*Hiển thị danh sách học viên lớp A1*/
select *
from student 
where classid = 1;    
/*Hiển thị điểm môn CF của các học viên.*/
select student.studentname,mark.mark,subject.subname
from student, subject, mark
where subject.subname='CF';
	