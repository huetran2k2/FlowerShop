create database ketthucmon_project; 
use ketthucmon_project;

create table LoaiHoa (
	MaLoai char(5) primary key,
	TenLoai varchar (50)
);
drop table loaihoa;
create table TenLoaiHoa (
	MaHoa char(5) primary key,
	MaLoai char(5),
    TenHoa varchar (50),
    foreign key (MaLoai) references LoaiHoa (MaLoai)
    );
Create table NCC (
	MaNCC char (5) primary key , 
    TenNCC varchar (50),
    Diachi varchar (100),
    Sdt varchar (20)
    );
drop table nhanvien;
create table NhanVien (
	MaNV char(5) primary key,
    TenNV varchar (50),
    GioiTinh enum ("Nam","Nữ","Khác"),
    username varchar (30),
    pass varchar (10)
    );
create table Hoadonnhap (
	maHD char (5) primary key,
    NgayNhap date,
    MaNCC char (5),
    MaNV char (5),
    Note varchar (50)
);

create table Chitiethoadonnhap (
	MaHD char  (5) primary key,
    MaHoa char (5),
    Soluong int,
    DonGiaNhap varchar (10),
    foreign key (MaHD) references HoaDonNhap (MaHD),
    foreign key (MaHoa) references TenLoaiHoa (MaHoa)
    );
Drop table hoadonban;    
create table HoaDonBan (
	MaHD char (5) primary key ,
    MaNV char (5),
    NgayLapHD date,
    MaKH char (5)
);

create table ChiTietHoaDonBan (
	MaHD char (5) primary key ,
    MaHoa char (5),
    SoLuong int,
    Dongiaban varchar(10),
    Phivanchuyen varchar (10),
    foreign key (MaHD) references HoaDonBan (MaHD),
    foreign key (MaHoa) references TenLoaiHoa (MaHoa)
    );
drop table chitiethoadonban;
drop table khachhang;

Create table KhachHang (
	MaKH char (5) primary key ,
    TenKH varchar (50),
    Diachi varchar (100),
    Sdt varchar (20)
);
drop table khuyenmai;
create table khuyenmai (
MaKM char (5) primary key ,
TenCT varchar(50),
MaLoai char (5),
Mucgiam varchar (20),
foreign key (Maloai) references Loaihoa(maloai)
);
drop table tinhtrangdonhang;
create table tinhtrangdonhang (
MaHD char (5) primary key,
TinhTrang varchar (50),
foreign key (maHD) references hoadonban (maHD)
);
drop table tinhtrangdonhang;

create table DonDatHang(
MaHD char(5),
Ngayguihang datetime,
ngaynhanhang datetime,
foreign key (MaHD) references HoaDonBan (MaHD)
);

insert into LoaiHoa
values
("LH001","Hoa khai trương"),
("LH002","Hoa tình yêu"),
("LH003","Hoa giỏ"),
("LH004","Hoa tang lễ"),
("LH005","Hoa bó"),
("LH006","Hoa chậu"),
("LH007","Hoa lan điệp");

insert into TenLoaiHoa
values 
("KT001","LH001","Hoa Hướng Dương"),
("KT002","LH001","Hoa Đồng Tiền"),
("KT003","LH001","Hoa Cẩm Tú Cầu"),
("TY001","LH002","Hoa Hồng"),
("TY002","LH002","Hoa Cẩm Chướng"),
("HG001","LH003","Hoa Mười Giờ"),
("HG002","LH003","Hoa Dạ Yến Thảo"),
("TL001","LH004","Hoa Cúc Trắng"),
("TL002","LH004","Hoa Ly Trắng"),
("HB001","LH005","Hoa Vàng Hoàng Kim"),
("HB002","LH005","Hoa Cúc Pingpong"),
("HC001","LH006","Thường Xuân"),
("HC002","LH006","Dương xỉ"),
("LD001","LH007","Lan Hồ Điệp"),
("LD002","Lh007","Lan Phi Điệp");

