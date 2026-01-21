-- Tạo bảng Employee
create table Employee (
    id serial primary key,
    full_name varchar(100),
    department varchar(50),
    salary numeric(10,2),
    hire_date date
);

-- Thêm 6 nhân viên mới
insert into Employee (full_name, department, salary, hire_date) values
('NGUYEN VAN AN', 'IT', 8500000.00, '2023-03-15'),
('TRAN THI HOAN', 'HR', 7200000.00, '2022-11-20'),
('LE MINH QUAN', 'IT', 9800000.00, '2023-07-10'),
('PHAM THI LOAN', 'MARKETING', 6500000.00, '2023-05-25'),
('HOANG VAN THANH', 'FINANCE', 5800000.00, '2022-09-12'),
('VU THI XUAN', 'IT', 10200000.00, '2023-02-28');

-- Hiển thị danh sách nhân viên ban đầu
select 'DANH SACH NHAN VIEN BAN DAU:' as thong_tin;
select * from Employee order by id;

-- 1. Cập nhật mức lương tăng 10% cho nhân viên thuộc phòng IT
update Employee 
set salary = salary * 1.10 
where department = 'IT';

-- Hiển thị nhân viên IT sau khi tăng lương
select 'NHAN VIEN IT SAU KHI TANG LUONG 10%:' as thong_tin;
select * from Employee 
where department = 'IT' 
order by id;

-- 2. Xóa nhân viên có mức lương dưới 6,000,000
delete from Employee 
where salary < 6000000;

-- Hiển thị danh sách nhân viên sau khi xóa
select 'DANH SACH NHAN VIEN SAU KHI XOA LUONG DUOI 6 TRIEU:' as thong_tin;
select * from Employee order by id;

-- 3. Liệt kê các nhân viên có tên chứa chữ "An" (không phân biệt hoa thường)
select 'NHAN VIEN CO TEN CHUA CHU "AN":' as thong_tin;
select * from Employee 
where lower(full_name) like '%an%' 
order by full_name;

-- 4. Hiển thị các nhân viên có ngày vào làm việc trong khoảng từ '2023-01-01' đến '2023-12-31'
select 'NHAN VIEN VAO LAM TRONG NAM 2023:' as thong_tin;
select * from Employee 
where hire_date between '2023-01-01' and '2023-12-31' 
order by hire_date;

-- Các truy vấn bổ sung để phân tích dữ liệu

-- Thống kê số lượng nhân viên theo phòng ban
select 'THONG KE NHAN VIEN THEO PHONG BAN:' as thong_tin;
select department, count(*) as so_luong_nhan_vien, 
       avg(salary) as luong_trung_binh
from Employee 
group by department 
order by so_luong_nhan_vien desc;

-- Hiển thị nhân viên có lương cao nhất và thấp nhất
select 'NHAN VIEN CO LUONG CAO NHAT:' as thong_tin;
select * from Employee 
where salary = (select max(salary) from Employee);

select 'NHAN VIEN CO LUONG THAP NHAT:' as thong_tin;
select * from Employee 
where salary = (select min(salary) from Employee);

-- Tìm nhân viên làm việc lâu nhất
select 'NHAN VIEN LAM VIEC LAU NHAT:' as thong_tin;
select *, (current_date - hire_date) as so_ngay_lam_viec
from Employee 
where hire_date = (select min(hire_date) from Employee);

-- Hiển thị mức lương theo từng khoảng
select 'PHAN BO LUONG THEO KHOANG:' as thong_tin;
select 
    case 
        when salary < 7000000 then 'DUOI 7 TRIEU'
        when salary between 7000000 and 9000000 then '7-9 TRIEU'
        when salary between 9000001 and 11000000 then '9-11 TRIEU'
        else 'TREN 11 TRIEU'
    end as khoang_luong,
    count(*) as so_luong_nhan_vien
from Employee 
group by 
    case 
        when salary < 7000000 then 'DUOI 7 TRIEU'
        when salary between 7000000 and 9000000 then '7-9 TRIEU'
        when salary between 9000001 and 11000000 then '9-11 TRIEU'
        else 'TREN 11 TRIEU'
    end
order by min(salary);