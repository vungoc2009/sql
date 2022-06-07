/* I. CREATE TABLES */

-- faculty (Khoa trong trường)
create table faculty (
	id number primary key,
	name nvarchar2(30) not null
);

-- subject (Môn học)
create table subject(
	id number primary key,
	name nvarchar2(100) not null,
	lesson_quantity number(2,0) not null -- tổng số tiết học
);

-- student (Sinh viên)
create table student (
	id number primary key,
	name nvarchar2(30) not null,
	gender nvarchar2(10) not null, -- giới tính
	birthday date not null,
	hometown nvarchar2(100) not null, -- quê quán
	scholarship number, -- học bổng
	faculty_id number not null constraint faculty_id references faculty(id) -- mã khoa
);

-- exam management (Bảng điểm)
create table exam_management(
	id number primary key,
	student_id number not null constraint student_id references student(id),
	subject_id number not null constraint subject_id references subject(id),
	number_of_exam_taking number not null, -- số lần thi (thi trên 1 lần được gọi là thi lại) 
	mark number(4,2) not null -- điểm
);



/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
insert into subject (id, name, lesson_quantity) values (1, n'Cơ sở dữ liệu', 45);
insert into subject values (2, n'Trí tuệ nhân tạo', 45);
insert into subject values (3, n'Truyền tin', 45);
insert into subject values (4, n'Đồ họa', 60);
insert into subject values (5, n'Văn phạm', 45);


-- faculty
insert into faculty values (1, n'Anh - Văn');
insert into faculty values (2, n'Tin học');
insert into faculty values (3, n'Triết học');
insert into faculty values (4, n'Vật lý');