insert into NCC
values
("NC001","SHOP HOA LAN NGHI","7A/5/16 Thành Thái Phường 14 Quận 10 TP.Hồ Chí Minh","0928470010"),
("NC002","CÔNG TY CỔ PHẦN ĐIÊN HOA TOÀN QUỐC"," 51 Nguyễn Khang, Quận Cầu Giấy, TP.Hà Nội","099589859"),
("NC003","CÔNG TY CỔ PHẦN THẾ GIỚI CÂY VÀ HOA","P830 HH4B, Khu Đô Thị Linh Đàm, Quận Hoàng Mai, TP Hà Nội","084358798"),
("NC004","SHOP HOA TƯƠI BÍCH NGỌC","155/2 Trung Chánh, Hóc Môn, Tp.Hồ Chí Minh","048937597"),
("NC005","CÔNG TY TNHH LINH NGỌC","1B Nguyễn Đình Chiểu, P.9, Tp.Đà Lạt, Lâm Đồng","00453050");

insert into NhanVien 
values
("NV001","Trần Thị Huế","Nữ","hue.tran23@gmail","123456"),
("NV002","Nguyễn Thị Nhi","Nữ","nhi.nguyen@gmail","985938"),
("NV004","Hoàng Nhật Minh","Nam","minhhoang@gamail","859399"),
("NV005","Lê Minh Anh","Nam","anhle@gmail","587934"),
("NV006","Hoàng Thị Kim Loan","Nữ","loanhoang@gamil","089538"),
("NV007","An Nhien","Nữ","nhienan@gmail","849328");
drop table hoadonnhap;
insert into HoaDonNhap 
values
("DN001","2021/10/02","NC001","NV001",""),
("DN002","2021/10/02","NC001","NV001",""),
("DN003","2021/10/06","NC002","NV002",""),
("DN004","2021/10/08","NC003","NV003",""),
("DN005","2021/10/08","NC004","NV004",""),
("DN006","2021/10/09","NC005","NV005",""),
("DN007","2021/10/05","NC005","NV006",""),
("DN008","2021/10/07","NC005","NV003",""),
("DN009","2021/10/09","NC005","NV003",""),
("DN010","2021/10/02","NC003","NV005",""),
("DN011","2021/10/05","NC002","NV002",""),
("DN012","2021/10/09","NC003","NV001",""),
("DN013","2021/10/03","NC004","NV002",""),
("DN014","2021/10/05","NC005","NV004",""),
("DN015","2021/10/05","Nc005","NV002","");
 insert into TinhTrangDonHang
 values 
 ("DB001","Đang giao hàng"),
 ("DB002","Mới đặt hàng"),
 ("DB003","Đã hoàn thành"),
 ("DB004","Đã hoàn thành"),
 ("DB005","Đã hoàn thành"),
 ("DB006","Đã hoàn thành"),
 ("DB007","Đang chuẩn bị hàng"),
 ("DB008","Đã hoàn thành"),
 ("DB009","Hủy đơn hàng");

insert into Chitiethoadonnhap
values
("DN001","KT001","5","500000"),
("DN002","KT002","10","600000"),
("DN003","KT003","6","700000"),
("DN004","TY001","9","200000"),
("DN005","TY002","12","300000"),
("DN006","HG001","9","850000"),
("DN007","HG002","10","640000"),
("DN008","TL001","3","400000"),
("DN009","TL002","4","550000"),
("DN010","HB001","25","300000"),
("DN011","HB002","10","400000"),
("DN012","HC001","7","600000"),
("DN013","HC002","3","790000"),
("DN014","LD001","5","1000.000"),
("DN015","LD002","10","1150000");

insert into HoaDonBan
values 
("DB001","NV001","2021/10/16","KH001"),
("DB002","NV002","2021/10/17","KH002"),
("DB003","NV003","2021/10/13","KH003"),
("DB004","NV004","2021/10/19","KH004"),
("DB005","NV001","2021/10/16","KH005"),
("DB006","NV002","2021/10/17","KH006"),
("DB007","NV007","2021/10/14","KH007"),
("DB008","NV005","2021/10/19","KH008"),
("DB009","NV006","2021/10/13","KH009");

insert into Chitiethoadonban
values
("DB001","KT001","2","600000","15000"),
("DB002","KT002","4","750000","25000"),
("DB003","KT003","5","250000","20000"),
("DB004","TY001","7","370000","10000"),
("DB005","TY002","2","700000","15000"),
("DB006","HG001","1","450000","10000"),
("DB007","HG002","1","1100000","20000"),
("DB008","TL001","1","450000","25000"),
("DB009","TL002","1","1100000","30000");


