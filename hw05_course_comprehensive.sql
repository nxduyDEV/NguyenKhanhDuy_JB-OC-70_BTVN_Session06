-- Tạo bảng Course
create table Course (
    id serial primary key,
    title varchar(100),
    instructor varchar(50),
    price numeric(10,2),
    duration int -- số giờ học
);

-- Thêm ít nhất 6 khóa học vào bảng
insert into Course (title, instructor, price, duration) values
('SQL FUNDAMENTALS', 'NGUYEN VAN MINH', 890000.00, 25),
('ADVANCED SQL QUERIES', 'TRAN THI HONG', 1250000.00, 35),
('PYTHON PROGRAMMING', 'LE VAN THANH', 1680000.00, 40),
('WEB DEVELOPMENT DEMO', 'PHAM THI LAN', 750000.00, 20),
('DATABASE DESIGN', 'HOANG VAN NAM', 1450000.00, 32),
('SQL SERVER ADMINISTRATION', 'VU THI HIEN', 1890000.00, 45),
('BASIC HTML CSS', 'NGUYEN THI MAI', 450000.00, 15),
('JAVA PROGRAMMING DEMO', 'TRAN VAN DUC', 1120000.00, 38);

-- Hiển thị danh sách khóa học ban đầu
select 'DANH SACH KHOA HOC BAN DAU:' as thong_tin;
select * from Course order by id;

-- 1. Cập nhật giá tăng 15% cho các khóa học có thời lượng trên 30 giờ
update Course 
set price = price * 1.15 
where duration > 30;

-- Hiển thị khóa học sau khi tăng giá
select 'KHOA HOC SAU KHI TANG GIA 15% (DURATION > 30H):' as thong_tin;
select * from Course 
where duration > 30 
order by duration desc;

-- 2. Xóa khóa học có tên chứa từ khóa "Demo"
delete from Course 
where lower(title) like '%demo%';

-- Hiển thị danh sách sau khi xóa
select 'DANH SACH SAU KHI XOA KHOA HOC CHUA "DEMO":' as thong_tin;
select * from Course order by id;

-- 3. Hiển thị các khóa học có tên chứa từ "SQL" (không phân biệt hoa thường)
select 'KHOA HOC CO TEN CHUA TU "SQL":' as thong_tin;
select * from Course 
where lower(title) like '%sql%' 
order by price desc;

-- 4. Lấy 3 khóa học có giá nằm giữa 500,000 và 2,000,000, sắp xếp theo giá giảm dần
select '3 KHOA HOC CO GIA TU 500K-2M (GIA GIAM DAN):' as thong_tin;
select * from Course 
where price between 500000 and 2000000 
order by price desc 
limit 3;

-- Các truy vấn bổ sung để thực hành tổng hợp

-- Thêm khóa học mới để test thêm
insert into Course (title, instructor, price, duration) values
('MYSQL ADVANCED COURSE', 'PHAN VAN LONG', 1350000.00, 28),
('POSTGRESQL FOR BEGINNERS', 'NGUYEN THI HUONG', 980000.00, 22);

select 'DANH SACH SAU KHI THEM KHOA HOC MOI:' as thong_tin;
select * from Course order by id;

-- Tìm khóa học có giá cao nhất và thấp nhất
select 'KHOA HOC CO GIA CAO NHAT:' as thong_tin;
select * from Course 
where price = (select max(price) from Course);

select 'KHOA HOC CO GIA THAP NHAT:' as thong_tin;
select * from Course 
where price = (select min(price) from Course);

-- Cập nhật giảm giá 10% cho khóa học có thời lượng dưới 25 giờ
update Course 
set price = price * 0.9 
where duration < 25;

select 'SAU KHI GIAM GIA 10% CHO KHOA HOC < 25H:' as thong_tin;
select * from Course 
where duration < 25 
order by duration;

-- Tìm giảng viên có tên chứa "NGUYEN"
select 'GIANG VIEN CO HO "NGUYEN":' as thong_tin;
select distinct instructor from Course 
where lower(instructor) like '%nguyen%' 
order by instructor;

-- Hiển thị khóa học theo khoảng giá
select 'KHOA HOC THEO KHOANG GIA:' as thong_tin;
select 
    case 
        when price < 500000 then 'DUOI 500K'
        when price between 500000 and 1000000 then '500K - 1M'
        when price between 1000001 and 1500000 then '1M - 1.5M'
        else 'TREN 1.5M'
    end as khoang_gia,
    count(*) as so_luong_khoa_hoc,
    avg(price) as gia_trung_binh
from Course 
group by 
    case 
        when price < 500000 then 'DUOI 500K'
        when price between 500000 and 1000000 then '500K - 1M'
        when price between 1000001 and 1500000 then '1M - 1.5M'
        else 'TREN 1.5M'
    end
order by avg(price);

-- Phân trang khóa học (pagination)
select 'TRANG 1 (3 KHOA HOC DAU TIEN THEO GIA):' as thong_tin;
select * from Course 
order by price 
limit 3 offset 0;

select 'TRANG 2 (3 KHOA HOC TIEP THEO):' as thong_tin;
select * from Course 
order by price 
limit 3 offset 3;

-- Tìm khóa học có thời lượng trong khoảng 25-35 giờ
select 'KHOA HOC CO THOI LUONG 25-35 GIO:' as thong_tin;
select * from Course 
where duration between 25 and 35 
order by duration, price;

-- Thống kê tổng hợp
select 'THONG KE TONG HOP KHOA HOC:' as thong_tin;
select 
    count(*) as tong_so_khoa_hoc,
    count(distinct instructor) as so_giang_vien,
    max(price) as gia_cao_nhat,
    min(price) as gia_thap_nhat,
    avg(price) as gia_trung_binh,
    sum(duration) as tong_thoi_luong,
    avg(duration) as thoi_luong_trung_binh
from Course;

-- Tìm khóa học có giá trên mức trung bình
select 'KHOA HOC CO GIA TREN MUC TRUNG BINH:' as thong_tin;
select * from Course 
where price > (select avg(price) from Course) 
order by price desc;

-- Update giá cho khóa học cụ thể dựa trên title
update Course 
set price = price + 100000 
where lower(title) like '%advanced%';

select 'SAU KHI TANG GIA 100K CHO KHOA HOC "ADVANCED":' as thong_tin;
select * from Course 
where lower(title) like '%advanced%';

-- Xem danh sách cuối cùng
select 'DANH SACH KHOA HOC CUOI CUNG:' as thong_tin;
select * from Course order by price desc;