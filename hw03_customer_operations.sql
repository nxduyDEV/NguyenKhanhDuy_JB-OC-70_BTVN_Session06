-- Tạo bảng Customer
create table Customer (
    id serial primary key,
    name varchar(100),
    email varchar(100),
    phone varchar(20),
    points int
);

-- Thêm 7 khách hàng (trong đó có 1 người không có email)
insert into Customer (name, email, phone, points) values
('NGUYEN VAN MINH', 'minh.nguyen@gmail.com', '0901234567', 850),
('TRAN THI HONG', 'hong.tran@yahoo.com', '0912345678', 1200),
('LE VAN THANH', null, '0923456789', 650),  -- Khách hàng không có email
('PHAM THI LAN', 'lan.pham@hotmail.com', '0934567890', 1500),
('HOANG VAN MINH', 'minh.hoang@gmail.com', '0945678901', 980),
('VU THI HIEN', 'hien.vu@outlook.com', '0956789012', 750),
('NGUYEN THI MINH', 'minh.nguyen.2@gmail.com', '0967890123', 1350);

-- Hiển thị danh sách khách hàng ban đầu
select 'DANH SACH KHACH HANG BAN DAU:' as thong_tin;
select * from Customer order by id;

-- 1. Truy vấn danh sách tên khách hàng duy nhất (DISTINCT)
select 'DANH SACH TEN KHACH HANG DUY NHAT:' as thong_tin;
select distinct name from Customer 
order by name;

-- Hiển thị chi tiết để so sánh với distinct
select 'SO SANH: TAT CA TEN KHACH HANG (CO TRUNG LAP):' as thong_tin;
select name from Customer 
order by name;

-- 2. Tìm các khách hàng chưa có email (IS NULL)
select 'KHACH HANG CHUA CO EMAIL:' as thong_tin;
select * from Customer 
where email is null;

-- Bổ sung: khách hàng có email
select 'KHACH HANG CO EMAIL:' as thong_tin;
select * from Customer 
where email is not null 
order by name;

-- 3. Hiển thị 3 khách hàng có điểm thưởng cao nhất, bỏ qua khách hàng cao điểm nhất (OFFSET)
select 'TOP 3 KHACH HANG CO DIEM THUONG CAO NHAT (BO QUA HANG 1):' as thong_tin;
select * from Customer 
order by points desc 
limit 3 offset 1;

-- Hiển thị để so sánh: tất cả khách hàng sắp xếp theo điểm
select 'TAT CA KHACH HANG SAP XEP THEO DIEM GIAM DAN:' as thong_tin;
select * from Customer 
order by points desc;

-- 4. Sắp xếp danh sách khách hàng theo tên giảm dần
select 'DANH SACH KHACH HANG SAP XEP THEO TEN GIAM DAN:' as thong_tin;
select * from Customer 
order by name desc;

-- Các truy vấn bổ sung để thực hành thêm

-- Sử dụng DISTINCT với nhiều cột
select 'DISTINCT THEO EMAIL DOMAIN:' as thong_tin;
select distinct 
    case 
        when email is null then 'KHONG CO EMAIL'
        when email like '%@gmail.com' then 'GMAIL'
        when email like '%@yahoo.com' then 'YAHOO'
        when email like '%@hotmail.com' then 'HOTMAIL'
        when email like '%@outlook.com' then 'OUTLOOK'
        else 'KHAC'
    end as email_provider,
    count(*) as so_luong
from Customer 
group by 
    case 
        when email is null then 'KHONG CO EMAIL'
        when email like '%@gmail.com' then 'GMAIL'
        when email like '%@yahoo.com' then 'YAHOO'
        when email like '%@hotmail.com' then 'HOTMAIL'
        when email like '%@outlook.com' then 'OUTLOOK'
        else 'KHAC'
    end
order by so_luong desc;

-- Thực hành LIMIT và OFFSET với các kịch bản khác
select 'TOP 2 KHACH HANG DIEM THAP NHAT:' as thong_tin;
select * from Customer 
order by points asc 
limit 2;

select '2 KHACH HANG TIEP THEO CO DIEM THAP (BO QUA 2 THAP NHAT):' as thong_tin;
select * from Customer 
order by points asc 
limit 2 offset 2;

-- Phân trang dữ liệu (pagination)
select 'TRANG 1 (3 KHACH HANG DAU TIEN):' as thong_tin;
select * from Customer 
order by name 
limit 3 offset 0;

select 'TRANG 2 (3 KHACH HANG TIEP THEO):' as thong_tin;
select * from Customer 
order by name 
limit 3 offset 3;

select 'TRANG 3 (KHACH HANG CON LAI):' as thong_tin;
select * from Customer 
order by name 
limit 3 offset 6;

-- Thống kê tổng hợp
select 'THONG KE TONG HOP:' as thong_tin;
select 
    count(*) as tong_so_khach_hang,
    count(email) as so_khach_hang_co_email,
    count(*) - count(email) as so_khach_hang_khong_co_email,
    max(points) as diem_cao_nhat,
    min(points) as diem_thap_nhat,
    avg(points) as diem_trung_binh,
    sum(points) as tong_diem
from Customer;