insert into KhachHang
values
("KH001","Nguyễn Ngọc Ánh","25 Hoàng Diệu, Sơn Trà, Đà Nẵng","094839500"),
("KH002","Trần Quang Minh","99 Tô Hiến Thành, Sơn Trà, Đà Nẵng","08940280"),
("KH003","Trần Quang Sang","87 Nguyễn Huy Hiệu, Sơn Trà, Đà Nẵng","08940280"),
("KH004","Nguyễn Hoa","123 Nguyễn Văn Thoại, Liên Chiều, Đà Nẵng","045386504"),
("KH005","Trần Thị Mỹ Thảo","98 Phan Châu Trinh, Thanh Khê Đà Nẵng","084028590"),
("KH006","Nguyễn Nhật Hoàng","93 Đặng Thì Nhậm, Thanh Khê, Đà Nẵng","084280488"),
("KH007","Hồ Thị Mỹ Nhung","08 Lê Hữu Trác, Hải Châu, Đà Nẵng","08320850"),
("KH008","Trần Nhật Minh","32 Lê Văn Lưu, Thanh Khê, Đà Nẵng","09438500"),
("KH009","Nguyễn Văn Anh","495 Nguyễn Văn Bằng, Liên Chiểu, Đà Nẵng","04809850");
drop table khuyenmai;
insert into KhuyenMai
values
("KM001","Khuyến mãi hoa khai trương","LH001","10(%)"),
("KM002","Khuyến mãi hoa tình yêu","LH002","5(%)"),
("KM003","Chưa có chương trình khuyến mãi","LH003",""),
("KM004","Chưa có chương trình khuyến mãi","LH004",""),
("KM005","Khuyến mãi hoa bó nhân ngày 20/10","LH005","7(%)"),
("KM006","Chưa có chuương trình khuyến mãi","LH006",""),
("KM007","Chưa có chương trình khuyến mãi","LH007","")
;

 insert into DonDatHang 
 values 
 ("DB001","2021/10/17","2021/10/21"),
 ("DB002","2021/10/18","2021/10/21"),
 ("DB003","2021/10/14","2021/10/19"),
 ("DB004","2021/10/21","2021/10/25"),
 ("DB005","2021/10/18","2021/10/23"),
 ("DB006","2021/10/18","2021/10/20"),
 ("DB007","2021/10/16","2021/10/20"),
 ("DB008","2021/10/21","2021/10/25"),
 ("DB009","2021/10/15","2021/10/18");
-- Doanh thu tháng 10 
select chitiethoadonban.mahoa, Tenloaihoa.tenhoa, chitiethoadonban.dongiaban, chitiethoadonban.soluong, khuyenmai.mucgiam,chitiethoadonban.dongiaban*chitiethoadonban.soluong-(chitiethoadonban.dongiaban*chitiethoadonban.soluong*khuyenmai.mucgiam/100) + chitiethoadonban.Phivanchuyen AS Thanh_tien
from chitiethoadonban left join Tenloaihoa on chitiethoadonban.mahoa=Tenloaihoa.mahoa
left join LoaiHoa on loaihoa.maloai=tenloaihoa.maloai
left join khuyenmai on khuyenmai.maloai=loaihoa.maloai
left join tinhtrangdonhang on tinhtrangdonhang.maHD = chitiethoadonban.MaHD
left join hoadonban on hoadonban.maHD=chitiethoadonban.maHD
where tinhtrangdonhang.tinhtrang ="Đã hoàn thành" and MONTH(hoadonban.NgaylapHD)=10;

-- Loại hoa có doanh số lớn nhất
select Tenloaihoa.mahoa as Mã_hoa,Tenloaihoa.tenhoa as Mã_loại ,chitiethoadonban.soLuong as Doanh_Số
from Tenloaihoa
inner join chitiethoadonban
on chitiethoadonban.mahoa=Tenloaihoa.mahoa
where soLuong=(select max(soLuong) from chitiethoadonban);
 

