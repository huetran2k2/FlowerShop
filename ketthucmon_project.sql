-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 24, 2021 lúc 11:35 AM
-- Phiên bản máy phục vụ: 10.4.21-MariaDB
-- Phiên bản PHP: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `ketthucmon_project`
--

DELIMITER $$
--
-- Thủ tục
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Find_KH_theoiD` (IN `id_KH` VARCHAR(5))  begin
select * from thông_tin_khách_hàng
where thông_tin_khách_hàng.maKH=id_KH;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Find_theo_mã_HD` (IN `id_HD` VARCHAR(5))  begin 
select * from thành_tiền_hdb
where thành_tiền_hdb.maHD= id_HD;
end$$

--
-- Các hàm
--
CREATE DEFINER=`root`@`localhost` FUNCTION `Tổng_GT_DH` (`id_HD` VARCHAR(5)) RETURNS INT(11) BEGIN
DECLARE tong int ;
set tong = 0;
set tong=(select(thành_tiền_hdb.Thành_tiền)from thành_tiền_hdb
where thành_tiền_hdb.maHD =id_HD);
return tong;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `Tổng_tiền_nhập_hoa` () RETURNS INT(11) begin
return(select (sum(chitiethoadonnhap.dongianhap * chitiethoadonnhap.soluong)) as tổng_tiền_nhập_hàng
from chitiethoadonnhap
join tenloaihoa on tenloaihoa.mahoa = chitiethoadonnhap.MaHoa
join loaihoa on loaihoa.maloai = tenloaihoa.MaLoai);
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `Tổng_tiền_nhập_T10` (`id_loaihoa` VARCHAR(5)) RETURNS INT(11) begin
declare tong int;
set tong = 0;
set tong = (select (sum(chitiethoadonnhap.dongianhap * chitiethoadonnhap.soluong))
from chitiethoadonnhap
join tenloaihoa on tenloaihoa.mahoa = chitiethoadonnhap.MaHoa
join loaihoa on loaihoa.maloai = tenloaihoa.MaLoai
where loaihoa.maloai = id_loaihoa); 
return tong;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chitiethoadonban`
--

CREATE TABLE `chitiethoadonban` (
  `MaHD` char(5) NOT NULL,
  `MaHoa` char(5) DEFAULT NULL,
  `SoLuong` int(11) DEFAULT NULL,
  `Dongiaban` varchar(10) DEFAULT NULL,
  `Phivanchuyen` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `chitiethoadonban`
--

INSERT INTO `chitiethoadonban` (`MaHD`, `MaHoa`, `SoLuong`, `Dongiaban`, `Phivanchuyen`) VALUES
('DB001', 'KT001', 2, '600000', '15000'),
('DB002', 'KT002', 4, '750000', '25000'),
('DB003', 'KT003', 5, '250000', '20000'),
('DB004', 'TY001', 7, '370000', '10000'),
('DB005', 'TY002', 2, '700000', '15000'),
('DB006', 'HG001', 1, '450000', '10000'),
('DB007', 'HG002', 1, '1100000', '20000'),
('DB008', 'TL001', 1, '450000', '25000'),
('DB009', 'TL002', 1, '1100000', '30000'),
('DB099', 'HB002', 3, '500000', '15000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chitiethoadonnhap`
--

