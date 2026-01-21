-- Tạo bảng Orders
create table Orders (
    id serial primary key,
    customer_id int,
    order_date date,
    total_amount numeric(10,2)
);

-- Thêm dữ liệu mẫu đủ để test các aggregate functions
insert into Orders (customer_id, order_date, total_amount) values
-- Năm 2022
(101, '2022-01-15', 2500000.00),
(102, '2022-02-20', 3200000.00),
(103, '2022-03-10', 1800000.00),
(104, '2022-05-18', 4500000.00),
(105, '2022-07-22', 2900000.00),
(106, '2022-09-14', 5600000.00),
(107, '2022-11-08', 3300000.00),
(108, '2022-12-25', 4200000.00),
-- Năm 2023
(109, '2023-01-12', 6800000.00),
(110, '2023-02-28', 3500000.00),
(111, '2023-04-15', 7200000.00),
(112, '2023-06-30', 5400000.00),
(113, '2023-08-18', 8900000.00),
(114, '2023-10-22', 4300000.00),
(115, '2023-11-14', 6700000.00),
(116, '2023-12-31', 9200000.00),
-- Năm 2024
(117, '2024-01-08', 12500000.00),
(118, '2024-02-14', 8600000.00),
(119, '2024-03-22', 15200000.00),
(120, '2024-05-10', 11800000.00),
(121, '2024-06-25', 13900000.00),
(122, '2024-08-12', 9400000.00),
(123, '2024-09-30', 16700000.00),
(124, '2024-11-18', 14300000.00),
(125, '2024-12-15', 18500000.00);

-- Hiển thị tất cả dữ liệu ban đầu
select 'DANH SACH TAT CA DON HANG:' as thong_tin;
select * from Orders order by order_date;

-- 1. Hiển thị tổng doanh thu, số đơn hàng, giá trị trung bình mỗi đơn (dùng SUM, COUNT, AVG)
-- Đặt bí danh cột lần lượt là total_revenue, total_orders, average_order_value
select 'THONG KE TONG QUAN:' as thong_tin;
select 
    sum(total_amount) as total_revenue,
    count(*) as total_orders,
    avg(total_amount) as average_order_value
from Orders;

-- 2. Nhóm dữ liệu theo năm đặt hàng, hiển thị doanh thu từng năm (GROUP BY EXTRACT(YEAR FROM order_date))
select 'DOANH THU THEO NAM:' as thong_tin;
select 
    extract(year from order_date) as order_year,
    sum(total_amount) as yearly_revenue,
    count(*) as yearly_orders,
    avg(total_amount) as yearly_average,
    min(total_amount) as min_order_value,
    max(total_amount) as max_order_value
from Orders 
group by extract(year from order_date) 
order by order_year;

-- 3. Chỉ hiển thị các năm có doanh thu trên 50 triệu (HAVING)
select 'NAM CO DOANH THU TREN 50 TRIEU:' as thong_tin;
select 
    extract(year from order_date) as high_revenue_year,
    sum(total_amount) as yearly_revenue,
    count(*) as total_orders_in_year
from Orders 
group by extract(year from order_date) 
having sum(total_amount) > 50000000
order by yearly_revenue desc;

-- 4. Hiển thị 5 đơn hàng có giá trị cao nhất (dùng ORDER BY + LIMIT)
select 'TOP 5 DON HANG GIA TRI CAO NHAT:' as thong_tin;
select 
    id as order_id,
    customer_id,
    order_date,
    total_amount as highest_amount
from Orders 
order by total_amount desc 
limit 5;

-- Các truy vấn bổ sung để luyện tập aggregate functions

-- Thống kê theo tháng của năm hiện tại (2024)
select 'DOANH THU THEO THANG NAM 2024:' as thong_tin;
select 
    extract(month from order_date) as order_month,
    count(*) as monthly_orders,
    sum(total_amount) as monthly_revenue,
    avg(total_amount) as monthly_average
