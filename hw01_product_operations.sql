-- Tạo bảng Product
create table Product (
    id serial primary key,
    name varchar(100),
    category varchar(50),
    price numeric(10,2),
    stock int
);

-- Thêm 10 sản phẩm mẫu vào bảng
insert into Product (name, category, price, stock) values
('IPHONE 15 PRO MAX', 'ĐIỆN TỬ', 29990000.00, 25),
('SAMSUNG GALAXY S24 ULTRA', 'ĐIỆN TỬ', 26990000.00, 18),
('MACBOOK PRO M3', 'ĐIỆN TỬ', 45990000.00, 12),
('SONY WH-1000XM5', 'ĐIỆN TỬ', 8990000.00, 30),
('NIKE AIR MAX 270', 'THỜI TRANG', 3290000.00, 45),
('ADIDAS ULTRABOOST 22', 'THỜI TRANG', 4590000.00, 35),
('DELL XPS 13', 'ĐIỆN TỬ', 32990000.00, 8),
('BOSE QUIETCOMFORT 45', 'ĐIỆN TỬ', 7490000.00, 22),
('LOUIS VUITTON KEEPALL', 'THỜI TRANG', 85000000.00, 3),
('ROLEX SUBMARINER', 'PHỤ KIỆN', 250000000.00, 2);

-- 1. Hiển thị danh sách toàn bộ sản phẩm
select * from Product;

-- 2. Hiển thị 3 sản phẩm có giá cao nhất
select * from Product 
order by price desc 
limit 3;

-- 3. Hiển thị các sản phẩm thuộc danh mục "Điện tử" có giá nhỏ hơn 10,000,000
select * from Product 
where category = 'ĐIỆN TỬ' and price < 10000000;

-- 4. Sắp xếp sản phẩm theo số lượng tồn kho tăng dần
select * from Product 
order by stock asc;

-- Các truy vấn bổ sung để hiển thị thông tin chi tiết

-- Hiển thị tổng số sản phẩm theo danh mục
select category, count(*) as so_luong_san_pham
from Product 
group by category;

-- Hiển thị giá trung bình theo danh mục
select category, avg(price) as gia_trung_binh
from Product 
group by category;

-- Hiển thị sản phẩm có tồn kho ít nhất
select * from Product 
where stock = (select min(stock) from Product);

-- Hiển thị tổng giá trị tồn kho theo danh mục
select category, sum(price * stock) as tong_gia_tri_ton_kho
from Product 
group by category 
order by tong_gia_tri_ton_kho desc;