-- student
insert into student values (1, n'Nguyễn Thị Hải', n'Nữ', to_date('19900223', 'YYYYMMDD'), 'Hà Nội', 130000, 2);
insert into student values (2, n'Trần Văn Chính', n'Nam', to_date('19921224', 'YYYYMMDD'), 'Bình Định', 150000, 4);
insert into student values (3, n'Lê Thu Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 150000, 2);
insert into student values (4, n'Lê Hải Yến', n'Nữ', to_date('19900221', 'YYYYMMDD'), 'TP HCM', 170000, 2);
insert into student values (5, n'Trần Anh Tuấn', n'Nam', to_date('19901220', 'YYYYMMDD'), 'Hà Nội', 180000, 1);
insert into student values (6, n'Trần Thanh Mai', n'Nữ', to_date('19910812', 'YYYYMMDD'), 'Hải Phòng', null, 3);
insert into student values (7, n'Trần Thị Thu Thủy', n'Nữ', to_date('19910102', 'YYYYMMDD'), 'Hải Phòng', 10000, 1);


-- exam_management
insert into exam_management values (1, 1, 1, 1, 3);
insert into exam_management values (2, 1, 1, 2, 6);
insert into exam_management values (3, 1, 2, 2, 6);
insert into exam_management values (4, 1, 3, 1, 5);
insert into exam_management values (5, 2, 1, 1, 4.5);
insert into exam_management values (6, 2, 1, 2, 7);
insert into exam_management values (7, 2, 3, 1, 10);
insert into exam_management values (8, 2, 5, 1, 9);
insert into exam_management values (9, 3, 1, 1, 2);
insert into exam_management values (10, 3, 1, 2, 5);
insert into exam_management values (11, 3, 3, 1, 2.5);
insert into exam_management values (12, 3, 3, 2, 4);
insert into exam_management values (13, 4, 5, 2, 10);
insert into exam_management values (14, 5, 1, 1, 7);
insert into exam_management values (15, 5, 3, 1, 2.5);
insert into exam_management values (16, 5, 3, 2, 5);
insert into exam_management values (17, 6, 2, 1, 6);
insert into exam_management values (18, 6, 4, 1, 10);
--A BASIC QUERY
-- 1. Liệt kê danh sách sinh viên sắp xếp theo thứ tự:
--      a. id tăng dần
--      b. giới tính
--      c. ngày sinh TĂNG DẦN và học bổng GIẢM DẦN
SELECT * FROM student ORDER BY student.id;

-- Cau 1b 
SELECT * FROM student ORDER BY student.gender;

-- Cau 1c 
SELECT * FROM student ORDER BY student.birthday ASC , student.scholarship DESC;

-- 2. Môn học có tên bắt đầu bằng chữ 'T'
SELECT subject.name FROM subject WHERE subject.name LIKE 'T%';

-- 3. Sinh viên có chữ cái cuối cùng trong tên là 'i'
SELECT student.name FROM student WHERE student.name LIKE '%i';

-- 4. Những khoa có ký tự thứ hai của tên khoa có chứa chữ 'n'
SELECT faculty.name  FROM faculty where faculty.name like '_n%';

-- 5. Sinh viên trong tên có từ 'Thị'
SELECT student.name FROM student WHERE student.name LIKE '%Thị%';

-- 6. Sinh viên có ký tự đầu tiên của tên nằm trong khoảng từ 'a' đến 'm', sắp xếp theo họ tên sinh viên

SELECT student.name FROM student WHERE student.name BETWEEN 'a' and 'm' GROUP BY student.name;

-- 7. Sinh viên có học bổng lớn hơn 100000, sắp xếp theo mã khoa giảm dần
select student.name, student.scholarship , student.faculty_id from student where student.scholarship > 100000 order by faculty_id desc;

-- 8. Sinh viên có học bổng từ 150000 trở lên và sinh ở Hà Nội

select student.name, student.scholarship,student.hometown from student where student.scholarship > 150000 and student.hometown = 'Hà Nộii';

-- 9. Những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày 05/06/1992
select student.name , student.birthday from student WHERE student.birthday BETWEEN TO_DATE('01/01/1991','DD/MM/YYYY') and TO_DATE('05/06/1992','DD/MM/YYYY');

-- 10. Những sinh viên có học bổng từ 80000 đến 150000
select * from student where student.scholarship between 80000 and 150000;

-- 11. Những môn học có số tiết lớn hơn 30 và nhỏ hơn 45
select subject.name , subject.lesson_quantity from Subject WHERE subject.lesson_quantity BETWEEN 30 and 45;


-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho biết thông tin về mức học bổng của các sinh viên, gồm: Mã sinh viên, Giới tính, Mã 
		-- khoa, Mức học bổng. Trong đó, mức học bổng sẽ hiển thị là “Học bổng cao” nếu giá trị 
		-- của học bổng lớn hơn 500,000 và ngược lại hiển thị là “Mức trung bình”.
select student.id, gender, student.faculty_id, 
case when scholarship > 500000 then 'Học bổng cao' else 'Học bổng trung bình' end scholarship
from student;
-- 2. Tính tổng số sinh viên của toàn trường
select count(id)as SUM_Student from Student ;

-- 3. Tính tổng số sinh viên nam và tổng số sinh viên nữ.
select student.gender, count(id)as sumGender from student GROUP BY student.gender;

-- 4. Tính tổng số sinh viên từng khoa
select faculty.name , count(student.id)  from student , faculty where faculty.id = student.id group by faculty.name;

-- 5. Tính tổng số sinh viên của từng môn học
select subject.name, count(exam_management.student_id) from exam_management, subject where subject.id = exam_management.subject_id group by subject.name;

-- 6. Tính số lượng môn học mà sinh viên đã học
select student_id, count(subject_id) from exam_management group by student_id;

-- 7. Tổng số học bổng của mỗi khoa	
select faculty.name , count(student.scholarship) from faculty , student where student.faculty_id = faculty.id GROUP by faculty.name;

-- 8. Cho biết học bổng cao nhất của mỗi khoa
select faculty.name , max(student.scholarship) from faculty , student  where student.faculty_id = faculty.id GROUP by faculty.name;

-- 9. Cho biết tổng số sinh viên nam và tổng số sinh viên nữ của mỗi khoa
select faculty.name, gender, count(student.id) total from student, faculty where gender = 'Nam' and faculty.id = student.faculty_id group by faculty.name, gender
union
select faculty.name, gender, count(student.id) total from student, faculty where gender = 'Nữ' and faculty.id = student.faculty_id group by faculty.name, gender;

-- 10. Cho biết số lượng sinh viên theo từng độ tuổii
select student.birthday , count (student.id) from student group by student.birthday;

-- 11. Cho biết những nơi nào có ít nhất 2 sinh viên đang theo học tại trường
select student.hometown , count (student.id) from student GROUP by student.hometown having count(student.id)>2;

-- 12. Cho biết những sinh viên thi lại ít nhất 2 lần
select student.name , exam_management.subject_id , count (exam_management.number_of_exam_taking)
from student , exam_management
where student.id = exam_management.student_id
GROUP by student.name, exam_management.subject_id
having count (exam_management.number_of_exam_taking)>=2;

-- 13. Cho biết những sinh viên nam có điểm trung bình lần 1 trên 7.0 
select student.name , avg(exam_management.mark) 
from student , exam_management
where student.id = exam_management.id and exam_management.number_of_exam_taking = 1 and student.gender ='Nam'
group by student.name
having avg(exam_management.mark) >7;
-- 14. Cho biết danh sách các sinh viên rớt ít nhất 2 môn ở lần thi 1 (rớt môn là điểm thi của môn không quá 4 điểm)
select student.name 
from student , exam_management
where student.id = exam_management.id and exam_management.number_of_exam_taking = 1 and exam_management.mark <=4
group by student.name;

-- 15. Cho biết danh sách những khoa có nhiều hơn 2 sinh viên nam
select faculty.name , count(student.gender)
from student , faculty
where student.faculty_id = faculty.id and student.gender ='Nam'
group by faculty.name
having count(student.gender) >2;

-- 16. Cho biết những khoa có 2 sinh viên đạt học bổng từ 200000 đến 300000
select faculty.name , count(student.id)
from student , faculty
where  student.scholarship BETWEEN 200000 and 300000
group by faculty.name
having count(student.id) > 2;

-- 17. Cho biết sinh viên nào có học bổng cao nhất
select student.name , max(student.scholarship)
from student 
where student.scholarship = (select max(student.scholarship) from student)
GROUP by student.name;

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có nơi sinh ở Hà Nội và sinh vào tháng 02
select student.name , student.birthday from student
where student.hometown = N'Hà N?i' and extract(month from student.birthday) = 2;

-- 2. Sinh viên có tuổi lớn hơn 20
select student.name from student 
where extract(year from CURRENT_DATE) - EXTRACT(year from student.birthday) >20;
-- 3. Sinh viên sinh vào mùa xuân năm 1990
select student.name from student
where EXTRACT (year from student.birthday) = 1990 and  EXTRACT (month from student.birthday) between 1 and 3;

select * from student
where extract(year from birthday)= 1990
    and extract(month from birthday) between 1 and 3;


-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên của khoa ANH VĂN và khoa VẬT LÝ
select student.name from student join faculty on student.faculty_id = faculty.id
where faculty.name ='Anh - Văn' or faculty.name ='Vật lý';
-- 2. Những sinh viên nam của khoa ANH VĂN và khoa TIN HỌC
select student.name from student join faculty on student.faculty_id = faculty.id where
(faculty.name ='Anh - Văn' or faculty.name ='Tin Học') and student.gender = 'Nam';
-- 3. Cho biết sinh viên nào có điểm thi lần 1 môn cơ sở dữ liệu cao nhất
select student.name , exam_management 
from student join exam_management
where 
-- 4. Cho biết sinh viên khoa anh văn có tuổi lớn nhất.

-- 5. Cho biết khoa nào có đông sinh viên nhất

-- 6. Cho biết khoa nào có đông nữ nhất

-- 7. Cho biết những sinh viên đạt điểm cao nhất trong từng môn

-- 8. Cho biết những khoa không có sinh viên học

-- 9. Cho biết sinh viên chưa thi môn cơ sở dữ liệu

-- 10. Cho biết sinh viên nào không thi lần 1 mà có dự thi lần 2