from Orders 
where extract(year from order_date) = 2024
group by extract(month from order_date) 
order by order_month;

-- Tìm customer có tổng giá trị đơn hàng cao nhất
select 'KHACH HANG CO TONG GIA TRI DON HANG CAO NHAT:' as thong_tin;
select 
    customer_id,
    count(*) as total_orders_per_customer,
    sum(total_amount) as total_spent,
    avg(total_amount) as average_per_order,
    max(total_amount) as highest_single_order
from Orders 
group by customer_id 
order by total_spent desc 
limit 3;

-- Sử dụng HAVING với điều kiện khác: chỉ hiển thị customer có ít nhất 2 đơn hàng
select 'KHACH HANG CO IT NHAT 2 DON HANG:' as thong_tin;
select 
    customer_id,
    count(*) as order_count,
    sum(total_amount) as total_value,
    avg(total_amount) as avg_order_value
from Orders 
group by customer_id 
having count(*) >= 2
order by order_count desc, total_value desc;

-- Thống kê theo quý
select 'DOANH THU THEO QUY:' as thong_tin;
select 
    extract(year from order_date) as year,
    extract(quarter from order_date) as quarter,
    count(*) as quarterly_orders,
    sum(total_amount) as quarterly_revenue,
    avg(total_amount) as quarterly_average
from Orders 
group by extract(year from order_date), extract(quarter from order_date) 
order by year, quarter;

-- Sử dụng nhiều aggregate functions với alias
select 'THONG KE CHI TIET VOI ALIAS:' as thong_tin;
select 
    count(distinct customer_id) as unique_customers,
    count(*) as total_transactions,
    sum(total_amount) as gross_revenue,
    avg(total_amount) as mean_order_value,
    min(total_amount) as smallest_order,
    max(total_amount) as largest_order,
    max(total_amount) - min(total_amount) as value_range,
    stddev(total_amount) as standard_deviation
from Orders;

-- Phân tích theo khoảng giá trị đơn hàng
select 'PHAN TICH THEO KHOANG GIA TRI:' as thong_tin;
select 
    case 
        when total_amount < 3000000 then 'DUOI 3 TRIEU'
        when total_amount between 3000000 and 7000000 then '3-7 TRIEU'
        when total_amount between 7000001 and 12000000 then '7-12 TRIEU'
        else 'TREN 12 TRIEU'
    end as price_range,
    count(*) as order_count,
    sum(total_amount) as range_revenue,
    avg(total_amount) as range_average
from Orders 
group by 
    case 
        when total_amount < 3000000 then 'DUOI 3 TRIEU'
        when total_amount between 3000000 and 7000000 then '3-7 TRIEU'
        when total_amount between 7000001 and 12000000 then '7-12 TRIEU'
        else 'TREN 12 TRIEU'
    end
order by min(total_amount);

-- HAVING với điều kiện phức tạp hơn
select 'NAM CO DOANH THU TREN 50 TRIEU VA IT NHAT 8 DON:' as thong_tin;
select 
    extract(year from order_date) as profitable_year,
    count(*) as total_orders,
    sum(total_amount) as total_revenue,
    avg(total_amount) as avg_order_value
from Orders 
group by extract(year from order_date) 
having sum(total_amount) > 50000000 and count(*) >= 8
order by total_revenue desc;

-- Tìm tháng có doanh thu cao nhất trong mỗi năm
select 'THANG CO DOANH THU CAO NHAT MOI NAM:' as thong_tin;
select 
    extract(year from order_date) as year,
    extract(month from order_date) as best_month,
    sum(total_amount) as monthly_revenue
from Orders o1
where not exists (
    select 1 from Orders o2 
    where extract(year from o2.order_date) = extract(year from o1.order_date)
    and extract(month from o2.order_date) != extract(month from o1.order_date)
    group by extract(month from o2.order_date)
    having sum(o2.total_amount) > sum(o1.total_amount)
)
group by extract(year from order_date), extract(month from order_date)
order by year, monthly_revenue desc;