-- Tạo bảng OrderInfo
create table OrderInfo (
    id serial primary key,
    customer_id int,
    order_date date,
    total numeric(10,2),
    status varchar(20)
);

-- Thêm 5 đơn hàng mẫu với tổng tiền khác nhau
insert into OrderInfo (customer_id, order_date, total, status) values
(101, '2024-10-15', 750000.00, 'COMPLETED'),
(102, '2024-10-22', 320000.00, 'PENDING'),
(103, '2024-09-18', 1200000.00, 'COMPLETED'),
(104, '2024-10-05', 680000.00, 'SHIPPED'),
(105, '2024-11-12', 450000.00, 'CANCELLED');

-- Hiển thị danh sách đơn hàng ban đầu
select 'DANH SACH DON HANG BAN DAU:' as thong_tin;
select * from OrderInfo order by id;

-- 1. Truy vấn các đơn hàng có tổng tiền lớn hơn 500,000
select 'DON HANG CO TONG TIEN LON HON 500,000:' as thong_tin;
select * from OrderInfo 
where total > 500000 
order by total desc;

-- 2. Truy vấn các đơn hàng có ngày đặt trong tháng 10 năm 2024
select 'DON HANG TRONG THANG 10 NAM 2024:' as thong_tin;
select * from OrderInfo 
where order_date between '2024-10-01' and '2024-10-31' 
order by order_date;

-- Cách khác sử dụng extract
select 'DON HANG THANG 10/2024 (CACH KHAC):' as thong_tin;
select * from OrderInfo 
where extract(year from order_date) = 2024 
and extract(month from order_date) = 10 
order by order_date;

-- 3. Liệt kê các đơn hàng có trạng thái khác "Completed"
select 'DON HANG CO TRANG THAI KHAC "COMPLETED":' as thong_tin;
select * from OrderInfo 
where status != 'COMPLETED' 
order by order_date desc;

-- Cách khác sử dụng NOT
select 'DON HANG KHAC "COMPLETED" (DUNG NOT):' as thong_tin;
select * from OrderInfo 
where not status = 'COMPLETED' 
order by order_date desc;

-- 4. Lấy 2 đơn hàng mới nhất
select '2 DON HANG MOI NHAT:' as thong_tin;
select * from OrderInfo 
order by order_date desc 
limit 2;

-- Các truy vấn bổ sung với toán tử so sánh

-- Đơn hàng có tổng tiền trong khoảng từ 400,000 đến 800,000
select 'DON HANG CO TONG TIEN TU 400,000 DEN 800,000:' as thong_tin;
select * from OrderInfo 
where total between 400000 and 800000 
order by total;

-- Đơn hàng có tổng tiền nhỏ hơn hoặc bằng 500,000
select 'DON HANG CO TONG TIEN <= 500,000:' as thong_tin;
select * from OrderInfo 
where total <= 500000 
order by total desc;

-- Đơn hàng có tổng tiền bằng chính xác 680,000
select 'DON HANG CO TONG TIEN BANG 680,000:' as thong_tin;
select * from OrderInfo 
where total = 680000;

-- Đơn hàng có customer_id lớn hơn 102
select 'DON HANG CO CUSTOMER_ID > 102:' as thong_tin;
select * from OrderInfo 
where customer_id > 102 
order by customer_id;

-- Sử dụng IN để tìm đơn hàng với nhiều trạng thái
select 'DON HANG CO TRANG THAI COMPLETED HOAC SHIPPED:' as thong_tin;
select * from OrderInfo 
where status in ('COMPLETED', 'SHIPPED') 
order by order_date;

-- Đơn hàng có ngày đặt trước tháng 11/2024
select 'DON HANG TRUOC THANG 11/2024:' as thong_tin;
select * from OrderInfo 
where order_date < '2024-11-01' 
order by order_date desc;

-- Thống kê theo trạng thái
select 'THONG KE DON HANG THEO TRANG THAI:' as thong_tin;
select 
    status,
    count(*) as so_luong_don_hang,
    sum(total) as tong_gia_tri,
    avg(total) as gia_tri_trung_binh,
    min(total) as gia_tri_thap_nhat,
    max(total) as gia_tri_cao_nhat
from OrderInfo 
group by status 
order by so_luong_don_hang desc;

-- Thống kê theo tháng
select 'THONG KE DON HANG THEO THANG:' as thong_tin;
select 
    extract(year from order_date) as nam,
    extract(month from order_date) as thang,
    count(*) as so_luong_don_hang,
    sum(total) as tong_gia_tri
from OrderInfo 
group by extract(year from order_date), extract(month from order_date)
order by nam, thang;

-- Tìm đơn hàng có giá trị cao nhất và thấp nhất
select 'DON HANG CO GIA TRI CAO NHAT:' as thong_tin;
select * from OrderInfo 
where total = (select max(total) from OrderInfo);

select 'DON HANG CO GIA TRI THAP NHAT:' as thong_tin;
select * from OrderInfo 
where total = (select min(total) from OrderInfo);

-- Đơn hàng có tổng tiền trên mức trung bình
select 'DON HANG CO GIA TRI TREN MUC TRUNG BINH:' as thong_tin;
select * from OrderInfo 
where total > (select avg(total) from OrderInfo) 
order by total desc;