CREATE TABLE `chitiethoadonnhap` (
  `MaHD` char(5) NOT NULL,
  `MaHoa` char(5) DEFAULT NULL,
  `Soluong` int(11) DEFAULT NULL,
  `DonGiaNhap` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `chitiethoadonnhap`
--

INSERT INTO `chitiethoadonnhap` (`MaHD`, `MaHoa`, `Soluong`, `DonGiaNhap`) VALUES
('DN001', 'KT001', 5, '500000'),
('DN002', 'KT002', 10, '600000'),
('DN003', 'KT003', 6, '700000'),
('DN004', 'TY001', 9, '200000'),
('DN005', 'TY002', 12, '300000'),
('DN006', 'HG001', 9, '850000'),
('DN007', 'HG002', 10, '640000'),
('DN008', 'TL001', 3, '400000'),
('DN009', 'TL002', 4, '550000'),
('DN010', 'HB001', 25, '300000'),
('DN011', 'HB002', 10, '400000'),
('DN012', 'HC001', 7, '600000'),
('DN013', 'HC002', 3, '790000'),
('DN014', 'LD001', 5, '1000.000'),
('DN015', 'LD002', 10, '1150000');

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `chi_tiết_từng_loại_hoa`
-- (See below for the actual view)
--
CREATE TABLE `chi_tiết_từng_loại_hoa` (
`Mã_hoa` char(5)
,`Tên_hoa` varchar(50)
,`Số_lượng_nhập` int(11)
,`Số_lượng_đã_bán` int(11)
,`Số_lượng_tồn` bigint(12)
);

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `các_sp_đang_giảm_giá`
-- (See below for the actual view)
--
CREATE TABLE `các_sp_đang_giảm_giá` (
`Mã_loại` char(5)
,`Tên_hoa` varchar(50)
,`Mức_giảm` varchar(20)
);

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `doanh_thu_tháng_10`
-- (See below for the actual view)
--
CREATE TABLE `doanh_thu_tháng_10` (
`mahoa` char(5)
,`tenhoa` varchar(50)
,`dongiaban` varchar(10)
,`soluong` int(11)
,`mucgiam` varchar(20)
,`Thanh_tien` double
);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dondathang`
--

CREATE TABLE `dondathang` (
  `MaHD` char(5) DEFAULT NULL,
  `Ngayguihang` datetime DEFAULT NULL,
  `ngaynhanhang` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `dondathang`
--

INSERT INTO `dondathang` (`MaHD`, `Ngayguihang`, `ngaynhanhang`) VALUES
('DB001', '2021-10-17 00:00:00', '2021-10-21 00:00:00'),
('DB002', '2021-10-18 00:00:00', '2021-10-21 00:00:00'),
('DB003', '2021-10-14 00:00:00', '2021-10-19 00:00:00'),
('DB004', '2021-10-21 00:00:00', '2021-10-25 00:00:00'),
('DB005', '2021-10-18 00:00:00', '2021-10-23 00:00:00'),
('DB006', '2021-10-18 00:00:00', '2021-10-20 00:00:00'),
('DB007', '2021-10-16 00:00:00', '2021-10-20 00:00:00'),
('DB008', '2021-10-21 00:00:00', '2021-10-25 00:00:00'),
('DB009', '2021-10-15 00:00:00', '2021-10-18 00:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hoadonban`
--

CREATE TABLE `hoadonban` (
  `MaHD` char(5) NOT NULL,
  `MaNV` char(5) DEFAULT NULL,
  `NgayLapHD` date DEFAULT NULL,
  `MaKH` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `hoadonban`
--

INSERT INTO `hoadonban` (`MaHD`, `MaNV`, `NgayLapHD`, `MaKH`) VALUES
('DB001', 'NV001', '2021-10-16', 'KH001'),
('DB002', 'NV002', '2021-10-17', 'KH002'),
('DB003', 'NV003', '2021-10-13', 'KH003'),
('DB004', 'NV004', '2021-10-19', 'KH004'),
('DB005', 'NV001', '2021-10-16', 'KH005'),
('DB006', 'NV002', '2021-10-17', 'KH006'),
('DB007', 'NV007', '2021-10-14', 'KH007'),
('DB008', 'NV005', '2021-10-19', 'KH008'),
('DB009', 'NV006', '2021-10-13', 'KH009'),
('DB099', 'NV001', '2021-10-01', 'KH099');

--
-- Bẫy `hoadonban`
--
DELIMITER $$
CREATE TRIGGER `before_update_id_NV` BEFORE UPDATE ON `hoadonban` FOR EACH ROW BEGIN
    IF (new.maNV NOT IN (SELECT maNV FROM nhanvien)) THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'maNV does not exist';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_ma_HDB` BEFORE DELETE ON `hoadonban` FOR EACH ROW begin 
delete from chitiethoadonban
where maHD=old.maHD;
delete from dondathang
where maHD=old.maHD;
delete from tinhtrangdonhang
where maHD=old.maHD;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hoadonnhap`
--

CREATE TABLE `hoadonnhap` (
  `maHD` char(5) NOT NULL,
  `NgayNhap` date DEFAULT NULL,
  `MaNCC` char(5) DEFAULT NULL,
  `MaNV` char(5) DEFAULT NULL,
  `Note` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `hoadonnhap`
--

INSERT INTO `hoadonnhap` (`maHD`, `NgayNhap`, `MaNCC`, `MaNV`, `Note`) VALUES
('DN001', '2021-10-02', 'NC000', 'NV001', ''),
('DN002', '2021-10-02', 'NC000', 'NV001', ''),
('DN003', '2021-10-06', 'NC002', 'NV002', ''),
('DN004', '2021-10-08', 'NC003', 'NV003', ''),
('DN005', '2021-10-08', 'NC004', 'NV004', ''),
('DN006', '2021-10-09', 'NC005', 'NV005', ''),
('DN007', '2021-10-05', 'NC005', 'NV006', ''),
('DN008', '2021-10-07', 'NC005', 'NV003', ''),
('DN009', '2021-10-09', 'NC005', 'NV003', ''),
('DN010', '2021-10-02', 'NC003', 'NV005', ''),
('DN011', '2021-10-05', 'NC002', 'NV002', ''),
('DN012', '2021-10-09', 'NC003', 'NV001', ''),
('DN013', '2021-10-03', 'NC004', 'NV002', ''),
('DN014', '2021-10-05', 'NC005', 'NV004', ''),
('DN015', '2021-10-05', 'Nc005', 'NV002', '');

--
-- Bẫy `hoadonnhap`
--
DELIMITER $$
CREATE TRIGGER `before_update_ma_NCC` BEFORE UPDATE ON `hoadonnhap` FOR EACH ROW BEGIN
    IF (new.mancc NOT IN (SELECT mancc FROM ncc)) THEN 
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'maNV does not exist';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khachhang`
--

CREATE TABLE `khachhang` (
  `MaKH` char(5) NOT NULL,
  `TenKH` varchar(50) DEFAULT NULL,
  `Diachi` varchar(100) DEFAULT NULL,
  `Sdt` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `khachhang`
--

INSERT INTO `khachhang` (`MaKH`, `TenKH`, `Diachi`, `Sdt`) VALUES
('KH001', 'Nguyễn Ngọc Ánh', '25 Hoàng Diệu, Sơn Trà, Đà Nẵng', '094839500'),
('KH002', 'Trần Quang Minh', '99 Tô Hiến Thành, Sơn Trà, Đà Nẵng', '08940280'),
('KH003', 'Trần Quang Sang', '87 Nguyễn Huy Hiệu, Sơn Trà, Đà Nẵng', '08940280'),
('KH004', 'Nguyễn Hoa', '123 Nguyễn Văn Thoại, Liên Chiều, Đà Nẵng', '045386504'),
('KH005', 'Trần Thị Mỹ Thảo', '98 Phan Châu Trinh, Thanh Khê Đà Nẵng', '084028590'),
('KH006', 'Nguyễn Nhật Hoàng', '93 Đặng Thì Nhậm, Thanh Khê, Đà Nẵng', '084280488'),
('KH007', 'Hồ Thị Mỹ Nhung', '08 Lê Hữu Trác, Hải Châu, Đà Nẵng', '08320850'),
('KH008', 'Trần Nhật Minh', '32 Lê Văn Lưu, Thanh Khê, Đà Nẵng', '09438500'),
('KH009', 'Nguyễn Văn Anh', '495 Nguyễn Văn Bằng, Liên Chiểu, Đà Nẵng', '04809850');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khuyenmai`
--

CREATE TABLE `khuyenmai` (
  `MaKM` char(5) NOT NULL,
  `TenCT` varchar(50) DEFAULT NULL,
  `MaLoai` char(5) DEFAULT NULL,
  `Mucgiam` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `khuyenmai`
--

INSERT INTO `khuyenmai` (`MaKM`, `TenCT`, `MaLoai`, `Mucgiam`) VALUES
('KM001', 'Khuyến mãi hoa khai trương', 'LH001', '10(%)'),
('KM002', 'Khuyến mãi hoa tình yêu', 'LH002', '5(%)'),
('KM003', 'Chưa có chương trình khuyến mãi', 'LH003', ''),
('KM004', 'Chưa có chương trình khuyến mãi', 'LH004', ''),
('KM005', 'Khuyến mãi hoa bó nhân ngày 20/10', 'LH005', '7(%)'),
('KM006', 'Chưa có chuương trình khuyến mãi', 'LH006', ''),
('KM007', 'Chưa có chương trình khuyến mãi', 'LH007', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `loaihoa`
--

CREATE TABLE `loaihoa` (
  `MaLoai` char(5) NOT NULL,
  `TenLoai` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `loaihoa`
--

INSERT INTO `loaihoa` (`MaLoai`, `TenLoai`) VALUES
('LH001', 'Hoa khai trương'),
('LH002', 'Hoa tình yêu'),
('LH003', 'Hoa giỏ'),
('LH004', 'Hoa tang lễ'),
('LH005', 'Hoa bó'),
('LH006', 'Hoa chậu'),
('LH007', 'Hoa lan điệp');

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `loại_hoa_có_doanh_số_max`
-- (See below for the actual view)
--
CREATE TABLE `loại_hoa_có_doanh_số_max` (
`Mã_hoa` char(5)
,`Mã_loại` varchar(50)
,`Doanh_Số` int(11)
);

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `loại_hoa_có_doanh_số_min`
-- (See below for the actual view)
--
CREATE TABLE `loại_hoa_có_doanh_số_min` (
`Mã_hoa` char(5)
,`Mã_loại` varchar(50)
,`Doanh_Số` int(11)
);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ncc`
--

CREATE TABLE `ncc` (
  `MaNCC` char(5) NOT NULL,
  `TenNCC` varchar(50) DEFAULT NULL,
  `Diachi` varchar(100) DEFAULT NULL,
  `Sdt` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `ncc`
--

INSERT INTO `ncc` (`MaNCC`, `TenNCC`, `Diachi`, `Sdt`) VALUES
('NC000', 'SHOP HOA LAN NGHI', '7A/5/16 Thành Thái Phường 14 Quận 10 TP.Hồ Chí Minh', '0928470010'),
('NC002', 'CÔNG TY CỔ PHẦN ĐIÊN HOA TOÀN QUỐC', ' 51 Nguyễn Khang, Quận Cầu Giấy, TP.Hà Nội', '099589859'),
('NC003', 'CÔNG TY CỔ PHẦN THẾ GIỚI CÂY VÀ HOA', 'P830 HH4B, Khu Đô Thị Linh Đàm, Quận Hoàng Mai, TP Hà Nội', '084358798'),
('NC004', 'SHOP HOA TƯƠI BÍCH NGỌC', '155/2 Trung Chánh, Hóc Môn, Tp.Hồ Chí Minh', '048937597'),
('NC005', 'CÔNG TY TNHH LINH NGỌC', '1B Nguyễn Đình Chiểu, P.9, Tp.Đà Lạt, Lâm Đồng', '00453050');

--
-- Bẫy `ncc`
--
DELIMITER $$
CREATE TRIGGER `after_update_NCC_HDN` AFTER UPDATE ON `ncc` FOR EACH ROW BEGIN
    UPDATE hoadonnhap
    SET mancc = new.mancc
    WHERE mancc = old.mancc;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhanvien`
--

CREATE TABLE `nhanvien` (
  `MaNV` char(5) NOT NULL,
  `TenNV` varchar(50) DEFAULT NULL,
  `GioiTinh` enum('Nam','Nữ','Khác') DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `pass` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `nhanvien`
--

INSERT INTO `nhanvien` (`MaNV`, `TenNV`, `GioiTinh`, `username`, `pass`) VALUES
('NV001', 'Trần Thị Huế', 'Nữ', 'hue.tran23@gmail', '123456'),
('NV002', 'Nguyễn Thị Nhi', 'Nữ', 'nhi.nguyen@gmail', '985938'),
('NV004', 'Hoàng Nhật Minh', 'Nam', 'minhhoang@gamail', '859399'),
('NV005', 'Lê Minh Anh', 'Nam', 'anhle@gmail', '587934'),
('NV006', 'Hoàng Thị Kim Loan', 'Nữ', 'loanhoang@gamil', '089538'),
('NV007', 'An Nhien', 'Nữ', 'nhienan@gmail', '849328');

--
-- Bẫy `nhanvien`
--
DELIMITER $$
CREATE TRIGGER `after_update_NV_HDB` AFTER UPDATE ON `nhanvien` FOR EACH ROW BEGIN
    UPDATE hoadonban
    SET maNV = new.maNV
    WHERE maNV = old.maNV;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `nv_không_nhập_hàng`
-- (See below for the actual view)
--
CREATE TABLE `nv_không_nhập_hàng` (
`MaNV` char(5)
,`TenNV` varchar(50)
,`GioiTinh` enum('Nam','Nữ','Khác')
,`username` varchar(30)
,`pass` varchar(10)
);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tenloaihoa`
--

CREATE TABLE `tenloaihoa` (
  `MaHoa` char(5) NOT NULL,
  `MaLoai` char(5) DEFAULT NULL,
  `TenHoa` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `tenloaihoa`
--

INSERT INTO `tenloaihoa` (`MaHoa`, `MaLoai`, `TenHoa`) VALUES
('HB001', 'LH005', 'Hoa Vàng Hoàng Kim'),
('HB002', 'LH005', 'Hoa Cúc Pingpong'),
('HC001', 'LH006', 'Thường Xuân'),
('HC002', 'LH006', 'Dương xỉ'),
('HG001', 'LH003', 'Hoa Mười Giờ'),
('HG002', 'LH003', 'Hoa Dạ Yến Thảo'),
('KT001', 'LH001', 'Hoa Hướng Dương'),
('KT002', 'LH001', 'Hoa Đồng Tiền'),
('KT003', 'LH001', 'Hoa Cẩm Tú Cầu'),
('LD001', 'LH007', 'Lan Hồ Điệp'),
('LD002', 'Lh007', 'Lan Phi Điệp'),
('TL001', 'LH004', 'Hoa Cúc Trắng'),
('TL002', 'LH004', 'Hoa Ly Trắng'),
('TY001', 'LH002', 'Hoa Hồng'),
('TY002', 'LH002', 'Hoa Cẩm Chướng');

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `thành_tiền_hdb`
-- (See below for the actual view)
--
CREATE TABLE `thành_tiền_hdb` (
`maHD` char(5)
,`Mã_hoa` char(5)
,`Tên_hoa` varchar(50)
,`Thành_tiền` double
,`Trạng_thái` varchar(50)
);

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `thông_tin_khách_hàng`
-- (See below for the actual view)
--
CREATE TABLE `thông_tin_khách_hàng` (
`maKH` char(5)
,`TenKH` varchar(50)
,`diachi` varchar(100)
,`sdt` varchar(20)
,`mahoa` char(5)
);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tinhtrangdonhang`
--

CREATE TABLE `tinhtrangdonhang` (
  `MaHD` char(5) NOT NULL,
  `TinhTrang` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `tinhtrangdonhang`
--

INSERT INTO `tinhtrangdonhang` (`MaHD`, `TinhTrang`) VALUES
('DB001', 'Đang giao hàng'),
('DB002', 'Mới đặt hàng'),
('DB003', 'Đã hoàn thành'),
('DB004', 'Đã hoàn thành'),
('DB005', 'Đã hoàn thành'),
('DB006', 'Đã hoàn thành'),
('DB007', 'Đang chuẩn bị hàng'),
('DB008', 'Đã hoàn thành'),
('DB009', 'Hủy đơn hàng'),
('DB099', 'Đang giao hàng');

-- --------------------------------------------------------

--
-- Cấu trúc đóng vai cho view `đơn_giá_nhập_tb`
-- (See below for the actual view)
--
CREATE TABLE `đơn_giá_nhập_tb` (
`maloai` char(5)
,`tenloai` varchar(50)
,`Giá_TB` double
);

-- --------------------------------------------------------

--
-- Cấu trúc cho view `chi_tiết_từng_loại_hoa`
--
DROP TABLE IF EXISTS `chi_tiết_từng_loại_hoa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `chi_tiết_từng_loại_hoa`  AS SELECT `chitiethoadonnhap`.`MaHoa` AS `Mã_hoa`, `tenloaihoa`.`TenHoa` AS `Tên_hoa`, `chitiethoadonnhap`.`Soluong` AS `Số_lượng_nhập`, `chitiethoadonban`.`SoLuong` AS `Số_lượng_đã_bán`, `chitiethoadonnhap`.`Soluong`- `chitiethoadonban`.`SoLuong` AS `Số_lượng_tồn` FROM ((`chitiethoadonnhap` join `chitiethoadonban` on(`chitiethoadonnhap`.`MaHoa` = `chitiethoadonban`.`MaHoa`)) join `tenloaihoa` on(`tenloaihoa`.`MaHoa` = `chitiethoadonnhap`.`MaHoa`)) GROUP BY `chitiethoadonban`.`MaHoa` ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `các_sp_đang_giảm_giá`
--
DROP TABLE IF EXISTS `các_sp_đang_giảm_giá`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `các_sp_đang_giảm_giá`  AS SELECT `loaihoa`.`MaLoai` AS `Mã_loại`, `tenloaihoa`.`TenHoa` AS `Tên_hoa`, `khuyenmai`.`Mucgiam` AS `Mức_giảm` FROM ((`loaihoa` join `tenloaihoa` on(`loaihoa`.`MaLoai` = `tenloaihoa`.`MaLoai`)) join `khuyenmai` on(`khuyenmai`.`MaLoai` = `tenloaihoa`.`MaLoai`)) WHERE `khuyenmai`.`Mucgiam` <> '' ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `doanh_thu_tháng_10`
--
DROP TABLE IF EXISTS `doanh_thu_tháng_10`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `doanh_thu_tháng_10`  AS SELECT `chitiethoadonban`.`MaHoa` AS `mahoa`, `tenloaihoa`.`TenHoa` AS `tenhoa`, `chitiethoadonban`.`Dongiaban` AS `dongiaban`, `chitiethoadonban`.`SoLuong` AS `soluong`, `khuyenmai`.`Mucgiam` AS `mucgiam`, `chitiethoadonban`.`Dongiaban`* `chitiethoadonban`.`SoLuong` - `chitiethoadonban`.`Dongiaban` * `chitiethoadonban`.`SoLuong` * `khuyenmai`.`Mucgiam` / 100 + `chitiethoadonban`.`Phivanchuyen` AS `Thanh_tien` FROM (((((`chitiethoadonban` left join `tenloaihoa` on(`chitiethoadonban`.`MaHoa` = `tenloaihoa`.`MaHoa`)) left join `loaihoa` on(`loaihoa`.`MaLoai` = `tenloaihoa`.`MaLoai`)) left join `khuyenmai` on(`khuyenmai`.`MaLoai` = `loaihoa`.`MaLoai`)) left join `tinhtrangdonhang` on(`tinhtrangdonhang`.`MaHD` = `chitiethoadonban`.`MaHD`)) left join `hoadonban` on(`hoadonban`.`MaHD` = `chitiethoadonban`.`MaHD`)) WHERE `tinhtrangdonhang`.`TinhTrang` = 'Đã hoàn thành' AND month(`hoadonban`.`NgayLapHD`) = 10 ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `loại_hoa_có_doanh_số_max`
--
DROP TABLE IF EXISTS `loại_hoa_có_doanh_số_max`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `loại_hoa_có_doanh_số_max`  AS SELECT `tenloaihoa`.`MaHoa` AS `Mã_hoa`, `tenloaihoa`.`TenHoa` AS `Mã_loại`, `chitiethoadonban`.`SoLuong` AS `Doanh_Số` FROM (`tenloaihoa` join `chitiethoadonban` on(`chitiethoadonban`.`MaHoa` = `tenloaihoa`.`MaHoa`)) WHERE `chitiethoadonban`.`SoLuong` = (select max(`chitiethoadonban`.`SoLuong`) from `chitiethoadonban`) ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `loại_hoa_có_doanh_số_min`
--
DROP TABLE IF EXISTS `loại_hoa_có_doanh_số_min`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `loại_hoa_có_doanh_số_min`  AS SELECT `tenloaihoa`.`MaHoa` AS `Mã_hoa`, `tenloaihoa`.`TenHoa` AS `Mã_loại`, `chitiethoadonban`.`SoLuong` AS `Doanh_Số` FROM (`tenloaihoa` join `chitiethoadonban` on(`chitiethoadonban`.`MaHoa` = `tenloaihoa`.`MaHoa`)) WHERE `chitiethoadonban`.`SoLuong` = (select min(`chitiethoadonban`.`SoLuong`) from `chitiethoadonban`) ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `nv_không_nhập_hàng`
--
DROP TABLE IF EXISTS `nv_không_nhập_hàng`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nv_không_nhập_hàng`  AS SELECT `nhanvien`.`MaNV` AS `MaNV`, `nhanvien`.`TenNV` AS `TenNV`, `nhanvien`.`GioiTinh` AS `GioiTinh`, `nhanvien`.`username` AS `username`, `nhanvien`.`pass` AS `pass` FROM `nhanvien` WHERE !exists(select `hoadonnhap`.`MaNV` from `hoadonnhap` where `hoadonnhap`.`MaNV` = `nhanvien`.`MaNV` limit 1) ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `thành_tiền_hdb`
--
DROP TABLE IF EXISTS `thành_tiền_hdb`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `thành_tiền_hdb`  AS SELECT `chitiethoadonban`.`MaHD` AS `maHD`, `tenloaihoa`.`MaHoa` AS `Mã_hoa`, `tenloaihoa`.`TenHoa` AS `Tên_hoa`, `chitiethoadonban`.`Dongiaban`* `chitiethoadonban`.`SoLuong` - `chitiethoadonban`.`Dongiaban` * `chitiethoadonban`.`SoLuong` * `khuyenmai`.`Mucgiam` / 100 + `chitiethoadonban`.`Phivanchuyen` AS `Thành_tiền`, `tinhtrangdonhang`.`TinhTrang` AS `Trạng_thái` FROM ((((`loaihoa` join `tenloaihoa` on(`loaihoa`.`MaLoai` = `tenloaihoa`.`MaLoai`)) join `chitiethoadonban` on(`chitiethoadonban`.`MaHoa` = `tenloaihoa`.`MaHoa`)) join `tinhtrangdonhang` on(`tinhtrangdonhang`.`MaHD` = `chitiethoadonban`.`MaHD`)) join `khuyenmai` on(`khuyenmai`.`MaLoai` = `loaihoa`.`MaLoai`)) ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `thông_tin_khách_hàng`
--
DROP TABLE IF EXISTS `thông_tin_khách_hàng`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `thông_tin_khách_hàng`  AS SELECT `khachhang`.`MaKH` AS `maKH`, `khachhang`.`TenKH` AS `TenKH`, `khachhang`.`Diachi` AS `diachi`, `khachhang`.`Sdt` AS `sdt`, `chitiethoadonban`.`MaHoa` AS `mahoa` FROM ((`khachhang` join `hoadonban` on(`hoadonban`.`MaKH` = `khachhang`.`MaKH`)) join `chitiethoadonban` on(`chitiethoadonban`.`MaHD` = `hoadonban`.`MaHD`)) ;

-- --------------------------------------------------------

--
-- Cấu trúc cho view `đơn_giá_nhập_tb`
--
DROP TABLE IF EXISTS `đơn_giá_nhập_tb`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `đơn_giá_nhập_tb`  AS SELECT `loaihoa`.`MaLoai` AS `maloai`, `loaihoa`.`TenLoai` AS `tenloai`, avg(`chitiethoadonnhap`.`DonGiaNhap`) AS `Giá_TB` FROM ((`loaihoa` join `tenloaihoa` on(`loaihoa`.`MaLoai` = `tenloaihoa`.`MaLoai`)) join `chitiethoadonnhap` on(`tenloaihoa`.`MaHoa` = `chitiethoadonnhap`.`MaHoa`)) GROUP BY `loaihoa`.`MaLoai` ;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `chitiethoadonban`
--
ALTER TABLE `chitiethoadonban`
  ADD PRIMARY KEY (`MaHD`),
  ADD KEY `MaHoa` (`MaHoa`);

--
-- Chỉ mục cho bảng `chitiethoadonnhap`
--
ALTER TABLE `chitiethoadonnhap`
  ADD PRIMARY KEY (`MaHD`),
  ADD KEY `MaHoa` (`MaHoa`);

--
-- Chỉ mục cho bảng `dondathang`
--
ALTER TABLE `dondathang`
  ADD KEY `MaHD` (`MaHD`);

--
-- Chỉ mục cho bảng `hoadonban`
--
ALTER TABLE `hoadonban`
  ADD PRIMARY KEY (`MaHD`);

--
-- Chỉ mục cho bảng `hoadonnhap`
--
ALTER TABLE `hoadonnhap`
  ADD PRIMARY KEY (`maHD`);

--
-- Chỉ mục cho bảng `khachhang`
--
ALTER TABLE `khachhang`
  ADD PRIMARY KEY (`MaKH`);

--
-- Chỉ mục cho bảng `khuyenmai`
--
ALTER TABLE `khuyenmai`
  ADD PRIMARY KEY (`MaKM`),
  ADD KEY `MaLoai` (`MaLoai`);

--
-- Chỉ mục cho bảng `loaihoa`
--
ALTER TABLE `loaihoa`
  ADD PRIMARY KEY (`MaLoai`);

--
-- Chỉ mục cho bảng `ncc`
--
ALTER TABLE `ncc`
  ADD PRIMARY KEY (`MaNCC`);

--
-- Chỉ mục cho bảng `nhanvien`
--
ALTER TABLE `nhanvien`
  ADD PRIMARY KEY (`MaNV`);

--
-- Chỉ mục cho bảng `tenloaihoa`
--
ALTER TABLE `tenloaihoa`
  ADD PRIMARY KEY (`MaHoa`),
  ADD KEY `MaLoai` (`MaLoai`);

--
-- Chỉ mục cho bảng `tinhtrangdonhang`
--
ALTER TABLE `tinhtrangdonhang`
  ADD PRIMARY KEY (`MaHD`);

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `chitiethoadonban`
--
ALTER TABLE `chitiethoadonban`
  ADD CONSTRAINT `chitiethoadonban_ibfk_1` FOREIGN KEY (`MaHD`) REFERENCES `hoadonban` (`MaHD`),
  ADD CONSTRAINT `chitiethoadonban_ibfk_2` FOREIGN KEY (`MaHoa`) REFERENCES `tenloaihoa` (`MaHoa`);

--
-- Các ràng buộc cho bảng `chitiethoadonnhap`
--
ALTER TABLE `chitiethoadonnhap`
  ADD CONSTRAINT `chitiethoadonnhap_ibfk_1` FOREIGN KEY (`MaHD`) REFERENCES `hoadonnhap` (`maHD`),
  ADD CONSTRAINT `chitiethoadonnhap_ibfk_2` FOREIGN KEY (`MaHoa`) REFERENCES `tenloaihoa` (`MaHoa`);

--
-- Các ràng buộc cho bảng `dondathang`
--
ALTER TABLE `dondathang`
  ADD CONSTRAINT `dondathang_ibfk_1` FOREIGN KEY (`MaHD`) REFERENCES `hoadonban` (`MaHD`);

--
-- Các ràng buộc cho bảng `khuyenmai`
--
ALTER TABLE `khuyenmai`
  ADD CONSTRAINT `khuyenmai_ibfk_1` FOREIGN KEY (`MaLoai`) REFERENCES `loaihoa` (`MaLoai`);

--
-- Các ràng buộc cho bảng `tenloaihoa`
--
ALTER TABLE `tenloaihoa`
  ADD CONSTRAINT `tenloaihoa_ibfk_1` FOREIGN KEY (`MaLoai`) REFERENCES `loaihoa` (`MaLoai`);

--
-- Các ràng buộc cho bảng `tinhtrangdonhang`
--
ALTER TABLE `tinhtrangdonhang`
  ADD CONSTRAINT `tinhtrangdonhang_ibfk_1` FOREIGN KEY (`MaHD`) REFERENCES `hoadonban` (`MaHD`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
