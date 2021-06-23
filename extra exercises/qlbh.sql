use demo2006;
-- BÀI TẬP ÔN TẬP SQL
-- Bài quản lý sản phẩm

-- 6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 19/6/2006 và ngày 20/6/2006.
select o.id,o.time,sum(p.price*od.quantity)as totall
from (demo2006.order o,demo2006.product p) join demo2006.orderdetail od 
on o.id =od.orderId and p.id= od.productId 
where o.time between '2006-06-19' and '2006-06-20'
group by o.id;

-- 7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 6/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
select o.id,o.time,sum(p.price*od.quantity)as total
from (demo2006.order o,demo2006.product p) join demo2006.orderdetail od 
on o.id =od.orderId and p.id= od.productId 
where o.time like '2006-06-%'
group by o.id
order by o.time asc , total desc;

-- 8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 20/06/2007.
select c.id,c.name,o.time
from demo2006.customer c join demo2006.order o on c.id =o.customerId
where o.time ='2006-06-20'
group by c.id;

-- 10. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
select c.name,p.id,p.name,o.time
from demo2006.customer c inner join demo2006.order o inner join demo2006.orderdetail od inner join demo2006.product p on 
c.id = o.customerId and o.id = od.orderId and p.id = od.productId
where c.id = o.customerId and o.id = od.orderId and p.id = od.productId and c.name ='Thao Pham' and o.time like '2006-10-%';

-- 11. Tìm các số hóa đơn đã mua sản phẩm “Máy giặt” hoặc “Tủ lạnh”.
select o.id as soHD,p.name as SpMua
from demo2006.order o inner join demo2006.orderdetail od inner join demo2006.product p on o.id = od.orderId and p.id=od.productId
where p.name = 'Máy giặt' or p.name = 'Tủ lạnh';

-- 12. Tìm các số hóa đơn đã mua sản phẩm “Máy giặt” hoặc “Tủ lạnh”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
select o.id as soHD,p.name as SpMua , od.quantity as soLuongMua
from demo2006.order o inner join demo2006.orderdetail od inner join demo2006.product p on o.id = od.orderId and p.id=od.productId
where (p.name = 'Máy giặt' or p.name = 'Tủ lạnh') and od.quantity between 10 and 20;

-- 13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm “Máy giặt” và “Tủ lạnh”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
-- Cach 1:
select o.id as soHD, group_concat(p.name separator ' ; ') as SPmua, p.name, od.quantity as soLuongMua
from demo2006.order o inner join demo2006.orderdetail od inner join demo2006.product p on o.id = od.orderId and p.id=od.productId
group by o.id
having (p.name = 'Máy giặt' or p.name = 'Tủ lạnh') and od.quantity between 10 and 20;

-- Cach 2:
select o.id as soHD, p.name, od.quantity 
from demo2006.order o inner join demo2006.orderdetail od inner join demo2006.product p on o.id = od.orderId and p.id=od.productId
where p.name = 'Máy giặt' 
and od.quantity between 10 and 20
and exists (select * from demo2006.order o1 inner join demo2006.orderdetail od1 inner join demo2006.product p1 on o1.id = od1.orderId and p1.id=od1.productId
where p1.name ='Tủ lạnh' and od1.quantity between 10 and 20 and o.id=o1.id);

-- 15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
-- Cach 1 :
select p.id as MaSP,p.name as TenSp
from demo2006.product p
where not exists( select * from demo2006.orderdetail od inner join demo2006.product p1 on p1.id = od.productId and p.id = p1.id);

-- Cach 2 :
select p.id as MaSP,p.name as TenSp
from demo2006.product p
where p.id not in (select productid from orderdetail);

-- 16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
select p.id as MaSP,p.name as TenSp,o.time
from demo2006.order o 
inner join demo2006.orderdetail od 
inner join demo2006.product p
on p.id = od.productId 
and o.id = od.orderId 
where p.id not in ( select p1.id from demo2006.order o1 
inner join demo2006.orderdetail od 
inner join demo2006.product p1 
on p1.id = od.productId 
and o1.id = od.orderId 
where o1.time like '2006%');

-- 17. In ra danh sách các sản phẩm (MASP,TENSP) có giá >300 sản xuất bán được trong năm 2006.
select p.id,p.name,p.price,o.time
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
where p.price>300 and o.time like '2006%'
group by p.id;

-- 18. Tìm số hóa đơn đã mua tất cả các sản phẩm có giá >200.
select o.id,p.id,group_concat( p.name separator ' ; ') as SPMuaGiaTren200,group_concat( p.price separator ' ; ') as GiaSPTuongUng
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
where p.price>200
group by o.id;

-- 19. Tìm số hóa đơn trong năm 2006 đã mua tất cả các sản phẩm có giá <300.
select o.id as SoHoaDon ,group_concat( p.name separator ' ; ') as SPGiaThapHon300 ,group_concat(p.price separator ' ; ') as GiaBanTuongUng , o.time as ThoiGianBan
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
where p.price<300 and o.time like '2006%'
group by o.id;
-- 21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
-- Cach1:
create view SPKhacNhau as
select p.id,p.name,o.time
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
where o.time like '2006%'
group by p.id;
select count(spkhacnhau.id) as SoLuongSanPhamKhacNhauBanRa2006
from spkhacnhau;

-- Cach 2:
select count(distinct p.id)
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
where o.time like '2006%';