-- Đơn giá trung bình của tất cả loại hoa
select loaihoa.maloai, loaihoa.tenloai, avg(chitiethoadonnhap.dongianhap) as Giá_TB
from loaihoa join tenloaihoa on loaihoa.maloai=tenloaihoa.maloai
join chitiethoadonnhap on tenloaihoa.mahoa = chitiethoadonnhap.mahoa
group by loaihoa.maloai;

-- Báo cáo chi tiết về từng loại hoa (Maloai, tenloai, soluongnhap, soluongxuat, tồn kho)
select chitiethoadonnhap.mahoa as Mã_hoa, tenloaihoa.tenhoa as Tên_hoa, chitiethoadonnhap.soluong as Số_lượng_nhập, chitiethoadonban.soluong as Số_lượng_đã_bán, (chitiethoadonnhap.soluong-chitiethoadonban.soluong) as Số_lượng_tồn
from chitiethoadonnhap 
join chitiethoadonban on chitiethoadonnhap.mahoa= chitiethoadonban.mahoa
join tenloaihoa on tenloaihoa.mahoa=chitiethoadonnhap.mahoa
group by chitiethoadonban.mahoa;

-- Các sản phẩm đang giảm giá.
select loaihoa.maloai as Mã_loại, Tenloaihoa.tenhoa as Tên_hoa, khuyenmai.mucgiam as Mức_giảm
from loaihoa 
join Tenloaihoa on loaihoa.maloai= tenloaihoa.maloai
join khuyenmai on khuyenmai.maloai=tenloaihoa.maloai
where khuyenmai.mucgiam!="";

-- Nhân viên không nhập hàng 
select * from NhanVien
where not exists (
select hoadonnhap.MaNV from hoadonnhap where hoadonnhap.maNV=NhanVien.maNV);

-- Thành tiền của từng mặt hàng có trong hóa đơn bán và tình trạng của hóa đơn.
select chitiethoadonban.maHD, TenLoaihoa.mahoa as Mã_hoa, tenloaihoa.tenhoa as Tên_hoa, chitiethoadonban.dongiaban*chitiethoadonban.soluong-(chitiethoadonban.dongiaban*chitiethoadonban.soluong*khuyenmai.mucgiam/100) + chitiethoadonban.Phivanchuyen AS Thành_tiền, tinhtrangdonhang.tinhtrang as Trạng_thái
from loaihoa 
join tenloaihoa on loaihoa.maloai=tenloaihoa.maloai
join chitiethoadonban on chitiethoadonban.mahoa=tenloaihoa.mahoa
join tinhtrangdonhang on tinhtrangdonhang.maHD=chitiethoadonban.maHD
join khuyenmai on khuyenmai.maloai=loaihoa.maloai;

select chitiethoadonban.maHD, TenLoaihoa.mahoa as Mã_hoa, tenloaihoa.tenhoa as Tên_hoa, chitiethoadonban.dongiaban*chitiethoadonban.soluong-(chitiethoadonban.dongiaban*chitiethoadonban.soluong*khuyenmai.mucgiam/100) + chitiethoadonban.Phivanchuyen AS Thành_tiền, tinhtrangdonhang.tinhtrang as Trạng_thái
from loaihoa 
join tenloaihoa on loaihoa.maloai=tenloaihoa.maloai
join chitiethoadonban on chitiethoadonban.mahoa=tenloaihoa.mahoa
join tinhtrangdonhang on tinhtrangdonhang.maHD=chitiethoadonban.maHD
join khuyenmai on khuyenmai.maloai=loaihoa.maloai;
where chitiethoadonban.maHD="DB001";

select khachhang.maKH, khachhang.TenKH, khachhang.diachi, khachhang.sdt, chitiethoadonban.mahoa
from khachhang
join hoadonban on hoadonban.maKH=khachhang.maKH
join chitiethoadonban on chitiethoadonban.maHD=hoadonban.maHD;

select (sum(chitiethoadonnhap.dongianhap * chitiethoadonnhap.soluong)) as tổng_tiền_nhập_hàng
from chitiethoadonnhap
join tenloaihoa on tenloaihoa.mahoa = chitiethoadonnhap.MaHoa
join loaihoa on loaihoa.maloai = tenloaihoa.MaLoai;


