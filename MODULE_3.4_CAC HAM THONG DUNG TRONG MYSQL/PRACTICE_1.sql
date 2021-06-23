use quanlysinhvien;
/*Hiển thị số lượng sinh viên ở từng nơi*/
select address, count(student.studentid) as qtystudentbyaddress
from student
group by address;

/*Tính điểm trung bình các môn học của mỗi học viên*/
select s.studentid, s.studentname ,avg(m.mark) 
from student s join mark m on s.studentid=m.studentid
group by s.studentid , s.studentname;
/*Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 15*/
select s.studentid, s.studentname ,avg(m.mark) 
from student s join mark m on s.studentid=m.studentid
group by s.studentid , s.studentname
having avg(m.mark)>15;

/*Hiển thị thông tin các học viên có điểm trung bình lớn nhất.*/
select s.studentid, s.studentname ,avg(m.mark) 
from student s join mark m on s.studentid=m.studentid
group by s.studentid , s.studentname
having avg(m.mark)>=all(select avg(mark)from mark group by mark.studentid);