-- 22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu?
create view TriGiaHD as
select o.id , sum(p.price*od.quantity) as TriGia
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
group by o.id;
select max(TriGiaHD.trigia) as TriGiaMaxIs
from trigiahd;
select min(TriGiaHD.trigia) as TriGiaMinIs
from trigiahd;

-- 23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
select avg(TriGiaHD2006.trigiahd) as TriGiaTB
from trigiahd2006;

-- 24. Tính doanh thu bán hàng trong năm 2006.
create view TriGiaHD2006 as
select o.id , sum(p.price*od.quantity) as TriGiaHD , o.time , c.name
from demo2006.customer c
inner join demo2006.order o 
inner join demo2006.orderdetail od 
inner join demo2006.product p 
on c.id =o.customerId and p.id = od.productId and o.id =od.orderId 
where o.time like '2006%'
group by o.id;
select sum(TriGiaHD2006.trigiahd) as DoanhThu2006
from trigiahd2006;

-- 25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
select trigiahd2006.id as SoHdCoTriGiaCaoNhat
from trigiahd2006
where trigiahd = (select max(trigiahd2006.trigiahd) from trigiahd2006);

-- 26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
select trigiahd2006.name as KhachHangCoHoaDonCaoNhat
from trigiahd2006
where trigiahd = (select max(trigiahd2006.trigiahd) from trigiahd2006);

-- 27. In ra danh sách 3 khách hàng (MAKH, HOTEN) mua nhiều hàng nhất (tính theo số lượng).
select c.id,c.name, count(od.orderid)as solanmuahang
from demo2006.customer c join demo2006.order o join demo2006.orderdetail od join demo2006.product p
on c.id = o.customerId and o.id = od.orderId and p.id = od.productId
group by c.id
order by solanmuahang desc
limit 3;

-- 28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
select p.id,p.name ,p.price
from demo2006.product p
order by p.price desc
limit 3
;

-- 29. In ra danh sách các sản phẩm (MASP, TENSP) có tên bắt đầu bằng chữ M, có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
select p.id,p.name ,p.price
from demo2006.product p
where p.name like 'M%'
order by p.price desc
limit 3
;
-- 32. Tính tổng số sản phẩm giá <300.
select count(p.price)
from demo2006.product p
where p.price<300;

-- 33. Tính tổng số sản phẩm theo từng giá.
select p.price as MucGia , count(p.name) as SoSanPhamCoCungMucGia
from demo2006.product p
group by p.price;

-- 34. Tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm bắt đầu bằng chữ M.
select  max(p.price) as GiaCaoNhat ,min(p.price) as GiaThapNhat, avg(p.price) as GiaTB
from demo2006.product p
where p.name like 'M%';

-- 35. Tính doanh thu bán hàng mỗi ngày.
select o.id , sum(p.price*od.quantity) as DoanhThu, o.time
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
group by o.time;

-- 36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
select p.name, sum(od.quantity) as TongSPBanThang10
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
where o.time like '2006-10-%'
group by p.id;


-- 37. Tính doanh thu bán hàng của từng tháng trong năm 2006.
select o.id , sum(p.price*od.quantity) as DoanhThu, month(o.time) as Month
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
where o.time like '2006-%'
group by month(o.time);

-- 38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
select o.id
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
group by o.id
having count(distinct p.id)>=4;

-- 39. Tìm hóa đơn có mua 3 sản phẩm có giá <300 (3 sản phẩm khác nhau).
select o.id , p.price
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
group by o.id
having count(distinct p.id) = 3 and (select price from product where price<300);


-- 40. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
select c.id,c.name, count(od.orderid)as solanmuahang
from demo2006.customer c join demo2006.order o join demo2006.orderdetail od join demo2006.product p
on c.id = o.customerId and o.id = od.orderId and p.id = od.productId
group by c.id
order by solanmuahang desc
limit 1;

-- 41. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất?
create view DoanhSoThang as
select o.id , sum(p.price*od.quantity) as DoanhThu, month(o.time) as Month
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
where o.time like '2006-%'
group by month(o.time);
select DoanhSoThang.Month,DoanhSoThang.DoanhThu
from DoanhSoThang
where DoanhSoThang.DoanhThu =(select max(DoanhSoThang.DoanhThu ) from DoanhSoThang );

-- 42. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
create view LuongBanSP2006 as
select p.name, sum(od.quantity) as TongSPBan2006
from demo2006.product p 
inner join demo2006.orderdetail od 
inner join demo2006.order o 
on p.id = od.productId and o.id =od.orderId
where o.time like '2006%'
group by p.id;
select LuongBanSP2006.name, min(LuongBanSP2006.TongSPBan2006) as LuongBan
from LuongBanSP2006;

-- 45. Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
create view DoanhSo as
select o.id , sum(p.price*od.quantity) as TriGia,c.name,count(od.orderid)as solanmuahang
from demo2006.customer c 
join demo2006.order o 
join demo2006.orderdetail od 
join demo2006.product p
on c.id = o.customerId 
and o.id = od.orderId and p.id = od.productId
group by o.id;
select DoanhSo.id , sum(DoanhSo.TriGia) as DoanhSoByCus , DoanhSo.name , sum(DoanhSo.solanmuahang) as SoLanMua
from DoanhSo
where DoanhSo.solanmuahang =(select max(DoanhSo.solanmuahang)  from Doanhso)
group by DoanhSo.name 
order by DoanhSoByCus desc
limit 10;